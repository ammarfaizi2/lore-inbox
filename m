Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTFOPei (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 11:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTFOPei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 11:34:38 -0400
Received: from mailc.telia.com ([194.22.190.4]:61155 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S262316AbTFOPeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 11:34:19 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Joseph Fannin <jhf@rivenstone.net>,
       Jens Taprogge <jens.taprogge@rwth-aachen.de>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
References: <m2smqhqk4k.fsf@p4.localdomain> <20030615001905.A27084@ucw.cz>
	<m2he6rv8i6.fsf@telia.com> <20030615142838.A3291@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Jun 2003 17:47:57 +0200
In-Reply-To: <20030615142838.A3291@ucw.cz>
Message-ID: <m2of0zqr4i.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Sun, Jun 15, 2003 at 02:18:57PM +0200, Peter Osterlund wrote:
> > 
> > -	if (hw.w != priv->old_w) {
> > -		input_event(dev, EV_MSC, MSC_GESTURE, hw.w);
> > -		priv->old_w = hw.w;
> > -	}
> > +	/*
> > +	 * This will generate an event even if w is unchanged, but that is
> > +	 * exactly what we want, because user space drivers may depend on
> > +	 * this for gesture decoding.
> > +	 */
> > +	input_event(dev, EV_MSC, MSC_GESTURE, hw.w);
> 
> This assumption is not nice. It should instead rely on input_sync() /
> EV_SYN, SYN_REPORT events for complete packet decoding. Can you do
> something about that?

The X driver already relies on EV_SYN to decide when it should act on
the data from the kernel. The problem is that the packet stream is
used as a time base for gesture decoding, because the touchpad was
designed like that to make driver implementation simpler. From the
Synaptics manual:

        (Specifically, the TouchPad begins sending packets when Z is 8
        or more.) The TouchPad also begins sending packets whenever
        any button is pressed or released. Once the TouchPad begins
        transmitting, it continues to send packets for one second
        after Z falls below 8 and the buttons stop changing. The
        TouchPad does this partly to allow host software to use the
        packet stream as a time base for gesture decoding, and also to
        minimize the impact if the system occasionally drops a packet.

For example, if I press the left button, the X driver can not
immediately generate a left button down event, because maybe I will
press the right button real soon, in which case the middle mouse
button emulation will be activated and generate a middle button down
event. This and similar things are easy to implement by just counting
packets.

I guess it would be possible to rewrite the driver so that it doesn't
rely on the packet stream for timing, but it would make the driver
more complicated.

If I could generate only EV_SYN events from the kernel without the
EV_MSC events, that would of course be OK too, but I don't know if
that is possible.

The event parsing code int the X driver currently looks like this:

static Bool
SynapticsParseEventData(LocalDevicePtr local, SynapticsPrivatePtr priv,
			struct SynapticsHwState *hw)
{
    struct input_event ev;

    while (SynapticsReadEvent(priv, &ev) == Success) {
	switch (ev.type) {
	case 0x00:			    /* SYN */
	    *hw = priv->hwState;
	    return Success;
	case 0x01:			    /* KEY */
	    switch (ev.code) {
	    case 0x110:			    /* BTN_LEFT */
		priv->hwState.left = (ev.value ? TRUE : FALSE);
		break;
	    case 0x111:			    /* BTN_RIGHT */
		priv->hwState.right = (ev.value ? TRUE : FALSE);
		break;
	    case 0x115:			    /* BTN_FORWARD */
		priv->hwState.up = (ev.value ? TRUE : FALSE);
		break;
	    case 0x116:			    /* BTN_BACK */
		priv->hwState.down = (ev.value ? TRUE : FALSE);
		break;
	    }
	    break;
	case 0x03:			    /* ABS */
	    switch (ev.code) {
	    case 0x00:			    /* ABS_X */
		priv->hwState.x = ev.value;
		break;
	    case 0x01:			    /* ABS_Y */
		priv->hwState.y = ev.value;
		break;
	    case 0x18:			    /* ABS_PRESSURE */
		priv->hwState.z = ev.value;
		break;
	    }
	    break;
	case 0x04:			    /* MSC */
	    switch (ev.code) {
	    case 0x02:			    /* MSC_GESTURE */
		priv->hwState.w = ev.value;
		break;
	    }
	    break;
	}
    }
    return !Success;
}

static Bool
SynapticsReadEvent(SynapticsPrivatePtr priv, struct input_event *ev)
{
    int i, c;
    unsigned char *pBuf, u;

    for (i = 0; i < sizeof(struct input_event); i++) {
	if ((c = XisbRead(priv->buffer)) < 0)
	    return !Success;
	u = (unsigned char)c;
	pBuf = (unsigned char *)ev;
	pBuf[i] = u;
    }
    return Success;
}

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
