Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTJ3C1G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 21:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTJ3C1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 21:27:06 -0500
Received: from ozlabs.org ([203.10.76.45]:52715 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262116AbTJ3C1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 21:27:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16288.30574.745348.194005@cargo.ozlabs.ibm.com>
Date: Thu, 30 Oct 2003 13:29:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Bug somewhere in crypto or ipsec stuff
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this oops in strcmp, called from crypto_alg_lookup, when I run
the "spi" command from a freeswan snapshot from 13 October this year.
The kernel is 2.6.0-test9.

Oops: kernel access of bad area, sig: 11 [#1]
NIP: C001323C LR: C00CEE6C SP: CB8D1C60 REGS: cb8d1bb0 TRAP: 0301    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 40000000
TASK = ca0c2320[934] 'spi' Last syscall: 4 
GPR00: C02D5204 CB8D1C60 CA0C2320 00000063 FFFFFFFF C02D5284 CB472A38 00000003 
GPR08: C03D0C84 C033BCBC 00000000 C00CF03C C03D0C84 
Call trace:
 [c00cf058] crypto_alloc_tfm+0x1c/0x104
 [cd97fb34] ipcomp_init_state+0x90/0x118 [ipcomp]
 [c0233a2c] pfkey_msg2xfrm_state+0x598/0x740
 [c0233ed4] pfkey_add+0x2c/0x148
 [c0235bb4] pfkey_process+0xb8/0xc0
 [c0236ba0] pfkey_sendmsg+0x124/0x204
 [c01c2018] sock_aio_write+0xe8/0x104
 [c0054e6c] do_sync_write+0x74/0xb8
 [c0054fc0] vfs_write+0x110/0x128
 [c005508c] sys_write+0x40/0x74
 [c0007a9c] ret_from_syscall+0x0/0x44

The problem is basically that crypto_alg_lookup gets called with NULL
for the `name' parameter.

The command that provokes the oops is:

spi --af inet --said tun.1234@10.61.2.68 --ip4 --src 10.61.2.90 \
    --dst 10.61.2.68

I was trying this because the freeswan web pages claim that they have
some preliminary support for 2.6 in their user command set.  I was
only half expecting the spi command to work, but it shouldn't have
been able to cause an oops.

Paul.
