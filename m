Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbTLGJ3h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 04:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbTLGJ3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 04:29:37 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:51902 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264383AbTLGJ3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 04:29:17 -0500
Date: Sun, 7 Dec 2003 10:28:44 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Pavel Machek <pavel@ucw.cz>, Brian Perkins <bperkins@netspace.org>,
       Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: [PATCH 2.6 1/3] Take 2: resume support for i8042 (atkbd & psmouse)
Message-ID: <20031207092844.GA27105@ucw.cz>
References: <200312070227.21460.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312070227.21460.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 02:27:49AM -0500, Dmitry Torokhov wrote:

Hi!

These look very good. I'll go over them later today and apply them to my
tree. Thanks!

> Hi,
> 
> Here is the 2nd attempt to implement resume for i8042 using serio_reconnect
> facility that can be found in -mm kernels. Big thanks to everyone who tested
> the first version. The changes from the last patch:
> 
> i8042:   - now correctly enables keyboard port on resume
> 	 - switches active multiplexing controller from Legacy mode back
> 	   to Multiplexing mode (4 AUX ports) on resume
> 	 - installs resume handlers for both old (pm_dev - APM) and new
>            (driver model) suspend/resume schemes.
>          - convert parameter handling to the new style
> 
> psmouse: - psmouse_pm_callback removed as i8042 will request reconnect
>            regardless of whether APM or new PM method is used.
> 
> The patched depend on bunch of other changes in input subsystem all of which
> can be found here:
> 
> http://www.geocities.com/dt_or/input
> 
> Should apply cleanly to -test11. If patching -mm tree omit patches 1-6 and 8
> as they are already present there.
> 
> Dmitry 
> 
> 
> ===================================================================
> 
> 
> ChangeSet@1.1514, 2003-12-07 01:48:52-05:00, dtor_core@ameritech.net
>   Input: - Implement resume methods using serio_reconnect facility
>          - Register i8042 with sysfs
>          - Register i8042 with older PM scheme to restore keyboard
>            and mouse for APM users
>          - Convert parameter handling to the new style
> 
> 
>  i8042.c |  520 +++++++++++++++++++++++++++++++++++++++-------------------------
>  1 files changed, 320 insertions(+), 200 deletions(-)
> 
> 
> ===================================================================
> 
> 
> 
> diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> --- a/drivers/input/serio/i8042.c	Sun Dec  7 02:17:56 2003
> +++ b/drivers/input/serio/i8042.c	Sun Dec  7 02:17:56 2003
> @@ -12,11 +12,14 @@
>  
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/moduleparam.h>
>  #include <linux/interrupt.h>
>  #include <linux/ioport.h>
>  #include <linux/config.h>
>  #include <linux/reboot.h>
>  #include <linux/init.h>
> +#include <linux/sysdev.h>
> +#include <linux/pm.h>
>  #include <linux/serio.h>
>  
>  #include <asm/io.h>
> @@ -25,19 +28,23 @@
>  MODULE_DESCRIPTION("i8042 keyboard and mouse controller driver");
>  MODULE_LICENSE("GPL");
>  
> -MODULE_PARM(i8042_noaux, "1i");
> -MODULE_PARM(i8042_nomux, "1i");
> -MODULE_PARM(i8042_unlock, "1i");
> -MODULE_PARM(i8042_reset, "1i");
> -MODULE_PARM(i8042_direct, "1i");
> -MODULE_PARM(i8042_dumbkbd, "1i");
> -
> -static int i8042_reset;
> -static int i8042_noaux;
> -static int i8042_nomux;
> -static int i8042_unlock;
> -static int i8042_direct;
> -static int i8042_dumbkbd;
> +static unsigned int i8042_noaux;
> +module_param(i8042_noaux, bool, 0);
> +
> +static unsigned int i8042_nomux;
> +module_param(i8042_nomux, bool, 0);
> +
> +static unsigned int i8042_unlock;
> +module_param(i8042_unlock, bool, 0);
> +
> +static unsigned int i8042_reset;
> +module_param(i8042_reset, bool, 0);
> +
> +static unsigned int i8042_direct;
> +module_param(i8042_direct, bool, 0);
> +
> +static unsigned int i8042_dumbkbd;
> +module_param(i8042_dumbkbd, bool, 0);
>  
>  #undef DEBUG
>  #include "i8042.h"
> @@ -59,6 +66,9 @@
>  static unsigned char i8042_initial_ctr;
>  static unsigned char i8042_ctr;
>  static unsigned char i8042_mux_open;
> +static unsigned char i8042_mux_present;
> +static unsigned char i8042_sysdev_initialized;
> +static struct pm_dev *i8042_pm_dev;
>  struct timer_list i8042_timer;
>  
>  /*
> @@ -214,16 +224,41 @@
>  }
>  
>  /*
> - * i8042_open() is called when a port is open by the higher layer.
> - * It allocates the interrupt and enables it in the chip.
> + * i8042_activate_port() enables port on a chip.
>   */
>  
> -static int i8042_open(struct serio *port)
> +static int i8042_activate_port(struct serio *port)
>  {
>  	struct i8042_values *values = port->driver;
>  
>  	i8042_flush();
>  
> +	/* 
> +	 * Enable port again here because it is disabled if we are
> +	 * resuming (normally it is enabled already).
> +	 */
> +	i8042_ctr &= ~values->disable;
> +
> +	i8042_ctr |= values->irqen;
> +
> +	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
> +		i8042_ctr &= ~values->irqen;
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +
> +/*
> + * i8042_open() is called when a port is open by the higher layer.
> + * It allocates the interrupt and calls i8042_enable_port.
> + */
> +
> +static int i8042_open(struct serio *port)
> +{
> +	struct i8042_values *values = port->driver;
> +
>  	if (values->mux != -1)
>  		if (i8042_mux_open++)
>  			return 0;
> @@ -234,10 +269,8 @@
>  		goto irq_fail;
>  	}
>  
> -	i8042_ctr |= values->irqen;
> -
> -	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
> -		printk(KERN_ERR "i8042.c: Can't write CTR while opening %s, unregistering the port\n", values->name);
> +	if (i8042_activate_port(port)) {
> +		printk(KERN_ERR "i8042.c: Can't activate %s, unregistering the port\n", values->name);
>  		goto ctr_fail;
>  	}
>  
> @@ -246,7 +279,6 @@
>  	return 0;
>  
>  ctr_fail:
> -	i8042_ctr &= ~values->irqen;
>  	free_irq(values->irq, i8042_request_irq_cookie);
>  
>  irq_fail:
> @@ -400,146 +432,80 @@
>  	return IRQ_RETVAL(j);
>  }
>  
> +
>  /*
> - * i8042_controller init initializes the i8042 controller, and,
> - * most importantly, sets it into non-xlated mode if that's
> - * desired.
> + * i8042_enable_mux_mode checks whether the controller has an active
> + * multiplexor and puts the chip into Multiplexed (as opposed to 
> + * Legacy) mode.
>   */
> -	
> -static int __init i8042_controller_init(void)
> +
> +static int i8042_enable_mux_mode(struct i8042_values *values, unsigned char *mux_version)
>  {
>  
> +	unsigned char param;
>  /*
> - * Test the i8042. We need to know if it thinks it's working correctly
> - * before doing anything else.
> + * Get rid of bytes in the queue.
>   */
>  
>  	i8042_flush();
>  
> -	if (i8042_reset) {
> -
> -		unsigned char param;
> -
> -		if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
> -			printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
> -			return -1;
> -		}
> -
> -		if (param != I8042_RET_CTL_TEST) {
> -			printk(KERN_ERR "i8042.c: i8042 controller selftest failed. (%#x != %#x)\n",
> -				 param, I8042_RET_CTL_TEST);
> -			return -1;
> -		}
> -	}
> -
>  /*
> - * Save the CTR for restoral on unload / reboot.
> + * Internal loopback test - send three bytes, they should come back from the
> + * mouse interface, the last should be version. Note that we negate mouseport
> + * command responses for the i8042_check_aux() routine.
>   */
>  
> -	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_RCTR)) {
> -		printk(KERN_ERR "i8042.c: Can't read CTR while initializing i8042.\n");
> +	param = 0xf0;
> +	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0x0f)
> +		return -1;
> +	param = 0x56;
> +	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa9)
> +		return -1;
> +	param = 0xa4;
> +	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == 0x5b)
>  		return -1;
> -	}
> -
> -	i8042_initial_ctr = i8042_ctr;
> -
> -/*
> - * Disable the keyboard interface and interrupt. 
> - */
>  
> -	i8042_ctr |= I8042_CTR_KBDDIS;
> -	i8042_ctr &= ~I8042_CTR_KBDINT;
> +	if (mux_version)
> +		*mux_version = ~param;
>  
> -/*
> - * Handle keylock.
> - */
> +	return 0; 
> +}
>  
> -	if (~i8042_read_status() & I8042_STR_KEYLOCK) {
> -		if (i8042_unlock)
> -			i8042_ctr |= I8042_CTR_IGNKEYLOCK;
> -		 else
> -			printk(KERN_WARNING "i8042.c: Warning: Keylock active.\n");
> -	}
>  
>  /*
> - * If the chip is configured into nontranslated mode by the BIOS, don't
> - * bother enabling translating and be happy.
> + * i8042_enable_mux_ports enables 4 individual AUX ports after
> + * the controller has been switched into Multiplexed mode
>   */
>  
> -	if (~i8042_ctr & I8042_CTR_XLATE)
> -		i8042_direct = 1;
> -
> +static int i8042_enable_mux_ports(struct i8042_values *values)
> +{
> +	unsigned char param;
> +	int i;
>  /*
> - * Set nontranslated mode for the kbd interface if requested by an option.
> - * After this the kbd interface becomes a simple serial in/out, like the aux
> - * interface is. We don't do this by default, since it can confuse notebook
> - * BIOSes.
> + * Disable all muxed ports by disabling AUX.
>   */
>  
> -	if (i8042_direct) {
> -		i8042_ctr &= ~I8042_CTR_XLATE;
> -		i8042_kbd_port.type = SERIO_8042;
> -	}
> -
> -/*
> - * Write CTR back.
> - */
> +	i8042_ctr |= I8042_CTR_AUXDIS;
> +	i8042_ctr &= ~I8042_CTR_AUXINT;
>  
>  	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
> -		printk(KERN_ERR "i8042.c: Can't write CTR while initializing i8042.\n");
> +		printk(KERN_ERR "i8042.c: Failed to disable AUX port, can't use MUX.\n");
>  		return -1;
>  	}
>  
> -	return 0;
> -}
> -
>  /*
> - * Here we try to reset everything back to a state in which the BIOS will be
> - * able to talk to the hardware when rebooting.
> - */
> -
> -void i8042_controller_cleanup(void)
> -{
> -	int i;
> -
> -	i8042_flush();
> -
> -/*
> - * Reset anything that is connected to the ports.
> - */
> -
> -	if (i8042_kbd_values.exists)
> -		serio_cleanup(&i8042_kbd_port);
> -
> -	if (i8042_aux_values.exists)
> -		serio_cleanup(&i8042_aux_port);
> -
> -	for (i = 0; i < 4; i++)
> -		if (i8042_mux_values[i].exists)
> -			serio_cleanup(i8042_mux_port + i);
> -
> -/*
> - * Reset the controller.
> + * Enable all muxed ports.
>   */
>  
> -	if (i8042_reset) {
> -		unsigned char param;
> -
> -		if (i8042_command(&param, I8042_CMD_CTL_TEST))
> -			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
> +	for (i = 0; i < 4; i++) {
> +		i8042_command(&param, I8042_CMD_MUX_PFX + i);
> +		i8042_command(&param, I8042_CMD_AUX_ENABLE);
>  	}
>  
> -/*
> - * Restore the original control register setting.
> - */
> -
> -	i8042_ctr = i8042_initial_ctr;
> -
> -	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
> -		printk(KERN_WARNING "i8042.c: Can't restore CTR.\n");
> -
> +	return 0;
>  }
>  
> +
>  /*
>   * i8042_check_mux() checks whether the controller supports the PS/2 Active
>   * Multiplexing specification by Synaptics, Phoenix, Insyde and
> @@ -548,66 +514,31 @@
>  
>  static int __init i8042_check_mux(struct i8042_values *values)
>  {
> -	unsigned char param;
>  	static int i8042_check_mux_cookie;
> -	int i;
> +	unsigned char mux_version;
>  
>  /*
>   * Check if AUX irq is available.
>   */
> -
>  	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
>  				"i8042", &i8042_check_mux_cookie))
>                  return -1;
>  	free_irq(values->irq, &i8042_check_mux_cookie);
>  
> -/*
> - * Get rid of bytes in the queue.
> - */
> -
> -	i8042_flush();
> -
> -/*
> - * Internal loopback test - send three bytes, they should come back from the
> - * mouse interface, the last should be version. Note that we negate mouseport
> - * command responses for the i8042_check_aux() routine.
> - */
> -
> -	param = 0xf0;
> -	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0x0f)
> -		return -1;
> -	param = 0x56;
> -	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa9)
> -		return -1;
> -	param = 0xa4;
> -	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == 0x5b)
> +	if (i8042_enable_mux_mode(values, &mux_version))
>  		return -1;
>  
>  	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev %d.%d.\n",
> -		(~param >> 4) & 0xf, ~param & 0xf);
> -
> -/*
> - * Disable all muxed ports by disabling AUX.
> - */
> -
> -	i8042_ctr |= I8042_CTR_AUXDIS;
> -	i8042_ctr &= ~I8042_CTR_AUXINT;
> +		(mux_version >> 4) & 0xf, mux_version & 0xf);
>  
> -	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
> +	if (i8042_enable_mux_ports(values))
>  		return -1;
>  
> -/*
> - * Enable all muxed ports.
> - */
> -
> -	for (i = 0; i < 4; i++) {
> -		i8042_command(&param, I8042_CMD_MUX_PFX + i);
> -		i8042_command(&param, I8042_CMD_AUX_ENABLE);
> -	}
> -
> +	i8042_mux_present = 1;
>  	return 0;
>  }
>  
> +
>  /*
>   * i8042_check_aux() applies as much paranoia as it can at detecting
>   * the presence of an AUX interface.
> @@ -683,6 +614,7 @@
>  	return 0;
>  }
>  
> +
>  /*
>   * i8042_port_register() marks the device as existing,
>   * registers it, and reports to the user.
> @@ -710,52 +642,194 @@
>  	return 0;
>  }
>  
> +
>  static void i8042_timer_func(unsigned long data)
>  {
>  	i8042_interrupt(0, NULL, NULL);
>  	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
>  }
>  
> -#ifndef MODULE
> -static int __init i8042_setup_reset(char *str)
> -{
> -	i8042_reset = 1;
> -	return 1;
> -}
> -static int __init i8042_setup_noaux(char *str)
> -{
> -	i8042_noaux = 1;
> -	i8042_nomux = 1;
> -	return 1;
> -}
> -static int __init i8042_setup_nomux(char *str)
> -{
> -	i8042_nomux = 1;
> -	return 1;
> -}
> -static int __init i8042_setup_unlock(char *str)
> +
> +/*
> + * i8042_controller init initializes the i8042 controller, and,
> + * most importantly, sets it into non-xlated mode if that's
> + * desired.
> + */
> +	
> +static int i8042_controller_init(void)
>  {
> -	i8042_unlock = 1;
> -	return 1;
> +
> +	if (i8042_noaux)
> +		i8042_nomux = 1;
> +/*
> + * Test the i8042. We need to know if it thinks it's working correctly
> + * before doing anything else.
> + */
> +
> +	i8042_flush();
> +
> +	if (i8042_reset) {
> +
> +		unsigned char param;
> +
> +		if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
> +			printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
> +			return -1;
> +		}
> +
> +		if (param != I8042_RET_CTL_TEST) {
> +			printk(KERN_ERR "i8042.c: i8042 controller selftest failed. (%#x != %#x)\n",
> +				 param, I8042_RET_CTL_TEST);
> +			return -1;
> +		}
> +	}
> +
> +/*
> + * Save the CTR for restoral on unload / reboot.
> + */
> +
> +	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_RCTR)) {
> +		printk(KERN_ERR "i8042.c: Can't read CTR while initializing i8042.\n");
> +		return -1;
> +	}
> +
> +	i8042_initial_ctr = i8042_ctr;
> +
> +/*
> + * Disable the keyboard interface and interrupt. 
> + */
> +
> +	i8042_ctr |= I8042_CTR_KBDDIS;
> +	i8042_ctr &= ~I8042_CTR_KBDINT;
> +
> +/*
> + * Handle keylock.
> + */
> +
> +	if (~i8042_read_status() & I8042_STR_KEYLOCK) {
> +		if (i8042_unlock)
> +			i8042_ctr |= I8042_CTR_IGNKEYLOCK;
> +		 else
> +			printk(KERN_WARNING "i8042.c: Warning: Keylock active.\n");
> +	}
> +
> +/*
> + * If the chip is configured into nontranslated mode by the BIOS, don't
> + * bother enabling translating and be happy.
> + */
> +
> +	if (~i8042_ctr & I8042_CTR_XLATE)
> +		i8042_direct = 1;
> +
> +/*
> + * Set nontranslated mode for the kbd interface if requested by an option.
> + * After this the kbd interface becomes a simple serial in/out, like the aux
> + * interface is. We don't do this by default, since it can confuse notebook
> + * BIOSes.
> + */
> +
> +	if (i8042_direct) {
> +		i8042_ctr &= ~I8042_CTR_XLATE;
> +		i8042_kbd_port.type = SERIO_8042;
> +	}
> +
> +/*
> + * Write CTR back.
> + */
> +
> +	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
> +		printk(KERN_ERR "i8042.c: Can't write CTR while initializing i8042.\n");
> +		return -1;
> +	}
> +
> +	return 0;
>  }
> -static int __init i8042_setup_direct(char *str)
> +
> +
> +/*
> + * Here we try to reset everything back to a state in which the BIOS will be
> + * able to talk to the hardware when rebooting.
> + */
> +
> +void i8042_controller_cleanup(void)
>  {
> -	i8042_direct = 1;
> -	return 1;
> +	int i;
> +
> +	i8042_flush();
> +
> +/*
> + * Reset anything that is connected to the ports.
> + */
> +
> +	if (i8042_kbd_values.exists)
> +		serio_cleanup(&i8042_kbd_port);
> +
> +	if (i8042_aux_values.exists)
> +		serio_cleanup(&i8042_aux_port);
> +
> +	for (i = 0; i < 4; i++)
> +		if (i8042_mux_values[i].exists)
> +			serio_cleanup(i8042_mux_port + i);
> +
> +/*
> + * Reset the controller.
> + */
> +
> +	if (i8042_reset) {
> +		unsigned char param;
> +
> +		if (i8042_command(&param, I8042_CMD_CTL_TEST))
> +			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
> +	}
> +
> +/*
> + * Restore the original control register setting.
> + */
> +
> +	i8042_ctr = i8042_initial_ctr;
> +
> +	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
> +		printk(KERN_WARNING "i8042.c: Can't restore CTR.\n");
> +
>  }
> -static int __init i8042_setup_dumbkbd(char *str)
> +
> +
> +/*
> + * Here we try to reset everything back to a state in which suspended
> + */
> +
> +static int i8042_controller_resume(void)
>  {
> -	i8042_dumbkbd = 1;
> -	return 1;
> +	int i;
> +
> +	if (i8042_controller_init()) {
> +		printk(KERN_ERR "i8042: resume failed\n");
> +		return -1;
> +	}
> +
> +	if (i8042_mux_present)
> +		if (i8042_enable_mux_mode(&i8042_aux_values, NULL) || 
> +		    i8042_enable_mux_ports(&i8042_aux_values)) {
> +			printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't wotk.\n");
> +		}
> +
> +/*
> + * Reconnect anything that was connected to the ports.
> + */
> +
> +	if (i8042_kbd_values.exists && i8042_activate_port(&i8042_kbd_port) == 0)
> +		serio_reconnect(&i8042_kbd_port);
> +
> +	if (i8042_aux_values.exists && i8042_activate_port(&i8042_aux_port) == 0)
> +		serio_reconnect(&i8042_aux_port);
> +
> +	for (i = 0; i < 4; i++)
> +		if (i8042_mux_values[i].exists && i8042_activate_port(i8042_mux_port + i) == 0)
> +			serio_reconnect(i8042_mux_port + i);
> +
> +	return 0;
>  }
>  
> -__setup("i8042_reset", i8042_setup_reset);
> -__setup("i8042_noaux", i8042_setup_noaux);
> -__setup("i8042_nomux", i8042_setup_nomux);
> -__setup("i8042_unlock", i8042_setup_unlock);
> -__setup("i8042_direct", i8042_setup_direct);
> -__setup("i8042_dumbkbd", i8042_setup_dumbkbd);
> -#endif
>  
>  /*
>   * We need to reset the 8042 back to original mode on system shutdown,
> @@ -777,6 +851,35 @@
>          0
>  };
>  
> +/*
> + * Resume handler for the new PM scheme (driver model)
> + */
> +static int i8042_resume(struct sys_device *dev)
> +{
> +	return i8042_controller_resume();
> +}
> +
> +static struct sysdev_class kbc_sysclass = {
> +       set_kset_name("i8042"),
> +       .resume = i8042_resume,
> +};
> +
> +static struct sys_device device_i8042 = {
> +       .id     = 0,
> +       .cls    = &kbc_sysclass,
> +};
> +
> +/*
> + * Resume handler for the old PM scheme (APM)
> + */
> +static int i8042_pm_callback(struct pm_dev *dev, pm_request_t request, void *dummy)
> +{
> +	if (request == PM_RESUME)
> +		return i8042_controller_resume();
> +
> +	return 0;
> +}
> +
>  static void __init i8042_init_mux_values(struct i8042_values *values, struct serio *port, int index)
>  {
>  	memcpy(port, &i8042_aux_port, sizeof(struct serio));
> @@ -825,6 +928,15 @@
>  	i8042_timer.function = i8042_timer_func;
>  	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
>  
> +        if (sysdev_class_register(&kbc_sysclass) == 0) {
> +                if (sys_device_register(&device_i8042) == 0)
> +			i8042_sysdev_initialized = 1;
> +		else
> +			sysdev_class_unregister(&kbc_sysclass);
> +        }
> +
> +	i8042_pm_dev = pm_register(PM_SYS_DEV, PM_SYS_UNKNOWN, i8042_pm_callback);
> +
>  	register_reboot_notifier(&i8042_notifier);
>  
>  	return 0;
> @@ -835,6 +947,14 @@
>  	int i;
>  
>  	unregister_reboot_notifier(&i8042_notifier);
> +
> +	if (i8042_pm_dev)
> +		pm_unregister(i8042_pm_dev);
> +
> +	if (i8042_sysdev_initialized) {
> +		sys_device_unregister(&device_i8042);
> +		sysdev_class_unregister(&kbc_sysclass);
> +	}
>  
>  	del_timer(&i8042_timer);
>  

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
