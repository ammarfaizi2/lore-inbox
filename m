Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUEFHNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUEFHNe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 03:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUEFHNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 03:13:34 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:22912 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S261880AbUEFHNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 03:13:06 -0400
Date: Thu, 6 May 2004 09:12:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] Convert i8042 input event handling to irq + tasklet
Message-ID: <20040506071256.GA379@ucw.cz>
References: <200405060150.52960.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405060150.52960.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 01:50:52AM -0500, Dmitry Torokhov wrote:

> Entire input event handling in i8042 is done from interrupt context. Given
> that there is mousedev emulation, evdev and what's not it seems way too much
> for my taste. The patch below moves most of the processing into a tasklet
> leaving only retrieving data from the KBC to interrup handler. What do you
> think?

Looks reasonable. The FIFO is a good thing, because before we
theoretically could deliver characters in the wrong order on multi-cpu
machines.

> --- linus-2.5/drivers/input/serio/i8042.c	2004-05-06 00:54:57.000000000 -0500
> +++ dtor/drivers/input/serio/i8042.c	2004-05-06 00:35:32.000000000 -0500
> @@ -74,6 +74,14 @@
>  	unsigned char *phys;
>  };
>  
> +#define I8042_QUEUE_LEN		64
> +struct {
> +	unsigned char str[I8042_QUEUE_LEN];
> +	unsigned char data[I8042_QUEUE_LEN];
> +	unsigned int read_pos;
> +	unsigned int write_pos;
> +} i8042_buf;
> +
>  static struct serio i8042_kbd_port;
>  static struct serio i8042_aux_port;
>  static unsigned char i8042_initial_ctr;
> @@ -82,7 +90,7 @@
>  static unsigned char i8042_mux_present;
>  static unsigned char i8042_sysdev_initialized;
>  static struct pm_dev *i8042_pm_dev;
> -struct timer_list i8042_timer;
> +static struct timer_list i8042_timer;
>  
>  /*
>   * Shared IRQ's require a device pointer, but this driver doesn't support
> @@ -374,77 +382,109 @@
>  static char i8042_mux_phys[4][32];
>  
>  /*
> - * i8042_interrupt() is the most important function in this driver -
> - * it handles the interrupts from the i8042, and sends incoming bytes
> - * to the upper layers.
> + * i8042_handle_data() is the most important function in this driver -
> + * it processes data received by i8042_interrupt and sends it to the
> + * upper layers.
>   */
>  
> -static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> +static void i8042_handle_data(unsigned long notused)
>  {
> -	unsigned long flags;
>  	unsigned char str, data = 0;
>  	unsigned int dfl;
> -	int ret;
>  
> -	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
> +	/*
> +	 * No locking it required on i8042_buf as the tasklet is guaranteed
> +	 * to be serialized and if write_pos changes while comparing it with
> +	 * read_pos another run will be scheduled by i8042_interrupt.
> +	 */
> +	while (i8042_buf.read_pos != i8042_buf.write_pos) {
>  
> -	spin_lock_irqsave(&i8042_lock, flags);
> -	str = i8042_read_status();
> -	if (str & I8042_STR_OBF)
> -		data = i8042_read_data();
> -	spin_unlock_irqrestore(&i8042_lock, flags);
> +		str = i8042_buf.str[i8042_buf.read_pos];
> +		data = i8042_buf.data[i8042_buf.read_pos];
>  
> -	if (~str & I8042_STR_OBF) {
> -		if (irq) dbg("Interrupt %d, without any data", irq);
> -		ret = 0;
> -		goto out;
> +		i8042_buf.read_pos++;
> +		i8042_buf.read_pos %= I8042_QUEUE_LEN;
> +
> +		dfl = ((str & I8042_STR_PARITY)  ? SERIO_PARITY  : 0) |
> +	      	      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
> +
> +		if (i8042_mux_values[0].exists && (str & I8042_STR_AUXDATA)) {
> +
> +			if (str & I8042_STR_MUXERR) {
> +				switch (data) {
> +					case 0xfd:
> +					case 0xfe: dfl = SERIO_TIMEOUT; break;
> +					case 0xff: dfl = SERIO_PARITY; break;
> +				}
> +				data = 0xfe;
> +			} else dfl = 0;
> +
> +			dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
> +				data, (str >> 6), irq,
> +				dfl & SERIO_PARITY ? ", bad parity" : "",
> +				dfl & SERIO_TIMEOUT ? ", timeout" : "");
> +
> +			serio_interrupt(i8042_mux_port + ((str >> 6) & 3), data, dfl, NULL);
> +		} else {
> +
> +			dbg("%02x <- i8042 (interrupt, %s, %d%s%s)",
> +				data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq,
> +				dfl & SERIO_PARITY ? ", bad parity" : "",
> +				dfl & SERIO_TIMEOUT ? ", timeout" : "");
> +
> +			if (i8042_aux_values.exists && (str & I8042_STR_AUXDATA))
> +				serio_interrupt(&i8042_aux_port, data, dfl, NULL);
> +			else if (i8042_kbd_values.exists)
> +				serio_interrupt(&i8042_kbd_port, data, dfl, NULL);
> +		}
>  	}
> +}
>  
> -	dfl = ((str & I8042_STR_PARITY) ? SERIO_PARITY : 0) |
> -	      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
> +DECLARE_TASKLET(i8042_tasklet, i8042_handle_data, 0);
>  
> -	if (i8042_mux_values[0].exists && (str & I8042_STR_AUXDATA)) {
> +/*
> + * i8042_interrupt() handles the interrupts from i8042 and schedules
> + * i8042_handle_data to process and pass received bytes to the upper
> + * layers.
> + */
>  
> -		if (str & I8042_STR_MUXERR) {
> -			switch (data) {
> -				case 0xfd:
> -				case 0xfe: dfl = SERIO_TIMEOUT; break;
> -				case 0xff: dfl = SERIO_PARITY; break;
> -			}
> -			data = 0xfe;
> -		} else dfl = 0;
> +static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	unsigned long flags;
> +	unsigned char str;
> +	unsigned int n_bytes = 0;
>  
> -		dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
> -			data, (str >> 6), irq, 
> -			dfl & SERIO_PARITY ? ", bad parity" : "",
> -			dfl & SERIO_TIMEOUT ? ", timeout" : "");
> +	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
>  
> -		serio_interrupt(i8042_mux_port + ((str >> 6) & 3), data, dfl, regs);
> -		
> -		goto irq_ret;
> -	}
> +	spin_lock_irqsave(&i8042_lock, flags);
> +
> +	while ((str = i8042_read_status()) & I8042_STR_OBF) {
>  
> -	dbg("%02x <- i8042 (interrupt, %s, %d%s%s)",
> -		data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq, 
> -		dfl & SERIO_PARITY ? ", bad parity" : "",
> -		dfl & SERIO_TIMEOUT ? ", timeout" : "");
> +		n_bytes++;
>  
> -	if (i8042_aux_values.exists && (str & I8042_STR_AUXDATA)) {
> -		serio_interrupt(&i8042_aux_port, data, dfl, regs);
> -		goto irq_ret;
> +		i8042_buf.str[i8042_buf.write_pos] = str;
> +		i8042_buf.data[i8042_buf.write_pos] = i8042_read_data();
> +
> +		i8042_buf.write_pos++;
> +		i8042_buf.write_pos %= I8042_QUEUE_LEN;
> +
> +		if (unlikely(i8042_buf.write_pos == i8042_buf.read_pos))
> +			printk(KERN_WARNING "i8042.c: ring buffer full\n");
>  	}
>  
> -	if (!i8042_kbd_values.exists)
> -		goto irq_ret;
> +	spin_unlock_irqrestore(&i8042_lock, flags);
> +
> +	if (unlikely(n_bytes == 0)) {
> +		if (irq) dbg("Interrupt %d, without any data", irq);
> +		return IRQ_NONE;
> +	}
>  
> -	serio_interrupt(&i8042_kbd_port, data, dfl, regs);
> +	tasklet_schedule(&i8042_tasklet);
>  
> -irq_ret:
> -	ret = 1;
> -out:
> -	return IRQ_RETVAL(ret);
> +	return IRQ_HANDLED;
>  }
>  
> +
>  /*
>   * i8042_enable_mux_mode checks whether the controller has an active
>   * multiplexor and puts the chip into Multiplexed (as opposed to
> @@ -1011,6 +1053,8 @@
>  		if (i8042_mux_values[i].exists)
>  			serio_unregister_port(i8042_mux_port + i);
>  
> +	tasklet_kill(&i8042_tasklet);
> +
>  	i8042_platform_exit();
>  }
>  
> 
> -- 
> Dmitry
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
