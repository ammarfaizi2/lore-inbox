Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWHGONe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWHGONe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWHGONe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:13:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27922 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932106AbWHGONc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:13:32 -0400
Date: Mon, 7 Aug 2006 13:44:41 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Message-ID: <20060807134440.GD4032@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492242899-git-send-email-multinymous@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11548492242899-git-send-email-multinymous@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The embedded controller on ThinkPad laptops has a non-standard interface
> at IO ports 0x1600-0x161F (mapped to LCP channel 3 of the H8S chip).
> The interface provides various system management services (currently 
> known: battery information and accelerometer readouts). This driver
> provides access and mutual exclusion for the EC interface.
> 
> The mainline hdaps driver already uses this hardware interface (in an 
> incorrect and unsafe way), and will be converted to use this module in
> the following patches. Another driver using this module, tp_smapi, will 
> be submitted later.
> 
> The Kconfig entry is set to tristate and will be selected by hdaps and
> (eventually) tp_smapi, since thinkpad_ec does nothing by itself.
> 
> Signed-off-by: Shem Multinymous <multinymous@gmail.com>

Signed-off-by: Pavel Machek <pavel@suse.cz>

> +/* Module parameters: */
> +static int tp_debug = 0;

Static variables do not need initializers.

> +module_param_named(debug, tp_debug, int, 0600);
> +MODULE_PARM_DESC(debug, "Debug level (0=off, 1=on)");
> +
> +/* A few macros for printk()ing: */
> +#define DPRINTK(fmt, args...) \
> +  do { if (tp_debug) printk(KERN_DEBUG fmt, ## args); } while (0)

Is not there generic function doing this?

> +/* thinkpad_ec_lock:
> + * Get exclusive lock for accesing the controller. May sleep.
> + * Returns 0 iff lock acquired .
> + */

Linuxdoc?

> +EXPORT_SYMBOL_GPL(thinkpad_ec_lock); 
> +EXPORT_SYMBOL_GPL(thinkpad_ec_try_lock); 
> +void thinkpad_ec_unlock(void) 
> +{
> + 	up(&thinkpad_ec_mutex);
> +}
> +

Do we need these wrappers? Perhaps just directly exporting the mutex?

> +	/* Wait until EC starts writing its reply (~60ns on average).
> +	 * Releasing locks before this happens may cause an EC hang
> +	 * due to firmware bug!
> +	 */
> +	for (i=0; i<TPC_REQUEST_RETRIES; ++i) {

I'd write i++ here (and in other loops)... just for consistency with
rest of kernel.

> +/*** Checking for EC hardware ***/
> +
> +/* thinkpad_ec_test:
> + * Ensure the EC LPC3 channel really works on this machine by making
> + * an arbitrary harmless EC request and seeing if the EC follows protocol.
> + * This test writes to IO ports, so execute only after checking DMI.
> + */
> +static int thinkpad_ec_test(void) {

{ on new line, please.


> +/* Search all DMI device names for a given type for a substrng */
> +static int __init dmi_find_substring(int type, const char *substr) {

same here.

> +	struct dmi_device *dev = NULL;

unneeded initializer.

> +static int __init thinkpad_ec_init(void)
> +{
> +	if (!check_dmi_for_ec()) {
> +		printk(KERN_ERR "thinkpad_ec: no ThinkPad embedded controller!\n");
> +		return -ENODEV;

KERN_ERR is little strong here, no?


> +	if (!request_region(TPC_BASE_PORT, TPC_NUM_PORTS,
> +	                    "thinkpad_ec")) 
> +	{

{ on same line, please.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
