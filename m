Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263072AbVBDGfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbVBDGfm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 01:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbVBDGfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 01:35:41 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:51643 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S263072AbVBDGfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 01:35:00 -0500
Date: Fri, 4 Feb 2005 07:35:20 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Stephen Evanchik <evanchsa@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Message-ID: <20050204063520.GD2329@ucw.cz>
References: <a71293c20502031443764fb4e5@mail.gmail.com> <200502031934.16642.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502031934.16642.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 07:34:16PM -0500, Dmitry Torokhov wrote:
> On Thursday 03 February 2005 17:43, Stephen Evanchik wrote:
> > Vojtech,
> > 
> > Here is a patch that exposes the IBM TrackPoint's extended properties
> > as well as scroll wheel emulation.
> > 
> > 
> 
> Hi,
> 
> Very nice although I have a couple of comments.
> 
> >  /*
> > + * Try to initialize the IBM TrackPoint
> > + */
> > +	if (max_proto > PSMOUSE_PS2 && trackpoint_init(psmouse) == 0) {
> > +		psmouse->vendor = "IBM";
> > +		psmouse->name = "TrackPoint";
> > + 
> > +		return PSMOUSE_PS2;
> 
> Why PSMOUSE_PS2? Reconnect will surely not like it.

Indeed. IIRC this patch killed wheel mouse detection in ubuntu.

> 
> > +int tp_sens = TP_DEF_SENS;
> > +module_param_named(sens, tp_sens, uint, 0);
> > +MODULE_PARM_DESC(sens, "Sensitivity");
> ....
> > +int tp_mb_scroll = TP_DEF_MB_SCROLL;
> > +module_param_named(mb_scroll, tp_mb_scroll, uint, 0);
> > +MODULE_PARM_DESC(mb_scroll, "Scroll with middle button");
> 
> All of this should be handled via sysfs dynamically, we don't need any
> more pmouse module parameters.

Exactly.

> > +        remove_proc_entry("neg_inertia", tp_dir);
> > +        remove_proc_entry("speed", tp_dir);
> > +        remove_proc_entry("sensitivity", tp_dir);
> > +        remove_proc_entry("trackpoint", NULL);
> > +}
> 
> No new proc stuff please (it will be visible from sysfs when you redo the
> module parameters).

... automatically, even ...

> > +
> > +		tp->scrolling = 0;
> > +		tp->mb_was_down = 0;
> > +	}
> > +        else if(tp->scrolling) {
> > +
> > +		/* Vertical scrolling */
> > +		diff = (int) ((packet[0] << 3) & 0x100) - (int) packet[2];
> > +                if( diff < -2 ) {
> > +			input_report_rel(&psmouse->dev, REL_WHEEL, 1);
> > +		}
> > +		else if(diff > 2) {
> > +			input_report_rel(&psmouse->dev, REL_WHEEL, -1);
> > +		}
> > +
> > +                /* Horizontal scrolling */
> > +                diff = (int) packet[1] - (int) ((packet[0] << 4) & 0x100);
> > +                if( diff < -2) {
> > +                        input_report_rel(&psmouse->dev, REL_HWHEEL, 1);
> > +                }
> > +                else if( diff > 2) {
> > +                        input_report_rel(&psmouse->dev, REL_HWHEEL, -1);
> > +                }
> > +
> > +		packet[1] &= 0x00;
> > +		packet[2] &= 0x00;
> > +	}
> 
> Looks like whitespace damage (tabs vs spaces) plus it should be "} else {"
> on one line.

What a shame that this thing doesn't have a raw mode where it'd report
the pressure ...

> > +int trackpoint_reconnect(struct psmouse *psmouse)
> > +{
> > +	unsigned char toggle;
> > +	struct trackpoint_data *tp = psmouse->private;
> > +
> > +	/* Push the config to the device */
> > +	
> 
> I'd like to verify that it still recognized as trackpoint - suspends often
> play tricks on PS/2 devices.
> 
> > +
> > +	printk("IBM TrackPoint firmware: 0x%02X\n", param[1]);
> 
> KERN_INFO?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
