Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752294AbWCFIuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbWCFIuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbWCFIuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:50:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63203 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752294AbWCFIuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:50:08 -0500
Date: Mon, 6 Mar 2006 03:49:51 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: tiwai@suse.de
Subject: fix usbmixer double kfree.
Message-ID: <20060306084951.GA15905@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, tiwai@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

snd_ctl_add() kfree's the kcontrol already if we fail there,
so this driver is currently doing a double kfree.

Coverity bug #959

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/sound/usb/usbmixer.c~	2006-03-06 03:40:20.000000000 -0500
+++ linux-2.6/sound/usb/usbmixer.c	2006-03-06 03:45:03.000000000 -0500
@@ -434,7 +434,6 @@ static int add_control_to_empty(struct m
 		kctl->id.index++;
 	if ((err = snd_ctl_add(state->chip->card, kctl)) < 0) {
 		snd_printd(KERN_ERR "cannot add control (err = %d)\n", err);
-		snd_ctl_free_one(kctl);
 		return err;
 	}
 	cval->elem_id = &kctl->id;

-- 
http://www.codemonkey.org.uk
