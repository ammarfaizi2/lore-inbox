Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUFNAsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUFNAsY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 20:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUFNArS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 20:47:18 -0400
Received: from holomorphy.com ([207.189.100.168]:32669 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261610AbUFNApT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 20:45:19 -0400
Date: Sun, 13 Jun 2004 17:45:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [10/12] fix handling of '/' embedded in filenames in isofs
Message-ID: <20040614004516.GY1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com> <20040614004034.GV1444@holomorphy.com> <20040614004147.GW1444@holomorphy.com> <20040614004354.GX1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614004354.GX1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 * Fix slashes in broken Acorn ISO9660 images in fs/isofs/dir.c (Darren Salt)
This fixes Debian BTS #141660.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=141660

	From: Darren Salt <linux@youmustbejoking.demon.co.uk>
	Message-ID: <4B238BA09A%linux@youmustbejoking.demon.co.uk>
	To: submit@bugs.debian.org
	Subject: Handle '/' in filenames in broken ISO9660 images

[Also applicable to 2.2.x]

There has been for some time a problem with certain CD-ROMs whose images were
generated using a particular tool on Acorn RISC OS. The problem is that in
certain catalogue entries, the extension separator character '/' (RISC OS
uses '.' and '/' the other way round) was not replaced with '.'; thus Linux
cannot properly parse this without this patch, thinking that it is a
directory separator.

Index: linux-2.5/fs/isofs/dir.c
===================================================================
--- linux-2.5.orig/fs/isofs/dir.c	2004-06-13 11:57:34.000000000 -0700
+++ linux-2.5/fs/isofs/dir.c	2004-06-13 12:08:57.000000000 -0700
@@ -64,7 +64,8 @@
 			break;
 
 		/* Convert remaining ';' to '.' */
-		if (c == ';')
+		/* Also '/' to '.' (broken Acorn-generated ISO9660 images) */
+		if (c == ';' || c == '/')
 			c = '.';
 
 		new[i] = c;
