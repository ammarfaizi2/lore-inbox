Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131061AbRAPMFJ>; Tue, 16 Jan 2001 07:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131043AbRAPMFA>; Tue, 16 Jan 2001 07:05:00 -0500
Received: from chiara.elte.hu ([157.181.150.200]:17937 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131017AbRAPMEu>;
	Tue, 16 Jan 2001 07:04:50 -0500
Date: Tue, 16 Jan 2001 13:04:22 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        dean gaudet <dean-list-linux-kernel@arctic.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: O_ANY  [was: Re: 'native files', 'object fingerprints' [was:
 sendpath()]]
In-Reply-To: <20010116123743.A32075@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.30.0101161242180.529-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Jan 2001, Andi Kleen wrote:

> > the 'allocate first free file descriptor number' rule for normal Unix
> > files?
> Not sure I follow. You mean dup2() ?

I'm sure you know this: when there are thousands of files open already,
much of the overhead of opening a new file comes from the mandatory POSIX
requirement of allocating the first not yet allocated file descriptor
integer to this file. Eg. if files 0, 1, 2, 10, 11 are already open, the
kernel must allocate file descriptor 3. Many utilities rely on this, and
the rule makes sense in a select() environment, because it compresses the
'file descriptor spectrum'. But in a non-select(), event-drive environment
it becomes unnecessery overhead.

- probably the most radical solution is what i suggested, to completely
avoid the unique-mapping of file structures to an integer range, and use
the address of the file structure (and some cookies) as an identification.

- a less radical solution would be to still map file structures to an
integer range (file descriptors) and usage-maintain files per processes,
but relax the 'allocate first non-allocated integer in the range' rule.
I'm not sure exactly how simple this is, but something like this should
work: on close()-ing file descriptors the freed file descriptors would be
cached in a list (this needs a new, separate structure which must be
allocated/freed as well). Something like:

	struct lazy_filedesc {
		int fd;
		struct file *file;
	}

	struct task {
		...
		struct lazy_filedesc *lazy_files;
		...
	}

the actual filedescriptor bit of a 'lazy file' would be cleared for real
on close(), and the '*file' argument is not a real file - it's NULL if at
close() time this process wasnt the last user of the file, or contains a
pointer to an allocated (but otherwise invalid) file structure. This must
happen to ensure the first-free-desc rule, and to optimize
freeing/allocate of file structures. Now, if the new code does a:

	fd = open(...,O_ANY);

then the kernel looks at the current->lazy_files list, and tries to set
the file descriptor bit in the current->files file table. If successful
then open() uses desc->fd and desc->file (if available) for opening the
new file, and unlinks+frees the lazy descriptor. If unsuccessful then
open() frees desc->file, frees and unlinks the descriptor and goes on to
look at the next descriptor.

- worst case overhead is the extra allocation overhead of the (very small)
  lazy file descriptor. Worst-case happens only if O_ANY allocation is
  mixed in a special way with normal open()s.

- Best-case overhead saves us a get_unused_fd() call, which can be *very*
  expensive (in terms of CPU time and cache footprint) if thousands of
  files are used. If O_ANY is used mostly, then the best-case is always
  triggered.

- (the number of lazy files must be limited to some sane value)

at exit_files() time the current->lazy_files list must be processed. On
exec() it does not get inherited.

current->lazy_files has no effect on task state or semantics otherwise,
it's only an isolated 'information cache'.

Have i missed something important?

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
