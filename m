Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUBHDs7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 22:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUBHDs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 22:48:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31940 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261974AbUBHDs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 22:48:57 -0500
Date: Sun, 8 Feb 2004 03:48:56 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: walt <wa1ter@myrealbox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: [2.6.1] Kernel panic with ppa driver updates
Message-ID: <20040208034855.GC21151@parcelfarce.linux.theplanet.co.uk>
References: <fa.db71fu4.1gju7jo@ifi.uio.no> <fa.n1cha2m.1hhep3a@ifi.uio.no> <4025AE98.3090601@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4025AE98.3090601@myrealbox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 07:35:52PM -0800, walt wrote:
> Only one of the print statements was executed, apparently:
> 
> ppa: Version 2.07 (for Linux 2.4.x)
> dev = dfd67940, dev->cur_cmd = 7232b2df
> Unable to handle kernel paging request at virtual address 7232b403
>  printing eip:
> c027bc25
> 
> The remainder of the message was identical to the previous post -- no
> extra printed messages anywhere.

Aaaaaargh....  dev = memset(dev, 0, sizeof(dev)); - spot the bug here...

Fix follows.  Linus, apply it, please.  Amazing that it survives in modular
case...

diff -urN RC2-bk1-base/drivers/scsi/imm.c RC2-bk1-current/drivers/scsi/imm.c
--- RC2-bk1-base/drivers/scsi/imm.c	Thu Feb  5 18:48:49 2004
+++ RC2-bk1-current/drivers/scsi/imm.c	Sat Feb  7 22:44:16 2004
@@ -1153,7 +1153,7 @@
 	if (!dev)
 		return -ENOMEM;
 
-	memset(dev, 0, sizeof(dev));
+	memset(dev, 0, sizeof(imm_struct));
 
 	dev->base = -1;
 	dev->mode = IMM_AUTODETECT;
diff -urN RC2-bk1-base/drivers/scsi/ppa.c RC2-bk1-current/drivers/scsi/ppa.c
--- RC2-bk1-base/drivers/scsi/ppa.c	Thu Feb  5 18:48:57 2004
+++ RC2-bk1-current/drivers/scsi/ppa.c	Sat Feb  7 22:44:27 2004
@@ -1010,7 +1010,7 @@
 	dev = kmalloc(sizeof(ppa_struct), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
-	memset(dev, 0, sizeof(dev));
+	memset(dev, 0, sizeof(ppa_struct));
 	dev->base = -1;
 	dev->mode = PPA_AUTODETECT;
 	dev->recon_tmo = PPA_RECON_TMO;
