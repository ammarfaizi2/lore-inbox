Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135654AbRDTIpu>; Fri, 20 Apr 2001 04:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135739AbRDTIpl>; Fri, 20 Apr 2001 04:45:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7695 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135654AbRDTIpa>;
	Fri, 20 Apr 2001 04:45:30 -0400
Date: Fri, 20 Apr 2001 10:45:24 +0200
From: Jens Axboe <axboe@suse.de>
To: stefan@jaschke-net.de
Cc: "J . A . Magallon" <jamagallon@able.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: patch: cdrom_init not called correctly (was Re: ac10 ide-cd oopses on boot)
Message-ID: <20010420104524.J501@suse.de>
In-Reply-To: <20010420004914.A1052@werewolf.able.es> <01042009050000.06427@antares>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <01042009050000.06427@antares>; from s-jaschke@t-online.de on Fri, Apr 20, 2001 at 09:05:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20 2001, Stefan Jaschke wrote:
> On Friday 20 April 2001 00:49, J . A . Magallon wrote:
> > Hi,
> >
> > Just built 2.4.3-ac10 and got an oops when booting. It tries to detect
> > the CD and gives the oops.
> > >>EIP; c01bfc7c <cdrom_get_entry+1c/50>   <=====
> 
> This appears to be a known problem. Jens Axboe sent a patch in a different
> thread ("SD-W2002 DVD-RAM") that fixes this. I am including it
> here for your convenience. (The patch is against 2.4.4-pre4 + Jens' 
> latest fixes.) 

Indeed, and it was the missing init call as suspected. The problem is
that cdrom is consequently linked after low level drivers -- this is
really the stuff that should be fixed, but instead of rewriting all of
that this quick hack should suffice.

-- 
Jens Axboe


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cd-ac10-1

--- drivers/cdrom/cdrom.c~	Fri Apr 20 10:43:31 2001
+++ drivers/cdrom/cdrom.c	Fri Apr 20 10:44:21 2001
@@ -381,7 +381,7 @@
  * change it here without gcc complaining at every line.
  */
 #define ENSURE(call, bits) if (cdo->call == NULL) *change_capability &= ~(bits)
-
+static int cdrom_init(void);
 int register_cdrom(struct cdrom_device_info *cdi)
 {
 	static char banner_printed;
@@ -397,11 +397,9 @@
 	if (cdo->open == NULL || cdo->release == NULL)
 		return -2;
 	if ( !banner_printed ) {
-		printk(KERN_INFO "Uniform CD-ROM driver " REVISION "\n");
 		banner_printed = 1;
-#ifdef CONFIG_SYSCTL
-		cdrom_sysctl_register();
-#endif /* CONFIG_SYSCTL */ 
+		printk(KERN_INFO "Uniform CD-ROM driver " REVISION "\n");
+		cdrom_init();
 	}
 	ENSURE(drive_status, CDC_DRIVE_STATUS );
 	ENSURE(media_changed, CDC_MEDIA_CHANGED);
@@ -477,7 +475,6 @@
 {
 	struct cdrom_device_info *cdi, *prev;
 	int major = MAJOR(unreg->dev);
-	int bit_nr, cd_index;
 
 	cdinfo(CD_OPEN, "entering unregister_cdrom\n"); 
 
@@ -2706,7 +2703,7 @@
 
 #endif /* CONFIG_SYSCTL */
 
-static int __init cdrom_init(void)
+static int cdrom_init(void)
 {
 	int n_entries = CDROM_MAX_CDROMS / (sizeof(unsigned long) * 8);
 
@@ -2729,5 +2726,4 @@
 	devfs_unregister(devfs_handle);
 }
 
-module_init(cdrom_init);
 module_exit(cdrom_exit);

--i9LlY+UWpKt15+FH--
