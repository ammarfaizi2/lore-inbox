Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVJFQwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVJFQwX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 12:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVJFQwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 12:52:23 -0400
Received: from qproxy.gmail.com ([72.14.204.195]:15842 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751147AbVJFQwW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 12:52:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J73yFjVzTKk9Zs4SnKWY181z5snShAktu9U2Y8L9lwk59hLJm6hy9lBZeq0LcRyaF3dvKpwvPPiyc38aPZkizo05WQoKjRMo/xUCO9pwxhPIoUJd09GODvofkKKour38Fcd58X52ly+9m5b/a2g31FhJZNEbnzDejAXwXZEdxas=
Message-ID: <9a8748490510060952v71927cadj469c912c13f60400@mail.gmail.com>
Date: Thu, 6 Oct 2005 18:52:21 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Mark Gross <mgross@linux.intel.com>
Subject: Re: Telecom Clock Driver for MPCBL0010 ATCA computer blade
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Sebastien.Bouchard@ca.kontron.com, mark.gross@intel.com
In-Reply-To: <200510060803.21470.mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510060803.21470.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Mark Gross <mgross@linux.intel.com> wrote:
>
> Andrew,
>
> Attached is a simple charactor driver for possible inclusion in your MM tree.
>
> This driver is specific to the MPCBL0010 that will start shipping this fall.
>
> The telcom clock is a special circuit, line card PLL, that provids a mechanism
> for synchronization of specialized hardware across the backplane of a chassis
> of multiple computers with similar specail curcits.  In this case the
> synchronization signals get routed to multiple places, typically to pins on
> expansion slots for hardware that knows what to do with this signal.  (SONET,
> G.813, stratum 3...) and similar signaling applications found in telcom sites
> can use this type of thing.
>
> The actual device is hidden behind the FPGA on the motherboar, and is
> connected to the FPGA via I2C.  This driver only talks to the FPGA registers.
>

A few minor style and spelling comments :

[snip]
> + *
> + * Send feedback to <sebastien.bouchard@ca.kontron.com>
> + *
> + * 2.6 driver version being maintained by <mark.gross@intel.com>

shouldn't this info go into CREDITS/MAINTAINERS and the above then simply be

 * Send feedback to Sebastien Bouchard and the current maintainer.

???

Same comment for the other files.


[snip]
> +/* sysFS interface definition:

Isn't it just called "sysfs" without the caps?


> +Uppon loading the driver will create a sysfs directory under class/misc/tlclk.

s/Uppon/Upon/


> +
> +This directory exports the following interfaces.  There opperation is documented

Line exceeds 80 characters (in this case due to trailing whitespace).

Let me quote Documentation/CodingStyle Chapter 2 :

"
The limit on the length of lines is 80 columns and this is a hard limit.

Statements longer than 80 columns will be broken into sensible chunks.
Descendants are always substantially shorter than the parent and are placed
substantially to the right. The same applies to function headers with a long
argument list. Long strings are as well broken into shorter strings.
"

You have both comment and code lines elsewhere in the file that exceed this.
Please fix.

And while you are at it, please get rid of all the trailing whitespace. A
simple sed script will do it like this :

sed -r s/"[ \t]+$"/""/ file_with_trailing_whitespace.c > fixed_file.c

[snip]
> +All sysfs interaces are integers in hex format, i.e echo 99 > refalign

I trust you mean "interfaces" ...

[snip]
> +#define debug_printk( args... ) printk( args)
> +#else
> +#define debug_printk( args... )

Why these spaces after start paren and before closing paren?


[snip]
> +tlclk_read(struct file * filp, char __user * buf, size_t count, loff_t * f_pos)

Most of your functions nicely place the '*' next to the variable name, but this
one, the next one and a few other cases do not. Please be consistent.


[snip]
> +static CLASS_DEVICE_ATTR(enable_clk3b_output, S_IWUGO, NULL,
> +		store_enable_clk3b_output);
> +
> +
> +
> +static ssize_t store_enable_clk3a_output(struct class_device *d,

Why all those blank lines? One should do just fine.


[snip]
> +static CLASS_DEVICE_ATTR(enable_clk3a_output, S_IWUGO, NULL,
> +		store_enable_clk3a_output);
> +
> +
> +
> +static ssize_t store_enable_clkb1_output(struct class_device *d,

Again a lot of blank lines, and this is not the last case (just the last one
I'm going to point out).


[snip]
> +#ifdef  CONFIG_SYSFS
> +	if( 0 > (ret = misc_register(&tlclk_miscdev )) ) {

First a style thing :
   	if (0 > (ret = misc_register(&tlclk_miscdev))) {

Secondly, wouldn't this look nicer as
   	if ((ret = misc_register(&tlclk_miscdev)) < 0) {
or is that just me?

Personally I think I would prefer this :
   	ret = misc_register(&tlclk_miscdev);
   	if (ret < 0) {
Looks more readable to me.

> +		printk(KERN_ERR" misc_register retruns %d \n", ret);

Ehh, why a space just before the newline in this printk?


> +		ret =  -EBUSY;

   		ret = -EBUSY;




--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
