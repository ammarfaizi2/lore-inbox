Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVBDAfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVBDAfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 19:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263099AbVBDAfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 19:35:24 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:4758 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261846AbVBDAeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:34:19 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stephen Evanchik <evanchsa@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Date: Thu, 3 Feb 2005 19:34:16 -0500
User-Agent: KMail/1.7.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <a71293c20502031443764fb4e5@mail.gmail.com>
In-Reply-To: <a71293c20502031443764fb4e5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502031934.16642.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 February 2005 17:43, Stephen Evanchik wrote:
> Vojtech,
> 
> Here is a patch that exposes the IBM TrackPoint's extended properties
> as well as scroll wheel emulation.
> 
> 

Hi,

Very nice although I have a couple of comments.

>  /*
> + * Try to initialize the IBM TrackPoint
> + */
> +	if (max_proto > PSMOUSE_PS2 && trackpoint_init(psmouse) == 0) {
> +		psmouse->vendor = "IBM";
> +		psmouse->name = "TrackPoint";
> + 
> +		return PSMOUSE_PS2;

Why PSMOUSE_PS2? Reconnect will surely not like it.

> +int tp_sens = TP_DEF_SENS;
> +module_param_named(sens, tp_sens, uint, 0);
> +MODULE_PARM_DESC(sens, "Sensitivity");
....
> +int tp_mb_scroll = TP_DEF_MB_SCROLL;
> +module_param_named(mb_scroll, tp_mb_scroll, uint, 0);
> +MODULE_PARM_DESC(mb_scroll, "Scroll with middle button");

All of this should be handled via sysfs dynamically, we don't need any
more pmouse module parameters.

> +__obsolete_setup("pts=");
> +__obsolete_setup("backup=");
> +__obsolete_setup("draghyst=");

What are these? They can't be obsolete as the module has never been part
of the vanilla kernel.

> +
> +/*
> + * Device IO: read, write and toggle bit
> + */
> +static void trackpoint_command(struct ps2dev *ps2dev, unsigned char cmd)
> +{	
> +	ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, TP_COMMAND));
> +	ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, cmd));
> +}
> +

Error checking would be nice.

> +
> +#ifdef CONFIG_PROC_FS
...
> +{
> +        remove_proc_entry("scroll_delay", tp_dir);
> +        remove_proc_entry("scroll", tp_dir);
> +        remove_proc_entry("transparent", tp_dir);
> +        remove_proc_entry("ext_dev", tp_dir);
> +        remove_proc_entry("mb", tp_dir);
> +        remove_proc_entry("skip_back", tp_dir);
> +        remove_proc_entry("ptson", tp_dir);
> +        remove_proc_entry("jenks_curv", tp_dir);
> +        remove_proc_entry("z_time", tp_dir);
> +        remove_proc_entry("up_thresh", tp_dir);
> +        remove_proc_entry("thresh", tp_dir);
> +        remove_proc_entry("min_drag", tp_dir);
> +        remove_proc_entry("drag_hyst", tp_dir);
> +        remove_proc_entry("backup", tp_dir);
> +        remove_proc_entry("neg_inertia", tp_dir);
> +        remove_proc_entry("speed", tp_dir);
> +        remove_proc_entry("sensitivity", tp_dir);
> +        remove_proc_entry("trackpoint", NULL);
> +}

No new proc stuff please (it will be visible from sysfs when you redo the
module parameters).

> +
> +		tp->scrolling = 0;
> +		tp->mb_was_down = 0;
> +	}
> +        else if(tp->scrolling) {
> +
> +		/* Vertical scrolling */
> +		diff = (int) ((packet[0] << 3) & 0x100) - (int) packet[2];
> +                if( diff < -2 ) {
> +			input_report_rel(&psmouse->dev, REL_WHEEL, 1);
> +		}
> +		else if(diff > 2) {
> +			input_report_rel(&psmouse->dev, REL_WHEEL, -1);
> +		}
> +
> +                /* Horizontal scrolling */
> +                diff = (int) packet[1] - (int) ((packet[0] << 4) & 0x100);
> +                if( diff < -2) {
> +                        input_report_rel(&psmouse->dev, REL_HWHEEL, 1);
> +                }
> +                else if( diff > 2) {
> +                        input_report_rel(&psmouse->dev, REL_HWHEEL, -1);
> +                }
> +
> +		packet[1] &= 0x00;
> +		packet[2] &= 0x00;
> +	}

Looks like whitespace damage (tabs vs spaces) plus it should be "} else {"
on one line.

> +int trackpoint_reconnect(struct psmouse *psmouse)
> +{
> +	unsigned char toggle;
> +	struct trackpoint_data *tp = psmouse->private;
> +
> +	/* Push the config to the device */
> +	

I'd like to verify that it still recognized as trackpoint - suspends often
play tricks on PS/2 devices.

> +
> +	printk("IBM TrackPoint firmware: 0x%02X\n", param[1]);

KERN_INFO?


-- 
Dmitry
