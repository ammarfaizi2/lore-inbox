Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270321AbTGRTlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 15:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270302AbTGRTlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 15:41:11 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:5395 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S270321AbTGRTlI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 15:41:08 -0400
Date: Fri, 18 Jul 2003 21:50:02 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] 2.6.0-test1-after-alan-s-patch - Fix error path in kahlua driver
Message-ID: <20030718215002.A780@electric-eye.fr.zoreil.com>
References: <200307181431.h6IEVV2g017880@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307181431.h6IEVV2g017880@hraefn.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Jul 18, 2003 at 03:31:31PM +0100
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Memory leak fix: hw_config is allocated before the call to sb_dsp_detect.

I don't know if it compiles because I haven't done the required patch
for sound/oss/Makefile yet :o)


 sound/oss/kahlua.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff -puN sound/oss/kahlua.c~janitor-error-path-kahlua sound/oss/kahlua.c
--- linux-2.6.0-test1-20030718_0517/sound/oss/kahlua.c~janitor-error-path-kahlua	Fri Jul 18 21:29:52 2003
+++ linux-2.6.0-test1-20030718_0517-fr/sound/oss/kahlua.c	Fri Jul 18 21:38:14 2003
@@ -159,7 +159,7 @@ static int __devinit probe_one(struct pc
 	if(sb_dsp_detect(hw_config, 0, 0, NULL)==0)
 	{
 		printk(KERN_ERR "kahlua: audio not responding.\n");
-		return 1;
+		goto err_out_free;
 	}
 
 	oldquiet = sb_be_quiet;	
@@ -167,13 +167,16 @@ static int __devinit probe_one(struct pc
 	if(sb_dsp_init(hw_config, THIS_MODULE))
 	{
 		sb_be_quiet = oldquiet;
-		pci_set_drvdata(pdev, NULL);
-		kfree(hw_config);
-		return 1;
+		goto err_out_free;
 	}
 	sb_be_quiet = oldquiet;
 	
 	return 0;
+
+err_out_free:
+	pci_set_drvdata(pdev, NULL);
+	kfree(hw_config);
+	return 1;
 }
 
 static void __devexit remove_one(struct pci_dev *pdev)

_
