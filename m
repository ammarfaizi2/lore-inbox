Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267156AbTAFVnz>; Mon, 6 Jan 2003 16:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267165AbTAFVnz>; Mon, 6 Jan 2003 16:43:55 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:56713 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267156AbTAFVnt>;
	Mon, 6 Jan 2003 16:43:49 -0500
Date: Mon, 6 Jan 2003 22:52:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: alan@redhat.com, greg@kroah.com, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: Fwd: Patch for initial CapsLock
Message-ID: <20030106225218.A1627@ucw.cz>
References: <20030106133716.A7554@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030106133716.A7554@devserv.devel.redhat.com>; from zaitcev@redhat.com on Mon, Jan 06, 2003 at 01:37:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 01:37:16PM -0500, Pete Zaitcev wrote:
> Dear Alan,
> 
> Here's a USB problem which can only be resolved in generic code.
> Vojtech is the owner of the code, but did not reply. Do you think
> you can keep this patch in -ac?

Sorry for the delay - yes, it's OK.

> 
> Thanks in advance,
> -- Pete
> 
> ----- Forwarded message from Pete Zaitcev <zaitcev@redhat.com> -----
> 
> Date: Tue, 24 Dec 2002 13:41:03 -0500
> From: Pete Zaitcev <zaitcev@redhat.com>
> To: vojtech@suse.cz
> Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
> Subject: Patch for initial CapsLock
> User-Agent: Mutt/1.2.5.1i
> 
> Hi, Vojtech:
> 
> In 2.4.21-pre2, if Caps Lock is on and a USB keyboard is connected,
> the LED will not be lit. It mostly affects KVM users like those
> of IBM BladeCenter, because they "connect" keyboards all day long.
> Would you be so kind to review the attached patch?
> 
> -- Pete
> 
> diff -ur -X dontdiff linux-2.4.21-pre2/drivers/char/keyboard.c linux-2.4.21-pre2-usb/drivers/char/keyboard.c
> --- linux-2.4.21-pre2/drivers/char/keyboard.c	2002-08-02 17:39:43.000000000 -0700
> +++ linux-2.4.21-pre2-usb/drivers/char/keyboard.c	2002-12-24 10:40:48.000000000 -0800
> @@ -64,6 +64,7 @@
>  void (*kbd_ledfunc)(unsigned int led);
>  EXPORT_SYMBOL(handle_scancode);
>  EXPORT_SYMBOL(kbd_ledfunc);
> +EXPORT_SYMBOL(kbd_refresh_leds);
>  
>  extern void ctrl_alt_del(void);
>  
> @@ -899,9 +900,9 @@
>   * Aside from timing (which isn't really that important for
>   * keyboard interrupts as they happen often), using the software
>   * interrupt routines for this thing allows us to easily mask
> - * this when we don't want any of the above to happen. Not yet
> - * used, but this allows for easy and efficient race-condition
> - * prevention later on.
> + * this when we don't want any of the above to happen.
> + * This allows for easy and efficient race-condition prevention
> + * for kbd_ledfunc => input_event(dev, EV_LED, ...) => ...
>   */
>  static void kbd_bh(unsigned long dummy)
>  {
> @@ -917,6 +918,18 @@
>  EXPORT_SYMBOL(keyboard_tasklet);
>  DECLARE_TASKLET_DISABLED(keyboard_tasklet, kbd_bh, 0);
>  
> +/*
> + * This allows a newly plugged keyboard to pick the LED state.
> + * We do it in this seemindly backwards fashion to ensure proper locking.
> + * Built-in keyboard does refresh on its own.
> + */
> +void kbd_refresh_leds(void)
> +{
> +	tasklet_disable(&keyboard_tasklet);
> +	if (ledstate != 0xff && kbd_ledfunc != NULL) kbd_ledfunc(ledstate);
> +	tasklet_enable(&keyboard_tasklet);
> +}
> +
>  typedef void (pm_kbd_func) (void);
>  
>  pm_callback pm_kbd_request_override = NULL;
> diff -ur -X dontdiff linux-2.4.21-pre2/drivers/input/keybdev.c linux-2.4.21-pre2-usb/drivers/input/keybdev.c
> --- linux-2.4.21-pre2/drivers/input/keybdev.c	2001-10-11 09:14:32.000000000 -0700
> +++ linux-2.4.21-pre2-usb/drivers/input/keybdev.c	2002-12-23 23:43:53.000000000 -0800
> @@ -201,6 +201,7 @@
>  	input_open_device(handle);
>  
>  //	printk(KERN_INFO "keybdev.c: Adding keyboard: input%d\n", dev->number);
> +	kbd_refresh_leds();
>  
>  	return handle;
>  }
> @@ -222,6 +223,7 @@
>  {
>  	input_register_handler(&keybdev_handler);
>  	kbd_ledfunc = keybdev_ledfunc;
> +	kbd_refresh_leds();
>  
>  	if (jp_kbd_109) {
>  		x86_keycodes[0xb5] = 0x73;	/* backslash, underscore */
> diff -ur -X dontdiff linux-2.4.21-pre2/include/linux/kbd_kern.h linux-2.4.21-pre2-usb/include/linux/kbd_kern.h
> --- linux-2.4.21-pre2/include/linux/kbd_kern.h	2002-12-19 20:22:19.000000000 -0800
> +++ linux-2.4.21-pre2-usb/include/linux/kbd_kern.h	2002-12-23 23:43:31.000000000 -0800
> @@ -72,6 +72,7 @@
>  extern int do_poke_blanked_console;
>  
>  extern void (*kbd_ledfunc)(unsigned int led);
> +extern void kbd_refresh_leds(void);
>  
>  extern void set_console(int nr);
>  extern void schedule_console_callback(void);
> 
> ----- End forwarded message -----

-- 
Vojtech Pavlik
SuSE Labs
