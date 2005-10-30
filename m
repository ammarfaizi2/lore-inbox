Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVJ3Vkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVJ3Vkz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVJ3Vkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:40:55 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:26788 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932352AbVJ3Vky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:40:54 -0500
Date: Sun, 30 Oct 2005 22:40:52 +0100
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: Re: BIND hangs with 2.6.14
Message-ID: <20051030214052.GA1454@uio.no>
References: <20051030023557.GA7798@uio.no> <2c0942db0510301054j64e650efqe416e14fc1e3bff2@mail.gmail.com> <20051030190538.GA25940@uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051030190538.GA25940@uio.no>
X-Operating-System: Linux 2.6.14-rc5 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.8 (--)
X-Spam-Report: Status=No hits=-2.8 required=5.0 tests=ALL_TRUSTED version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 08:05:38PM +0100, Steinar H. Gunderson wrote:
> I have a run going in valgrind now to see if it can find anything bad about
> the pointers in the msg_hdr structure (the structure itself appears to be OK,
> judging from my printf-debugging); it's been going for a few hours, so I hope
> it will be entering its zombie mode now soon :-)

I finally caught it with gdb, after inserting some debug probes. Excerpts
(removed a few syntax errors):

(gdb) bt
#0  0xffffe405 in __kernel_vsyscall ()
#1  0x55840885 in raise () from /lib/tls/i686/cmov/libc.so.6
#2  0x55842002 in abort () from /lib/tls/i686/cmov/libc.so.6
#3  0x557e1383 in doio_recv (sock=0x80d1230, dev=0x8197ac8) at socket.c:917
#4  0x557e41d5 in internal_recv (me=0x81975a0, ev=0x80d1284) at socket.c:2012
#5  0x557d6259 in dispatch (manager=0x8094960) at task.c:855
#6  0x557d64c7 in run (uap=0x8094960) at task.c:998
#7  0x5580cca3 in start_thread () from /lib/tls/i686/cmov/libpthread.so.0
#8  0x558eff5a in clone () from /lib/tls/i686/cmov/libc.so.6
(gdb) up
#1  0x55840885 in raise () from /lib/tls/i686/cmov/libc.so.6
(gdb)
#2  0x55842002 in abort () from /lib/tls/i686/cmov/libc.so.6
(gdb)
#3  0x557e1383 in doio_recv (sock=0x80d1230, dev=0x8197ac8) at socket.c:917
917                     abort();
(gdb) print msghdr
$1 = {msg_name = 0x8197b14, msg_namelen = 28, msg_iov = 0x561519e0, msg_iovlen = 1, msg_control = 0x809a810, msg_controllen = 52, msg_flags = 0}
(gdb) print msghdr.msg_name
$2 = (void *) 0x8197b14
(gdb) print (char *)msghdr.msg_name
$3 = 0x8197b14 ""
(gdb) print ((char *)msghdr.msg_name)[0]
$4 = 0 '\0'
(gdb) print ((char *)msghdr.msg_name)[27]
$5 = 0 '\0'
(gdb) print ((char *)msghdr.msg_control)[0]
$6 = 20 '\024'
(gdb) print ((char *)msghdr.msg_control)[51]
$7 = -66 '¾'
(gdb) print *(msghdr.msg_iov)
$9 = {iov_base = 0x8171208, iov_len = 4096}
(gdb) print ((char*)msghdr.msg_iov.iov_base)[0]
$10 = -30 'â'
(gdb) print ((char*)msghdr.msg_iov.iov_base)[4095]
$11 = -66 '¾'
(gdb) print sock->fd
$12 = 22
(gdb) print recvmsg(sock->fd, &msghdr, 0)
$14 = 42

IOW, the call that just failed suddenly worked in the debugger. I can't
really believe this is a BIND bug anymore... I'm lost here. Anyone?

/* Steinar */
-- 
Homepage: http://www.sesse.net/
