Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWCWVc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWCWVc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWCWVc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:32:59 -0500
Received: from lixom.net ([66.141.50.11]:38611 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S932101AbWCWVc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:32:59 -0500
Date: Thu, 23 Mar 2006 15:32:17 -0600
To: Arnd Bergmann <abergman@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [patch 02/13] powerpc: add hvc backend for rtas
Message-ID: <20060323213217.GB5538@pb15.lixom.net>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com> <20060323203521.100452000@dyn-9-152-242-103.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323203521.100452000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a couple of nitpicks below, nothing major.

Since it's such a simple driver, it's easy to use as a base for similar
ones, and as such it'd be nice to have it as clean as possible to avoid
others to inherit strangeness.


-Olof

On Thu, Mar 23, 2006 at 12:00:02AM +0100, Arnd Bergmann wrote:

> +static inline int hvc_rtas_write_console(uint32_t vtermno, const char *buf, int count)
> +{
> +	int done;
> +
> +	/* if there is more than one character to be displayed, wait a bit */
> +	for (done = 0; done < count; done++) {
> +		int result;
> +		result = rtas_call(rtascons_put_char_token, 1, 1, NULL, buf[done]);
> +		if (result)
> +			break;

Why introduce a scope-local variable just to check it?
		if(rtas_call(...))   would be cleaner.

> +	}
> +	/* the calling routine expects to receive the number of bytes sent */
> +	return done;
> +}
> +
> +static int hvc_rtas_read_console(uint32_t vtermno, char *buf, int count)
> +{
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		int c, err;
> +
> +		err = rtas_call(rtascons_get_char_token, 0, 2, &c);
> +		if (err)
> +			break;

Same here

> +
> +		buf[i] = c;
> +	}
> +
> +	return i;
> +}
> +
> +static struct hv_ops hvc_rtas_get_put_ops = {
> +	.get_chars = hvc_rtas_read_console,
> +	.put_chars = hvc_rtas_write_console,
> +};
> +
> +static int hvc_rtas_init(void)
> +{
> +	struct hvc_struct *hp;
> +
> +	if (rtascons_put_char_token == RTAS_UNKNOWN_SERVICE)
> +		rtascons_put_char_token = rtas_token("put-term-char");
> +	if (rtascons_put_char_token == RTAS_UNKNOWN_SERVICE)
> +		return -EIO;
> +
> +	if (rtascons_get_char_token == RTAS_UNKNOWN_SERVICE)
> +		rtascons_get_char_token = rtas_token("get-term-char");
> +	if (rtascons_get_char_token == RTAS_UNKNOWN_SERVICE)
> +		return -EIO;
> +
> +	BUG_ON(hvc_rtas_dev);
> +
> +	/* Allocate an hvc_struct for the console device we instantiated
> +	 * earlier.  Save off hp so that we can return it on exit */
> +	hp = hvc_alloc(hvc_rtas_cookie, NO_IRQ, &hvc_rtas_get_put_ops);
> +	if (IS_ERR(hp))
> +		return PTR_ERR(hp);
> +	hvc_rtas_dev = hp;
> +	return 0;
> +}
> +module_init(hvc_rtas_init);
> +
> +/* This will tear down the tty portion of the driver */
> +static void __exit hvc_rtas_exit(void)
> +{
> +	/* Really the fun isn't over until the worker thread breaks down and the
> +	 * tty cleans up */
> +	if (hvc_rtas_dev)
> +		hvc_remove(hvc_rtas_dev);
> +}
> +module_exit(hvc_rtas_exit); /* before drivers/char/hvc_console.c */

Cryptic comment? 

> +/* This will happen prior to module init.  There is no tty at this time? */
> +static int hvc_rtas_console_init(void)
> +{
> +	rtascons_put_char_token = rtas_token("put-term-char");
> +	if (rtascons_put_char_token == RTAS_UNKNOWN_SERVICE)
> +		return -EIO;
> +	rtascons_get_char_token = rtas_token("get-term-char");
> +	if (rtascons_get_char_token == RTAS_UNKNOWN_SERVICE)
> +		return -EIO;
> +
> +	hvc_instantiate(hvc_rtas_cookie, 0, &hvc_rtas_get_put_ops );
> +	add_preferred_console("hvc", 0, NULL);
> +	return 0;
> +}
> +console_initcall(hvc_rtas_console_init);
> Index: linus-2.6/drivers/char/Makefile
> ===================================================================
> --- linus-2.6.orig/drivers/char/Makefile
> +++ linus-2.6/drivers/char/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_SX)		+= sx.o generic_serial
>  obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
>  obj-$(CONFIG_HVC_DRIVER)	+= hvc_console.o
>  obj-$(CONFIG_HVC_CONSOLE)	+= hvc_vio.o hvsi.o
> +obj-$(CONFIG_HVC_RTAS)		+= hvc_rtas.o
>  obj-$(CONFIG_RAW_DRIVER)	+= raw.o
>  obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
>  obj-$(CONFIG_MMTIMER)		+= mmtimer.o
> Index: linus-2.6/drivers/char/Kconfig
> ===================================================================
> --- linus-2.6.orig/drivers/char/Kconfig
> +++ linus-2.6/drivers/char/Kconfig
> @@ -578,6 +578,13 @@ config HVC_CONSOLE
>  	  console. This driver allows each pSeries partition to have a console
>  	  which is accessed via the HMC.
>  
> +config HVC_RTAS
> +	bool "IBM RTAS Console support"
> +	depends on PPC_RTAS
> +	select HVC_DRIVER
> +	help
> +	  IBM Console device driver which makes use of RTAS
> +
>  config HVCS
>  	tristate "IBM Hypervisor Virtual Console Server support"
>  	depends on PPC_PSERIES
> 
> --
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
