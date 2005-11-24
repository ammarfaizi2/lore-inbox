Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbVKXR2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVKXR2O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 12:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVKXR2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 12:28:14 -0500
Received: from mx1.rowland.org ([192.131.102.7]:34823 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932432AbVKXR2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 12:28:13 -0500
Date: Thu, 24 Nov 2005 12:28:09 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Mark Lord <lkml@rtr.ca>
cc: Jeff Garzik <jgarzik@pobox.com>,
       =?ISO-8859-1?Q?Gustavo_Guil?= =?ISO-8859-1?Q?lermo_P=E9rez?= 
	<gustavo@compunauta.com>,
       <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: /dev/sr0 not ready, but working
In-Reply-To: <4385D63C.50009@rtr.ca>
Message-ID: <Pine.LNX.4.44L0.0511241225360.8378-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2005, Mark Lord wrote:

> Jeff Garzik wrote:

> > The difference is between ide-cd.c and sr.c, most likely.
> 
> Agreed.  I get hundreds and hundreds of these when simply playing a DVD:
> 
> sr0: CDROM not ready.  Make sure there is a disc in the drive.
> 
> Nothing really wrong here, other than that the kernel is flooding
> my syslogs with messages that could really be left to the userspace
> application to decide about.

If any of you is interested in pursuing this, try out this patch.  It will 
tell what the offending command is and how it is getting submitted.  Once 
that is known, the generic cdrom layer or the sr driver can be changed to 
suppress these warnings.

Alan Stern



--- a/drivers/scsi/sr_ioctl.c	Mon Oct 31 10:12:20 2005
+++ b/drivers/scsi/sr_ioctl.c	Thu Nov 24 12:24:59 2005
@@ -139,8 +139,15 @@
 					break;
 				}
 			}
-			if (!cgc->quiet)
-				printk(KERN_INFO "%s: CDROM not ready.  Make sure there is a disc in the drive.\n", cd->cdi.name);
+			if (!cgc->quiet) {
+				static int cnt = 0;
+				if (cnt < 8) {
+					++cnt;
+					printk(KERN_INFO "%s: CDROM not ready.  Make sure there is a disc in the drive.\n", cd->cdi.name);
+					printk("cmd[0] = %d\n", cgc->cmd[0]);
+					dump_stack();
+				}
+			}
 #ifdef DEBUG
 			scsi_print_sense_hdr("sr", &sshdr);
 #endif

