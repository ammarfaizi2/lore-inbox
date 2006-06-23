Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751939AbWFWSr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbWFWSr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbWFWSmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:21 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:20687 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751928AbWFWSmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:42:06 -0400
Message-Id: <20060623183916.046515000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:15 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 19/21] convert q40 irq code
Content-Disposition: inline; filename=0025-M68K-convert-q40-irq-code.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/kernel/entry.S |   11 -
 arch/m68k/q40/config.c   |   11 -
 arch/m68k/q40/q40ints.c  |  464 +++++++++++++++++-----------------------------
 3 files changed, 169 insertions(+), 317 deletions(-)

bce99c5ef50415ebd104bf5a562dd9cb4ac141a4
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 48cccc5..449b62b 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -205,18 +205,9 @@ ENTRY(auto_inthandler)
 
 	movel	%sp,%sp@-
 	movel	%d0,%sp@-		|  put vector # on stack
-#if defined(MACH_Q40_ONLY) && defined(CONFIG_BLK_DEV_FD)
-	btstb	#4,0xff000000		| Q40 floppy needs very special treatment ...
-	jbeq	1f
-	btstb	#3,0xff000004
-	jbeq	1f
-	jbsr	floppy_hardint
-	jbra	3f
-1:
-#endif
 auto_irqhandler_fixup = . + 2
 	jsr	m68k_handle_int		|  process the IRQ
-3:	addql	#8,%sp			|  pop parameters off stack
+	addql	#8,%sp			|  pop parameters off stack
 
 ret_from_interrupt:
 	subqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+1)
diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index 01fd662..efa52d3 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -38,13 +38,8 @@ #include <asm/q40_master.h>
 
 extern irqreturn_t q40_process_int (int level, struct pt_regs *regs);
 extern void q40_init_IRQ (void);
-extern void q40_free_irq (unsigned int, void *);
-extern int  show_q40_interrupts (struct seq_file *, void *);
-extern void q40_enable_irq (unsigned int);
-extern void q40_disable_irq (unsigned int);
 static void q40_get_model(char *model);
 static int  q40_get_hardware_list(char *buffer);
-extern int  q40_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
 extern void q40_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
 
 extern unsigned long q40_gettimeoffset (void);
@@ -174,12 +169,6 @@ void __init config_q40(void)
     mach_set_clock_mmss	 = q40_set_clock_mmss;
 
     mach_reset		 = q40_reset;
-    mach_free_irq	 = q40_free_irq;
-    mach_process_int	 = q40_process_int;
-    mach_get_irq_list	 = show_q40_interrupts;
-    mach_request_irq	 = q40_request_irq;
-    enable_irq		 = q40_enable_irq;
-    disable_irq          = q40_disable_irq;
     mach_get_model       = q40_get_model;
     mach_get_hardware_list = q40_get_hardware_list;
 
diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index ff80cba..472f41c 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -14,13 +14,8 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/sched.h>
-#include <linux/seq_file.h>
 #include <linux/interrupt.h>
-#include <linux/hardirq.h>
 
-#include <asm/rtc.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <asm/irq.h>
@@ -39,28 +34,37 @@ #include <asm/q40ints.h>
  *
 */
 
-extern int ints_inited;
+static void q40_irq_handler(unsigned int, struct pt_regs *fp);
+static void q40_enable_irq(unsigned int);
+static void q40_disable_irq(unsigned int);
 
+unsigned short q40_ablecount[35];
+unsigned short q40_state[35];
 
-irqreturn_t q40_irq2_handler (int, void *, struct pt_regs *fp);
-
-
-static irqreturn_t q40_defhand (int irq, void *dev_id, struct pt_regs *fp);
-
-
-#define DEVNAME_SIZE 24
+static int q40_irq_startup(unsigned int irq)
+{
+	/* test for ISA ints not implemented by HW */
+	switch (irq) {
+	case 1: case 2: case 8: case 9:
+	case 11: case 12: case 13:
+		printk("%s: ISA IRQ %d not implemented by HW\n", __FUNCTION__, irq);
+		return -ENXIO;
+	}
+	return 0;
+}
 
-static struct q40_irq_node {
-	irqreturn_t	(*handler)(int, void *, struct pt_regs *);
-	unsigned long	flags;
-	void		*dev_id;
-  /*        struct q40_irq_node *next;*/
-        char	        devname[DEVNAME_SIZE];
-	unsigned	count;
-        unsigned short  state;
-} irq_tab[Q40_IRQ_MAX+1];
+static void q40_irq_shutdown(unsigned int irq)
+{
+}
 
-short unsigned q40_ablecount[Q40_IRQ_MAX+1];
+static struct irq_controller q40_irq_controller = {
+	.name		= "q40",
+	.lock		= SPIN_LOCK_UNLOCKED,
+	.startup	= q40_irq_startup,
+	.shutdown	= q40_irq_shutdown,
+	.enable		= q40_enable_irq,
+	.disable	= q40_disable_irq,
+};
 
 /*
  * void q40_init_IRQ (void)
@@ -73,139 +77,29 @@ short unsigned q40_ablecount[Q40_IRQ_MAX
  * the q40 IRQ handling routines.
  */
 
-static int disabled=0;
+static int disabled;
 
-void q40_init_IRQ (void)
+void q40_init_IRQ(void)
 {
-	int i;
-
-	disabled=0;
-	for (i = 0; i <= Q40_IRQ_MAX; i++) {
-		irq_tab[i].handler = q40_defhand;
-		irq_tab[i].flags = 0;
-		irq_tab[i].dev_id = NULL;
-		/*		irq_tab[i].next = NULL;*/
-		irq_tab[i].devname[0] = 0;
-		irq_tab[i].count = 0;
-		irq_tab[i].state =0;
-		q40_ablecount[i]=0;   /* all enabled */
-	}
+	m68k_setup_irq_controller(&q40_irq_controller, 1, Q40_IRQ_MAX);
 
 	/* setup handler for ISA ints */
-	cpu_request_irq(IRQ_AUTO_2, q40_irq2_handler, 0,
-			"q40 ISA and master chip", NULL);
+	m68k_setup_auto_interrupt(q40_irq_handler);
+
+	m68k_irq_startup(IRQ_AUTO_2);
+	m68k_irq_startup(IRQ_AUTO_4);
 
 	/* now enable some ints.. */
-	master_outb(1,EXT_ENABLE_REG);  /* ISA IRQ 5-15 */
+	master_outb(1, EXT_ENABLE_REG);  /* ISA IRQ 5-15 */
 
 	/* make sure keyboard IRQ is disabled */
-	master_outb(0,KEY_IRQ_ENABLE_REG);
+	master_outb(0, KEY_IRQ_ENABLE_REG);
 }
 
-int q40_request_irq(unsigned int irq,
-		irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                unsigned long flags, const char *devname, void *dev_id)
-{
-  /*printk("q40_request_irq %d, %s\n",irq,devname);*/
-
-	if (irq > Q40_IRQ_MAX || (irq>15 && irq<32)) {
-		printk("%s: Incorrect IRQ %d from %s\n", __FUNCTION__, irq, devname);
-		return -ENXIO;
-	}
-
-	/* test for ISA ints not implemented by HW */
-	switch (irq)
-	  {
-	  case 1: case 2: case 8: case 9:
-	  case 12: case 13:
-	    printk("%s: ISA IRQ %d from %s not implemented by HW\n", __FUNCTION__, irq, devname);
-	    return -ENXIO;
-	  case 11:
-	    printk("warning IRQ 10 and 11 not distinguishable\n");
-	    irq=10;
-	  default:
-	    ;
-	  }
-
-	if (irq<Q40_IRQ_SAMPLE)
-	  {
-	    if (irq_tab[irq].dev_id != NULL)
-		  {
-		    printk("%s: IRQ %d from %s is not replaceable\n",
-			   __FUNCTION__, irq, irq_tab[irq].devname);
-		    return -EBUSY;
-		  }
-	    /*printk("IRQ %d set to handler %p\n",irq,handler);*/
-	    if (dev_id==NULL)
-		  {
-		printk("WARNING: dev_id == NULL in request_irq\n");
-		dev_id=(void*)1;
-	      }
-	    irq_tab[irq].handler = handler;
-	    irq_tab[irq].flags   = flags;
-	    irq_tab[irq].dev_id  = dev_id;
-	    strlcpy(irq_tab[irq].devname,devname,sizeof(irq_tab[irq].devname));
-	    irq_tab[irq].state = 0;
-	    return 0;
-	  }
-	else {
-	  /* Q40_IRQ_SAMPLE :somewhat special actions required here ..*/
-	  cpu_request_irq(4, handler, flags, devname, dev_id);
-	  cpu_request_irq(6, handler, flags, devname, dev_id);
-	  return 0;
-	}
-}
-
-void q40_free_irq(unsigned int irq, void *dev_id)
-{
-	if (irq > Q40_IRQ_MAX || (irq>15 && irq<32)) {
-		printk("%s: Incorrect IRQ %d, dev_id %x \n", __FUNCTION__, irq, (unsigned)dev_id);
-		return;
-	}
-
-	/* test for ISA ints not implemented by HW */
-	switch (irq)
-	  {
-	  case 1: case 2: case 8: case 9:
-	  case 12: case 13:
-	    printk("%s: ISA IRQ %d from %x invalid\n", __FUNCTION__, irq, (unsigned)dev_id);
-	    return;
-	  case 11: irq=10;
-	  default:
-	    ;
-	  }
-
-	if (irq<Q40_IRQ_SAMPLE)
-	  {
-	    if (irq_tab[irq].dev_id != dev_id)
-	      printk("%s: Removing probably wrong IRQ %d from %s\n",
-		     __FUNCTION__, irq, irq_tab[irq].devname);
-
-	    irq_tab[irq].handler = q40_defhand;
-	    irq_tab[irq].flags   = 0;
-	    irq_tab[irq].dev_id  = NULL;
-	    /* irq_tab[irq].devname = NULL; */
-	    /* do not reset state !! */
-	  }
-	else
-	  { /* == Q40_IRQ_SAMPLE */
-	    cpu_free_irq(4, dev_id);
-	    cpu_free_irq(6, dev_id);
-	  }
-}
-
-
-irqreturn_t q40_process_int (int level, struct pt_regs *fp)
-{
-  printk("unexpected interrupt vec=%x, pc=%lx, d0=%lx, d0_orig=%lx, d1=%lx, d2=%lx\n",
-          level, fp->pc, fp->d0, fp->orig_d0, fp->d1, fp->d2);
-  printk("\tIIRQ_REG = %x, EIRQ_REG = %x\n",master_inb(IIRQ_REG),master_inb(EIRQ_REG));
-  return IRQ_HANDLED;
-}
 
 /*
  * this stuff doesn't really belong here..
-*/
+ */
 
 int ql_ticks;              /* 200Hz ticks since last jiffie */
 static int sound_ticks;
@@ -214,54 +108,53 @@ #define SVOL 45
 
 void q40_mksound(unsigned int hz, unsigned int ticks)
 {
-  /* for now ignore hz, except that hz==0 switches off sound */
-  /* simply alternate the ampl (128-SVOL)-(128+SVOL)-..-.. at 200Hz */
-  if (hz==0)
-    {
-      if (sound_ticks)
-	sound_ticks=1;
-
-      *DAC_LEFT=128;
-      *DAC_RIGHT=128;
-
-      return;
-    }
-  /* sound itself is done in q40_timer_int */
-  if (sound_ticks == 0) sound_ticks=1000; /* pretty long beep */
-  sound_ticks=ticks<<1;
+	/* for now ignore hz, except that hz==0 switches off sound */
+	/* simply alternate the ampl (128-SVOL)-(128+SVOL)-..-.. at 200Hz */
+	if (hz == 0) {
+		if (sound_ticks)
+			sound_ticks = 1;
+
+		*DAC_LEFT = 128;
+		*DAC_RIGHT = 128;
+
+		return;
+	}
+	/* sound itself is done in q40_timer_int */
+	if (sound_ticks == 0)
+		sound_ticks = 1000; /* pretty long beep */
+	sound_ticks = ticks << 1;
 }
 
 static irqreturn_t (*q40_timer_routine)(int, void *, struct pt_regs *);
 
 static irqreturn_t q40_timer_int (int irq, void * dev, struct pt_regs * regs)
 {
-    ql_ticks = ql_ticks ? 0 : 1;
-    if (sound_ticks)
-      {
-	unsigned char sval=(sound_ticks & 1) ? 128-SVOL : 128+SVOL;
-	sound_ticks--;
-	*DAC_LEFT=sval;
-	*DAC_RIGHT=sval;
-      }
-
-    if (!ql_ticks)
-	q40_timer_routine(irq, dev, regs);
-    return IRQ_HANDLED;
+	ql_ticks = ql_ticks ? 0 : 1;
+	if (sound_ticks) {
+		unsigned char sval=(sound_ticks & 1) ? 128-SVOL : 128+SVOL;
+		sound_ticks--;
+		*DAC_LEFT=sval;
+		*DAC_RIGHT=sval;
+	}
+
+	if (!ql_ticks)
+		q40_timer_routine(irq, dev, regs);
+	return IRQ_HANDLED;
 }
 
 void q40_sched_init (irqreturn_t (*timer_routine)(int, void *, struct pt_regs *))
 {
-    int timer_irq;
+	int timer_irq;
 
-    q40_timer_routine = timer_routine;
-    timer_irq=Q40_IRQ_FRAME;
+	q40_timer_routine = timer_routine;
+	timer_irq = Q40_IRQ_FRAME;
 
-    if (request_irq(timer_irq, q40_timer_int, 0,
+	if (request_irq(timer_irq, q40_timer_int, 0,
 				"timer", q40_timer_int))
-	panic ("Couldn't register timer int");
+		panic("Couldn't register timer int");
 
-    master_outb(-1,FRAME_CLEAR_REG);
-    master_outb( 1,FRAME_RATE_REG);
+	master_outb(-1, FRAME_CLEAR_REG);
+	master_outb( 1, FRAME_RATE_REG);
 }
 
 
@@ -307,153 +200,132 @@ static int mext_disabled=0;  /* ext irq 
 static int aliased_irq=0;  /* how many times inside handler ?*/
 
 
-/* got level 2 interrupt, dispatch to ISA or keyboard/timer IRQs */
-irqreturn_t q40_irq2_handler (int vec, void *devname, struct pt_regs *fp)
+/* got interrupt, dispatch to ISA or keyboard/timer IRQs */
+static void q40_irq_handler(unsigned int irq, struct pt_regs *fp)
 {
-  unsigned mir, mer;
-  int irq,i;
+	unsigned mir, mer;
+	int i;
 
 //repeat:
-  mir=master_inb(IIRQ_REG);
-  if (mir&Q40_IRQ_FRAME_MASK) {
-	  irq_tab[Q40_IRQ_FRAME].count++;
-	  irq_tab[Q40_IRQ_FRAME].handler(Q40_IRQ_FRAME,irq_tab[Q40_IRQ_FRAME].dev_id,fp);
-	  master_outb(-1,FRAME_CLEAR_REG);
-  }
-  if ((mir&Q40_IRQ_SER_MASK) || (mir&Q40_IRQ_EXT_MASK)) {
-	  mer=master_inb(EIRQ_REG);
-	  for (i=0; eirqs[i].mask; i++) {
-		  if (mer&(eirqs[i].mask)) {
-			  irq=eirqs[i].irq;
+	mir = master_inb(IIRQ_REG);
+#ifdef CONFIG_BLK_DEV_FD
+	if ((mir & Q40_IRQ_EXT_MASK) &&
+	    (master_inb(EIRQ_REG) & Q40_IRQ6_MASK)) {
+		floppy_hardint();
+		return;
+	}
+#endif
+	switch (irq) {
+	case 4:
+	case 6:
+		m68k_handle_int(Q40_IRQ_SAMPLE, fp);
+		return;
+	}
+	if (mir & Q40_IRQ_FRAME_MASK) {
+		m68k_handle_int(Q40_IRQ_FRAME, fp);
+		master_outb(-1, FRAME_CLEAR_REG);
+	}
+	if ((mir & Q40_IRQ_SER_MASK) || (mir & Q40_IRQ_EXT_MASK)) {
+		mer = master_inb(EIRQ_REG);
+		for (i = 0; eirqs[i].mask; i++) {
+			if (mer & eirqs[i].mask) {
+				irq = eirqs[i].irq;
 /*
  * There is a little mess wrt which IRQ really caused this irq request. The
  * main problem is that IIRQ_REG and EIRQ_REG reflect the state when they
  * are read - which is long after the request came in. In theory IRQs should
  * not just go away but they occassionally do
  */
-			  if (irq>4 && irq<=15 && mext_disabled) {
-				  /*aliased_irq++;*/
-				  goto iirq;
-			  }
-			  if (irq_tab[irq].handler == q40_defhand ) {
-				  printk("handler for IRQ %d not defined\n",irq);
-				  continue; /* ignore uninited INTs :-( */
-			  }
-			  if ( irq_tab[irq].state & IRQ_INPROGRESS ) {
-				  /* some handlers do local_irq_enable() for irq latency reasons, */
-				  /* however reentering an active irq handler is not permitted */
+				if (irq > 4 && irq <= 15 && mext_disabled) {
+					/*aliased_irq++;*/
+					goto iirq;
+				}
+				if (q40_state[irq] & IRQ_INPROGRESS) {
+					/* some handlers do local_irq_enable() for irq latency reasons, */
+					/* however reentering an active irq handler is not permitted */
 #ifdef IP_USE_DISABLE
-				  /* in theory this is the better way to do it because it still */
-				  /* lets through eg the serial irqs, unfortunately it crashes */
-				  disable_irq(irq);
-				  disabled=1;
+					/* in theory this is the better way to do it because it still */
+					/* lets through eg the serial irqs, unfortunately it crashes */
+					disable_irq(irq);
+					disabled = 1;
 #else
-				  /*printk("IRQ_INPROGRESS detected for irq %d, disabling - %s disabled\n",irq,disabled ? "already" : "not yet"); */
-				  fp->sr = (((fp->sr) & (~0x700))+0x200);
-				  disabled=1;
+					/*printk("IRQ_INPROGRESS detected for irq %d, disabling - %s disabled\n",
+						irq, disabled ? "already" : "not yet"); */
+					fp->sr = (((fp->sr) & (~0x700))+0x200);
+					disabled = 1;
 #endif
-				  goto iirq;
-			  }
-			  irq_tab[irq].count++;
-			  irq_tab[irq].state |= IRQ_INPROGRESS;
-			  irq_tab[irq].handler(irq,irq_tab[irq].dev_id,fp);
-			  irq_tab[irq].state &= ~IRQ_INPROGRESS;
-
-			  /* naively enable everything, if that fails than    */
-			  /* this function will be reentered immediately thus */
-			  /* getting another chance to disable the IRQ        */
-
-			  if ( disabled ) {
+					goto iirq;
+				}
+				q40_state[irq] |= IRQ_INPROGRESS;
+				m68k_handle_int(irq, fp);
+				q40_state[irq] &= ~IRQ_INPROGRESS;
+
+				/* naively enable everything, if that fails than    */
+				/* this function will be reentered immediately thus */
+				/* getting another chance to disable the IRQ        */
+
+				if (disabled) {
 #ifdef IP_USE_DISABLE
-				  if (irq>4){
-					  disabled=0;
-					  enable_irq(irq);}
+					if (irq > 4) {
+						disabled = 0;
+						enable_irq(irq);
+					}
 #else
-				  disabled=0;
-				  /*printk("reenabling irq %d\n",irq); */
+					disabled = 0;
+					/*printk("reenabling irq %d\n", irq); */
 #endif
-			  }
+				}
 // used to do 'goto repeat;' here, this delayed bh processing too long
-			  return IRQ_HANDLED;
-		  }
-	  }
-	  if (mer && ccleirq>0 && !aliased_irq)
-		  printk("ISA interrupt from unknown source? EIRQ_REG = %x\n",mer),ccleirq--;
-  }
- iirq:
-  mir=master_inb(IIRQ_REG);
-  /* should test whether keyboard irq is really enabled, doing it in defhand */
-  if (mir&Q40_IRQ_KEYB_MASK) {
-	  irq_tab[Q40_IRQ_KEYBOARD].count++;
-	  irq_tab[Q40_IRQ_KEYBOARD].handler(Q40_IRQ_KEYBOARD,irq_tab[Q40_IRQ_KEYBOARD].dev_id,fp);
-  }
-  return IRQ_HANDLED;
-}
-
-int show_q40_interrupts (struct seq_file *p, void *v)
-{
-	int i;
-
-	for (i = 0; i <= Q40_IRQ_MAX; i++) {
-		if (irq_tab[i].count)
-		      seq_printf(p, "%sIRQ %02d: %8d  %s%s\n",
-			      (i<=15) ? "ISA-" : "    " ,
-			    i, irq_tab[i].count,
-			    irq_tab[i].devname[0] ? irq_tab[i].devname : "?",
-			    irq_tab[i].handler == q40_defhand ?
-					" (now unassigned)" : "");
+				return;
+			}
+		}
+		if (mer && ccleirq > 0 && !aliased_irq) {
+			printk("ISA interrupt from unknown source? EIRQ_REG = %x\n",mer);
+			ccleirq--;
+		}
 	}
-	return 0;
-}
-
+ iirq:
+	mir = master_inb(IIRQ_REG);
+	/* should test whether keyboard irq is really enabled, doing it in defhand */
+	if (mir & Q40_IRQ_KEYB_MASK)
+		m68k_handle_int(Q40_IRQ_KEYBOARD, fp);
 
-static irqreturn_t q40_defhand (int irq, void *dev_id, struct pt_regs *fp)
-{
-        if (irq!=Q40_IRQ_KEYBOARD)
-	     printk ("Unknown q40 interrupt %d\n", irq);
-	else master_outb(-1,KEYBOARD_UNLOCK_REG);
-	return IRQ_NONE;
+	return;
 }
 
-
-void q40_enable_irq (unsigned int irq)
+void q40_enable_irq(unsigned int irq)
 {
-  if ( irq>=5 && irq<=15 )
-  {
-    mext_disabled--;
-    if (mext_disabled>0)
-	  printk("q40_enable_irq : nested disable/enable\n");
-    if (mext_disabled==0)
-    master_outb(1,EXT_ENABLE_REG);
-    }
+	if (irq >= 5 && irq <= 15) {
+		mext_disabled--;
+		if (mext_disabled > 0)
+			printk("q40_enable_irq : nested disable/enable\n");
+		if (mext_disabled == 0)
+			master_outb(1, EXT_ENABLE_REG);
+	}
 }
 
 
-void q40_disable_irq (unsigned int irq)
+void q40_disable_irq(unsigned int irq)
 {
-  /* disable ISA iqs : only do something if the driver has been
-   * verified to be Q40 "compatible" - right now IDE, NE2K
-   * Any driver should not attempt to sleep across disable_irq !!
-   */
-
-  if ( irq>=5 && irq<=15 ) {
-    master_outb(0,EXT_ENABLE_REG);
-    mext_disabled++;
-    if (mext_disabled>1) printk("disable_irq nesting count %d\n",mext_disabled);
-  }
+	/* disable ISA iqs : only do something if the driver has been
+	 * verified to be Q40 "compatible" - right now IDE, NE2K
+	 * Any driver should not attempt to sleep across disable_irq !!
+	 */
+
+	if (irq >= 5 && irq <= 15) {
+		master_outb(0, EXT_ENABLE_REG);
+		mext_disabled++;
+		if (mext_disabled > 1)
+			printk("disable_irq nesting count %d\n",mext_disabled);
+	}
 }
 
-unsigned long q40_probe_irq_on (void)
+unsigned long q40_probe_irq_on(void)
 {
-  printk("irq probing not working - reconfigure the driver to avoid this\n");
-  return -1;
+	printk("irq probing not working - reconfigure the driver to avoid this\n");
+	return -1;
 }
-int q40_probe_irq_off (unsigned long irqs)
+int q40_probe_irq_off(unsigned long irqs)
 {
-  return -1;
+	return -1;
 }
-/*
- * Local variables:
- * compile-command: "m68k-linux-gcc -D__KERNEL__ -I/home/rz/lx/linux-2.2.6/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -pipe -fno-strength-reduce -ffixed-a2 -m68040   -c -o q40ints.o q40ints.c"
- * End:
- */
-- 
1.3.3

--

