Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUBXH5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 02:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbUBXH5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 02:57:52 -0500
Received: from mxsf06.cluster1.charter.net ([209.225.28.206]:3589 "EHLO
	mxsf06.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262205AbUBXH5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 02:57:46 -0500
Subject: Re: 2.6.3 oops at kobject_unregister, alsa & aic7xxx
From: Eric Kerin <eric@bootseg.com>
To: Andrew Morton <akpm@osdl.org>
Cc: alexn@telia.com, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20040223233218.73e61a9e.akpm@osdl.org>
References: <1077546633.362.28.camel@boxen>
	 <20040223160716.799195d0.akpm@osdl.org> <1077602725.3172.19.camel@opiate>
	 <20040223221740.5786b0b3.akpm@osdl.org> <1077606462.3172.38.camel@opiate>
	 <20040223233218.73e61a9e.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1077609283.3172.46.camel@opiate>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 24 Feb 2004 02:54:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-24 at 02:32, Andrew Morton wrote:
> Eric Kerin <eric@bootseg.com> wrote:
> >  There's a 2nd patch in the above thread that changes those modules to
> >  stay loaded even if no devices are found, which Arjan V pointed out was
> >  the preferred way for drivers to work.
> 
> Sounds good.  Do you have that patch handy?
> -

Sure do, 

Below are the patches I coded up for the aic7xxx and aic79xx drivers
that leave the module loaded.

Eric Kerin


--- aic7xxx_osm.c.original      2004-01-02 03:56:32.000000000 -0500
+++ aic7xxx_osm.c       2004-01-03 05:03:41.000000000 -0500
@@ -844,6 +844,7 @@ ahc_linux_detect(Scsi_Host_Template *tem
 {
        struct  ahc_softc *ahc;
        int     found;
+       int     pci_reg_state;
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
        /*
@@ -891,8 +892,9 @@ ahc_linux_detect(Scsi_Host_Template *tem
         */
        ahc_list_lockinit();
 
+       pci_reg_state = -1;
 #ifdef CONFIG_PCI
-       ahc_linux_pci_init();
+       pci_reg_state = ahc_linux_pci_init();
 #endif
 
 #ifdef CONFIG_EISA
@@ -913,6 +915,10 @@ ahc_linux_detect(Scsi_Host_Template *tem
        spin_lock_irq(&io_request_lock);
 #endif
        aic7xxx_detect_complete++;
+       if(pci_reg_state == 0 && found == 0){
+               return(1); 
+       }
+
        return (found);
 }
 


--- aic79xx_osm.c.original      2004-01-02 02:46:43.000000000 -0500
+++ aic79xx_osm.c       2004-01-03 05:05:52.000000000 -0500
@@ -856,6 +856,7 @@ ahd_linux_detect(Scsi_Host_Template *tem
 {
        struct  ahd_softc *ahd;
        int     found;
+       int     pci_reg_state;
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
        /*
@@ -906,8 +907,9 @@ ahd_linux_detect(Scsi_Host_Template *tem
         */
        ahd_list_lockinit();
 
+       pci_reg_state = -1;
 #ifdef CONFIG_PCI
-       ahd_linux_pci_init();
+       pci_reg_state = ahd_linux_pci_init();
 #endif
 
        /*
@@ -924,6 +926,10 @@ ahd_linux_detect(Scsi_Host_Template *tem
        spin_lock_irq(&io_request_lock);
 #endif
        aic79xx_detect_complete++;
+       if(pci_reg_state == 0 && found == 0){
+               return(1); 
+       }
+
        return (found);
 }

