Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267227AbUFZXJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267227AbUFZXJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267229AbUFZXJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:09:29 -0400
Received: from [213.22.183.248] ([213.22.183.248]:56963 "HELO corah.org")
	by vger.kernel.org with SMTP id S267227AbUFZXJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:09:22 -0400
Message-ID: <007b01c45bd2$9c0687f0$020010ac@local>
From: "Joao Santos" <jps@corah.org>
To: <linux-kernel@vger.kernel.org>
Subject: setuid odd behaviour
Date: Sun, 27 Jun 2004 00:09:19 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2739.300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone.

I have been rewriting a private privilege system in the 2.6.7 kernel and
while making the final tests, vsftpd did not work because it could not set
capabilities after changing to UID 99 (which seemed correct to me).  Just to
make sure I was doing the right thing, I booted up a vanilla kernel and
traced vsftpd again to see how the kernel was reacting to that setcap()
after setuid() and strangely the kernel let the setcap through and returned
success.

After watching that, I placed several debugging messages within the kernel
(one of which was in sys_setcap()) and noticed that in the vanilla kernel
even though the [R]|[S]|[E]UID all change with the setuid() call, the
permitted capability set is kept in vsftpd, the CAP_SETPCAP capability is
disabled (as it is by default in the vanilla kernel) so no other processes
can change the daemon's capabilities and the daemon itself is not doing
anything unusual before calling setuid() but what is a noticeable fact is
that those permitted capabilities are kept AFTER the setuid() call and it
only happens in vsftpd!  When I do the same thing by myself, the kernel
resets all my capability sets!

Software used (only the relevant software is listed):
 * linux 2.6.7;
 * strace 4.5.4 (the code had to be changed to compile with the linux 2.6
headers);
 * vsftpd 1.2.2.

How to trigger this:
 1 - Set up inetd to run vsftpd (I did not test it in the standalone mode);
 2 - Set up vsftpd to run in inetd;
 3 - Restart/-HUP inetd;
 4 - Make a local ftp connection;
 5 - When the client prompts for the username, switch to another terminal;
 6 - Find out which vsftpd is the parent;
 7 - Attach strace to the parent process;
 8 - Switch back to the first terminal and finish the login process with a
valid user/pass.

At this point, strace must be showing something like the following:
setgroups32(0, [])                      = 0
chdir("/usr/share/empty")               = 0
chroot(".")                             = 0
capset(NULL, NULL)                      = -1 EFAULT (Bad address)
prctl(0x8, 0, 0x8056197, 0, 0)          = 0
prctl(0x8, 0x1, 0xbffff9fc, 0x80560bf, 0xbffffa30) = 0
setgid32(99)                            = 0
setuid32(99)                            = 0
capset(0x19980330, 0, {CAP_CHOWN|CAP_NET_BIND_SERVICE,
CAP_CHOWN|CAP_NET_BIND_SERVICE, }) = 0

Meanwhile my debugging code in the kernel sources show the following in
dmesg:
sys_capset(): ruid: 99, euid: 99, suid: 99, c_effective: 0
c_permitted: -257, c_inheritable: 0, n_effective: 1025 n_permitted: 1025,
n_inheritable: 0
The -257 there is just a wrong format (%ld instead of %lu) and means
~CAP_SETPCAP while 1025 means CAP_CHOWN | CAP_NET_BIND_SERVICE.

Is this a bug or a feature which I don't know about and vsftpd uses in all
its glory?  If it is a feature, could someone explain me how to use it?  I
would like to mimic the same behaviour in my own privilege system as it is
currently preventing vsftpd from running due to the lack of privileges after
setuid().  If it is a bug, it may also affect the 2.4 and 2.2 series.

Thanks everyone in advance.
Joao Santos [jps@corah.org]


