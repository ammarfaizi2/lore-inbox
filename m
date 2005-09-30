Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbVI3Saw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVI3Saw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVI3Saw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:30:52 -0400
Received: from [85.21.88.2] ([85.21.88.2]:16813 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S965017AbVI3Sav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:30:51 -0400
Message-ID: <433D8455.4030601@ru.mvista.com>
Date: Fri, 30 Sep 2005 22:30:45 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: dpervushin@gmail.com, dpervushin@ru.mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SPI
References: <20050930175923.F3C89E9E25@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20050930175923.F3C89E9E25@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

<snip>

>> drivers/spi/Kconfig    |   33 +++
>> drivers/spi/Makefile   |   14 +
>> include/linux/spi.h    |  232 ++++++++++++++++++++++
>>    
>>
>
>Looks familiar.  :)  But another notion for the headers would be
>
>	<linux/spi/spi.h>	... main header
>	<linux/spi/CHIP.h>	... platform_data, for CHIP.c driver
>
>Not all chips would need them, but it might be nice to have some place
>other than <linux/CHIP.h> for such things.  The platform_data would have
>various important data that can't be ... chip variants, initialization
>data, and similar stuff that differs between boards is knowable only by
>board-specific init code, yet is needed by board-agnostic driver code.
>  
>
What about SPI busses that are common for different boards?

<snip>

>>+static int spi_thread(void *context);
>>    
>>
>
>You're imposing the same implementation strategy Mark Underwood was.
>I believe I persuaded him not to want that, pointing out three other
>implementation strategies that can be just as reasonable:
>
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=112684135722116&w=2
>
>It'd be fine if for example your PNX controller driver worked that way
>internally.  But other drivers shouldn't be forced to allocate kernel
>threads when they don't need them.
>  
>
Hm, so does that imply that the whole -rt patches from 
Ingo/Sven/Daniel/etc. are implementing wrong strategy (interrupts in 
threads)?
How will your strategy work with that BTW?

<snip>

>>+				/*
>>+				 * all messages for current selected_device
>>+				 * are processed.
>>+				 * let's switch to another device
>>+				 */
>>    
>>
>
>Why are you hard-wiring such an unfair scheduling policy ... and
>preventing use of better ones?  I'd use FIFO rather than something
>as unfair as that; and FIFO is much simpler to code, too.
>  
>
Sounds reasonable to me.

>>--- /dev/null
>>+++ linux-2.6.10/drivers/spi/spi-dev.c
>>@@ -0,0 +1,219 @@
>>+/*
>>+    spi-dev.c - spi driver, char device interface
>>+
>>    
>>
>
>Do you have userspace drivers that work with this?  I can see how to use
>it with read-only sensors (each read generates a 12bit sample, etc) and
>certain write-only devices, I guess.
>
>But it doesn't look like this character device can handle RPC-ish things
>like "give me an ADC conversion for line 3" (which commonly maps to a
>"write 8 bits, then start reading 12 data bits one half clock after
>the last bit is written" ... hard to make that work with separate
>read and write transactions, given the half clock rule).
>  
>
Hm. I thought half-clock cases were to be programmed kernel-wise.

<snip>

>  
>
>>+  +--------------+                    +---------+
>>+  | platform_bus |                    | spi_bus |
>>+  +--------------+                    +---------+
>>+       |..|                                |
>>+       |..|--------+               +---------------+
>>+     +------------+| is parent to  |  SPI devices  |
>>+     | SPI busses |+-------------> |               |
>>+     +------------+                +---------------+
>>+           |                               |
>>+     +----------------+          +----------------------+
>>+     | SPI bus driver |          |    SPI device driver |
>>+     +----------------+          +----------------------+
>>    
>>
>
>That seems wierd even if I assume "platform_bus" is just an example.
>For example there are two rather different "spi bus" notions there,
>and it looks like neither one is the physical parent of any SPI device ...
>
>  
>
Not sure if I understand you :(

>  
>
>>+3.2 How do the SPI devices gets discovered and probed ?
>>    
>>
>
>Better IMO to have tables that get consulted when the SPI master controller
>drivers register the parent ... tables that are initialized by the board
>specific __init section code, early on.  (Or maybe by __setup commandline
>parameters.)
>
>Doing it the way you are prevents you from declaring all the SPI devices in
>a single out-of-the-way location like the arch/.../board-specific.c file,
>which is normally responsible for declaring devices that are hard-wired on
>a given board and can't be probed.
>  
>
By what means does it prevent that?

>>+static inline struct spi_msg *spimsg_alloc(struct spi_device *device,
>>+					   unsigned flags,
>>+					   unsigned short len,
>>+					   void (*status) (struct spi_msg *,
>>+							   int code))
>>+{
>>+	... 30+ lines including...
>>+
>>+	msg = kmalloc(sizeof(struct spi_msg), GFP_KERNEL);
>>+	memset(msg, 0, sizeof(struct spi_msg));
>>    
>>
>
>If these things aren't going to be refcounted, then it'd be easier
>to just let them be stack-allocated; they ARE that small.  And if
>they've _got_ to be on the heap, then there's a new "kzalloc()" call
>you should be looking at ...
>
>
>  
>
>>+		msg->devbuf_rd = drv->alloc ?
>>+		    drv->alloc(len, GFP_KERNEL) : kmalloc(len, GFP_KERNEL);
>>+		msg->databuf_rd = drv->get_buffer ?
>>+		    drv->get_buffer(device, msg->devbuf_rd) : msg->devbuf_rd;
>>    
>>
>
>Oy.  More dynamic allocation.  (Repeated for write buffers too ...)
>See above; don't force such costs on all drivers, few will ever need it.
>  
>
I guess that won't necessarily be actual allocation, it's a matter of 
drv callbacks.

<snip>

>>+#define SPI_MAJOR	153
>>+
>>+...
>>+
>>+#define SPI_DEV_CHAR "spi-char"
>>    
>>
I thought 153 was the official SPI device number.


Best regards,
   Vitaly
