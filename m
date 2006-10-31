Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161573AbWJaHtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161573AbWJaHtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161612AbWJaHtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:49:11 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:3837 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1161573AbWJaHtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:49:09 -0500
Date: Tue, 31 Oct 2006 08:49:07 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       R.E.Wolff@BitWizard.nl, support@specialix.co.uk
Subject: Re: [PATCH 4/9] Char: sx, remove unneeded stuff
Message-ID: <20061031074907.GA2031@bitwizard.nl>
References: <17859287641876623669@karneval.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17859287641876623669@karneval.cz>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

When you work on a driver, it has happened to me multiple times that
I forget to acknowledge the interrupt to the hardware. This is when
the "rate limit" converts a solid hang ("what the <beep> is going on?)
into a console message that "your interrupt is triggering too much". 

This reduces development time on the driver, which I think is worth
the 20 or so inactive lines-of-code that this requires in the source. 

Also proposed to be deleted the defines that I added to remind me
of the possibility to report fifo overruns. Other drivers have this
capability, but much smaller buffers. So it hasn't been neccesary
yet. For now it remains unimplemented. But I would prefer to keep
the notes of the possibility of this enhancement in the driver source
instead of somewhere else. 


Apparently, someone deleted the call to the word-wide memory test. So 
now the memory test seems dead code. I've had clients call for support 
where after debugging a while, the conclusion was: you may have a corruption
problem between the CPU and the card. Enable memory test, and voila!
Proof that there is something seriously wrong with the hardware setup!

This debugging feature is uncommon enough that I recommend leaving it
compile-time-disabled. The other debugging features are compile time
enabled, run-time-disabled. This allows end-users to send in detailed
debugging reports without having to recompile the driver, which usually
costs them a lot of time. 

The other "small" cleanups look ok. 

	Roger. 


On Tue, Oct 31, 2006 at 01:42:06AM +0100, Jiri Slaby wrote:
> sx, remove unneeded stuff
> 
> remove #if 0's and commented code. We have version control for this purpose.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> ---
> commit 10fd13e67b848584d1553b524d2e925ad60a1b4f
> tree 6a6750db2865877d6c7c31a5f8406e53e79af787
> parent b7dbf65a81c1707405982cb66aa5df5a9ada464e
> author Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 00:43:11 +0100
> committer Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 00:43:11 +0100
> 
>  drivers/char/sx.c |  132 -----------------------------------------------------
>  1 files changed, 1 insertions(+), 131 deletions(-)
> 
> diff --git a/drivers/char/sx.c b/drivers/char/sx.c
> index 7395c13..fe5fabb 100644
> --- a/drivers/char/sx.c
> +++ b/drivers/char/sx.c
> @@ -252,29 +252,6 @@ #endif
>  /* Am I paranoid or not ? ;-) */
>  #undef SX_PARANOIA_CHECK
>  
> -/* 20 -> 2000 per second. The card should rate-limit interrupts at 100
> -   Hz, but it is user configurable. I don't recommend going above 1000
> -   Hz. The interrupt ratelimit might trigger if the interrupt is
> -   shared with a very active other device. */
> -#define IRQ_RATE_LIMIT 20
> -
> -/* Sharing interrupts is possible now. If the other device wants more
> -   than 2000 interrupts per second, we'd gracefully decline further
> -   interrupts. That's not what we want. On the other hand, if the
> -   other device interrupts 2000 times a second, don't use the SX
> -   interrupt. Use polling. */
> -#undef IRQ_RATE_LIMIT
> -
> -#if 0
> -/* Not implemented */
> -/* 
> - * The following defines are mostly for testing purposes. But if you need
> - * some nice reporting in your syslog, you can define them also.
> - */
> -#define SX_REPORT_FIFO
> -#define SX_REPORT_OVERRUN
> -#endif
> -
>  /* Function prototypes */
>  static void sx_disable_tx_interrupts(void *ptr);
>  static void sx_enable_tx_interrupts(void *ptr);
> @@ -1011,7 +988,7 @@ #define CFLAG port->gs.tty->termios->c_c
>  	}
>  	sx_dprintk(SX_DEBUG_TERMIOS, "oflags: %x(%d)\n",
>  			port->gs.tty->termios->c_oflag, O_OTHER(port->gs.tty));
> -	/* port->c_dcd = sx_get_CD (port); */
> +
>  	func_exit();
>  	return 0;
>  }
> @@ -1173,7 +1150,6 @@ static inline void sx_receive_chars(stru
>  		/* Tell the rest of the system the news. Great news. New 
>  		   characters! */
>  		tty_flip_buffer_push(tty);
> -		/*    tty_schedule_flip (tty); */
>  	}
>  
>  	func_exit();
> @@ -1254,9 +1230,6 @@ static irqreturn_t sx_interrupt(int irq,
>  	/* AAargh! The order in which to do these things is essential and
>  	   not trivial. 
>  
> -	   - Rate limit goes before "recursive". Otherwise a series of
> -	   recursive calls will hang the machine in the interrupt routine. 
> -
>  	   - hardware twiddling goes before "recursive". Otherwise when we
>  	   poll the card, and a recursive interrupt happens, we won't
>  	   ack the card, so it might keep on interrupting us. (especially
> @@ -1271,28 +1244,6 @@ static irqreturn_t sx_interrupt(int irq,
>  	   - The initialized test goes before recursive. 
>  	 */
>  
> -#ifdef IRQ_RATE_LIMIT
> -	/* Aaargh! I'm ashamed. This costs more lines-of-code than the
> -	   actual interrupt routine!. (Well, used to when I wrote that
> -	   comment) */
> -	{
> -		static int lastjif;
> -		static int nintr = 0;
> -
> -		if (lastjif == jiffies) {
> -			if (++nintr > IRQ_RATE_LIMIT) {
> -				free_irq(board->irq, board);
> -				printk(KERN_ERR "sx: Too many interrupts. "
> -						"Turning off interrupt %d.\n",
> -						board->irq);
> -			}
> -		} else {
> -			lastjif = jiffies;
> -			nintr = 0;
> -		}
> -	}
> -#endif
> -
>  	if (board->irq == irq) {
>  		/* Tell the card we've noticed the interrupt. */
>  
> @@ -1401,7 +1352,6 @@ static void sx_enable_tx_interrupts(void
>  
>  static void sx_disable_rx_interrupts(void *ptr)
>  {
> -	/*  struct sx_port *port = ptr; */
>  	func_enter();
>  
>  	func_exit();
> @@ -1409,7 +1359,6 @@ static void sx_disable_rx_interrupts(voi
>  
>  static void sx_enable_rx_interrupts(void *ptr)
>  {
> -	/*  struct sx_port *port = ptr; */
>  	func_enter();
>  
>  	func_exit();
> @@ -1505,13 +1454,8 @@ static int sx_open(struct tty_struct *tt
>  	if (port->gs.count <= 1)
>  		sx_setsignals(port, 1, 1);
>  
> -#if 0
> -	if (sx_debug & SX_DEBUG_OPEN)
> -		my_hd(port, sizeof(*port));
> -#else
>  	if (sx_debug & SX_DEBUG_OPEN)
>  		my_hd_io(port->board->base + port->ch_base, sizeof(*port));
> -#endif
>  
>  	if (port->gs.count <= 1) {
>  		if (sx_send_command(port, HS_LOPEN, -1, HS_IDLE_OPEN) != 1) {
> @@ -1535,7 +1479,6 @@ #endif
>  
>  		return retval;
>  	}
> -	/* tty->low_latency = 1; */
>  
>  	port->c_dcd = sx_get_CD(port);
>  	sx_dprintk(SX_DEBUG_OPEN, "at open: cd=%d\n", port->c_dcd);
> @@ -1576,9 +1519,6 @@ static void sx_close(void *ptr)
>  	if (port->gs.count) {
>  		sx_dprintk(SX_DEBUG_CLOSE, "WARNING port count:%d\n",
>  				port->gs.count);
> -		/*printk("%s SETTING port count to zero: %p count: %d\n",
> -				__FUNCTION__, port, port->gs.count);
> -		port->gs.count = 0;*/
>  	}
>  
>  	func_exit();
> @@ -1641,52 +1581,6 @@ #undef W1
>  #undef R0
>  #undef R1
>  
> -#define MARCHUP		for (i = min; i < max; i += 2)
> -#define MARCHDOWN	for (i = max - 1; i >= min; i -= 2)
> -#define W0		write_sx_word(board, i, 0x55aa)
> -#define W1		write_sx_word(board, i, 0xaa55)
> -#define R0		if (read_sx_word(board, i) != 0x55aa) return 1
> -#define R1		if (read_sx_word(board, i) != 0xaa55) return 1
> -
> -#if 0
> -/* This memtest takes a human-noticable time. You normally only do it
> -   once a boot, so I guess that it is worth it. */
> -static int do_memtest_w(struct sx_board *board, int min, int max)
> -{
> -	int i;
> -
> -	MARCHUP {
> -		W0;
> -	}
> -	MARCHUP {
> -		R0;
> -		W1;
> -		R1;
> -		W0;
> -		R0;
> -		W1;
> -	}
> -	MARCHUP {
> -		R1;
> -		W0;
> -		W1;
> -	}
> -	MARCHDOWN {
> -		R1;
> -		W0;
> -		W1;
> -		W0;
> -	}
> -	MARCHDOWN {
> -		R0;
> -		W1;
> -		W0;
> -	}
> -
> -	return 0;
> -}
> -#endif
> -
>  static int sx_fw_ioctl(struct inode *inode, struct file *filp,
>  		unsigned int cmd, unsigned long arg)
>  {
> @@ -1700,13 +1594,8 @@ static int sx_fw_ioctl(struct inode *ino
>  
>  	func_enter();
>  
> -#if 0
>  	/* Removed superuser check: Sysops can use the permissions on the device
>  	   file to restrict access. Recommendation: Root only. (root.root 600) */
> -	if (!capable(CAP_SYS_ADMIN)) {
> -		return -EPERM;
> -	}
> -#endif
>  
>  	sx_dprintk(SX_DEBUG_FIRMWARE, "IOCTL %x: %lx\n", cmd, arg);
>  
> @@ -1756,10 +1645,8 @@ #endif
>  			rc = do_memtest(board, 0, 0x7000);
>  			if (!rc)
>  				rc = do_memtest(board, 0, 0x7000);
> -			/*if (!rc) rc = do_memtest_w (board, 0, 0x7000); */
>  		} else {
>  			rc = do_memtest(board, 0, 0x7ff8);
> -			/* if (!rc) rc = do_memtest_w (board, 0, 0x7ff8); */
>  		}
>  		sx_dprintk(SX_DEBUG_FIRMWARE, "returning memtest result= %d\n",
>  			   rc);
> @@ -1893,8 +1780,6 @@ static int sx_ioctl(struct tty_struct *t
>  	void __user *argp = (void __user *)arg;
>  	int ival;
>  
> -	/* func_enter2(); */
> -
>  	rc = 0;
>  	switch (cmd) {
>  	case TIOCGSOFTCAR:
> @@ -1919,7 +1804,6 @@ static int sx_ioctl(struct tty_struct *t
>  		break;
>  	}
>  
> -	/* func_exit(); */
>  	return rc;
>  }
>  
> @@ -2030,7 +1914,6 @@ static int sx_init_board(struct sx_board
>  	}
>  
>  	/* grab the first module type... */
> -	/* board->ta_type = mod_compat_type (read_sx_byte (board, 0x80 + 0x08)); */
>  	board->ta_type = mod_compat_type(sx_read_module_byte(board, 0x80,
>  				mc_chip));
>  
> @@ -2075,17 +1958,6 @@ static int sx_init_board(struct sx_board
>  			chans = 0;
>  			break;
>  		}
> -#if 0				/* Problem fixed: firmware 3.05 */
> -		if (IS_SX_BOARD(board) && (type == TA8)) {
> -			/* There are some issues with the firmware and the DCD/RTS
> -			   lines. It might work if you tie them together or something.
> -			   It might also work if you get a newer sx_firmware.   Therefore
> -			   this is just a warning. */
> -			printk(KERN_WARNING
> -			       "sx: The SX host doesn't work too well "
> -			       "with the TA8 adapters.\nSpecialix is working on it.\n");
> -		}
> -#endif
>  	}
>  
>  	if (chans) {
> @@ -2465,8 +2337,6 @@ #endif
>  			}
>  			sx_dprintk(SX_DEBUG_PROBE, "\n");
>  		}
> -		/* This has to be done earlier. */
> -		/* board->flags |= SX_BOARD_INITIALIZED; */
>  	}
>  
>  	func_exit();

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
