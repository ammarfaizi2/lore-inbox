Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbVEHPDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVEHPDr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 11:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbVEHPDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 11:03:47 -0400
Received: from mail.nagafix.co.uk ([213.228.237.37]:55232 "EHLO
	mail.nagafix.co.uk") by vger.kernel.org with ESMTP id S262882AbVEHPDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 11:03:41 -0400
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
From: Antoine Martin <antoine@nagafix.co.uk>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com
In-Reply-To: <m1ekchvmb0.fsf@muc.de>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net>
	 <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra>
	 <1115483506.12131.33.camel@cobra>  <m1ekchvmb0.fsf@muc.de>
Content-Type: text/plain
Date: Sun, 08 May 2005 17:35:02 +0100
Message-Id: <1115570102.10373.23.camel@cobra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (..)
> That is a wrmsr to 0x00000000c0000102 (KERNEL_GS_BASE), the code 
> is trying to write 0x0000c8e816000002 into it. That is a non canonical
> address, which causes the GPF.
> 
> The strange thing is that the kernel should have rejected it in
> the first place. The code to allow user space to set kernel gs 
> checks for the address being > TASK_SIZE and TASK_SIZE is 0x800000000000.
> It should have rejected it in the first place.
> 
> Are you sure you did not apply any strange UML related patches
> to the host kernel? Maybe those are buggy.
The only extra patch applied on top of what is on the web page (as per
Jeff's instructions) is the mconsole-exec patch, and AFAIK it wouldn't
affect the code above.

Alexander Nyberg is also experiencing crashes, aren't you?
Just un-compressing portage (20MB .tar.bz2) on the root_fs image posted
earlier caused a different kind of mis-behaviour, the guest lost network
connectivity, cpu usage shot up on the host (load > 10 now), and I found
this in the host log:
kernel: segfault at 00000000df2948d0 rip 00000000601e5beb
rsp00000000df2948d0 error 4
(same kernel as earlier crashes...)
That's on a different box, running a different host kernel (FC3 2.6.9-?)

The really weird thing is that the processes are still running, but ps
-ef shows an empty string in place of the process name:
(and the terminal which launched the instance got control back)
I am now rebuilding a new kernel on another test box, let me know what
to do to provide better debug information.

# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 13:27 ?        00:00:00 init [3]
root         2     1  0 13:27 ?        00:00:00 [ksoftirqd/0]
root         3     1  0 13:27 ?        00:00:00 [events/0]
root         4     3  0 13:27 ?        00:00:00 [khelper]
root         5     3  0 13:27 ?        00:00:00 [kacpid]
root        27     3  0 13:27 ?        00:00:00 [kblockd/0]
root        28     1  0 13:27 ?        00:00:00 [khubd]
root        40     3  0 13:27 ?        00:00:00 [pdflush]
root        41     3  0 13:27 ?        00:00:00 [pdflush]
root        43     3  0 13:27 ?        00:00:00 [aio/0]
root        42     1  0 13:27 ?        00:00:00 [kswapd0]
root       115     1  0 13:27 ?        00:00:00 [kseriod]
root       183     3  0 13:27 ?        00:00:00 [ata/0]
root       185     1  0 13:27 ?        00:00:00 [scsi_eh_0]
root       186     1  0 13:27 ?        00:00:00 [scsi_eh_1]
root       202     1  0 13:27 ?        00:00:00 [kjournald]
root      1025     1  0 13:27 ?        00:00:00 udevd
root      1261     1  0 13:27 ?        00:00:00 [khpsbpkt]
root      1290     1  0 13:27 ?        00:00:00 [knodemgrd_0]
root      1453     1  0 13:27 ?        00:00:00 [kjournald]
root      1454     1  0 13:27 ?        00:00:00 [kjournald]
root      1693     1  0 13:28 ?        00:00:00 syslogd -m 0
root      1697     1  0 13:28 ?        00:00:00 klogd -x
nobody    1737     1  0 13:28 ?        00:00:00 mDNSResponder
root      1755     1  0 13:28 ?        00:00:00 /usr/sbin/acpid
root      1770     1  0 13:28 ?        00:00:00 /usr/sbin/sshd
root      1779     1  0 13:28 ?        00:00:00 gpm -m /dev/input/mice
-t imps2
root      1809     1  0 13:28 ?        00:00:00 crond
dbus      1833     1  0 13:28 ?        00:00:00 dbus-daemon-1 --system
root      1842     1  0 13:28 ?        00:00:00 hald
root      1849     1  0 13:28 ?        00:00:00 login -- root
root      1850     1  0 13:28 tty2     00:00:00 /sbin/mingetty tty2
root      1851     1  0 13:28 tty3     00:00:00 /sbin/mingetty tty3
root      1852     1  0 13:28 tty4     00:00:00 /sbin/mingetty tty4
root      1853     1  0 13:28 tty5     00:00:00 /sbin/mingetty tty5
root      1854     1  0 13:28 tty6     00:00:00 /sbin/mingetty tty6
root      2270  1849  0 13:31 tty1     00:00:00 -bash
root      2312  1770  0 13:31 ?        00:00:00 sshd: root@pts/0
root      2314  2312  0 13:32 pts/0    00:00:00 -bash
root      2363  2314 19 13:36 pts/0    00:30:19 ./setiathome
root      4346  1770  0 15:03 ?        00:00:00 sshd: root@pts/1
root      4350  4346  0 15:03 pts/1    00:00:00 -bash
root      5291  4350  0 15:14 pts/1    00:00:00 tail
-f /var/log/messages /var/log/secure
root      6179     1  0 15:16 pts/0    00:00:35
root      7231     1  0 15:16 pts/0    00:00:35
root      7252     1  0 15:16 pts/0    00:00:35
root      7345     1  0 15:17 ?        00:00:00 /usr/sbin/dhcpd
root      7352     1  0 15:17 pts/0    00:00:34
root      7485     1  0 15:17 pts/0    00:00:34
root      7509     1  0 15:17 pts/0    00:00:34
root      7520  1770  0 15:18 ?        00:00:00 sshd: root@pts/2
root      7522  7520  0 15:18 pts/2    00:00:00 -bash
root      7561  7522  0 15:18 pts/2    00:00:00 ssh -v root@10.0.0.250
root      7563     1  1 15:18 pts/0    00:00:35
root      7571     1  1 15:18 pts/0    00:00:35
root     10302  1770  0 15:57 ?        00:00:00 sshd: root@pts/3
root     10304 10302  0 15:57 pts/3    00:00:00 -bash
root     10422     1  8 16:08 pts/0    00:00:38
root     10424     1  9 16:08 pts/0    00:00:42
root     10445  2314  0 16:16 pts/0    00:00:00 ps -ef


