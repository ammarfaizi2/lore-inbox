Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTFKSCw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 14:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTFKSCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 14:02:52 -0400
Received: from mailb.telia.com ([194.22.194.6]:10206 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id S262636AbTFKSCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 14:02:48 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Joseph Fannin <jhf@rivenstone.net>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
References: <m2smqhqk4k.fsf@p4.localdomain> <20030611170246.A4187@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Jun 2003 20:16:13 +0200
In-Reply-To: <20030611170246.A4187@ucw.cz>
Message-ID: <m27k7sv5si.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@ucw.cz> writes:

> On Wed, Jun 11, 2003 at 07:05:31AM +0200, Peter Osterlund wrote:
> > 
> > Here is a driver for the Synaptics TouchPad for 2.5.70.
...
> > The only major missing feature is runtime configuration of driver
> > parameters. What is the best way to implement that?
> 
> sysfs, of course.

Actually, the runtime configuration may not be needed at all if we do
the ABS -> REL conversion in user space, because all parameters
control different aspects of this conversion.

> > The patch is available here:
> > 
> >         http://w1.894.telia.com/~u89404340/patches/synaptics_driver.patch
> > 
> > Comments?
> 
> IMO it should use ABS_ events and the relativization should be done in
> the XFree86 driver. Other than that, it looks quite OK.

OK, the hardware state consists of 4 "axes" and 4 buttons, as defined
in the synaptics_hw_state struct:

        struct synaptics_hw_state {
        	int x;
        	int y;
        	int z;
        	int w;
        	int left;
        	int right;
        	int up;
        	int down;
        };

x and y are the finger position, z is the finger pressure and w
contains information about multifinger taps and finger width (for palm
detection.) Left, right, up and down contain the state of the
corresponding physical buttons.

Is this mapping reasonable?

        x     -> ABS_X
        y     -> ABS_Y
        z     -> ABS_PRESSURE
        w     -> ABS_MISC
        left  -> BTN_LEFT
        right -> BTN_RIGHT
        up    -> BTN_FORWARD
        down  -> BTN_BACK

The w value is somewhat special and not really a real axis. According
to the Synaptics TouchPad Interfacing Guide
(http://www.synaptics.com/decaf/utilities/ACF126.pdf), W is defined as
follows:

Value		Needed capability	Interpretation
W = 0		capMultiFinger		Two fingers on the pad.
W = 1		capMultiFinger		Three or more fingers on the pad.
W = 2		capPen			Pen (instead of finger) on the pad.
W = 3		Reserved.
W = 4-7		capPalmDetect		Finger of normal width.
W = 8-14	capPalmDetect		Very wide finger or palm.
W = 15		capPalmDetect		Maximum reportable width; extremely
					wide contact.

Is there a better way than using ABS_MISC to pass the W information to
user space?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
