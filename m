Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKMPXh>; Mon, 13 Nov 2000 10:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbQKMPX1>; Mon, 13 Nov 2000 10:23:27 -0500
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:54538 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S129091AbQKMPXO>;
	Mon, 13 Nov 2000 10:23:14 -0500
To: "David Schwartz" <davids@webmaster.com>
Cc: <tytso@mit.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: What protects f_pos?
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKKENGLNAA.davids@webmaster.com>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 13 Nov 2000 15:22:56 +0000
In-Reply-To: "David Schwartz"'s message of "Sun, 12 Nov 2000 14:27:54 -0800"
Message-ID: <y7rg0kv99rj.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> writes:
> 	Suppose you had a multithreaded program that used a
> configuration file with a group of fixed-length blocks indicating what
> work it had to do. Each thread read a block from the file and then did
> the work. One might think that there's no need to protect the file
> descriptor with a mutex.

I don't think that this will work, due to a separate non-atomicity
issue with f_pos.  The generic file read and write implementations do
not atomically update f_pos.  They read f_pos to determine the file
offset to use, then manipulate the page cache (possibly sleeping on
I/O), and only then set f_pos to the appropriate updated value.  So
the example you suggest, with two threads, could do something like:

          Thread 1                           Thread 2

   sys_read(fd, buf1, len)

      off = file->f_pos                sys_read(fd, buf2, len)

         read to buf1                     off = file->f_pos

    file->f_pos = off + len                 read to buf2

                                        file->f_pos = off + len


So both threads read the same block, and f_pos only gets incremented
once.

(Pipes and sockets are a different matter, of course.)

2.2 has the same issue, since although the BKL is held, it will get
dropped if one of the threads sleeps on I/O.  (Earlier Linux versions
might well have the same issue, but I don't have the source around to
check.)

POSIX doesn't seem to bar this behaviour.  From 6.4.1.2:

    On a regular file or other file capable of seeking, read() shall
    start at a position in the file given by the file offset
    associated with fildes.  Before successful return from read(), the
    file offset shall be incremented by the number of bytes actually
    read.

Which is exactly what Linux does.  I can't find text anywhere else in
POSIX.1 that strengthens that condition for the case of multiple
processes/threads reading from the same file.  I'll try to find out
what the Austin Group has to say about this.


David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
