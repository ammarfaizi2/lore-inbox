Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbUADCNH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 21:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUADCNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 21:13:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61644 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264452AbUADCNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 21:13:02 -0500
Date: Sun, 4 Jan 2004 02:12:46 +0000
From: Dave Jones <davej@redhat.com>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: agpgart issue on 2.6.1-rc1-bk3 (x86-64)
Message-ID: <20040104021246.GB10650@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Srihari Vijayaraghavan <harisri@bigpond.com>,
	linux-kernel@vger.kernel.org
References: <200401041228.22987.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401041228.22987.harisri@bigpond.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 12:28:22PM +1100, Srihari Vijayaraghavan wrote:
 > Hello,
 > 
 > I see this message in the 2.6.1-rc3-bk3 kernel log:
 > agpgart: Detected AGP bridge 0
 > agpgart: Too many northbridges for AGP
 > 
 > This results in <100 FPS in glxgears, and I am unable to play the tuxracer 
 > game :-). With 2.6.0-x8664-1 however I get 450 FPS (approx), and all was 
 > well.
 > 
 > Upon applying this patch (making it identical to 2.6.0-x86-64 that is):
 > --- 2.6.1-rc1-bk3/drivers/char/agp/amd64-agp.c.orig     2004-01-04 
 > 01:06:20.000000000 +1100
 > +++ 2.6.1-rc1-bk3/drivers/char/agp/amd64-agp.c  2004-01-04 01:06:50.000000000 
 > +1100
 > @@ -16,11 +16,7 @@
 >  #include "agp.h"
 > 
 >  /* Will need to be increased if AMD64 ever goes >8-way. */
 > -#ifdef CONFIG_SMP
 >  #define MAX_HAMMER_GARTS   8
 > -#else
 > -#define MAX_HAMMER_GARTS   1
 > -#endif

Wrong fix.  Amongst another bunch of AGP fixes going to Linus/Andrew
on Monday is the following..

(Andi also sent me another amd64 update, which I'll merge before
 pushing Linuswards)


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/agp/amd64-agp.c linux-2.5/drivers/char/agp/amd64-agp.c
--- bk-linus/drivers/char/agp/amd64-agp.c	2003-10-17 20:53:49.000000000 +0100
+++ linux-2.5/drivers/char/agp/amd64-agp.c	2003-12-02 02:05:32.000000000 +0000
@@ -357,11 +356,18 @@ static __devinit int cache_nbs (struct p
 		}
 		hammers[i++] = loop_dev;
 		nr_garts = i;
-		if (i == MAX_HAMMER_GARTS) { 
+#ifdef CONFIG_SMP
+		if (i > MAX_HAMMER_GARTS) { 
 			printk(KERN_INFO PFX "Too many northbridges for AGP\n");
 			return -1;
 		}
+#else
+		/* Uniprocessor case, return after finding first bridge.
+		   (There may be more, but in UP, we don't care). */
+		return 0;
+#endif
 	}
+
 	return i == 0 ? -1 : 0;
 }
 

 
-- 
 Dave Jones     http://www.codemonkey.org.uk
