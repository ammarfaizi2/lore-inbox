Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130548AbRAOTlu>; Mon, 15 Jan 2001 14:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130670AbRAOTll>; Mon, 15 Jan 2001 14:41:41 -0500
Received: from chiara.elte.hu ([157.181.150.200]:48144 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130548AbRAOTl1>;
	Mon, 15 Jan 2001 14:41:27 -0500
Date: Mon, 15 Jan 2001 20:41:01 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jonathan Thackray <jthackray@zeus.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <14947.5703.60574.309140@leda.cam.zeus.com>
Message-ID: <Pine.LNX.4.30.0101152035090.5713-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Jan 2001, Jonathan Thackray wrote:

> It's a very useful system call and makes file serving much more
> scalable, and I'm glad that most Un*xes now have support for it
> (Linux, FreeBSD, HP-UX, AIX, Tru64). The next cool feature to add to
> Linux is sendpath(), which does the open() before the sendfile() all
> combined into one system call.

i believe the right model for a user-space webserver is to cache open file
descriptors, and directly hash URLs to open files. This way you can do
pure sendfile() without any open(). Not that open() is too expensive in
Linux:

 m:~/lm/lmbench-2alpha9/bin/i686-linux> ./lat_syscall open
 Simple open/close: 7.5756 microseconds

 m:~/lm/lmbench-2alpha9/bin/i686-linux> ./lat_syscall stat
 Simple stat: 5.4864 microseconds

 m:~/lm/lmbench-2alpha9/bin/i686-linux> ./lat_syscall write
 Simple write: 0.9614 microseconds

 m:~/lm/lmbench-2alpha9/bin/i686-linux> ./lat_syscall read
 Simple read: 1.1420 microseconds

 m:~/lm/lmbench-2alpha9/bin/i686-linux> ./lat_syscall null
 Simple syscall: 0.6349 microseconds

(note that lmbench opens a nontrivial path, it can be cheaper than this.)

nevertheless saving the lookup can be win.

[ TUX uses dentries directly so there is no file opening cost - it's
pretty equivalent to sendpath(), with the difference that TUX can do
security evaluation on the (held) file prior sending it - while sendpath()
is pretty much a shot into the dark. ]

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
