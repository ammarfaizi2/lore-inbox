Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266056AbUALFme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 00:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbUALFme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 00:42:34 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:21488 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266056AbUALFmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 00:42:13 -0500
Message-ID: <400233A5.8080505@mvista.com>
Date: Sun, 11 Jan 2004 21:41:57 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: kgdb cleanups
References: <20040109183826.GA795@elf.ucw.cz> <3FFF2304.8000403@mvista.com> <20040110044722.GY18208@waste.org> <3FFFB3D6.1050505@mvista.com> <20040110175607.GH18208@waste.org>
In-Reply-To: <20040110175607.GH18208@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Sat, Jan 10, 2004 at 12:12:06AM -0800, George Anzinger wrote:
> 
>>Matt Mackall wrote:
>>
>>>On Fri, Jan 09, 2004 at 01:54:12PM -0800, George Anzinger wrote:
>>>
>>>
>>>>Pavel Machek wrote:
>>>>
>>>>
>>>>>Hi!
>>>>>
>>>>>No real code changes, but cleanups all over the place. What about
>>>>>applying?
>>>>>
>>>>>Ouch and arch-dependend code is moved to kernel/kgdb.c. I'll probably
>>>>>do x86-64 version so that is rather important.
>>>>>
>>>>>								Pavel
>>>>
>>>>A few comments:
>>>>
>>>>I like the code seperation.  Does it follow what Amit is doing?  It would 
>>>>be nice if Amit's version and this one could come together around this.
>>>>
>>>>I don't think we want to merge the eth and regular kgdb just yet.  I 
>>>>would, however, like to keep eth completly out of the stub.  Possibly a 
>>>>new module which just takes care of steering the I/O to the correct place.
>>>
>>>
>>>I've sent Amit the start of an plug interface for abstracting the
>>>communication layer. Should be relatively painless and allow for
>>>starting sessions on the interface of your choice.
>>>
>>
>>May I see?

A few comments:

First, I would like to keep kgdb.h for the user of kgdb so that it may be 
included without concern most anywhere.  In this light I think it should only 
contain the breakpoint macro and the timestamp macro stuff, i.e. those things 
that a user might want to put in his code.

For the internal kgdb stuff I have created kdgb_local.h which I intended to be 
local to the workings of kgdb and not to contain anything a user would need.

Other comments below.
> 
> 
> Here's the interface plus the eth side of it:
> 
>  tiny-mpm/arch/i386/kernel/kgdb_stub.c |   59 +++++++++-------------------------
>  tiny-mpm/drivers/net/kgdb_eth.c       |   26 +++++++++-----
>  tiny-mpm/include/asm-i386/kgdb.h      |   14 +++++---
>  3 files changed, 44 insertions(+), 55 deletions(-)
> 
> diff -puN include/asm-i386/kgdb.h~kgdb-plug include/asm-i386/kgdb.h
> --- tiny/include/asm-i386/kgdb.h~kgdb-plug	2003-12-27 12:18:47.000000000 -0600
> +++ tiny-mpm/include/asm-i386/kgdb.h	2003-12-27 13:19:16.000000000 -0600
> @@ -19,13 +19,19 @@ extern void breakpoint(void);
>  #define BREAKPOINT   asm("   int $3")
>  #endif
>  
> +struct kgdb_hook {
> +	char *sendbuf;
> +	int maxsend;

I don't see the need of maxsend, or sendbuff, for that matter, as kgdb uses it 
now (for the eth code) it is redundant, in that the eth putchar also does the 
same thing as is being done in the kgdb_stub.c code.  I think this should be 
removed from the stub and the limit in the ethcode relied upon.

> +	int (*getchar)(void);
> +	void (*putchar)(int chr);
> +	void (*flush)(void);
> +	void (*trap)(int enable);
> +};
> +
> +extern void kgdb_attach(struct kgdb_hook *hook);
>  extern void kgdb_schedule_breakpoint(void);
>  extern void kgdb_process_breakpoint(void);
>  
> -extern int kgdb_tty_hook(void);
> -extern int kgdb_eth_hook(void);
> -extern int kgdboe;
> -
>  /*
>   * GDB debug stub (or any debug stub) can point the 'linux_debug_hook'
>   * pointer to its routine and it will be entered as the first thing
> diff -puN arch/i386/kernel/kgdb_stub.c~kgdb-plug arch/i386/kernel/kgdb_stub.c
> --- tiny/arch/i386/kernel/kgdb_stub.c~kgdb-plug	2003-12-27 12:18:47.000000000 -0600
> +++ tiny-mpm/arch/i386/kernel/kgdb_stub.c	2003-12-27 13:19:19.000000000 -0600
> @@ -130,12 +130,7 @@ typedef void (*Function) (void);	/* poin
>  /* Thread reference */
>  typedef unsigned char threadref[8];
>  
> -extern int tty_putDebugChar(int);     /* write a single character      */
> -extern int tty_getDebugChar(void);    /* read and return a single char */
> -extern void tty_flushDebugChar(void); /* flush pending characters      */
> -extern int eth_putDebugChar(int);     /* write a single character      */
> -extern int eth_getDebugChar(void);    /* read and return a single char */
> -extern void eth_flushDebugChar(void); /* flush pending characters      */
> +struct kgdb_hook *kh = 0;
>  
>  /************************************************************************/
>  /* BUFMAX defines the maximum number of characters in inbound/outbound buffers*/
> @@ -275,39 +270,25 @@ malloc(int size)
>  	}
>  }
>  
> -/*
> - * I/O dispatch functions...
> - * Based upon kgdboe, either call the ethernet
> - * handler or the serial one..
> - */
>  void
>  putDebugChar(int c)
>  {
> -	if (!kgdboe) {
> -		tty_putDebugChar(c);
> -	} else {
> -		eth_putDebugChar(c);
> -	}
> +	if (kh)
> +		kh->putchar(c);
>  }

I was thinking that this might read something like:
          if (xxx[kh].putchar(c))
                 xxx[kh].putchar(c);

One might further want to do something like:
          if (!xxx[kh].putchar(c))
                 kh = 0;

In otherwords, an array (xxx must, of course, be renamed) of stuct kgdb_hook 
(which name should also be changed to relate to I/O, kgdb_IO_hook, for example). 
  Then reserve entry 0 for the rs232 I/O code.  An alternate possibility is an 
array of pointer to struct kgdb_hook which allows one to define the struct 
contents as below and to build the array, all at compile/link time.  A legal 
entry MUST define get and put, but why not define them all, using dummy 
functions for the ones that make no sense in a particular interface.

I also think the functions that kgdb_stub calls should be putDebugChar and 
friends, not the underlying functions.  I.e. move these out of kgdb_stub.c to a 
new common module.  This would make it easy for other archs to use, as they 
would be using something that looks very much like what they do today.  So, in 
short, kdgd_stub.c needs to know nothing of kh or the structure it references.

I would also like to see the index (kh in my code) in the kgdb_info structure so 
that the user can examine it.  I am not sure if I want to allow him to change 
it, but I have considered it.
>  
>  int
>  getDebugChar(void)
>  {
> -	if (!kgdboe) {
> -		return tty_getDebugChar();
> -	} else {
> -		return eth_getDebugChar();
> -	}
> +	if (kh)
> +		return kh->getchar();
>  }
>  
>  void
>  flushDebugChar(void)
>  {
> -	if (!kgdboe) {
> -		tty_flushDebugChar();
> -	} else {
> -		eth_flushDebugChar();
> -	}
> +	if (kh)
> +		kh->flush();
>  }
>  
>  /*
> @@ -490,7 +471,7 @@ putpacket(char *buffer)
>  
>  	/*  $<packet info>#<checksum>. */
>  
> -	if (!kgdboe) {
> +	if (kh && !kh->sendbuf) {
>  		do {
>  			if (remote_debug)
>  				printk("T:%s\n", buffer);
> @@ -516,10 +497,7 @@ putpacket(char *buffer)
>  		 * We only transfer MAX_SEND_COUNT size bytes each time
>  		 */
>  
> -#define MAX_SEND_COUNT 30
> -
>  		int send_count = 0, i = 0;
> -		char send_buf[MAX_SEND_COUNT];
>  
>  		do {
>  			if (remote_debug)
> @@ -529,21 +507,21 @@ putpacket(char *buffer)
>  			count = 0;
>  			send_count = 0;
>  			while ((ch = buffer[count])) {
> -				if (send_count >= MAX_SEND_COUNT) {
> -					for(i = 0; i < MAX_SEND_COUNT; i++) {
> -						putDebugChar(send_buf[i]);
> +				if (send_count >= kh->maxsend) {
> +					for(i = 0; i < kh->maxsend; i++) {
> +						putDebugChar(kh->sendbuf[i]);
>  					}
As I observed above, the eth code already does all this.  This code is redundant 
and should be removed.
>  					flushDebugChar();
>  					send_count = 0;
>  				} else {
> -					send_buf[send_count] = ch;
> +					kh->sendbuf[send_count] = ch;
>  					checksum += ch;
>  					count ++;
>  					send_count++;
>  				}
>  			}
>  			for(i = 0; i < send_count; i++)
> -				putDebugChar(send_buf[i]);
> +				putDebugChar(kh->sendbuf[i]);
>  			putDebugChar('#');
>  			putDebugChar(hexchars[checksum >> 4]);
>  			putDebugChar(hexchars[checksum % 16]);
> @@ -1272,12 +1250,9 @@ kgdb_handle_exception(int exceptionVecto
>  		print_regs(&regs);
>  		return (0);
>  	}
> -	/*
> -	 * If we're using eth mode, set the 'mode' in the netdevice.
> -	 */
>  
> -	if (kgdboe)
> -		netpoll_set_trap(1);
> +	if (kh)
> +		kh->trap(1);
>  
>  	kgdb_local_irq_save(flags);
>  
> @@ -1727,8 +1702,8 @@ kgdb_handle_exception(int exceptionVecto
>  				}
>  			}
>  
> -			if (kgdboe)
> -				netpoll_set_trap(0);
> +			if(kh)
> +				kh->trap(0);
>  
>  			correct_hw_break();
>  			asm volatile ("movl %0, %%db6\n"::"r" (0));
> diff -puN arch/i386/lib/kgdb_serial.c~kgdb-plug arch/i386/lib/kgdb_serial.c
> diff -puN drivers/net/kgdb_eth.c~kgdb-plug drivers/net/kgdb_eth.c
> --- tiny/drivers/net/kgdb_eth.c~kgdb-plug	2003-12-27 12:18:47.000000000 -0600
> +++ tiny-mpm/drivers/net/kgdb_eth.c	2003-12-27 13:19:18.000000000 -0600
> @@ -34,8 +34,6 @@ static int in_head, in_tail, out_count;
>  static atomic_t in_count;
>  int kgdboe = 0; /* Default to tty mode */
>  
> -extern void set_debug_traps(void);
> -extern void breakpoint(void);
>  static void rx_hook(struct netpoll *np, int port, char *msg, int len);
>  
>  static struct netpoll np = {
> @@ -47,7 +45,7 @@ static struct netpoll np = {
>  	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
>  };
>  
> -int eth_getDebugChar(void)
> +static int getchar(void)
>  {
>  	int chr;
>  
> @@ -60,7 +58,7 @@ int eth_getDebugChar(void)
>  	return chr;
>  }
>  
> -void eth_flushDebugChar(void)
> +static void flush(void)
>  {
>  	if(out_count && np.dev) {
>  		netpoll_send_udp(&np, out_buf, out_count);
> @@ -68,13 +66,24 @@ void eth_flushDebugChar(void)
>  	}
>  }
>  
> -void eth_putDebugChar(int chr)
> +static void putchar(int chr)
>  {
>  	out_buf[out_count++] = chr;
>  	if(out_count == OUT_BUF_SIZE)
>  		eth_flushDebugChar();
>  }
>  
> +#define MAX_SEND 30
> +char sendbuf[MAX_SEND];
> +static struct kgdb_hook kh = {
> +	.sendbuf = sendbuf,
> +	.maxsend = MAX_SEND
> +	.getchar = getchar,
> +	.putchar = putchar,
> +	.flush = flush,
> +	.trap = netpoll_set_trap
> +};
> +
>  static void rx_hook(struct netpoll *np, int port, char *msg, int len)
>  {
>  	int i;
> @@ -82,8 +91,10 @@ static void rx_hook(struct netpoll *np, 
>  	np->remote_port = port;
>  
>  	/* Is this gdb trying to attach? */
> -	if (!netpoll_trap() && len == 8 && !strncmp(msg, "$Hc-1#09", 8))
> +	if (!netpoll_trap() && len == 8 && !strncmp(msg, "$Hc-1#09", 8)) {
> +		kgdb_attach(kh);
>  		kgdb_schedule_breakpoint();
> +	}
>  
>  	for (i = 0; i < len; i++) {
>  		if (msg[i] == 3)
> @@ -117,12 +128,9 @@ static int init_kgdboe(void)
>  	}
>  #endif
>  
> -	set_debug_traps();
> -
>  	if(!np.remote_ip || netpoll_setup(&np))
>  		return 1;
>  
> -	kgdboe = 1;
>  	printk(KERN_INFO "kgdb: debugging over ethernet enabled\n");
>  
>  	return 0;
> 
> _
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

