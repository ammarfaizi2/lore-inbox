Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbUCBWC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbUCBWC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:02:57 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:245 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262054AbUCBWC1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:02:27 -0500
Message-ID: <40450468.2090700@mvista.com>
Date: Tue, 02 Mar 2004 14:02:16 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>, Pavel Machek <pavel@suse.cz>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
References: <20040302213901.GF20227@smtp.west.cox.net>
In-Reply-To: <20040302213901.GF20227@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> Hello.  The following interdiff kills kgdb_serial in favor of function
> names.  This only adds a weak function for kgdb_flush_io, and documents
> when it would need to be provided.

It looks like you are also dumping any notion of building a kernel that can 
choose which method of communication to use for kgdb at run time.  Is this so?

-g
> 
> diff -u linux-2.6.3/drivers/net/kgdb_eth.c linux-2.6.3/drivers/net/kgdb_eth.c
> --- linux-2.6.3/drivers/net/kgdb_eth.c	2004-02-27 14:16:02.339413768 -0700
> +++ linux-2.6.3/drivers/net/kgdb_eth.c	2004-03-02 14:31:41.267262668 -0700
> @@ -72,7 +72,7 @@
>  	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
>  };
>  
> -int eth_getDebugChar(void)
> +int kgdb_read_debug_char(void)
>  {
>  	int chr;
>  
> @@ -85,7 +85,7 @@
>  	return chr;
>  }
>  
> -void eth_flushDebugChar(void)
> +void kgdb_flush_io(void)
>  {
>  	if (out_count && np.dev) {
>  		netpoll_send_udp(&np, out_buf, out_count);
> @@ -94,11 +94,11 @@
>  	}
>  }
>  
> -void eth_putDebugChar(int chr)
> +void kgdb_write_debug_char(int chr)
>  {
>  	out_buf[out_count++] = chr;
>  	if (out_count == OUT_BUF_SIZE)
> -		eth_flushDebugChar();
> +		kgdb_flush_io();
>  }
>  
>  static void rx_hook(struct netpoll *np, int port, char *msg, int len)
> @@ -137,7 +137,7 @@
>  
>  __setup("kgdboe=", option_setup);
>  
> -static int hook(void)
> +static int kgdb_hook_io(void)
>  {
>  	/* Un-initalized, don't go further. */
>  	if (kgdboe != 1)
> @@ -148,19 +148,11 @@
>  	return 0;
>  }
>  
> -struct kgdb_serial kgdbeth_serial = {
> -	.read_char = eth_getDebugChar,
> -	.write_char = eth_putDebugChar,
> -	.hook = hook,
> -	.flush = eth_flushDebugChar,
> -};
> -
>  static int init_kgdboe(void)
>  {
>  	if (!np.remote_ip || netpoll_setup(&np))
>  		return 1;
>  
> -	kgdb_serial = &kgdbeth_serial;
>  	kgdboe = 1;
>  	printk(KERN_INFO "kgdb: debugging over ethernet enabled\n");
>  
> diff -u linux-2.6.3/drivers/serial/kgdb_8250.c linux-2.6.3/drivers/serial/kgdb_8250.c
> --- linux-2.6.3/drivers/serial/kgdb_8250.c	2004-03-01 08:12:18.293899848 -0700
> +++ linux-2.6.3/drivers/serial/kgdb_8250.c	2004-03-02 14:31:59.210205936 -0700
> @@ -128,7 +128,7 @@
>   * Wait until the interface can accept a char, then write it.
>   */
>  void
> -kgdb_put_debug_char(int chr)
> +kgdb_write_debug_char(int chr)
>  {
>  	while (!(serial_inb(kgdb8250_port + (UART_LSR << reg_shift)) &
>  		UART_LSR_THRE))
> @@ -154,7 +154,7 @@
>  	 */
>  	if (it & 0xc) {
>  		kgdb8250_init();
> -		kgdb_put_debug_char('-');
> +		kgdb_write_debug_char('-');
>  		return '-';
>  	}
>  
> @@ -167,7 +167,7 @@
>   */
>  
>  int
> -kgdb_get_debug_char(void)
> +kgdb_read_debug_char(void)
>  {
>  	int retchr;
>  	unsigned long flags;
> @@ -379,12 +379,6 @@
>  	return 0;
>  }
>  
> -struct kgdb_serial kgdb8250_serial_driver = {
> -	.read_char = kgdb_get_debug_char,
> -	.write_char = kgdb_put_debug_char,
> -	.hook = kgdb_hook_io,
> -};
> -
>  void
>  kgdb8250_add_port(int i, struct uart_port *serial_req)
>  {
> @@ -422,8 +416,6 @@
>  	/* Make the baud rate change happen. */
>  	gdb_async_info.state->custom_divisor = BASE_BAUD / kgdb8250_baud;
>  
> -	kgdb_serial = &kgdb8250_serial_driver;
> -
>  	return 1;
>  
>        errout:
> diff -u linux-2.6.3/arch/ppc/kernel/kgdb.c linux-2.6.3/arch/ppc/kernel/kgdb.c
> --- linux-2.6.3/arch/ppc/kernel/kgdb.c	2004-03-01 10:01:48.164203161 -0700
> +++ linux-2.6.3/arch/ppc/kernel/kgdb.c	2004-03-02 14:26:16.330767482 -0700
> @@ -263,27 +263,21 @@
>  };
>  
>  #ifdef CONFIG_PPC_SIMPLE_SERIAL
> -static void kgdbppc_write_char(int chr)
> +static void kgdb_write_debug_char(int chr)
>  {
>  	putDebugChar(chr);
>  }
>  
> -static int kgdbppc_read_char(void)
> +static int kgdb_read_debug_char(void)
>  {
>  	return getDebugChar();
>  }
>  
> -int kgdbppc_hook(void)
> +int kgdb_hook_io(void)
>  {
>  	kgdb_map_scc();
>  	return 0;
>  }
> -
> -struct kgdb_serial kgdbppc_serial = {
> -	.read_char = kgdbppc_read_char,
> -	.write_char = kgdbppc_write_char,
> -	.hook = kgdbppc_hook
> -};
>  #endif
>  
>  int kgdb_arch_init (void)
> @@ -295,14 +289,4 @@
>  	debugger_dabr_match = kgdb_dabr_match;
>  
> -	/* If we have the bigger 8250 serial driver, set that to be
> -	 * the output now. */
> -#if defined(CONFIG_KGDB_8250)
> -        extern struct kgdb_serial kgdb8250_serial_driver;
> -        kgdb_serial = &kgdb8250_serial_driver;
> -#elif defined(CONFIG_PPC_SIMPLE_SERIAL)
> -	/* Take our serial driver. */
> -	kgdb_serial = &kgdbppc_serial;
> -#endif
> -
>  	return 0;
>  }
> diff -u linux-2.6.3/include/linux/kgdb.h linux-2.6.3/include/linux/kgdb.h
> --- linux-2.6.3/include/linux/kgdb.h	2004-03-01 08:19:06.668218454 -0700
> +++ linux-2.6.3/include/linux/kgdb.h	2004-03-02 14:27:05.880556965 -0700
> @@ -102,14 +102,12 @@
>  /* Thread reference */
>  typedef unsigned char threadref[8];
>  
> -struct kgdb_serial {
> -	int (*read_char) (void);
> -	void (*write_char) (int);
> -	void (*flush) (void);
> -	int (*hook) (void);
> -};
> +/* I/O */
> +extern int kgdb_read_debug_char(void);
> +extern void kgdb_write_debug_char(int ch);
> +extern void kgdb_flush_io(void);
> +extern int kgdb_hook_io(void);
>  
> -extern struct kgdb_serial *kgdb_serial;
>  extern struct kgdb_arch arch_kgdb_ops;
>  extern int kgdb_initialized;
>  
> diff -u linux-2.6.3/kernel/kgdb.c linux-2.6.3/kernel/kgdb.c
> --- linux-2.6.3/kernel/kgdb.c	2004-03-01 08:19:06.672217551 -0700
> +++ linux-2.6.3/kernel/kgdb.c	2004-03-02 14:25:42.590401068 -0700
> @@ -73,8 +73,6 @@
>   * also at runtime. */
>  int kgdb_useraccess = 0;
>  
> -struct kgdb_serial *kgdb_serial;
> -
>  /*
>   * Holds information about breakpoints in a kernel. These breakpoints are
>   * added and removed by gdb.
> @@ -105,8 +103,7 @@
>   * The following are the stub functions for code which is arch specific
>   * and can be omitted on some arches
>   * This function will handle the initalization of any architecture specific
> - * hooks.  If there is a suitable early output driver, kgdb_serial
> - * can be pointed at it now.
> + * hooks.
>   */
>  int __attribute__ ((weak))
>      kgdb_arch_init(void)
> @@ -190,6 +187,17 @@
>  	return NULL;
>  }
>  
> +/*
> + * An I/O driver must provide routines for reading and writing a single
> + * character.  However, if characters are buffered, a method to flush them
> + * must be provided.  The following is used as the default when a flush
> + * is a nop.
> + */
> +void __attribute__ ((weak))
> +	kgdb_flush_io(void)
> +{
> +}
> +
>  static int hex(char ch)
>  {
>  	if ((ch >= 'a') && (ch <= 'f'))
> @@ -213,7 +221,7 @@
>  	do {
>  		/* wait around for the start character, ignore all other
>  		 * characters */
> -		while ((ch = (kgdb_serial->read_char() & 0x7f)) != '$')
> +		while ((ch = (kgdb_read_debug_char() & 0x7f)) != '$')
>  			;	/* Spin. */
>  		kgdb_connected = 1;
>  		checksum = 0;
> @@ -223,7 +231,7 @@
>  
>  		/* now, read until a # or end of buffer is found */
>  		while (count < (BUFMAX - 1)) {
> -			ch = kgdb_serial->read_char() & 0x7f;
> +			ch = kgdb_read_debug_char() & 0x7f;
>  			if (ch == '#')
>  				break;
>  			checksum = checksum + ch;
> @@ -233,15 +241,14 @@
>  		buffer[count] = 0;
>  
>  		if (ch == '#') {
> -			xmitcsum = hex(kgdb_serial->read_char() & 0x7f) << 4;
> -			xmitcsum += hex(kgdb_serial->read_char() & 0x7f);
> +			xmitcsum = hex(kgdb_read_debug_char() & 0x7f) << 4;
> +			xmitcsum += hex(kgdb_read_debug_char() & 0x7f);
>  
>  			if (checksum != xmitcsum)
> -				kgdb_serial->write_char('-');	/* failed checksum */
> +				kgdb_write_debug_char('-');	/* failed checksum */
>  			else
> -				kgdb_serial->write_char('+');	/* successful transfer */
> -			if (kgdb_serial->flush)
> -				kgdb_serial->flush();
> +				kgdb_write_debug_char('+');	/* successful transfer */
> +			kgdb_flush_io();
>  		}
>  	} while (checksum != xmitcsum);
>  }
> @@ -258,27 +265,26 @@
>  
>  	/*  $<packet info>#<checksum>. */
>  	while (1) {
> -		kgdb_serial->write_char('$');
> +		kgdb_write_debug_char('$');
>  		checksum = 0;
>  		count = 0;
>  
>  		while ((ch = buffer[count])) {
> -			kgdb_serial->write_char(ch);
> +			kgdb_write_debug_char(ch);
>  			checksum += ch;
>  			count++;
>  		}
>  
> -		kgdb_serial->write_char('#');
> -		kgdb_serial->write_char(hexchars[checksum >> 4]);
> -		kgdb_serial->write_char(hexchars[checksum % 16]);
> -		if (kgdb_serial->flush)
> -			kgdb_serial->flush();
> +		kgdb_write_debug_char('#');
> +		kgdb_write_debug_char(hexchars[checksum >> 4]);
> +		kgdb_write_debug_char(hexchars[checksum % 16]);
> +		kgdb_flush_io();
>  
>  		/* Now see what we get in reply. */
> -		ch = kgdb_serial->read_char();
> +		ch = kgdb_read_debug_char();
>  
>  		if (ch == 3)
> -			ch = kgdb_serial->read_char();
> +			ch = kgdb_read_debug_char();
>  
>  		/* If we get an ACK, we are done. */
>  		if (ch == '+')
> @@ -289,9 +295,8 @@
>  		 * the packet being sent, and stop trying to send this
>  		 * packet. */
>  		if (ch == '$') {
> -			kgdb_serial->write_char('-');
> -			if (kgdb_serial->flush)
> -				kgdb_serial->flush();
> +			kgdb_write_debug_char('-');
> +			kgdb_flush_io();
>  			return;
>  		}
>  	}
> @@ -1126,10 +1131,10 @@
>  
>  	atomic_set(&kgdb_setting_breakpoint, 0);
>  
> -	if (!kgdb_serial || kgdb_serial->hook() < 0) {
> +	if (kgdb_hook_io())
>  		/* KGDB interface isn't ready yet */
>  		return;
> -	}
> +
>  	kgdb_initialized = 1;
>  	if (!kgdb_enter) {
>  		return;
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

