Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUDVHaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUDVHaa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbUDVH3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:29:32 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:24218 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263820AbUDVHXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:23:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
Date: Thu, 22 Apr 2004 02:23:41 -0500
User-Agent: KMail/1.6.1
Cc: Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       Kim Holviala <kim@holviala.com>, Tuukka Toivonen <tuukkat@ee.oulu.fi>
References: <Pine.GSO.4.58.0402271451420.11281@stekt37> <200404220139.02775.dtor_core@ameritech.net> <xb71xmgebkr.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb71xmgebkr.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Message-Id: <200404220223.41361.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 April 2004 02:06 am, Sau Dan Lee wrote:
> >>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:
> 
>     Dmitry> OK, here you go. It is the first cut. The driver creates
>     Dmitry> an absolute device for the touchscreen and a fake
>     Dmitry> pass-through port to for the pointing device which works
>     Dmitry> in relative mode. All fancy stuff can be done in userspace
>     Dmitry> via evdev.
> 
> I  still  haven't  tried  it.   But upon  first  inspection,  I  found
> something undesirable already.
> 
> +static void lbtouch_pass_pt_packet(struct serio *ptport, unsigned char *packet)
> +{
> +	struct psmouse *child = ptport->private;
> +
> +	if (child && child->state == PSMOUSE_ACTIVATED) {
> +		serio_interrupt(ptport, packet[0], 0, NULL);
> +		serio_interrupt(ptport, packet[1], 0, NULL);
> +		serio_interrupt(ptport, packet[2], 0, NULL);
> +	}
> +}
> +
> 
> So,  you're  imposing the  policy  that  the  packets must  as  3-byte
> packets?

Yes, this is my uderstanding of Lifebook protocol. It is incapable of anything
but bare PS/2 as far as the pointing device goes. If we ever get a spec we can
revisit it.

> My  experiences in  writing my XFree86  driver is  that some 
> bytes  are sometimes  dropped, for  reasons I  don't know.   My driver
> would  attempt to  resync, although  not reliably  because  the packet
> format   in   touch-screen   mode   does  not   provide   a   reliable
> synchronization mechanism (such  as parity, a special bit  to mark the
> end of a packet, etc.).
>

There is a timeout and synchronization attempt in psmosue_interrupt (parent
of this module) so you should be covered. 

> I don't know whether the dropping  of bytes is specific to my machine,
> or is common to all B142 models.
> 
> 
> +static psmouse_ret_t lbtouch_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
> +{
> +	struct input_dev *dev = &psmouse->dev;
> +	unsigned char *p = psmouse->packet;
> +	int x, y, touch;
> +
> +	input_regs(dev, regs);
> +
> +	if (psmouse->pktcnt < 3)
> +		return PSMOUSE_GOOD_DATA;
> +
> 
> The  same problem.   You  wait  for a  complete  3-byte packet  before
> emitting an event.  What happens to dropped bytes?
> 

The packet is dropped when we wait for a byte for too long.

-- 
Dmitry
