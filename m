Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWEZRzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWEZRzL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWEZRzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:55:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40837 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750741AbWEZRzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:55:09 -0400
Date: Fri, 26 May 2006 13:59:02 -0400
From: Don Zickus <dzickus@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: [PATCH] x86 clean up nmi panic messages
Message-ID: <20060526175902.GB2839@redhat.com>
References: <20060511214933.GU16561@redhat.com> <20060518191700.GC5846@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518191700.GC5846@ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up some of the output messages on the nmi error paths to make more
sense when they are displayed.  This is mainly a cosmetic fix and
shouldn't impact any normal code path.  

Signed-off-by:  Don Zickus <dzickus@redhat.com>

---

Pavel, 

I hope this patch addresses your concerns.  This will apply on top of my
other patch.  

Cheers,
Don

> > Index: linux-don/arch/i386/kernel/traps.c
> > ===================================================================
> > --- linux-don.orig/arch/i386/kernel/traps.c
> > +++ linux-don/arch/i386/kernel/traps.c
> > @@ -602,6 +602,8 @@ static void mem_parity_error(unsigned ch
> >  			"to continue\n");
> >  	printk(KERN_EMERG "You probably have a hardware problem with your RAM "
> >  			"chips\n");
> > +	if (panic_on_unrecovered_nmi)
> > +                panic("NMI: Not continuing");
> >  
> >  	/* Clear and disable the memory parity error line. */
> >  	clear_mem_error(reason);
> > @@ -637,6 +639,10 @@ static void unknown_nmi_error(unsigned c
> >  		reason, smp_processor_id());
> >  	printk("Dazed and confused, but trying to continue\n");
> 
> 'Trying to contninue'
> 
> >  	printk("Do you have a strange power saving mode enabled?\n");
> > +
> > +	if (panic_on_unrecovered_nmi)
> > +                panic("NMI: Not continuing");
> > +
> 
> 'not really'. Move printks around so it makes sense...


Index: linux-don/arch/i386/kernel/traps.c
===================================================================
--- linux-don.orig/arch/i386/kernel/traps.c
+++ linux-don/arch/i386/kernel/traps.c
@@ -598,13 +598,15 @@ gp_in_kernel:
 
 static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
-	printk(KERN_EMERG "Uhhuh. NMI received. Dazed and confused, but trying "
-			"to continue\n");
+	printk(KERN_EMERG "Uhhuh. NMI received for unknown reason %02x on "
+		"CPU %d.\n", reason, smp_processor_id());
 	printk(KERN_EMERG "You probably have a hardware problem with your RAM "
 			"chips\n");
 	if (panic_on_unrecovered_nmi)
                 panic("NMI: Not continuing");
 
+	printk(KERN_EMERG "Dazed and confused, but trying to continue\n");
+
 	/* Clear and disable the memory parity error line. */
 	clear_mem_error(reason);
 }
@@ -635,14 +637,13 @@ static void unknown_nmi_error(unsigned c
 		return;
 	}
 #endif
-	printk("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
-		reason, smp_processor_id());
-	printk("Dazed and confused, but trying to continue\n");
-	printk("Do you have a strange power saving mode enabled?\n");
-
+	printk(KERN_EMERG "Uhhuh. NMI received for unknown reason %02x on "
+		"CPU %d.\n", reason, smp_processor_id());
+	printk(KERN_EMERG "Do you have a strange power saving mode enabled?\n");
 	if (panic_on_unrecovered_nmi)
                 panic("NMI: Not continuing");
 
+	printk(KERN_EMERG "Dazed and confused, but trying to continue\n");
 }
 
 static DEFINE_SPINLOCK(nmi_print_lock);
Index: linux-don/arch/x86_64/kernel/traps.c
===================================================================
--- linux-don.orig/arch/x86_64/kernel/traps.c
+++ linux-don/arch/x86_64/kernel/traps.c
@@ -606,10 +606,15 @@ asmlinkage void __kprobes do_general_pro
 static __kprobes void
 mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
-	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
-	printk("You probably have a hardware problem with your RAM chips\n");
+	printk(KERN_EMERG "Uhhuh. NMI received for unknown reason %02x.\n",
+		reason);
+	printk(KERN_EMERG "You probably have a hardware problem with your "
+		"RAM chips\n");
+
 	if (panic_on_unrecovered_nmi)
-               panic("NMI: Not continuing");
+		panic("NMI: Not continuing");
+
+	printk(KERN_EMERG "Dazed and confused, but trying to continue\n");
 
 	/* Clear and disable the memory parity error line. */
 	reason = (reason & 0xf) | 4;
@@ -632,13 +637,15 @@ io_check_error(unsigned char reason, str
 
 static __kprobes void
 unknown_nmi_error(unsigned char reason, struct pt_regs * regs)
-{	printk("Uhhuh. NMI received for unknown reason %02x.\n", reason);
-	printk("Dazed and confused, but trying to continue\n");
-	printk("Do you have a strange power saving mode enabled?\n");
+{
+	printk(KERN_EMERG "Uhhuh. NMI received for unknown reason %02x.\n",
+		reason);
+	printk(KERN_EMERG "Do you have a strange power saving mode enabled?\n");
 
 	if (panic_on_unrecovered_nmi)
-                panic("NMI: Not continuing");
+		panic("NMI: Not continuing");
 
+	printk(KERN_EMERG "Dazed and confused, but trying to continue\n");
 }
 
 /* Runs on IST stack. This code must keep interrupts off all the time.
