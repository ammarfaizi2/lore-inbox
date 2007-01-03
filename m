Return-Path: <linux-kernel-owner+w=401wt.eu-S1754893AbXACHYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893AbXACHYq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754808AbXACHYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:24:46 -0500
Received: from mail.queued.net ([207.210.101.209]:1732 "EHLO mail.queued.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754893AbXACHYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:24:45 -0500
Message-ID: <459B52F5.1000402@queued.net>
Date: Wed, 03 Jan 2007 01:53:41 -0500
From: Andres Salomon <dilinger@queued.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: linux-kernel@vger.kernel.org, vojtech@suse.cz, warp@aehallh.com
Subject: Re: [PATCH] psmouse split [03/03]
References: <457F822E.4040404@debian.org>	 <200612130108.19447.dtor@insightbb.com> <457FAA01.9010807@debian.org>	 <d120d5000612130612v5d12adc0uc878b8307770d79@mail.gmail.com>	 <45802D98.7030608@debian.org> <d120d5000612130947w899614y68cf32cb1e3b35ec@mail.gmail.com> <459B51C4.8040906@queued.net> <459B5256.6050004@queued.net>
In-Reply-To: <459B5256.6050004@queued.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------020907070604080202050608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020907070604080202050608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andres Salomon wrote:
> Andres Salomon wrote:
>> Dmitry Torokhov wrote:
>>> On 12/13/06, Andres Salomon <dilinger@debian.org> wrote:
>>>> Alright, I guess we're down to a matter of taste then.  I'll change the
>>>> patch to still have a monolithic psmouse that allows protocols to be
>>>> enabled/disabled via Kconfig.
>>>>
>>> That'd be great. Thanks!
>>>
>> Yikes, almost forgot to send this.  Here you go; 3 patches total.
>> Please let me know if there are any other change.  The first is attached.

^
Er, let me know if you'd like any other changes.

>>
> 
> Here's the second; everything is split except for the synaptic stuff.
> 

And finally, the third splits out the synaptic stuff.

My initial tests show that compiling the psmouse driver for a specific
protocol extension can cut the driver's size by more than half.

--------------020907070604080202050608
Content-Type: text/plain;
 name="0003-Allow-disabling-of-synaptic-protocol-extension.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0003-Allow-disabling-of-synaptic-protocol-extension.txt"

>From ba82c3e427cd9e319e5d8898c2f730589da698a6 Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@debian.org>
Date: Tue, 26 Dec 2006 17:13:42 -0500
Subject: [PATCH] Allow disabling of synaptic protocol extension

This allows disabling of synaptic; basically, it leaves synaptic_detect()
and synaptic_reset() (for synaptic hardware emulating other protocols), but
gets rid of synaptic_init.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/input/mouse/Makefile       |    6 +-----
 drivers/input/mouse/psmouse-base.c |    5 +++++
 drivers/input/mouse/synaptics.c    |   34 ++++++++++++++++++++++------------
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index e7c7fbb..76722ec 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
 
-psmouse-objs := psmouse-base.o
+psmouse-objs := psmouse-base.o synaptics.o
 
 ifeq ($(CONFIG_MOUSE_PS2_ALPS),y)
 psmouse-objs += alps.o
@@ -24,10 +24,6 @@ ifeq ($(CONFIG_MOUSE_PS2_LOGIPS2PP),y)
 psmouse-objs += logips2pp.o
 endif
 
-ifeq ($(CONFIG_MOUSE_PS2_SYNAPTICS),y)
-psmouse-objs += synaptics.o
-endif
-
 ifeq ($(CONFIG_MOUSE_PS2_LIFEBOOK),y)
 psmouse-objs += lifebook.o
 endif
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 6b3ac9d..bfb47e1 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -583,8 +583,11 @@ #endif
 		synaptics_hardware = 1;
 
 		if (max_proto > PSMOUSE_IMEX) {
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
 			if (!set_properties || synaptics_init(psmouse) == 0)
 				return PSMOUSE_SYNAPTICS;
+#endif
+
 /*
  * Some Synaptics touchpads can emulate extended protocols (like IMPS/2).
  * Unfortunately Logitech/Genius probes confuse some firmware versions so
@@ -702,6 +705,7 @@ #endif
 		.maxproto	= 1,
 		.detect		= im_explorer_detect,
 	},
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
 	{
 		.type		= PSMOUSE_SYNAPTICS,
 		.name		= "SynPS/2",
@@ -709,6 +713,7 @@ #endif
 		.detect		= synaptics_detect,
 		.init		= synaptics_init,
 	},
+#endif
 #ifdef CONFIG_MOUSE_PS2_ALPS
 	{
 		.type		= PSMOUSE_ALPS,
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 49ac696..5d69f52 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -45,28 +45,30 @@ #define YMAX_NOMINAL 4448
  ****************************************************************************/
 
 /*
- * Send a command to the synpatics touchpad by special commands
+ * Set the synaptics touchpad mode byte by special commands
  */
-static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c, unsigned char *param)
+static int synaptics_mode_cmd(struct psmouse *psmouse, unsigned char mode)
 {
-	if (psmouse_sliced_command(psmouse, c))
+	unsigned char param[1];
+
+	if (psmouse_sliced_command(psmouse, mode))
 		return -1;
-	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETINFO))
+	param[0] = SYN_PS_SET_MODE2;
+	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_SETRATE))
 		return -1;
 	return 0;
 }
 
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
+
 /*
- * Set the synaptics touchpad mode byte by special commands
+ * Send a command to the synpatics touchpad by special commands
  */
-static int synaptics_mode_cmd(struct psmouse *psmouse, unsigned char mode)
+static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c, unsigned char *param)
 {
-	unsigned char param[1];
-
-	if (psmouse_sliced_command(psmouse, mode))
+	if (psmouse_sliced_command(psmouse, c))
 		return -1;
-	param[0] = SYN_PS_SET_MODE2;
-	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_SETRATE))
+	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETINFO))
 		return -1;
 	return 0;
 }
@@ -529,12 +531,16 @@ static void set_input_params(struct inpu
 	clear_bit(REL_Y, dev->relbit);
 }
 
+#endif /* CONFIG_MOUSE_PS2_SYNAPTICS */
+
 void synaptics_reset(struct psmouse *psmouse)
 {
 	/* reset touchpad back to relative mode, gestures enabled */
 	synaptics_mode_cmd(psmouse, 0);
 }
 
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
+
 static void synaptics_disconnect(struct psmouse *psmouse)
 {
 	synaptics_reset(psmouse);
@@ -569,6 +575,8 @@ static int synaptics_reconnect(struct ps
 	return 0;
 }
 
+#endif /* CONFIG_MOUSE_PS2_SYNAPTICS */
+
 int synaptics_detect(struct psmouse *psmouse, int set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
@@ -593,6 +601,8 @@ int synaptics_detect(struct psmouse *psm
 	return 0;
 }
 
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
+
 #if defined(__i386__)
 #include <linux/dmi.h>
 static struct dmi_system_id toshiba_dmi_table[] = {
@@ -679,4 +689,4 @@ #endif
 	return -1;
 }
 
-
+#endif /* CONFIG_MOUSE_PS2_SYNAPTICS */
-- 
1.4.1


--------------020907070604080202050608--
