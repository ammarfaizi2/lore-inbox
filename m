Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbUDFUHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263988AbUDFUHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:07:04 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:26802 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S263983AbUDFUGq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:06:46 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: Dave Jones <davej@redhat.com>, Bjoern Michaelsen <bmichaelsen@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Date: Tue, 6 Apr 2004 22:06:38 +0200
User-Agent: KMail/1.6.1
References: <20040406031949.GA8351@lord.sinclair> <200404062044.06533.volker.hemmann@heim10.tu-clausthal.de> <20040406192447.GA1100@redhat.com>
In-Reply-To: <20040406192447.GA1100@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404062206.38731.volker.hemmann@heim10.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 06 April 2004 21:24, Dave Jones wrote:
> On Tue, Apr 06, 2004 at 08:44:06PM +0200, Hemmann, Volker Armin wrote:
>  > I rebooted.
>  > Same error, uname -r:
>  > Linux energy.heim10.tu-clausthal.de 2.6.5 #1 Tue Apr 6 20:26:45 CEST
>  > 2004 i686 AMD Athlon(tm) XP 2000+ AuthenticAMD GNU/Linux
>  >
>  > So yes, I am pretty sure, that I am innocent ;o)
>
> Ok, what happens if you nuke the ..
>
> 	} else {
> 		sis_driver.agp_enable=sis_648_enable;
> 	}
>
> in sis_get_driver() ?
> That should put things back to 2.6.4 style "working" order for you.
>
> 		Dave

more bad news, it did not.
It compiled and the module loaded, but with the error again.
I copied over tht sis-agp.c from 2.6.5-rc3 that was modified with your patches 
last week and AGP is now working again.
I did a diff between the modified sis-agp.c from 2.6.5 (sis-agp.bak, without 
the else) and the working sis-agp.c from 2.6.5-rc3 (now in 2.6.5):


bash-2.05b$ diff 
-u /usr/src/linux/drivers/char/agp/sis-agp.bak /usr/src/linux-2.6.5-rc3/drivers/char/agp/sis-agp.c
--- /usr/src/linux/drivers/char/agp/sis-agp.bak 2004-04-06 21:43:53.000000000 
+0200
+++ /usr/src/linux-2.6.5-rc3/drivers/char/agp/sis-agp.c 2004-04-02 
03:21:43.000000000 +0200
@@ -92,17 +92,17 @@
<snap only whitespace difference> 

@@ -225,9 +225,11 @@

 static void __devinit sis_get_driver(struct agp_bridge_data *bridge)
 {
-       if (bridge->dev->device == PCI_DEVICE_ID_SI_648 ||
-           bridge->dev->device == PCI_DEVICE_ID_SI_746) {
-               if (agp_bridge->major_version == 3) {
+        if (bridge->dev->device == PCI_DEVICE_ID_SI_648 ||
+           bridge->dev->device == PCI_DEVICE_ID_SI_746) {
+               if (agp_bridge->major_version == 3 && 
agp_bridge->minor_version < 5) {
+                       sis_driver.agp_enable=sis_648_enable;
+               } else {
                        sis_driver.agp_enable                   = 
sis_648_enable;
                        sis_driver.aperture_sizes               = 
agp3_generic_sizes;
                        sis_driver.size_type                    = 
U16_APER_SIZE;


Glück Auf
Volker

-- 
Conclusions 
 In a straight-up fight, the Empire squashes the Federation like a bug. Even 
with its numerical advantage removed, the Empire would still squash the 
Federation like a bug. Accept it. -Michael Wong 
