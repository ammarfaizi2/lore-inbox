Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423190AbWJQJHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423190AbWJQJHN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 05:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423191AbWJQJHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 05:07:13 -0400
Received: from mailer.campus.mipt.ru ([194.85.82.4]:36233 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S1423190AbWJQJHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 05:07:11 -0400
Date: Tue, 17 Oct 2006 13:08:09 +0400
Message-Id: <200610170908.k9H989xT004364@vass.7ka.mipt.ru>
From: Vasily Tarasov <vtaras@openvz.org>
To: Jan Kara <jack@suse.cz>
CC: Vasily Averin <vvs@sw.ru>
CC: Kirill Korotaev <dev@openvz.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: OpenVZ Developers List <devel@openvz.org>
Subject: 32 bit quota tools problem on 64bit architectures
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Tue, 17 Oct 2006 13:06:42 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OpenVZ Linux kernel team has discovered that there is a problem
with 32 bit quota tools on 64 bit architectures.

In 2.6.10 kernel the patch
http://linux.bkbits.net:8080/linux-2.6/patch@1.1938.302.19 was introduced:

--- a/arch/x86_64/ia32/ia32entry.S	2006-10-17 09:40:14 -07:00
+++ b/arch/x86_64/ia32/ia32entry.S	2006-10-17 09:40:14 -07:00
@@ -433,7 +433,7 @@
 	.quad sys_init_module
 	.quad sys_delete_module
 	.quad quiet_ni_syscall		/* 130  get_kernel_syms */
-	.quad sys32_quotactl		/* quotactl */ 
+	.quad sys_quotactl
 	.quad sys_getpgid
 	.quad sys_fchdir
 	.quad quiet_ni_syscall	/* bdflush */

The comment for this patch is:

"[PATCH] x86_64: Add 32bit quota support
[untested, but other 64bit ports seem to get away with it]
sys_quotactl seems to be 32/64bit clean, enable it for 32bit."

However this isn't right! Look at if_dqblk structure:

struct if_dqblk {
        __u64 dqb_bhardlimit;
        __u64 dqb_bsoftlimit;
        __u64 dqb_curspace;
        __u64 dqb_ihardlimit;
        __u64 dqb_isoftlimit;
        __u64 dqb_curinodes;
        __u64 dqb_btime;
        __u64 dqb_itime;
        __u32 dqb_valid;
};

For 64 bit kernel its size is 0x48, but not 0x44, 'cause of alignment!
But for 32 bit quota tools it's 0x44, 'cause there is no such alignment.
Thus we got a problem. In OpenVZ technology 32 bit Virtual Environments over 
64 bit OS are common, hence we have customers, that complains on this bad quota
behaviour: 

# /usr/bin/quota
quota: error while getting quota from /dev/sda1 for 0: Success

The reason of this bad behaviour is stated above.

Thank you,
	Vasily Tarasov,
	OpenVZ Linux kernel team

FYI, node description:
# uname -a
Linux nodename 2.6.18 #1 SMP Tue Oct 17 12:24:11 MSD 2006 x86_64 x86_64 x86_64
GNU/Linux
# /usr/bin/quota -V
Quota utilities version 3.13.
Compiled with RPC and EXT2_DIRECT
Bugs to jack@suse.cz

(quota-tools are got from Debian testing repository.)

# file /usr/bin/quota
/ust/bin/quota: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), for
GNU/Linux 2.4.1, dynamically linked (uses shared libs), stripped
# ls -l /lib/libc.so.6
lrwxrwxrwx  1 root root 13 Oct  4 13:50 /lib/libc.so.6 -> libc-2.3.4.so
