Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWGURAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWGURAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 13:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWGURAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 13:00:21 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:44846 "EHLO
	asav02.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751083AbWGURAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 13:00:20 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAIKjwESBTw
From: Dmitry Torokhov <dtor@insightbb.com>
To: George Nychis <gnychis@cmu.edu>
Subject: Re: thinkpad x60s: middle button doesn't work after hibernate
Date: Fri, 21 Jul 2006 13:00:17 -0400
User-Agent: KMail/1.9.3
Cc: lkml <linux-kernel@vger.kernel.org>
References: <44BFD911.70106@cmu.edu> <d120d5000607201246s6af0223o83be95ef54147f10@mail.gmail.com> <44C0EA85.30500@cmu.edu>
In-Reply-To: <44C0EA85.30500@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607211300.17660.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 July 2006 10:53, George Nychis wrote:
> 
> Dmitry Torokhov wrote:
> > On 7/20/06, George Nychis <gnychis@cmu.edu> wrote:
> >> Hey guys,
> >>
> >> I recently got the suspend to disk working and suspend to memory working
> >> thanks to many of you.  Whenever I suspend to disk and resume, the
> >> middle mouse button on my thinkpad x60s no longer works for scrolling or
> >> for pasting.  I either have to reboot, or suspend to memory and resume.
> >>  Therefore:
> >>
> >> Initial Boot: working
> >> Suspend to disk -> resume: not working
> >> Suspend to memory -> resume: working
> >>
> >> To fix it for now, i simply suspend to memory and resume after resuming
> >> a suspend to disk.
> >>
> > 
> > It sounds like psmouse resume method either not getting called or
> > fails during resume from disk. Could you do:
> > 
> > echo 1 > /sys/modules/i8042/parameters/debug
> > 
> > before suspending and send me dmesg after resuming. Make sure you have
> > big dmesg buffer.
> > 
> > Thanks!
> > 
> 
> Here it is:
> http://rafb.net/paste/results/hDJXzS85.html
> 
> thanks again :)
> 

Please try the patch below. If it still does not work try uncommenting call
to psmouse_reset() in trackpoint_resume().

-- 
Dmitry

Input: trackpoint - activate protocol when resuming

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/mouse/trackpoint.c |   54 ++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 18 deletions(-)

Index: linux/drivers/input/mouse/trackpoint.c
===================================================================
--- linux.orig/drivers/input/mouse/trackpoint.c
+++ linux/drivers/input/mouse/trackpoint.c
@@ -183,21 +183,26 @@ static struct attribute_group trackpoint
 	.attrs = trackpoint_attrs,
 };
 
-static void trackpoint_disconnect(struct psmouse *psmouse)
+static int trackpoint_start_protocol(struct psmouse *psmouse, unsigned char *firmware_id)
 {
-	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj, &trackpoint_attr_group);
+	unsigned char param[2] = { 0 };
 
-	kfree(psmouse->private);
-	psmouse->private = NULL;
+	if (ps2_command(&psmouse->ps2dev, param, MAKE_PS2_CMD(0, 2, TP_READ_ID)))
+		return -1;
+
+	if (param[0] != TP_MAGIC_IDENT)
+		return -1;
+
+	if (firmware_id)
+		*firmware_id = param[1];
+
+	return 0;
 }
 
 static int trackpoint_sync(struct psmouse *psmouse)
 {
-	unsigned char toggle;
 	struct trackpoint_data *tp = psmouse->private;
-
-	if (!tp)
-		return -1;
+	unsigned char toggle;
 
 	/* Disable features that may make device unusable with this driver */
 	trackpoint_read(&psmouse->ps2dev, TP_TOGGLE_TWOHAND, &toggle);
@@ -263,27 +268,40 @@ static void trackpoint_defaults(struct t
 	tp->ext_dev = TP_DEF_EXT_DEV;
 }
 
+static void trackpoint_disconnect(struct psmouse *psmouse)
+{
+	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj, &trackpoint_attr_group);
+
+	kfree(psmouse->private);
+	psmouse->private = NULL;
+}
+
+static int trackpoint_reconnect(struct psmouse *psmouse)
+{
+	/* psmouse_reset(psmouse); */
+
+	if (trackpoint_start_protocol(psmouse, NULL))
+		return -1;
+
+	if (trackpoint_sync(psmouse))
+		return -1;
+
+	return 0;
+}
+
 int trackpoint_detect(struct psmouse *psmouse, int set_properties)
 {
 	struct trackpoint_data *priv;
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char firmware_id;
 	unsigned char button_info;
-	unsigned char param[2];
-
-	param[0] = param[1] = 0;
 
-	if (ps2_command(ps2dev, param, MAKE_PS2_CMD(0, 2, TP_READ_ID)))
-		return -1;
-
-	if (param[0] != TP_MAGIC_IDENT)
+	if (trackpoint_start_protocol(psmouse, &firmware_id))
 		return -1;
 
 	if (!set_properties)
 		return 0;
 
-	firmware_id = param[1];
-
 	if (trackpoint_read(&psmouse->ps2dev, TP_EXT_BTN, &button_info)) {
 		printk(KERN_WARNING "trackpoint.c: failed to get extended button data\n");
 		button_info = 0;
@@ -296,7 +314,7 @@ int trackpoint_detect(struct psmouse *ps
 	psmouse->vendor = "IBM";
 	psmouse->name = "TrackPoint";
 
-	psmouse->reconnect = trackpoint_sync;
+	psmouse->reconnect = trackpoint_reconnect;
 	psmouse->disconnect = trackpoint_disconnect;
 
 	trackpoint_defaults(priv);
