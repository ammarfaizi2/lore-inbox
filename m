Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261466AbTCVAhU>; Fri, 21 Mar 2003 19:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261475AbTCVAhU>; Fri, 21 Mar 2003 19:37:20 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:5360 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S261466AbTCVAhS>; Fri, 21 Mar 2003 19:37:18 -0500
Date: Fri, 21 Mar 2003 16:47:08 -0800
From: Chris Wright <chris@wirex.com>
To: Greg KH <greg@kroah.com>
Cc: Junfeng Yang <yjf@stanford.edu>, linux-kernel@vger.kernel.org,
       mc@cs.stanford.edu
Subject: Re: [CHECKER] potential dereference of user pointer errors
Message-ID: <20030321164708.F646@figure1.int.wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, Junfeng Yang <yjf@stanford.edu>,
	linux-kernel@vger.kernel.org, mc@cs.stanford.edu
References: <200303041112.h24BCRW22235@csl.stanford.edu> <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU> <20030321161550.D646@figure1.int.wirex.com> <20030322003251.GA18359@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030322003251.GA18359@kroah.com>; from greg@kroah.com on Fri, Mar 21, 2003 at 04:32:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> 
> Ugh, that's pretty bad.  That whole chunk of debug code should just be
> replaced with a call to usb_serial_debug_data() like the other
> usb-serial drivers do.
> 
> Patches welcomed :)

Something like this?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== drivers/usb/serial/kobil_sct.c 1.5 vs edited =====
--- 1.5/drivers/usb/serial/kobil_sct.c	Wed Mar 12 14:57:33 2003
+++ edited/drivers/usb/serial/kobil_sct.c	Fri Mar 21 16:50:56 2003
@@ -406,8 +406,6 @@
 	int result = 0;
 	int todo = 0;
 	struct kobil_private * priv;
-	int i;
-	char *data;
 
 	if (count == 0) {
 		dbg("%s - port %d write request of 0 bytes", __FUNCTION__, port->number);
@@ -421,19 +419,6 @@
 		return -ENOMEM;
 	}
 
-	// BEGIN DEBUG
-	data = (unsigned char *) kmalloc((3 * count + 10) * sizeof(char), GFP_KERNEL);  
-	if (! data) {
-		return (-1);
-	}
-	memset(data, 0, (3 * count + 10));
-	for (i = 0; i < count; i++) { 
-		sprintf(data +3*i, "%02X ", buf[i]); 
-	} 
-	dbg(" %d --> %s", port->number, data );
-	kfree(data);
-	// END DEBUG
-
 	// Copy data to buffer
 	if (from_user) {
 		if (copy_from_user(priv->buf + priv->filled, buf, count)) {
@@ -442,6 +427,8 @@
 	} else {
 		memcpy (priv->buf + priv->filled, buf, count);
 	}
+
+	usb_serial_debug_data (__FILE__, __FUNCTION__, count, priv->buf + priv->filled);
 
 	priv->filled = priv->filled + count;
 
