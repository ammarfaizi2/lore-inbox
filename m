Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265634AbUBFTKA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265694AbUBFTKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:10:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57059 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265634AbUBFTJ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:09:57 -0500
Date: Fri, 6 Feb 2004 19:09:56 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: John Cherry <cherry@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.2 - 2004-02-05.22.30) - 3 New warnings (gcc 3.2.2)
Message-ID: <20040206190956.GN21151@parcelfarce.linux.theplanet.co.uk>
References: <200402061122.i16BMZ10009537@cherrypit.pdx.osdl.net> <20040206113305.GF21151@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402060850380.30672@home.osdl.org> <20040206182208.GI21151@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402061041190.30672@home.osdl.org> <20040206184707.GL21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206184707.GL21151@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 06:47:07PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> Anyway, in both of those cases BUG() is gratitious.  What that code tries
> to do is "if we decided to use one of the old modes, we'll need 3 ports;
> otherwise we should claim 8".  So simple if() would be enough.  I'll send
> a patch in a few.

Please, apply

diff -urN RC2-bk1-base/drivers/scsi/imm.c RC2-bk1-current/drivers/scsi/imm.c
--- RC2-bk1-base/drivers/scsi/imm.c	Thu Feb  5 18:48:49 2004
+++ RC2-bk1-current/drivers/scsi/imm.c	Fri Feb  6 14:07:08 2004
@@ -1208,19 +1208,10 @@
 		goto out1;
 
 	/* now the glue ... */
-	switch (dev->mode) {
-	case IMM_NIBBLE:
-	case IMM_PS2:
+	if (dev->mode == IMM_NIBBLE || dev->mode == IMM_PS2)
 		ports = 3;
-		break;
-	case IMM_EPP_8:
-	case IMM_EPP_16:
-	case IMM_EPP_32:
+	else
 		ports = 8;
-		break;
-	default:	/* Never gets here */
-		BUG();
-	}
 
 	INIT_WORK(&dev->imm_tq, imm_interrupt, dev);
 
diff -urN RC2-bk1-base/drivers/scsi/ppa.c RC2-bk1-current/drivers/scsi/ppa.c
--- RC2-bk1-base/drivers/scsi/ppa.c	Thu Feb  5 18:48:57 2004
+++ RC2-bk1-current/drivers/scsi/ppa.c	Fri Feb  6 14:07:50 2004
@@ -1069,21 +1069,10 @@
 		goto out1;
 
 	/* now the glue ... */
-	switch (dev->mode) {
-	case PPA_NIBBLE:
+	if (dev->mode == PPA_NIBBLE || dev->mode == PPA_PS2)
 		ports = 3;
-		break;
-	case PPA_PS2:
-		ports = 3;
-		break;
-	case PPA_EPP_8:
-	case PPA_EPP_16:
-	case PPA_EPP_32:
+	else
 		ports = 8;
-		break;
-	default:	/* Never gets here */
-		BUG();
-	}
 
 	INIT_WORK(&dev->ppa_tq, ppa_interrupt, dev);
 
