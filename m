Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVBFRwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVBFRwt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBFRwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:52:43 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:27729 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261254AbVBFRwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:52:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.de>
Subject: Re: [RFC/RFT] Better handling of bad xfers/interrupt delays in psmouse
Date: Sun, 6 Feb 2005 12:52:29 -0500
User-Agent: KMail/1.7.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       zhilla <zhilla@spymac.com>, Victor Hahn <victorhahn@web.de>
References: <200502051448.57492.dtor_core@ameritech.net> <200502060223.55090.dtor_core@ameritech.net> <20050206083739.GC8642@ucw.cz>
In-Reply-To: <20050206083739.GC8642@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502061252.30084.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 February 2005 03:37, Vojtech Pavlik wrote:
> On Sun, Feb 06, 2005 at 02:23:48AM -0500, Dmitry Torokhov wrote:
> 
> > Ok, here is the patch using PSMOUSE_CMD_POLL. Seems to work fine with 2
> > external mice that I have and my touchpad in PS/2 compatibility mode.
> > 
> > Unfortunately POLL command kicks Synaptics out of absolute mode so I
> > disabled all time-based sync checks for Synaptics altogether. This should
> > be OK since Synaptics have pretty strict protocol rules and usually
> > can resync on their own. I wonder what POLL does to ALPS?
> > 
> > Again, 2.6.10 version can be found here:
> > 
> > 	http://www.geocities.com/dt_or/input/2_6_10/
> > 
> > Comments/testing is appreciated.
>  
> Did you check that issuing the POLL command in the middle of a mouse
> packet does indeed reset the counter of the streaming mode? I'd expect
> them to be separate, at least on some mice, if POLL is handled as a
> normal mouse command, and after the three bytes from POLL are sent, the
> mouse could just continue sending the packet like with any other
> command.
> 

I have tested with Synaptics touchpad, a noname explorer mouse and a Belkin
USB with USB-PS/2 converted, all of them resumed streaming with the full
packet. I used the following patch to force polling:

===== drivers/input/mouse/psmouse-base.c 1.88 vs edited =====
--- 1.88/drivers/input/mouse/psmouse-base.c	2005-02-06 03:01:36 -05:00
+++ edited/drivers/input/mouse/psmouse-base.c	2005-02-06 12:46:47 -05:00
@@ -185,6 +185,7 @@
 static irqreturn_t psmouse_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
+	static int bcnt;
 	struct psmouse *psmouse = serio_get_drvdata(serio);
 	psmouse_ret_t rc;
 
@@ -237,6 +238,20 @@
 			goto out;
 		}
 	}
+
+	if (psmouse->state == PSMOUSE_ACTIVATED &&
+	    psmouse->type != PSMOUSE_SYNAPTICS &&
+	    !serio->parent &&
+	    (++bcnt % 502) == 0) {
+		printk(KERN_WARNING "psmouse.c: %s at %s - repolling, throwing %d bytes away.\n",
+		       psmouse->name, psmouse->phys, psmouse->pktcnt);
+		psmouse->pktcnt = 0;
+		if (serio_write(serio, PSMOUSE_CMD_POLL & 0xff) == 0) {
+			psmouse->resend = 1;
+			goto out;
+		}
+	}
+
 
 	psmouse->last = jiffies;
 	psmouse->packet[psmouse->pktcnt++] = data;



We of course need more testing, I am particularly interested in ALPS reaction
to poll command.

-- 
Dmitry
