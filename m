Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270219AbVBFHY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270219AbVBFHY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 02:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272213AbVBFHY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 02:24:59 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:65212 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270515AbVBFHX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 02:23:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.de>
Subject: Re: [RFC/RFT] Better handling of bad xfers/interrupt delays in psmouse
Date: Sun, 6 Feb 2005 02:23:48 -0500
User-Agent: KMail/1.7.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       zhilla <zhilla@spymac.com>, Victor Hahn <victorhahn@web.de>
References: <200502051448.57492.dtor_core@ameritech.net> <20050205211136.GB8451@ucw.cz> <200502060029.21068.dtor_core@ameritech.net>
In-Reply-To: <200502060029.21068.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502060223.55090.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 February 2005 00:29, Dmitry Torokhov wrote:
> On Saturday 05 February 2005 16:11, Vojtech Pavlik wrote:
> > On Sat, Feb 05, 2005 at 02:48:56PM -0500, Dmitry Torokhov wrote:
> > > Hi,
> > > 
> > > The patch below attempts to better handle situation when psmouse interrupt
> > > is delayed for more than 0.5 sec by requesting a resend. This will allow
> > > properly synchronize with the beginning of the packet as mouse is supposed
> > > to resend entire package.
> > 
> > Have you actually tested the mouse is really sending the whole packet?
> > I'd suspect it could just resend the last byte. :I Maybe using the
> 
> Well, I did test and my touchpad behaved properly. But then I tried 2 external
> mice and they are both sending ACK (and they should not) and then the last byte
> only. So I guess we'll have to scrap using 0xfe idea...
> 
> > GET_PACKET command would be more useful in this case.
> >
> 
> Are you talking about 0xeb? We could also try sending "set stream" mode as a
> sync marker...
> 

Ok, here is the patch using PSMOUSE_CMD_POLL. Seems to work fine with 2
external mice that I have and my touchpad in PS/2 compatibility mode.

Unfortunately POLL command kicks Synaptics out of absolute mode so I
disabled all time-based sync checks for Synaptics altogether. This should
be OK since Synaptics have pretty strict protocol rules and usually
can resync on their own. I wonder what POLL does to ALPS?

Again, 2.6.10 version can be found here:

	http://www.geocities.com/dt_or/input/2_6_10/

Comments/testing is appreciated.

-- 
Dmitry


===================================================================


ChangeSet@1.2006, 2005-02-06 01:58:47-05:00, dtor_core@ameritech.net
  Input: psmouse - better handle bad transfers and interrupt delays
         by using POLL command to synchtonize on beginning of a
         packet so we don't need to guess whether received byte is
         remainder of the last packet or beginning of a new one.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 psmouse-base.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 psmouse.h      |    1 
 2 files changed, 73 insertions(+), 11 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2005-02-06 02:15:18 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2005-02-06 02:15:18 -05:00
@@ -134,6 +134,49 @@
 	return PSMOUSE_FULL_PACKET;
 }
 
+static void psmouse_schedule_reconnect(struct psmouse *psmouse)
+{
+	psmouse->state = PSMOUSE_IGNORE;
+	printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
+	serio_reconnect(psmouse->ps2dev.serio);
+}
+
+static void psmouse_handle_bad_xfer(struct psmouse *psmouse, unsigned int flags)
+{
+	if (psmouse->state == PSMOUSE_ACTIVATED)
+		printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
+			flags & SERIO_TIMEOUT ? " timeout" : "",
+			flags & SERIO_PARITY ? " bad parity" : "");
+
+	if (!psmouse->resend) {
+		/*
+		 * This is first error. Try to request resend but not if we
+		 * got a timeout and we in initialize phase - there most
+		 * likely no mouse at all. Also skip Synaptics as they don't
+		 * like POLL command and pass-through ports since we can't
+		 * use their serio_write in interrupt context.
+		 */
+		if ((psmouse->state > PSMOUSE_INITIALIZING || (~flags & SERIO_TIMEOUT)) &&
+		    psmouse->type != PSMOUSE_SYNAPTICS && !psmouse->ps2dev.serio->parent) {
+			if (serio_write(psmouse->ps2dev.serio, PSMOUSE_CMD_POLL & 0xff) == 0) {
+				psmouse->resend = 1;
+				psmouse->pktcnt = 0;
+			}
+		}
+	} else {
+		/*
+		 * This is second error in a row. If mouse was itialized - attempt
+		 * to rconnect, otherwise just signal failure.
+		 */
+		psmouse->resend = 0;
+		if (psmouse->state > PSMOUSE_INITIALIZING)
+			psmouse_schedule_reconnect(psmouse);
+	}
+
+	if (!psmouse->resend)
+		ps2_cmd_aborted(&psmouse->ps2dev);
+}
+
 /*
  * psmouse_interrupt() handles incoming characters, either gathering them into
  * packets or passing them to the command routine as command output.
@@ -149,11 +192,14 @@
 		goto out;
 
 	if (flags & (SERIO_PARITY|SERIO_TIMEOUT)) {
-		if (psmouse->state == PSMOUSE_ACTIVATED)
-			printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
-				flags & SERIO_TIMEOUT ? " timeout" : "",
-				flags & SERIO_PARITY ? " bad parity" : "");
-		ps2_cmd_aborted(&psmouse->ps2dev);
+		psmouse_handle_bad_xfer(psmouse, flags);
+		goto out;
+	}
+
+	if (unlikely(psmouse->resend)) {
+		psmouse->resend = 0;
+		if (data != PSMOUSE_RET_ACK)
+			psmouse_schedule_reconnect(psmouse);
 		goto out;
 	}
 
@@ -168,11 +214,28 @@
 	if (psmouse->state == PSMOUSE_INITIALIZING)
 		goto out;
 
+	/*
+	 * If there is a long delay between bytes in a packet we suspect
+	 * that we lost synchronization and will try to restore it by
+	 * requesting transmission of a full packet from th? mouse.
+	 * Unfortunately POLL command kicks Synaptics touchpads out of
+	 * absolute mode, so we skip them (but they have good protocol
+	 * checks and usually can re-sync without problems). We also don't
+	 * try to re-sync devices on pass-through ports as their serio_write
+	 * can't be used in interrupt context and they usually in sync as
+	 * long as their parent is.
+	 */
 	if (psmouse->state == PSMOUSE_ACTIVATED &&
+	    psmouse->type != PSMOUSE_SYNAPTICS &&
+	    !serio->parent &&
 	    psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
 		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
 		       psmouse->name, psmouse->phys, psmouse->pktcnt);
 		psmouse->pktcnt = 0;
+		if (serio_write(serio, PSMOUSE_CMD_POLL & 0xff) == 0) {
+			psmouse->resend = 1;
+			goto out;
+		}
 	}
 
 	psmouse->last = jiffies;
@@ -206,11 +269,9 @@
 				psmouse->name, psmouse->phys, psmouse->pktcnt);
 			psmouse->pktcnt = 0;
 
-			if (++psmouse->out_of_sync == psmouse->resetafter) {
-				psmouse->state = PSMOUSE_IGNORE;
-				printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
-				serio_reconnect(psmouse->ps2dev.serio);
-			}
+			if (++psmouse->out_of_sync == psmouse->resetafter)
+				psmouse_schedule_reconnect(psmouse);
+
 			break;
 
 		case PSMOUSE_FULL_PACKET:
@@ -594,7 +655,7 @@
 {
 	serio_pause_rx(psmouse->ps2dev.serio);
 	psmouse->state = new_state;
-	psmouse->pktcnt = psmouse->out_of_sync = 0;
+	psmouse->pktcnt = psmouse->out_of_sync = psmouse->resend = 0;
 	psmouse->ps2dev.flags = 0;
 	serio_continue_rx(psmouse->ps2dev.serio);
 }
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	2005-02-06 02:15:18 -05:00
+++ b/drivers/input/mouse/psmouse.h	2005-02-06 02:15:18 -05:00
@@ -48,6 +48,7 @@
 	unsigned long last;
 	unsigned long out_of_sync;
 	enum psmouse_state state;
+	unsigned int resend;
 	char devname[64];
 	char phys[32];
 
