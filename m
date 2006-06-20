Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWFTFWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWFTFWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWFTFWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:22:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965015AbWFTFW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:22:26 -0400
Date: Mon, 19 Jun 2006 22:22:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 20/20 RFC] chardev: GPIO for SCx200 & PC-8736x: add
 sysfs-GPIO interface
Message-Id: <20060619222223.8f5133a9.akpm@osdl.org>
In-Reply-To: <44944D14.2000308@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<44944D14.2000308@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 12:42:28 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> Ok, 
> 
> heres the brand-spanking-new proto-sysfs-gpio interface,
> preceded by some pseudo/proto-Documentation.
> 

Well I stuck it in -mm anyway.  Let's see what happens.

We don't have a Signed-off-by: for this patch.

Fixup patches agains next -mm would be suitable.  Please keep them
super-short: basically one-patch-per-review-comment.  That way I can easily
instertion-sort the patches into place and we retain a nice patch series.

> Ive

Apostrophe aversion?

>  
> +/* the pin-mode-change 'commands' of the legacy device-file-interface,
> +   now refactored for reuse in a sysfs-interface.  Includes some
> +   updates which arent exposed via sysfs attributes.
> +*/
> +static int common_write(struct nsc_gpio_ops *amp, char c, unsigned m)
> +{
> +       struct device *dev = amp->dev;
> +       int err = 0;
> +       switch (c) {
> +       case '0':
> +               amp->gpio_set(m, 0);
> +               break;
> +       case '1':
> +               amp->gpio_set(m, 1);
> +               break;
> +       case 'O':
> +               dev_dbg(dev, "GPIO%d output enabled\n", m);
> +               amp->gpio_config(m, ~1, 1);
> +               break;
> +       case 'o':
> +               dev_dbg(dev, "GPIO%d output disabled\n", m);
> +               amp->gpio_config(m, ~1, 0);
> +               break;
> +       case 'T':
> +               dev_dbg(dev, "GPIO%d output is push pull\n", m);
> +               amp->gpio_config(m, ~2, 2);
> +               break;
> +       case 't':
> +               dev_dbg(dev, "GPIO%d output is open drain\n", m);
> +               amp->gpio_config(m, ~2, 0);
> +               break;
> +       case 'P':
> +               dev_dbg(dev, "GPIO%d pull up enabled\n", m);
> +               amp->gpio_config(m, ~4, 4);
> +               break;
> +       case 'p':
> +               dev_dbg(dev, "GPIO%d pull up disabled\n", m);
> +               amp->gpio_config(m, ~4, 0);
> +               break;
> +       case 'L':
> +               dev_dbg(dev, "GPIO%d lock pin\n", m);
> +               amp->gpio_config(m, ~8, 8);
> +               break;
> +       case 'l':
> +               dev_warn(dev, "GPIO%d cant unlock locked? pin\n", m);
> +               amp->gpio_config(m, ~8, 0);
> +               break;
> +
> +       case 'D':
> +               dev_dbg(dev, "GPIO%d turn on debounce\n", m);
> +               amp->gpio_config(m, ~PF_DEBOUNCE, PF_DEBOUNCE);
> +               break;
> +       case 'd':
> +               dev_warn(dev, "GPIO%d cant unlock locked? pin\n", m);
> +               amp->gpio_config(m, ~PF_DEBOUNCE, 0);
> +               break;
> +
> +       case 'v':
> +               /* View Current pin settings */
> +               amp->gpio_dump(amp, m);
> +               break;
> +       case 'c':
> +               /* view pin's current values: driven and read */
> +               dev_info(dev, "io%02d: driven %d, input %d\n",
> +                        m, amp->gpio_current(m), amp->gpio_get(m));
> +               break;
> +       case '\n':
> +               /* end of settings string, do nothing */
> +               break;
> +       default:
> +               dev_err(dev, "GPIO-%2d bad setting: chr<0x%2x>\n", m,
> +                       (int)c);
> +               err++;
> +       }
> +       return err;
> +}
> +
>  ssize_t nsc_gpio_write(struct file *file, const char __user *data,
>  		       size_t len, loff_t *ppos)
>  {
> +	int i, err = 0;
>  	unsigned m = iminor(file->f_dentry->d_inode);
>  	struct nsc_gpio_ops *amp = file->private_data;
> -	struct device *dev = amp->dev;
> -	size_t i;
> -	int err = 0;
>  
>  	for (i = 0; i < len; ++i) {
>  		char c;
>  		if (get_user(c, data + i))
>  			return -EFAULT;
> -		switch (c) {
> -		case '0':
> -			amp->gpio_set(m, 0);
> -			break;
> -		case '1':
> -			amp->gpio_set(m, 1);
> -			break;
> -		case 'O':
> -			dev_dbg(dev, "GPIO%d output enabled\n", m);
> -			amp->gpio_config(m, ~1, 1);
> -			break;
> -		case 'o':
> -			dev_dbg(dev, "GPIO%d output disabled\n", m);
> -			amp->gpio_config(m, ~1, 0);
> -			break;
> -		case 'T':
> -			dev_dbg(dev, "GPIO%d output is push pull\n", m);
> -			amp->gpio_config(m, ~2, 2);
> -			break;
> -		case 't':
> -			dev_dbg(dev, "GPIO%d output is open drain\n", m);
> -			amp->gpio_config(m, ~2, 0);
> -			break;
> -		case 'P':
> -			dev_dbg(dev, "GPIO%d pull up enabled\n", m);
> -			amp->gpio_config(m, ~4, 4);
> -			break;
> -		case 'p':
> -			dev_dbg(dev, "GPIO%d pull up disabled\n", m);
> -			amp->gpio_config(m, ~4, 0);
> -			break;
> -
> -		case 'v':
> -			/* View Current pin settings */
> -			amp->gpio_dump(amp, m);
> -			break;
> -		case '\n':
> -			/* end of settings string, do nothing */
> -			break;
> -		default:
> -			dev_err(dev, "GPIO-%2d bad setting: chr<0x%2x>\n", m,
> -			       (int)c);
> -			err++;
> -		}
> +
> +		err += common_write(amp, c, m);
>  	}
>  	if (err)
>  		return -EINVAL;	/* full string handled, report error */

This all spat a whopping great reject for reasons unknown, which I fixed by
hand.  Please check that it all still works.


> +ssize_t nsc_gpio_sysfs_set(struct device *dev,
> +			   struct device_attribute *devattr, const char *buf,
> +			   size_t count)
> +{
> +        struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> +        int idx = attr->index;
> +        int func = attr->nr;
> +	struct nsc_gpio_ops *amp = dev->driver_data;
> +	int err, xor;
> +
> +	/* invert cmd if setting low */
> +	xor = simple_strtol(buf, NULL, 10) ? 0 : 'T'^'t';

whoa.  How does this work?

> +	dev_info(dev, "set func:%d  Func:%d, flp%d\n", func, func^xor, xor);
> +
> +	err = common_write(amp, func^xor, idx);

The tricksies in here aren't very understandable.  Can it be simplified?

> +	if (err)
> +		return -EINVAL;	// full string handled, report error
> +	
> +	return strlen(buf);
> +}
>
> ...
>
>  static void __init pc8736x_init_shadow(void)
>  {
>  	int port;
> @@ -320,6 +368,12 @@ static int __init pc8736x_gpio_init(void
>  		dev_dbg(&pdev->dev, ": got dynamic major %d\n", major);
>  	}
>  
> +	pc8736x_sysfs_init(&pdev->dev);
> +
> +	/* provide info wheresysfs callbacks can get them */
> +	pc8736x_access.dev->driver_data = &pc8736x_access;
> +
> +;
>  	return 0;
>  }

stray semicolon.

> +/* GPIO pins have 5 attributes we care about: group them */
> +struct gpio_pin_attributes {
> +	struct sensor_device_attribute_2
> +		output_enabled,
> +		totem_pole,
> +		pullup_enabled,
> +		debounced,
> +		locked;
> +};

A bit hard to read.  Normally we'd do

struct gpio_pin_attributes {
	struct sensor_device_attribute_2 output_enabled;
	struct sensor_device_attribute_2 totem_pole;
	struct sensor_device_attribute_2 pullup_enabled;
	struct sensor_device_attribute_2 debounced;
	struct sensor_device_attribute_2 locked;
};

because kernel-style is super-simple-style.


