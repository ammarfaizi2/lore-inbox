Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbRAPJtX>; Tue, 16 Jan 2001 04:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129859AbRAPJtE>; Tue, 16 Jan 2001 04:49:04 -0500
Received: from chiara.elte.hu ([157.181.150.200]:7697 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129725AbRAPJtB>;
	Tue, 16 Jan 2001 04:49:01 -0500
Date: Tue, 16 Jan 2001 10:48:34 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: 'native files', 'object fingerprints' [was: sendpath()]
In-Reply-To: <Pine.LNX.4.10.10101152056170.12667-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101161020200.673-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Jan 2001, Linus Torvalds wrote:

> > _syscall4 (int, sendpath, int, out_fd, char *, path, off_t *, off, size_t, size)

> You want to do a non-blocking send, so that you don't block on the
> socket, and do some simple multiplexing in your server.
>
> And "sendpath()" cannot do that without having to look up the name
> again, and again, and again. Which makes the performance
> "optimization" a horrible pessimisation.

yep, correct. But take a look at the trick it does with file descriptors,
i believe it could be a useful way of doing things. It basically
privatizes a struct file, without inserting it into the enumerated file
descriptors. This shows that 'native files' are possible: file struct
without file descriptor integers mapped to them.

ob'plug: this privatized file descriptor mechanizm is used in TUX [TUX
privatizes files by putting them into the HTTP request structure - ie.
timeouts and continuation/nonblocking logic can be done with them]. But
TUX is trusted code, and it can pass a struct file to the VFS without
having to validate it, and TUX will also free such file descriptors.

But even user-space code could use 'native files', via the following, safe
mechanizm:

1) current->native_files list, freed at exit_files() time.

2) "struct native_file" which embedds "struct file". It has the following
   fields:

	struct native_file {
		unsigned long master_fingerprint[8];
		unsigned long file_fingerprint[8];
		struct file file;
	};

'fingerprints' are 256 bit, true random numbers. master_fingerprint is
global to the kernel and is generated once per boot. It validates the
pointer of the structure. The master fingerprint is never known to
user-space.

file_fingerprint is a 256-bit identifier generated for this native file.
The file fingerprint and the (kernel) pointer to the native file is
returned to user-space. The cryptographical safety of these 256-bit random
numbers guarantees that no breach can occur in a reasonable period of
time. It's in essence an 'encrypted' communication between kernel and
user-space.

user-space thus can pass a pointer to the following structure:


	struct safe_kpointer {
		void *kaddr;
		unsigned long fingerprint[4];
	};

the kernel can validate kaddr by 1) validating the pointer via the master
fingerprint (every valid kernel pointer must point to a structure that
starts with the master fingerprint's copy). Then usage-permissions are
validated by checking the file fingerprint (the per-object fingerprint).

this is a safe, very fast [ O(1) ] object-permission model. (it's a
variation of a former idea of yours.) A process can pass object
fingerprints and kernel pointers to other processes too - thus the other
process can access the object too. Threads will 'naturally' share objects,
because fingerprints are typically stored in memory.

3) on closing a native file the fingerprint is destroyed (first byte of
the master fingerprint copy is overwritten).

what do you think about this? I believe most of the file APIs can be /
should be reworked to use native files, and 'Unix files' would just be a
compatibility layer parallel to them. Then various applications could
convert to 'native file' usage - i believe file servers which have lots of
file descriptors would do this first.

(this 'fingerprint' mechanizm can be used for any object, not only files.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
