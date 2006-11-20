Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966767AbWKTVfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966767AbWKTVfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966788AbWKTVfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:35:42 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:19679 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S966767AbWKTVfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:35:41 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 20 Nov 2006 22:34:40 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [2.6 patch] the scheduled removal of
 RAW1394_REQ_ISO_{SEND,LISTEN}
To: Adrian Bunk <bunk@stusta.de>
cc: Jody McIntyre <scjody@modernduck.com>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20061120210705.GD31879@stusta.de>
Message-ID: <tkrat.7924e1457666b8be@s5r6.in-berlin.de>
References: <20061120210705.GD31879@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Nov, Adrian Bunk wrote:
> This patch contains the scheduled removal of requests of type 
> RAW1394_REQ_ISO_SEND, RAW1394_REQ_ISO_LISTEN.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  Documentation/feature-removal-schedule.txt |    9 -
>  drivers/ieee1394/highlevel.c               |   37 ----
>  drivers/ieee1394/highlevel.h               |   21 --
>  drivers/ieee1394/hosts.h                   |    2 
>  drivers/ieee1394/ieee1394_core.c           |    7 
>  drivers/ieee1394/ieee1394_transactions.c   |   30 ----
>  drivers/ieee1394/ieee1394_transactions.h   |    2 
>  drivers/ieee1394/raw1394-private.h         |    5 
>  drivers/ieee1394/raw1394.c                 |  157 ---------------------
>  drivers/ieee1394/raw1394.h                 |    4 
>  10 files changed, 3 insertions(+), 271 deletions(-)

Thanks for this cleanup. Now that you did the work I hope you are not
too upset that a recent discussion on linux1394-devel and
libdc1394-devel concluded with another delay of the feature removal.
http://thread.gmane.org/gmane.linux.kernel.firewire.devel/8055
Here is what I sent to the lists after the discussion:


Date: Mon, 20 Nov 2006 00:05:05 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: ieee1394: raw1394: defer feature removal of old isoch interface

Known to be affected:
 - libdc1394: prefers video1394 for now, old-style raw1394 support might
   be dropped eventually
 - OpenH323 PWLib, AVC video input module: uses libraw1394's old API

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 Documentation/feature-removal-schedule.txt |   11 ++++++-----
 drivers/ieee1394/raw1394.c                 |   17 +++++++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

Index: linux/Documentation/feature-removal-schedule.txt
===================================================================
--- linux.orig/Documentation/feature-removal-schedule.txt	2006-11-11 12:42:21.000000000 +0100
+++ linux/Documentation/feature-removal-schedule.txt	2006-11-11 15:49:42.000000000 +0100
@@ -30,11 +30,12 @@ Who:	Adrian Bunk <bunk@stusta.de>
 ---------------------------
 
 What:	raw1394: requests of type RAW1394_REQ_ISO_SEND, RAW1394_REQ_ISO_LISTEN
-When:	November 2006
-Why:	Deprecated in favour of the new ioctl-based rawiso interface, which is
-	more efficient.  You should really be using libraw1394 for raw1394
-	access anyway.
-Who:	Jody McIntyre <scjody@modernduck.com>
+When:	June 2007
+Why:	Deprecated in favour of the more efficient and robust rawiso interface.
+	Affected are applications which use the deprecated part of libraw1394
+	(raw1394_iso_write, raw1394_start_iso_write, raw1394_start_iso_rcv,
+	raw1394_stop_iso_rcv) or bypass	libraw1394.
+Who:	Dan Dennedy <dan@dennedy.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>
 
 ---------------------------
 
Index: linux/drivers/ieee1394/raw1394.c
===================================================================
--- linux.orig/drivers/ieee1394/raw1394.c	2006-11-11 12:42:21.000000000 +0100
+++ linux/drivers/ieee1394/raw1394.c	2006-11-11 14:59:50.000000000 +0100
@@ -99,6 +99,21 @@ static struct hpsb_address_ops arm_ops =
 
 static void queue_complete_cb(struct pending_request *req);
 
+#include <asm/current.h>
+static void print_old_iso_deprecation(void)
+{
+	static pid_t p;
+
+	if (p == current->pid)
+		return;
+	p = current->pid;
+	printk(KERN_WARNING "raw1394: WARNING - Program \"%s\" uses unsupported"
+	       " isochronous request types which will be removed in a next"
+	       " kernel release\n", current->comm);
+	printk(KERN_WARNING "raw1394: Update your software to use libraw1394's"
+	       " newer interface\n");
+}
+
 static struct pending_request *__alloc_pending_request(gfp_t flags)
 {
 	struct pending_request *req;
@@ -2292,6 +2307,7 @@ static int state_connected(struct file_i
 		return sizeof(struct raw1394_request);
 
 	case RAW1394_REQ_ISO_SEND:
+		print_old_iso_deprecation();
 		return handle_iso_send(fi, req, node);
 
 	case RAW1394_REQ_ARM_REGISTER:
@@ -2310,6 +2326,7 @@ static int state_connected(struct file_i
 		return reset_notification(fi, req);
 
 	case RAW1394_REQ_ISO_LISTEN:
+		print_old_iso_deprecation();
 		handle_iso_listen(fi, req);
 		return sizeof(struct raw1394_request);
 

-- 
Stefan Richter
-=====-=-==- =-== =-=--
http://arcgraph.de/sr/

