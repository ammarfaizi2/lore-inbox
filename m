Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130704AbQKBHVW>; Thu, 2 Nov 2000 02:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130785AbQKBHVM>; Thu, 2 Nov 2000 02:21:12 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:52476 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130704AbQKBHU5>; Thu, 2 Nov 2000 02:20:57 -0500
Message-ID: <3A0115CD.5C1083FF@uow.edu.au>
Date: Thu, 02 Nov 2000 18:20:45 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Pasi Kärkkäinen <pk@edu.joroinen.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3-order allocation failed
In-Reply-To: <Pine.LNX.4.21.0010261508530.15696-100000@duckman.distro.conectiva> <Pine.LNX.4.21.0011011306480.10457-100000@edu.joroinen.fi>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pasi Kärkkäinen" wrote:
> 
> I added show_stack(0); to the mm/page_alloc.c :
> 
>         /* No luck.. */
>         printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order)
>         show_stack(0);
>         return NULL;
> 
> Then, when the first stack-dump came to kern.log, I gave it to
> ksymoops. The result can be seen on
> 
> http://edu.joroinen.fi/~pk/ksymoops-output.
> 

Alas:

Nov  1 12:48:34 mansion kernel: c3543e80 c01e5be0 00000002 00000000 00000007 c12277c8 00000007 00000007
Nov  1 12:48:34 mansion kernel:        00000000 c02200d4 c012bb44 c01288ad c12277c8 00000246 00000007 00000000
Nov  1 12:48:34 mansion kernel:        00000001 c0128ab9 c12277c8 00000007 c6529e60 00000000 c885ed60 c886e222
Nov  1 12:48:34 mansion kernel: Call Trace: [inet_check_attr+49792/72172] [<c012bb44>] [<c01288ad>] [<c0128ab9>] [<c885ed60>] [<c886e222>] [<c885ed60>]
Nov  1 12:48:39 mansion kernel:        [<c886911c>] [<c885e185>] [<c013866d>] [<c012f782>] [<c012e9b1>] [<c012e8ea>] [<c012ebdc>] [<c010a31f>] <3>__alloc_pages: 2-order
allocation failed.

...

Trace; c886911c <[cpia]cpia_open+88/160>
Trace; c885e185 <[videodev]video_open+79/94>
Trace; c013866d <permission+95/f4>
Trace; c012f782 <chrdev_open+3e/4c>
Trace; c012e9b1 <dentry_open+bd/148>
Trace; c012e8ea <filp_open+52/5c>
Trace; c012ebdc <sys_open+38/b4>
Trace; c010a31f <system_call+33/38>
Trace; c886911c <[cpia]cpia_open+88/160>        

So your klogd tried to interpret the trace and screwed it up.  Then
ksymoops tried to interpret klogd's output and screwed it up.

Could you please change you init scripts so `klogd' is 
started with the `-x' option and then restart your logging
daemons?  There's a reasonable chance that if you do this
your klogd will segfault and stop working when it sees the
trace - I'm not sure if Debian have fixed this one.

Alternatively, if you still have that kernel,

cd /usr/src/linux
gdb vmlinux
x/10i 0xc01e5be0
x/10i 0xc02200d4
x/10i 0xc012bb44
x/10i 0xc01288ad
[etc]

That should (finally) tell us where the allocations are occurring.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
