Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUEMPSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUEMPSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUEMPSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:18:24 -0400
Received: from adsl-74-86.38-151.net24.it ([151.38.86.74]:27152 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S264254AbUEMPSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:18:03 -0400
Date: Thu, 13 May 2004 17:17:59 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: problem with sis900
Message-ID: <20040513151759.GA27382@gateway.milesteg.arr>
Mail-Followup-To: Dominik Karall <dominik.karall@gmx.net>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <1084300104.24569.8.camel@datacontrol> <200405112101.09525.dominik.karall@gmx.net> <20040511214558.GC19101@picchio.gall.it> <200405120030.12883.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <200405120030.12883.dominik.karall@gmx.net>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 12, 2004 at 12:30:12AM +0200, Dominik Karall wrote:
[...]
> nvidia: module license 'NVIDIA' taints kernel.
> 0: nvidia: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-5336  Wed Jan 14 
> 18:29:26 PST 2004
[...]

Your kernel is tainted, but I'm willing to think that you can reproduce
the problem without binary modules loaded. Please confirm this.

> Let me know if you need more infos!
It seems that the driver is confused by the on chip informations it
reads and detects some 'ghost' transceivers, then decides to use one of
those, instead of taking the real one.

The following patch is a guess in this direction, it should make the
driver get the PHY at address 1, the one detected correctly for you.
Obviously, if it works, I'll need to make the patch a bit more
general before submission...

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis900-phy.diff"

--- linux-2.6.5/drivers/net/sis900.c	2004-04-04 22:31:55.000000000 +0200
+++ linux-irda-2.6.5/drivers/net/sis900.c	2004-05-13 17:04:29.000000000 +0200
@@ -665,6 +665,7 @@
 		default_phy = sis_priv->first_mii;
 
 	if( sis_priv->mii != default_phy ){
+		default_phy = sis_priv->first_mii->next;
 		sis_priv->mii = default_phy;
 		sis_priv->cur_phy = default_phy->phy_addr;
 		printk(KERN_INFO "%s: Using transceiver found at address %d as default\n", net_dev->name,sis_priv->cur_phy);

--UugvWAfsgieZRqgk--
