Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263614AbUDVHGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUDVHGT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUDVHGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:06:19 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:681 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263614AbUDVHGP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:06:15 -0400
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Kim Holviala <kim@holviala.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: /dev/psaux-Interface
References: <Pine.GSO.4.58.0402271451420.11281@stekt37>
	<200404210151.06636.dtor_core@ameritech.net>
	<xb7smexg5sm.fsf@savona.informatik.uni-freiburg.de>
	<200404220139.02775.dtor_core@ameritech.net>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 22 Apr 2004 09:06:12 +0200
In-Reply-To: <200404220139.02775.dtor_core@ameritech.net>
Message-ID: <xb71xmgebkr.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:

    Dmitry> OK, here you go. It is the first cut. The driver creates
    Dmitry> an absolute device for the touchscreen and a fake
    Dmitry> pass-through port to for the pointing device which works
    Dmitry> in relative mode. All fancy stuff can be done in userspace
    Dmitry> via evdev.

I  still  haven't  tried  it.   But upon  first  inspection,  I  found
something undesirable already.

+static void lbtouch_pass_pt_packet(struct serio *ptport, unsigned char *packet)
+{
+	struct psmouse *child = ptport->private;
+
+	if (child && child->state == PSMOUSE_ACTIVATED) {
+		serio_interrupt(ptport, packet[0], 0, NULL);
+		serio_interrupt(ptport, packet[1], 0, NULL);
+		serio_interrupt(ptport, packet[2], 0, NULL);
+	}
+}
+

So,  you're  imposing the  policy  that  the  packets must  as  3-byte
packets?  My  experiences in  writing my XFree86  driver is  that some
bytes  are sometimes  dropped, for  reasons I  don't know.   My driver
would  attempt to  resync, although  not reliably  because  the packet
format   in   touch-screen   mode   does  not   provide   a   reliable
synchronization mechanism (such  as parity, a special bit  to mark the
end of a packet, etc.).

I don't know whether the dropping  of bytes is specific to my machine,
or is common to all B142 models.


+static psmouse_ret_t lbtouch_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
+{
+	struct input_dev *dev = &psmouse->dev;
+	unsigned char *p = psmouse->packet;
+	int x, y, touch;
+
+	input_regs(dev, regs);
+
+	if (psmouse->pktcnt < 3)
+		return PSMOUSE_GOOD_DATA;
+

The  same problem.   You  wait  for a  complete  3-byte packet  before
emitting an event.  What happens to dropped bytes?


And what  happens to the timeout  feature in my  XFree86 driver?  That
feature is  the main reason I  write my driver, because  that's what I
want and  couldn't find (in others' implementation  of the touchscreen
driver).  The feature could be either in a XFree86 driver, or a kernel
mouse driver.  But I'm not going to write another XFree86 driver.  The
feature is already there in my  XFree86 driver, and I just want direct
byte-level  communication  to the  PSAUX  port.   No 3-byte  boundarys
imposed.  No censoring of data in either direction.  It's that simple.
What make that so difficult?



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

