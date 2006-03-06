Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752305AbWCFJFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbWCFJFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbWCFJFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:05:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38636 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752303AbWCFJFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:05:48 -0500
Date: Mon, 6 Mar 2006 04:05:33 -0500
From: Dave Jones <davej@redhat.com>
To: tiwai@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: opl3_oss use after free.
Message-ID: <20060306090533.GA12999@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, tiwai@suse.de,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't read from free'd memory.  Also make use of the return
value, and don't register the device if something went wrong
creating the port.

Coverity #955

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/sound/drivers/opl3/opl3_oss.c~	2006-03-06 03:59:35.000000000 -0500
+++ linux-2.6/sound/drivers/opl3/opl3_oss.c	2006-03-06 04:03:44.000000000 -0500
@@ -104,8 +104,10 @@ static int snd_opl3_oss_create_port(stru
 							  voices, voices,
 							  name);
 	if (opl3->oss_chset->port < 0) {
+		int port;
+		port = opl3->oss_chset->port;
 		snd_midi_channel_free_set(opl3->oss_chset);
-		return opl3->oss_chset->port;
+		return port;
 	}
 	return 0;
 }
@@ -136,10 +138,10 @@ void snd_opl3_init_seq_oss(struct snd_op
 	arg->oper = oss_callback;
 	arg->private_data = opl3;
 
-	snd_opl3_oss_create_port(opl3);
-
-	/* register to OSS synth table */
-	snd_device_register(opl3->card, dev);
+	if (snd_opl3_oss_create_port(opl3)) {
+		/* register to OSS synth table */
+		snd_device_register(opl3->card, dev);
+	}
 }
 
 /* unregister */

-- 
http://www.codemonkey.org.uk
