Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266818AbUBEVl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266881AbUBEVjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:39:21 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:5132
	"EHLO muru.com") by vger.kernel.org with ESMTP id S266818AbUBEVc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:32:56 -0500
Date: Thu, 5 Feb 2004 13:33:03 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] powernow-k8 max speed sanity check
Message-ID: <20040205213303.GA9757@atomide.com>
References: <20040131203512.GA21909@atomide.com> <20040203131432.GE550@openzaurus.ucw.cz> <20040205181704.GC7658@atomide.com> <20040205184841.GB590@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205184841.GB590@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

Here's some comments after trying out your 2 patches. 

First, the PCMCIA patch worked great, I can now plug/unplug power cord with
yenta_socket loaded :) Maybe now I can _haul_ this laptop to a cafe and use 
the WLAN, hehe. In case anybody else needs them, I'll put the patches 
I'm using to:

http://www.muru.com/linux/amd64/

The powernow-k8.c patch did not work, as my numpst is 8, not 3. So why not
just ignore the numpst, as it is not used?

Maybe replace this

 		if (psb->numpst != 1) {
 			printk(KERN_ERR BFX "numpst must be 1\n");
-			return -ENODEV;
+			if (psb->numpst == 3) {
+				printk(KERN_INFO PFX "assuming arima notebug\n");
+				arima = 1;
+			} else
+				return -ENODEV;
 		}

With this instead:
 
 		dprintk(KERN_DEBUG PFX "numpst: 0x%x\n", psb->numpst);
 		if (psb->numpst != 1) {
-			printk(KERN_ERR BFX "numpst must be 1\n");
-			return -ENODEV;
+			printk(KERN_WARNING BFX "numpst listed as %i "
+			       "should be 1. Using 1.\n", psb->numpst);
 		}
 
Hmm, looks like that contains a bug, where it does not change psb->numpst to 1,
but that's not used anyways, so it could all be actually chopped out?

I see a little problem with hardcoding the values:

+		if (arima) {
+			ppst[1].fid = 0x8;
+			ppst[1].vid = 0x6;
+#ifdef THREE
+			ppst[2].fid = 0xa;
+			ppst[2].vid = 0x2;
+#endif
 		}

This would fail if I upgraded my CPU, right? 

What do you think about using module options maxfid and maxvid?

Regards,

Tony
