Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbSI0Tlr>; Fri, 27 Sep 2002 15:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262603AbSI0Tkv>; Fri, 27 Sep 2002 15:40:51 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:5390 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262602AbSI0Tjy>;
	Fri, 27 Sep 2002 15:39:54 -0400
Date: Fri, 27 Sep 2002 12:43:30 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More USB changes for 2.5.38
Message-ID: <20020927194330.GH12909@kroah.com>
References: <20020927193723.GA12909@kroah.com> <20020927193855.GB12909@kroah.com> <20020927194025.GC12909@kroah.com> <20020927194054.GD12909@kroah.com> <20020927194240.GE12909@kroah.com> <20020927194258.GF12909@kroah.com> <20020927194314.GG12909@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927194314.GG12909@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.611.1.6 -> 1.611.1.7
#	drivers/usb/storage/transport.c	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/26	yuri@acronis.com	1.611.1.7
# [PATCH] USB storage: Another (!) patch for the abort handler
# 
# This is a simple, obvious patch for the abort handler.  I don't know how
# we missed it before.
# 
# Fix abort problem: us->srb was used after it was erased.
# --------------------------------------------
#
diff -Nru a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
--- a/drivers/usb/storage/transport.c	Fri Sep 27 12:30:11 2002
+++ b/drivers/usb/storage/transport.c	Fri Sep 27 12:30:11 2002
@@ -859,6 +859,7 @@
  * This must be called with scsi_lock(us->srb->host) held */
 void usb_stor_abort_transport(struct us_data *us)
 {
+	struct Scsi_Host *host;
 	int state = atomic_read(&us->sm_state);
 
 	US_DEBUGP("usb_stor_abort_transport called\n");
@@ -870,7 +871,8 @@
 
 	/* set state to abort and release the lock */
 	atomic_set(&us->sm_state, US_STATE_ABORTING);
-	scsi_unlock(us->srb->host);
+	host = us->srb->host;
+	scsi_unlock(host);
 
 	/* If the state machine is blocked waiting for an URB or an IRQ,
 	 * let's wake it up */
@@ -892,8 +894,8 @@
 	/* Wait for the aborted command to finish */
 	wait_for_completion(&us->notify);
 
-	/* Reacquire the lock */
-	scsi_lock(us->srb->host);
+	/* Reacquire the lock: note that us->srb is now NULL */
+	scsi_lock(host);
 }
 
 /*
