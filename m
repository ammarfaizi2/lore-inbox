Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVLXR5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVLXR5A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 12:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVLXR5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 12:57:00 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:58517 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932150AbVLXR47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 12:56:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: jfeise@feise.com
Subject: Re: mouse issues in 2.6.15-rc5-mm series
Date: Sat, 24 Dec 2005 12:56:51 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <43ACEE14.7060507@feise.com>
In-Reply-To: <43ACEE14.7060507@feise.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512241256.52189.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 December 2005 01:43, Joe Feise wrote:
> [Note: please cc me on answers since I'm not subscribed to the kernel list]
> 
> I am experiencing problems with mouse resyncing in the -mm series.
> This is a Logitech wheel mouse connected through a KVM.
> Symptom: whenever the mouse isn't moved for some seconds, it doesn't
> react to movement for a second, and then resyncs. Sometimes, the
> resyncing results in the mouse pointer jumping, which as far as I
> know is a protocol mismatch.
> While searching for reports of similar problems, I came across
> Frank Sorenson's post from Nov. 23 (http://lkml.org/lkml/2005/11/23/533).
> Like in his case, reverting
> input-attempt-to-re-synchronize-mouse-every-5-seconds.patch
> resulted in a kernel without this problem.
>

Joe,

Instead of reverting input-attempt-to-re-synchronize-mouse-every-5-seconds
patch could youplease drop the patch below on top of -mm.

Jet me know if your mouse stays synchronized. Thanks!

-- 
Dmitry

 drivers/input/mouse/psmouse-base.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: linux/drivers/input/mouse/psmouse-base.c
===================================================================
--- linux.orig/drivers/input/mouse/psmouse-base.c
+++ linux/drivers/input/mouse/psmouse-base.c
@@ -1029,6 +1029,23 @@ static int psmouse_switch_protocol(struc
 	else
 		psmouse->type = psmouse_extensions(psmouse, psmouse_max_proto, 1);
 
+	/*
+	 * If mouse's packet size is 3 there is no point in polling the
+	 * device in hopes to detect protocol reset - we won't get less
+	 * than 3 bytes response anyhow.
+	 */
+	if (psmouse->pktsize == 3)
+		psmouse->resync_time = 0;
+
+	/*
+	 * Some smart KVMs fake response to POLL command returning just
+	 * 3 bytes and messing up our resync logic, so if initial poll
+	 * fails we won't try polling the device anymore. Hopefully
+	 * such KVM will maintain initially selected protocol.
+	 */
+	if (psmouse->resync_time && psmouse->poll(psmouse))
+		psmouse->resync_time = 0;
+
 	sprintf(psmouse->devname, "%s %s %s",
 		psmouse_protocol_by_type(psmouse->type)->name, psmouse->vendor, psmouse->name);
 
