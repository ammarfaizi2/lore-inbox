Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSHBXDl>; Fri, 2 Aug 2002 19:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317363AbSHBXDl>; Fri, 2 Aug 2002 19:03:41 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:32644 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S317354AbSHBXDi>; Fri, 2 Aug 2002 19:03:38 -0400
Message-ID: <3D4B1057.2040703@linuxhq.com>
Date: Fri, 02 Aug 2002 19:05:59 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jonathan Buzzard <jonathan@buzzard.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Toshiba Laptop Support and IRQ Locks
References: <3D4AAD53.7010008@linux.org> <1028310939.18309.93.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Fri, 2002-08-02 at 17:03, John Weber wrote:
> 
>>Hi,
>>
>>Toshiba laptop support is broken.  Here's my rookie attempt at fixing it.
> 
> 
> Looks basically sound. You probably want to use spinlock_irqsave - the
> spin locks are less overhead than the reader/writer locks and you don't
> really seem to be using it for anything else. I'm assuming we want the
> irqsave to block interrupts because the I/O cycles might have to happen
> one after another - if not they could be relaxed - perhaps Jonathan
> knows ?

Alrighty then, the patch below uses spinlocks instead of cli() and 
friends -- to conform to the new irq locking mechanism -- and some minor 
module changes while we're at it.

--- linux-2.5.30/drivers/char/toshiba.c	2002-08-01 17:16:39.000000000 -0400
+++ linux-bleed/drivers/char/toshiba.c	2002-08-02 18:43:53.000000000 -0400
@@ -82,7 +82,13 @@

  static int tosh_fn = 0;

+extern spinlock_t tosh_lock;
+
  MODULE_PARM(tosh_fn, "i");
+MODULE_PARM_DESC(tosh_fn, "User specified Fn key detection port");
+MODULE_AUTHOR("Jonathan Buzzard <jonathan@buzzard.org.uk>");
+MODULE_DESCRIPTION("Toshiba laptop SMM driver");
+MODULE_SUPPORTED_DEVICE("toshiba");

  MODULE_LICENSE("GPL");

@@ -114,11 +120,10 @@
  	if (tosh_fn!=0) {
  		scan = inb(tosh_fn);
  	} else {
- 
	save_flags(flags);
- 
	cli();
+ 
         spin_lock_irqsave(&tosh_lock,flags);
  		outb(0x8e, 0xe4);
  		scan = inb(0xe5);
- 
	restore_flags(flags);
+ 
	spin_unlock_irqrestore(&tosh_lock,flags);
  	}

          return (int) scan;
@@ -141,35 +146,32 @@
  	if (tosh_id==0xfccb) {
  		if (eax==0xfe00) {
  	 
	/* fan status */
- 
		save_flags(flags);
- 
		cli();
+ 
	        spin_lock_irqsave(&tosh_lock,flags);
  	 
	outb(0xbe, 0xe4);
  	 
	al = inb(0xe5);
- 
		restore_flags(flags);
+ 
		spin_unlock_irqrestore(&tosh_lock,flags);
  	 
	regs->eax = 0x00;
  	 
	regs->ecx = (unsigned int) (al & 0x01);
  		}
  		if ((eax==0xff00) && (ecx==0x0000)) {
  	 
	/* fan off */
- 
		save_flags(flags);
- 
		cli();
+ 
	        spin_lock_irqsave(&tosh_lock,flags);
  	 
	outb(0xbe, 0xe4);
  	 
	al = inb(0xe5);
  	 
	outb(0xbe, 0xe4);
  	 
	outb (al | 0x01, 0xe5);
- 
		restore_flags(flags);
+ 
		spin_unlock_irqrestore(&tosh_lock,flags);
  	 
	regs->eax = 0x00;
  	 
	regs->ecx = 0x00;
  		}
  		if ((eax==0xff00) && (ecx==0x0001)) {
  	 
	/* fan on */
- 
		save_flags(flags);
- 
		cli();
+ 
	        spin_lock_irqsave(&tosh_lock,flags);
  	 
	outb(0xbe, 0xe4);
  	 
	al = inb(0xe5);
  	 
	outb(0xbe, 0xe4);
  	 
	outb(al & 0xfe, 0xe5);
- 
		restore_flags(flags);
+ 
		spin_unlock_irqrestore(&tosh_lock,flags);
  	 
	regs->eax = 0x00;
  	 
	regs->ecx = 0x01;
  		}
@@ -180,33 +182,30 @@
  	if (tosh_id==0xfccc) {
  		if (eax==0xfe00) {
  	 
	/* fan status */
- 
		save_flags(flags);
- 
		cli();
+ 
	        spin_lock_irqsave(&tosh_lock,flags);
  	 
	outb(0xe0, 0xe4);
  	 
	al = inb(0xe5);
- 
		restore_flags(flags);
+ 
		spin_unlock_irqrestore(&tosh_lock,flags);
  	 
	regs->eax = 0x00;
  	 
	regs->ecx = al & 0x01;
  		}
  		if ((eax==0xff00) && (ecx==0x0000)) {
  	 
	/* fan off */
- 
		save_flags(flags);
- 
		cli();
+ 
	        spin_lock_irqsave(&tosh_lock,flags);
  	 
	outb(0xe0, 0xe4);
  	 
	al = inb(0xe5);
  	 
	outw(0xe0 | ((al & 0xfe) << 8), 0xe4);
- 
		restore_flags(flags);
+ 
		spin_unlock_irqrestore(&tosh_lock,flags);
  	 
	regs->eax = 0x00;
  	 
	regs->ecx = 0x00;
  		}
  		if ((eax==0xff00) && (ecx==0x0001)) {
  	 
	/* fan on */
- 
		save_flags(flags);
- 
		cli();
+ 
	        spin_lock_irqsave(&tosh_lock,flags);
  	 
	outb(0xe0, 0xe4);
  	 
	al = inb(0xe5);
  	 
	outw(0xe0 | ((al | 0x01) << 8), 0xe4);
- 
		restore_flags(flags);
+ 
		spin_unlock_irqrestore(&tosh_lock,flags);
  	 
	regs->eax = 0x00;
  	 
	regs->ecx = 0x01;
  		}

