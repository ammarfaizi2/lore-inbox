Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVIEUof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVIEUof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 16:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVIEUof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 16:44:35 -0400
Received: from mail.europlex.ie ([83.141.76.10]:34126 "EHLO
	eurodubx.europlex.local") by vger.kernel.org with ESMTP
	id S1751151AbVIEUoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 16:44:34 -0400
Message-ID: <431CB166.40904@eircom.net>
Date: Mon, 05 Sep 2005 21:58:14 +0100
From: "Bryan O'Donoghue" <typedef@eircom.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] Change behaviour of psmouse-base.c under error conditions.
Content-Type: multipart/mixed;
 boundary="------------000906060404060508010309"
X-OriginalArrivalTime: 05 Sep 2005 20:47:42.0406 (UTC) FILETIME=[0FA35E60:01C5B25B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000906060404060508010309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Greetings.

The contained patch addresses a problem I have with a Belkin SOHO KVM,
it is in fact a work around for breakage with the Belkin.

Here is a trace of some normal upwards movement with my intellimouse.

psmouse_process_byte 0x8 0x0 0x1 0x0
psmouse_process_byte 0x8 0x0 0x1 0x0

At this point if I cycle through ports on the KVM (4 port) returning to
the tracing machine and move the mouse upwards, I get packets like this.

psmouse_process_byte 0x18 0x0 0x1 0x0
psmouse_process_byte 0x18 0xff 0x1 0x0
psmouse_process_byte 0x18 0xff 0x2 0x0
psmouse_process_byte 0x18 0xff 0x2 0x8

psmouse_process_byte 0x0 0xff 0x2 0x8

Even though a) I'm fairly sure I made no X axis movement with the mouse
b) emphatically no roller movement is happening. What's being returned
from the KVM, for the IMPS/2 protocol, is just all wrong at this point
in time. From the point of view of psmouse-base.c though, there doesn't
really seem to be a way of actually knowing that, ie, even though the
post switched packets are not what's actually being done with the mouse,
they are possible and valid for the mouse to return.

However, the KVM in question invariably ends up sending a packet like this

packet= 0x0 0xff 0x2 0x8

Which is completely invalid for PS/2 and IMPS/2, the specification of
PS/2 defines bit 4 in byte 0 as always being 1.

My patch validates this bit, generating a PSMOUSE_BAD_DATA result code
if this bit is not set to 1. This has the effect of changing the flow of
control in psmouse_interrupt such that serio_reconnect(); gets called,
which is what's actually needed to fixup the error.

The second bit of the patch changes the default resetafter value from
zero to one, which has the effect that if one PSMOUSE_BAD_DATA result
code should happen, then serio_reconnect() shall be called. The
rationale behind that behaviour is that from a user's point of view it
makes more sense for the code to correct errors as a default, then it
does for a user to explicately specify "Yes I can see packets being
dropped and if 'n' become dropped reset". This behaviour can still be
switched off setting the variable to zero.

Also, it's worth noting that to date, with this KVM people have been
reverting to the bare PS/2 protocol (no third wheel) as a fix. A google
for "Belkin lost synchronization throwing bytes away", will show the
appropiate references here.

My own tests with a simple two button standard PS/2 mouse reveal that
the Belkin doesn't mangle the protocol after a switch away + switch back
cycle and that this bug with the KVM only happens with IMPS/2. In the
Kernel it should be safe to validate bit 4 of byte 0 and to throw an
error if that bit is not present, based on the PS/2 specification.

Signed-off-by: Bryan O'Donoghue <typedef@eircom.net>


--------------000906060404060508010309
Content-Type: text/plain;
 name="psmouse-base-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="psmouse-base-patch"

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -53,7 +53,7 @@ static unsigned int psmouse_smartscroll 
 module_param_named(smartscroll, psmouse_smartscroll, bool, 0644);
 MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
 
-static unsigned int psmouse_resetafter;
+static unsigned int psmouse_resetafter = 1;
 module_param_named(resetafter, psmouse_resetafter, uint, 0644);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
 
@@ -96,6 +96,10 @@ static psmouse_ret_t psmouse_process_byt
 	struct input_dev *dev = &psmouse->dev;
 	unsigned char *packet = psmouse->packet;
 
+	if ((packet[0] & 8) == 0)
+		return PSMOUSE_BAD_DATA;
+
+
 	if (psmouse->pktcnt < psmouse->pktsize)
 		return PSMOUSE_GOOD_DATA;
 


--------------000906060404060508010309--
