Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUCVENX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 23:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUCVENX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 23:13:23 -0500
Received: from ns.suse.de ([195.135.220.2]:30894 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261677AbUCVENW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 23:13:22 -0500
Date: Mon, 22 Mar 2004 05:13:18 +0100
From: Andi Kleen <ak@suse.de>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Drop O_LARGEFILE from F_GETFL for POSIX compliance
Message-Id: <20040322051318.597ad1f9.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 64bit architectures open() sets O_LARGEFILE implicitely. This causes the LSB
testsuite to fail, which checks that F_GETFL only returns the flags set by 
a previous open.

According to the POSIX standards gurus the Linux behaviour is not compliant.

This patch fixes this by just not reporting O_LARGEFILE in F_GETFL.

This has been in several shipping SuSE releases and the x86-64.org CVS
treee for a long time, so is unlikely to break anything.

-Andi

diff -burpN -X ../KDIFX linux-2.4.26-pre5/fs/fcntl.c linux-merge/fs/fcntl.c
--- linux-2.4.26-pre5/fs/fcntl.c	2004-01-13 10:29:17.000000000 +0100
+++ linux-merge/fs/fcntl.c	2003-10-23 15:40:52.000000000 +0200
@@ -271,7 +271,7 @@ static long do_fcntl(unsigned int fd, un
 			set_close_on_exec(fd, arg&1);
 			break;
 		case F_GETFL:
-			err = filp->f_flags;
+			err = filp->f_flags & ~O_LARGEFILE;
 			break;
 		case F_SETFL:
 			lock_kernel();
