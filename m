Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKMPqA>; Mon, 13 Nov 2000 10:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQKMPpv>; Mon, 13 Nov 2000 10:45:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10370 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129103AbQKMPpg>; Mon, 13 Nov 2000 10:45:36 -0500
Date: Mon, 13 Nov 2000 10:44:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Wragg <dpw@doc.ic.ac.uk>
cc: David Schwartz <davids@webmaster.com>, tytso@mit.edu,
        linux-kernel@vger.kernel.org
Subject: Re: What protects f_pos?
In-Reply-To: <y7rg0kv99rj.fsf@sytry.doc.ic.ac.uk>
Message-ID: <Pine.LNX.3.95.1001113102742.3756A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Nov 2000, David Wragg wrote:

> "David Schwartz" <davids@webmaster.com> writes:
[SNIPPED....]


> 
> So both threads read the same block, and f_pos only gets incremented
> once.
> 
> (Pipes and sockets are a different matter, of course.)
> 
> 2.2 has the same issue, since although the BKL is held, it will get
> dropped if one of the threads sleeps on I/O.  (Earlier Linux versions
> might well have the same issue, but I don't have the source around to
> check.)
> 
> POSIX doesn't seem to bar this behaviour.  From 6.4.1.2:
> 
>     On a regular file or other file capable of seeking, read() shall
>     start at a position in the file given by the file offset
>     associated with fildes.  Before successful return from read(), the
>     file offset shall be incremented by the number of bytes actually
>     read.
> 
> Which is exactly what Linux does.  I can't find text anywhere else in
> POSIX.1 that strengthens that condition for the case of multiple
> processes/threads reading from the same file.  I'll try to find out
> what the Austin Group has to say about this.
> 

Anything that uses f_pos has a problem with multiple readers or multiple
writers. That's one of the problems that file locking is supposed to
handle. An application has got to know how to access a file when it can
be changed by another.

There is a more far-reaching problem that sooner or later will get us.
That's the built-in problem with lseek. Lseek is supposed to return -1
if it failed, with errno being set appropriately. This, in principle,
does not prevent seeking to the last byte of the file as long as errno
is checked by the caller if the function returns -1.

Linux, internally, uses "-errno" as a return value to show an
error. So what happens if we `lseek` to -EBADF or -EFAULT, etc.

An otherwise empty lseek routine in a module, that does nothing except
return the input value, will show errors once the offsets corresponding
to negative errno values are reached.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
