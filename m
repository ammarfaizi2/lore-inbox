Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbUKZXqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbUKZXqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUKZTqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:46:00 -0500
Received: from zeus.kernel.org ([204.152.189.113]:20931 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262489AbUKZT2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:28:23 -0500
Date: Fri, 26 Nov 2004 00:32:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 35/51: Code always built in to the kernel.
Message-ID: <20041125233243.GB2909@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101298112.5805.330.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101298112.5805.330.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +/*
> + * generic_read_proc
> + *
> + * Generic handling for reading the contents of bits, integers,
> + * unsigned longs and strings.
> + */
> +static int generic_read_proc(char * page, char ** start, off_t off, int count,
> +		int *eof, void *data)
> +{
> +	int len = 0;
> +	struct suspend_proc_data * proc_data = (struct suspend_proc_data *) data;
> +
> +	switch (proc_data->type) {
> +		case SUSPEND_PROC_DATA_CUSTOM:
> +			printk("Error! /proc/suspend/%s marked as having custom"
> +				" routines, but the generic read routine has"
> +				" been invoked.\n",
> +				proc_data->filename);
> +			break;
> +		case SUSPEND_PROC_DATA_BIT:
> +			len = sprintf(page, "%d\n", 
> +				-test_bit(proc_data->data.bit.bit,
> +					proc_data->data.bit.bit_vector));
> +			break;

You have your own abstraction on the top of /proc? That's no-no.

> +/*
> + * Non-plugin proc entries.
> + *
> + * This array contains entries that are automatically registered at
> + * boot. Plugins and the console code register their own entries separately.
> + */
> +

...aha, you do that to enable plugin system. Take it as another reason
why plugins have to go.

> +/* 
> + * Basic keypress handler for suspend. This is extensible
> + * via the user interface modules.
> + */
> +
> +/* For simplicity, we convert keyboard key codes to ascii,
> + * except in the case of function keys, which are mapped
> + * to 1-12. We can then use the same case statement for
> + * serial keyboards (and from a serial keyboard, you can
> + * press Control-A..L to toggle sections.
> + */
> +static unsigned int kbd_keytable[] = {
> +	  0,  27,  49,  50,  51,  52,  53,  54,  55,  56,
> +	 57,  48,   0,   0,   0,   0,   0,   0,   0, 114,
> +	116,   0,   0,   0,   0, 112,   0,   0,   0,   0,
> +	  0, 115,   0,   0,   0,   0,   0,   0, 108,   0,
> +	  0, 122,   0,   0,   0,   0,  99,   0,   0,   0,
> +	  0,   0,   0,   0,   0,   0,   0,  32,   0,   1,
> +	  2,   3,   4,   5,   6,   7,   8,   9,  10,   0,
> +	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
> +	  0,   0,   0,   0,   0,   0,   0,  11,  12,   0,
> +};
> +
> +/*
> + * keycode_to_action
> + *
> + * Convert a keycode (serial or keyboard) into our
> + * internal code (ascii, except for function keys).
> + */
> +static unsigned int keycode_to_action(unsigned int keycode, int source)
> +{
> +	if (source == SUSPEND_KEY_SERIAL) {
> +		if (keycode > 64)
> +			return (keycode | 32);
> +		else
> +			return keycode;
> +	}

And your own keyboard driver :-(.

> +		say("BIG FAT WARNING!! %s\n\n", suspend_print_buf);
> +		if (can_erase_image) {
> +			say("If you want to use the current suspend image, reboot and try\n");
> +			say("again with the same kernel that you suspended from. If you want\n");
> +			say("to forget that image, continue and the image will be erased.\n");
> +		} else {
> +			say("If you continue booting, note that any image WILL NOT BE REMOVED.\n");
> +			say("Suspend is unable to do so because the appropriate modules aren't\n");
> +			say("loaded. You should manually remove the image to avoid any\n");
> +			say("possibility of corrupting your filesystem(s) later.\n");
> +		}
> +		say("Press SPACE to reboot or C to continue booting with this kernel\n");

Plus kernel now actually expects user interaction to solve problems
during boot. No, no.
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
