Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSHBQBq>; Fri, 2 Aug 2002 12:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSHBQBX>; Fri, 2 Aug 2002 12:01:23 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:9138 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S316586AbSHBQA6>; Fri, 2 Aug 2002 12:00:58 -0400
Message-ID: <3D4AAD53.7010008@linux.org>
Date: Fri, 02 Aug 2002 12:03:31 -0400
From: John Weber <john.weber@linux.org>
Organization: Linux Online
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Toshiba Laptop Support and IRQ Locks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Toshiba laptop support is broken.  Here's my rookie attempt at fixing it.

--- linux-2.5.30/drivers/char/toshiba.c	2002-08-01 17:16:39.000000000 -0400
+++ linux-bleed/drivers/char/toshiba.c	2002-08-02 11:37:14.000000000 -0400
@@ -82,6 +82,8 @@

  static int tosh_fn = 0;

+extern rwlock_t tosh_lock;
+
  MODULE_PARM(tosh_fn, "i");

  MODULE_LICENSE("GPL");
@@ -114,11 +116,10 @@
  	if (tosh_fn!=0) {
  		scan = inb(tosh_fn);
  	} else {
- 
	save_flags(flags);
- 
	cli();
+ 
         write_lock_irq(&tosh_lock);
  		outb(0x8e, 0xe4);
  		scan = inb(0xe5);
- 
	restore_flags(flags);
+ 
	write_unlock_irq(&tosh_lock);
  	}

          return (int) scan;
@@ -141,35 +142,32 @@
  	if (tosh_id==0xfccb) {
  		if (eax==0xfe00) {
  	 
	/* fan status */
- 
		save_flags(flags);
- 
		cli();
+ 
	        write_lock_irq(&tosh_lock);
  	 
	outb(0xbe, 0xe4);
  	 
	al = inb(0xe5);
- 
		restore_flags(flags);
+ 
		write_unlock_irq(&tosh_lock);
  	 
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
	        write_lock_irq(&tosh_lock);
  	 
	outb(0xbe, 0xe4);
  	 
	al = inb(0xe5);
  	 
	outb(0xbe, 0xe4);
  	 
	outb (al | 0x01, 0xe5);
- 
		restore_flags(flags);
+ 
		write_unlock_irq(&tosh_lock);
  	 
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
	        write_lock_irq(&tosh_lock);
  	 
	outb(0xbe, 0xe4);
  	 
	al = inb(0xe5);
  	 
	outb(0xbe, 0xe4);
  	 
	outb(al & 0xfe, 0xe5);
- 
		restore_flags(flags);
+ 
		write_unlock_irq(&tosh_lock);
  	 
	regs->eax = 0x00;
  	 
	regs->ecx = 0x01;
  		}
@@ -180,33 +178,30 @@
  	if (tosh_id==0xfccc) {
  		if (eax==0xfe00) {
  	 
	/* fan status */
- 
		save_flags(flags);
- 
		cli();
+ 
	        write_lock_irq(&tosh_lock);
  	 
	outb(0xe0, 0xe4);
  	 
	al = inb(0xe5);
- 
		restore_flags(flags);
+ 
		write_unlock_irq(&tosh_lock);
  	 
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
	        write_lock_irq(&tosh_lock);
  	 
	outb(0xe0, 0xe4);
  	 
	al = inb(0xe5);
  	 
	outw(0xe0 | ((al & 0xfe) << 8), 0xe4);
- 
		restore_flags(flags);
+ 
		write_unlock_irq(&tosh_lock);
  	 
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
	        write_lock_irq(&tosh_lock);
  	 
	outb(0xe0, 0xe4);
  	 
	al = inb(0xe5);
  	 
	outw(0xe0 | ((al | 0x01) << 8), 0xe4);
- 
		restore_flags(flags);
+ 
		write_unlock_irq(&tosh_lock);
  	 
	regs->eax = 0x00;
  	 
	regs->ecx = 0x01;
  		}

