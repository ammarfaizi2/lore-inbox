Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVCGMZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVCGMZB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 07:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVCGMZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 07:25:01 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:33990 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261466AbVCGMY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 07:24:57 -0500
Date: Mon, 7 Mar 2005 13:24:32 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix NULL pointer deference in ALPS
Message-ID: <20050307122432.GG8138@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a NULL pointer deference in with alps while suspending.

The following patch fixes it: alps_get_model returns a pointer or
NULL in case of errors, so we need to check for the results being NULL,
not negative.

Since it is trivial, it is maybe a candidate for 2.6.11.2.

It does not apply to -mm since the last occurence of alps_get_model
was corrected (but not the others), if needed i can send a patch for
-mm as well.

regards,

Benoit

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>


--- linux-clean/drivers/input/mouse/alps.c	2005-03-07 12:45:46.000000000 +0100
+++ linux-vanilla/drivers/input/mouse/alps.c	2005-03-07 12:50:12.000000000 +0100
@@ -325,7 +325,7 @@ static int alps_reconnect(struct psmouse
 	int model;
 	unsigned char param[4];
 
-	if ((model = alps_get_model(psmouse)) < 0)
+	if (!(model = alps_get_model(psmouse)))
 		return -1;
 
 	if (model == ALPS_MODEL_DUALPOINT && alps_passthrough_mode(psmouse, 1))
@@ -358,7 +358,7 @@ int alps_init(struct psmouse *psmouse)
 	unsigned char param[4];
 	int model;
 
-	if ((model = alps_get_model(psmouse)) < 0)
+	if (!(model = alps_get_model(psmouse)))
 		return -1;
 
 	printk(KERN_INFO "ALPS Touchpad (%s) detected\n",
@@ -412,7 +412,7 @@ int alps_init(struct psmouse *psmouse)
 
 int alps_detect(struct psmouse *psmouse, int set_properties)
 {
-	if (alps_get_model(psmouse) < 0)
+	if (!alps_get_model(psmouse))
 		return -1;
 
 	if (set_properties) {

