Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131655AbQKQAww>; Thu, 16 Nov 2000 19:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbQKQAwn>; Thu, 16 Nov 2000 19:52:43 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:20211 "HELO
	halfway.linuxcare.com.au") by vger.kernel.org with SMTP
	id <S129941AbQKQAwc>; Thu, 16 Nov 2000 19:52:32 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] set_bit takes a `long *'
Date: Fri, 17 Nov 2000 11:21:40 +1100
Message-Id: <20001117002140.94419813F@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Portable code must only use set_bit() on a long, otherwise Sparc64 and
mips64 break (and probably PPC64 in future).

Personally, I'd be much happier if set_bit(N,addr) were defined to
operate on the byte `(char *)addr + N/8': then we could use it on
`char', etc, as well (ie. set_le_bit renamed to set_bit).

I even changed cases where it didn't matter eg. hardware only used on
32-bit platforms, since people obviously copy that code...

Not fixed:
./fs/affs/bitmap.c:77:	set_bit(bit & 31,&blk);
	- This seems gratuitous anyway.

./drivers/net/wan/cycx_x25.c:1175:	set_bit(key, (void*)&card->u.x.connection_keys);
	- I think this is also gratuitous.

./drivers/block/cpqarray.c:1353:		} while(test_and_set_bit(i%32, h->cmd_pool_bits+(i/32)) != 0);
	- Broken on bigendian 64bit.

./drivers/block/cciss.c:235:                } while(test_and_set_bit(i%32, h->cmd_pool_bits+(i/32)) != 0);
	- Broken on bigendian 64bit.

./drivers/char/agp/agpgart_be.c:198:		set_bit(bit, agp_bridge.key_list);
	- Broken, but changing to long would break other things I think.

./drivers/scsi/qla1280.c:1522:    if(test_and_set_bit(QLA1280_IN_ISR_BIT, &ha->flags))
	- Completely broken (bitfield), but painful to fix.

./drivers/ieee1394/ohci1394.c:866:                if (!test_and_set_bit(channelbit, isochannels))
	- Doesn't seem trivial to fix.

Rusty.
--
Hacking time.
PS. Resent to l-k list because my fingers still remember vger.rutgers...

diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/Documentation/DocBook/kernel-hacking.tmpl working-2.4.0-test11-5/Documentation/DocBook/kernel-hacking.tmpl
--- linux-2.4.0-test11-5/Documentation/DocBook/kernel-hacking.tmpl	Thu May 25 12:41:11 2000
+++ working-2.4.0-test11-5/Documentation/DocBook/kernel-hacking.tmpl	Fri Nov 17 09:04:46 2000
@@ -846,7 +846,7 @@
    first class of operations work on <type>atomic_t</type>
 
    <filename class=headerfile>include/asm/atomic.h</filename>; this
-   contains a signed integer (at least 32 bits long), and you must use
+   contains a signed integer (at least 24 bits long), and you must use
    these functions to manipulate or read atomic_t variables.
    <function>atomic_read()</function> and
    <function>atomic_set()</function> get and set the counter,
@@ -870,8 +870,8 @@
   </para>
 
   <para>
-   The second class of atomic operations is atomic bit operations,
-   defined in
+   The second class of atomic operations is atomic bit operations on a
+   <type>long</type>, defined in
 
    <filename class=headerfile>include/asm/bitops.h</filename>.  These
    operations generally take a pointer to the bit pattern, and a bit
@@ -887,8 +887,14 @@
   
   <para>
    It is possible to call these operations with bit indices greater
-   than 31.  The resulting behavior is strange on big-endian
+   than BITS_PER_LONG.  The resulting behavior is strange on big-endian
    platforms though so it is a good idea not to do this.
+  </para>
+
+  <para>
+   Note that the order of bits depends on the architecture, and in
+   particular, the bitfield passed to these operations must be at
+   least as large as a <type>long</type>.
   </para>
  </chapter>
 
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/arch/alpha/kernel/semaphore.c working-2.4.0-test11-5/arch/alpha/kernel/semaphore.c
--- linux-2.4.0-test11-5/arch/alpha/kernel/semaphore.c	Sun Feb 27 19:26:13 2000
+++ working-2.4.0-test11-5/arch/alpha/kernel/semaphore.c	Fri Nov 17 08:32:34 2000
@@ -261,6 +261,7 @@
 void
 __do_rwsem_wake(struct rw_semaphore *sem, int readers)
 {
+	/* set_bit is safe, even though granted is `int': little endian --RR */
 	if (readers) {
 		if (test_and_set_bit(0, &sem->granted))
 			BUG();
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/arch/alpha/kernel/smp.c working-2.4.0-test11-5/arch/alpha/kernel/smp.c
--- linux-2.4.0-test11-5/arch/alpha/kernel/smp.c	Wed Oct  4 15:16:14 2000
+++ working-2.4.0-test11-5/arch/alpha/kernel/smp.c	Fri Nov 17 08:31:33 2000
@@ -1081,6 +1081,7 @@
 debug_spin_trylock(spinlock_t * lock, const char *base_file, int line_no)
 {
 	int ret;
+	/* this is safe, even though lock is `int': little endian --RR */
 	if ((ret = !test_and_set_bit(0, lock))) {
 		lock->on_cpu = smp_processor_id();
 		lock->previous = __builtin_return_address(0);
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/arch/i386/kernel/irq.c working-2.4.0-test11-5/arch/i386/kernel/irq.c
--- linux-2.4.0-test11-5/arch/i386/kernel/irq.c	Sat Aug 12 00:23:15 2000
+++ working-2.4.0-test11-5/arch/i386/kernel/irq.c	Fri Nov 17 08:28:22 2000
@@ -179,7 +179,7 @@
 
 #ifdef CONFIG_SMP
 unsigned char global_irq_holder = NO_PROC_ID;
-unsigned volatile int global_irq_lock;
+unsigned volatile long global_irq_lock; /* pendantic: long for set_bit --RR */
 
 extern void show_stack(unsigned long* esp);
 
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/arch/ia64/kernel/irq.c working-2.4.0-test11-5/arch/ia64/kernel/irq.c
--- linux-2.4.0-test11-5/arch/ia64/kernel/irq.c	Thu Nov  9 16:15:46 2000
+++ working-2.4.0-test11-5/arch/ia64/kernel/irq.c	Fri Nov 17 08:56:00 2000
@@ -181,7 +181,7 @@
 
 #ifdef CONFIG_SMP
 unsigned int global_irq_holder = NO_PROC_ID;
-volatile unsigned int global_irq_lock;
+volatile unsigned long global_irq_lock; /* long for set_bit --RR */
 
 extern void show_stack(unsigned long* esp);
 
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/arch/ppc/kernel/irq.c working-2.4.0-test11-5/arch/ppc/kernel/irq.c
--- linux-2.4.0-test11-5/arch/ppc/kernel/irq.c	Wed Oct  4 15:16:18 2000
+++ working-2.4.0-test11-5/arch/ppc/kernel/irq.c	Fri Nov 17 08:36:36 2000
@@ -357,7 +357,7 @@
 
 #ifdef CONFIG_SMP
 unsigned char global_irq_holder = NO_PROC_ID;
-unsigned volatile int global_irq_lock;
+unsigned volatile long global_irq_lock; /* pendantic :long for set_bit--RR*/
 atomic_t global_irq_count;
 
 atomic_t global_bh_count;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/arch/ppc/kernel/local_irq.h working-2.4.0-test11-5/arch/ppc/kernel/local_irq.h
--- linux-2.4.0-test11-5/arch/ppc/kernel/local_irq.h	Sat Aug 12 00:23:18 2000
+++ working-2.4.0-test11-5/arch/ppc/kernel/local_irq.h	Fri Nov 17 08:49:37 2000
@@ -15,8 +15,9 @@
 extern int ppc_spurious_interrupts;
 extern int ppc_second_irq;
 extern struct irqaction *ppc_irq_action[NR_IRQS];
-extern unsigned int ppc_cached_irq_mask[NR_MASK_WORDS];
-extern unsigned int ppc_lost_interrupts[NR_MASK_WORDS];
+/* pendatic: these are long because they are used with set_bit --RR */
+extern unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
+extern unsigned long ppc_lost_interrupts[NR_MASK_WORDS];
 extern atomic_t ppc_n_lost_interrupts;
 
 #endif /* _PPC_KERNEL_LOCAL_IRQ_H */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/arch/s390/kernel/irq.c working-2.4.0-test11-5/arch/s390/kernel/irq.c
--- linux-2.4.0-test11-5/arch/s390/kernel/irq.c	Sat Aug 12 00:23:18 2000
+++ working-2.4.0-test11-5/arch/s390/kernel/irq.c	Fri Nov 17 09:00:52 2000
@@ -205,6 +205,8 @@
 			if (!local_bh_count(cpu)
 			    && atomic_read(&global_bh_count))
 				continue;
+			/* this works even though global_irq_lock not
+                           a long, but is arch-specific --RR */
 			if (!test_and_set_bit(0,&global_irq_lock))
 				break;
 		}
@@ -243,6 +245,8 @@
 
 static inline void get_irqlock(int cpu)
 {
+	/* this works even though global_irq_lock not a long, but is
+	   arch-specific --RR */
 	if (test_and_set_bit(0,&global_irq_lock)) {
 		/* do we already hold the lock? */
 		if ( cpu == atomic_read(&global_irq_holder))
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/acorn/block/fd1772.c working-2.4.0-test11-5/drivers/acorn/block/fd1772.c
--- linux-2.4.0-test11-5/drivers/acorn/block/fd1772.c	Wed Oct  4 15:16:19 2000
+++ working-2.4.0-test11-5/drivers/acorn/block/fd1772.c	Fri Nov 17 08:11:16 2000
@@ -276,8 +276,8 @@
 static volatile int fdc_busy = 0;
 static DECLARE_WAIT_QUEUE_HEAD(fdc_wait);
 
-
-static unsigned int changed_floppies = 0xff, fake_change = 0;
+/* long req'd for set_bit --RR */
+static unsigned long changed_floppies = 0xff, fake_change = 0;
 #define	CHECK_CHANGE_DELAY	HZ/2
 
 /* DAG - increased to 30*HZ - not sure if this is the correct thing to do */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/block/ataflop.c working-2.4.0-test11-5/drivers/block/ataflop.c
--- linux-2.4.0-test11-5/drivers/block/ataflop.c	Wed Jul 12 17:52:03 2000
+++ working-2.4.0-test11-5/drivers/block/ataflop.c	Fri Nov 17 07:11:35 2000
@@ -317,7 +317,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(fdc_wait);
 static DECLARE_WAIT_QUEUE_HEAD(format_wait);
 
-static unsigned int changed_floppies = 0xff, fake_change = 0;
+static unsigned long changed_floppies = 0xff, fake_change = 0;
 #define	CHECK_CHANGE_DELAY	HZ/2
 
 #define	FD_MOTOR_OFF_DELAY	(3*HZ)
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/char/drm/mga_drv.h working-2.4.0-test11-5/drivers/char/drm/mga_drv.h
--- linux-2.4.0-test11-5/drivers/char/drm/mga_drv.h	Wed Oct  4 15:16:27 2000
+++ working-2.4.0-test11-5/drivers/char/drm/mga_drv.h	Fri Nov 17 07:29:17 2000
@@ -38,7 +38,7 @@
 #define MGA_BUF_NEEDS_OVERFLOW 3
 
 typedef struct {
-	u32 buffer_status;
+	long buffer_status; /* long req'd for set_bit() --RR */
    	int num_dwords;
    	int max_dwords;
    	u32 *current_dma_ptr;
@@ -62,7 +62,7 @@
 #define MGA_IN_GETBUF	  3
 
 typedef struct _drm_mga_private {
-   	u32 dispatch_status;
+   	long dispatch_status;	/* long req'd for set_bit() --RR */
 	unsigned int next_prim_age;
 	__volatile__ unsigned int last_prim_age;
    	int reserved_map_idx;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/char/mixcomwd.c working-2.4.0-test11-5/drivers/char/mixcomwd.c
--- linux-2.4.0-test11-5/drivers/char/mixcomwd.c	Wed Oct  4 15:16:27 2000
+++ working-2.4.0-test11-5/drivers/char/mixcomwd.c	Fri Nov 17 07:24:05 2000
@@ -54,7 +54,7 @@
 #define FLASHCOM_WATCHDOG_OFFSET 0x4
 #define FLASHCOM_ID 0x18
 
-static int mixcomwd_opened;
+static long mixcomwd_opened; /* long req'd for setbit --RR */
 
 static int watchdog_port;
 
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/char/moxa.c working-2.4.0-test11-5/drivers/char/moxa.c
--- linux-2.4.0-test11-5/drivers/char/moxa.c	Fri May 12 13:22:17 2000
+++ working-2.4.0-test11-5/drivers/char/moxa.c	Fri Nov 17 07:23:24 2000
@@ -152,7 +152,7 @@
 	unsigned short closing_wait;
 	int count;
 	int blocked_open;
-	int event;
+	long event; /* long req'd for set_bit --RR */
 	int asyncflags;
 	long session;
 	long pgrp;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/char/rio/host.h working-2.4.0-test11-5/drivers/char/rio/host.h
--- linux-2.4.0-test11-5/drivers/char/rio/host.h	Tue May 23 02:43:11 2000
+++ working-2.4.0-test11-5/drivers/char/rio/host.h	Fri Nov 17 07:39:43 2000
@@ -110,7 +110,7 @@
     struct UnixRup	    UnixRups[MAX_RUP+LINKS_PER_UNIT];
 	int				timeout_id;	/* For calling 100 ms delays */
 	int				timeout_sem;/* For calling 100 ms delays */
-    int locks;
+    long locks; /* long req'd for set_bit --RR */
     char             	    ____end_marker____;
 };
 #define Control      CardP->DpControl
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/char/riscom8.h working-2.4.0-test11-5/drivers/char/riscom8.h
--- linux-2.4.0-test11-5/drivers/char/riscom8.h	Thu May 13 06:27:37 1999
+++ working-2.4.0-test11-5/drivers/char/riscom8.h	Fri Nov 17 07:20:47 2000
@@ -71,7 +71,7 @@
 	struct tty_struct 	* tty;
 	int			count;
 	int			blocked_open;
-	int			event;
+	long			event; /* long req'd for set_bit --RR */
 	int			timeout;
 	int			close_delay;
 	long			session;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/char/sx.h working-2.4.0-test11-5/drivers/char/sx.h
--- linux-2.4.0-test11-5/drivers/char/sx.h	Fri May 12 13:47:06 2000
+++ working-2.4.0-test11-5/drivers/char/sx.h	Fri Nov 17 07:19:57 2000
@@ -31,7 +31,7 @@
   int                     c_dcd;
   struct sx_board         *board;
   int                     line;
-  int                     locks;
+  long                    locks; /* long req'd for set_bit --RR */
 };
 
 struct sx_board {
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/ide/ide-floppy.c working-2.4.0-test11-5/drivers/ide/ide-floppy.c
--- linux-2.4.0-test11-5/drivers/ide/ide-floppy.c	Thu Apr 27 12:57:27 2000
+++ working-2.4.0-test11-5/drivers/ide/ide-floppy.c	Fri Nov 17 08:05:58 2000
@@ -104,7 +104,7 @@
 	byte *current_position;			/* Pointer into the above buffer */
 	void (*callback) (ide_drive_t *);	/* Called when this packet command is completed */
 	byte pc_buffer[IDEFLOPPY_PC_BUFFER_SIZE];	/* Temporary buffer */
-	unsigned int flags;			/* Status/Action bit flags */
+	unsigned long flags;			/* Status/Action bit flags: long for set_bit */
 } idefloppy_pc_t;
 
 /*
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/ide/ide-tape.c working-2.4.0-test11-5/drivers/ide/ide-tape.c
--- linux-2.4.0-test11-5/drivers/ide/ide-tape.c	Thu Nov  9 16:15:52 2000
+++ working-2.4.0-test11-5/drivers/ide/ide-tape.c	Fri Nov 17 08:07:53 2000
@@ -686,7 +686,7 @@
 	byte *current_position;			/* Pointer into the above buffer */
 	ide_startstop_t (*callback) (ide_drive_t *);	/* Called when this packet command is completed */
 	byte pc_buffer[IDETAPE_PC_BUFFER_SIZE];	/* Temporary buffer */
-	unsigned int flags;			/* Status/Action bit flags */
+	unsigned long flags;			/* Status/Action bit flags: long for set_bit */
 } idetape_pc_t;
 
 /*
@@ -908,7 +908,7 @@
 	int pages_per_stage;
 	int excess_bh_size;			/* Wasted space in each stage */
 
-	unsigned int flags;			/* Status/Action flags */
+	unsigned long flags;			/* Status/Action flags: long for set_bit --RR */
 	spinlock_t spinlock;			/* protects the ide-tape queue */
 
 	/*
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/isdn/hisax/hisax.h working-2.4.0-test11-5/drivers/isdn/hisax/hisax.h
--- linux-2.4.0-test11-5/drivers/isdn/hisax/hisax.h	Sun Aug 27 15:10:58 2000
+++ working-2.4.0-test11-5/drivers/isdn/hisax/hisax.h	Fri Nov 17 08:02:16 2000
@@ -202,7 +202,7 @@
 	void *hardware;
 	struct BCState *bcs;
 	struct PStack **stlistp;
-	int Flags;
+	long Flags; /* long req'd for set_bit --RR */
 	struct FsmInst l1m;
 	struct FsmTimer	timer;
 	void (*l1l2) (struct PStack *, int, void *);
@@ -241,7 +241,7 @@
 	int tei;
 	int sap;
 	int maxlen;
-	unsigned int flag;
+	unsigned long flag; /* long req'd for set_bit --RR */
 	unsigned int vs, va, vr;
 	int rc;
 	unsigned int window;
@@ -366,7 +366,7 @@
 };
 
 struct isar_reg {
-	unsigned int Flags;
+	unsigned long Flags;	/* long req'd for set_bit --RR */
 	volatile u_char bstat;
 	volatile u_char iis;
 	volatile u_char cmsb;
@@ -483,7 +483,7 @@
 struct BCState {
 	int channel;
 	int mode;
-	int Flag;
+	long Flag; /* long req'd for set_bit --RR */
 	struct IsdnCardState *cs;
 	int tx_cnt;		/* B-Channel transmit counter */
 	struct sk_buff *tx_skb; /* B-Channel transmit Buffer */
@@ -528,7 +528,8 @@
 	int data_open;
 	struct l3_process *proc;
 	setup_parm setup;	/* from isdnif.h numbers and Serviceindicator */
-	int Flags;		/* for remembering action done in l4 */
+	long Flags;		/* for remembering action done in l4 */
+				/* long req'd for set_bit --RR */
 	int leased;
 };
 
@@ -865,7 +866,7 @@
 	int protocol;
 	unsigned int irq;
 	unsigned long irq_flags;
-	int HW_Flags;
+	long HW_Flags; /* long req'd for set_bit --RR */
 	int *busy_flag;
         int chanlimit; /* limited number of B-chans to use */
         int logecho; /* log echo if supported by card */
@@ -932,7 +933,7 @@
 	int rcvidx;
 	struct sk_buff *tx_skb;
 	int tx_cnt;
-	int event;
+	long event; /* long req'd for set_bit --RR */
 	struct tq_struct tqueue;
 	struct timer_list dbusytimer;
 #ifdef ERROR_STATISTIC
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/media/video/zr36120.h working-2.4.0-test11-5/drivers/media/video/zr36120.h
--- linux-2.4.0-test11-5/drivers/media/video/zr36120.h	Sun Aug 27 15:10:59 2000
+++ working-2.4.0-test11-5/drivers/media/video/zr36120.h	Fri Nov 17 08:25:29 2000
@@ -130,7 +130,8 @@
 	int		tuner_type;	/* tuner type, when found	*/
 	int		running;	/* are we rolling?		*/
 	rwlock_t	lock;
-	int		state;		/* what is requested of us?	*/
+	long		state;		/* what is requested of us?	*/
+					/* long req'd for set_bit --RR */
 #define STATE_OVERLAY	0
 #define STATE_VBI	1
 	struct vidinfo*	workqueue;	/* buffers to grab, head is active */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/3c505.h working-2.4.0-test11-5/drivers/net/3c505.h
--- linux-2.4.0-test11-5/drivers/net/3c505.h	Mon Feb 14 19:19:30 2000
+++ working-2.4.0-test11-5/drivers/net/3c505.h	Thu Nov 16 19:42:35 2000
@@ -284,7 +284,7 @@
 
 	/* flags */
 	unsigned long send_pcb_semaphore;
-	unsigned int dmaing;
+	unsigned long dmaing;
 	unsigned long busy;
 
 	unsigned int rx_active;  /* number of receive PCBs */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/aironet4500.h working-2.4.0-test11-5/drivers/net/aironet4500.h
--- linux-2.4.0-test11-5/drivers/net/aironet4500.h	Fri Jul 21 02:30:52 2000
+++ working-2.4.0-test11-5/drivers/net/aironet4500.h	Fri Nov 17 07:03:22 2000
@@ -1487,7 +1487,7 @@
 	volatile int		ejected;
 	volatile int		bh_running;
 	volatile int		bh_active;
-	volatile int		tx_chain_active;
+	volatile long		tx_chain_active; /* long req'd: set_bit --RR */
 	volatile u16		enabled_interrupts;
 	volatile u16		waiting_interrupts;
 	volatile int		interrupt_count;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/arlan.h working-2.4.0-test11-5/drivers/net/arlan.h
--- linux-2.4.0-test11-5/drivers/net/arlan.h	Fri Jul 21 02:30:52 2000
+++ working-2.4.0-test11-5/drivers/net/arlan.h	Fri Nov 17 07:01:12 2000
@@ -388,7 +388,7 @@
       volatile int	tx_chain_active;
       volatile int 	timer_chain_active;
       volatile int 	interrupt_ack_requested;
-      volatile int	command_lock;
+      volatile long	command_lock; /* long req'd for set_bit() --RR */
       volatile int	rx_command_needed;
       volatile int	tx_command_needed;
       volatile int 	waiting_command_mask;
@@ -398,8 +398,8 @@
       volatile int 	under_reset;
       volatile int 	under_config;
       volatile int 	rx_command_given;
-      volatile int 	tx_command_given;
-      volatile int	interrupt_processing_active;
+      volatile long 	tx_command_given; /* long req'd for set_bit() --RR */
+      volatile long	interrupt_processing_active; /* and here --RR */
       volatile long long 	last_tx_time;
       volatile long long	last_rx_time;
       volatile long long	last_rx_int_ack_time;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/atarilance.c working-2.4.0-test11-5/drivers/net/atarilance.c
--- linux-2.4.0-test11-5/drivers/net/atarilance.c	Fri Oct 15 15:51:16 1999
+++ working-2.4.0-test11-5/drivers/net/atarilance.c	Fri Nov 17 09:08:32 2000
@@ -225,9 +225,9 @@
 						/* copy function */
 	void				*(*memcpy_f)( void *, const void *, size_t );
 	struct net_device_stats stats;
-/* These two must be ints for set_bit() */
-	int					tx_full;
-	int					lock;
+/* These two must be longs for set_bit() */
+	long int			tx_full;
+	long int			lock;
 };
 
 /* I/O register access macros */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/bagetlance.c working-2.4.0-test11-5/drivers/net/bagetlance.c
--- linux-2.4.0-test11-5/drivers/net/bagetlance.c	Tue May 23 02:43:15 2000
+++ working-2.4.0-test11-5/drivers/net/bagetlance.c	Fri Nov 17 07:05:30 2000
@@ -224,9 +224,9 @@
 						/* copy function */
 	void				*(*memcpy_f)( void *, const void *, size_t );
 	struct net_device_stats stats;
-/* These two must be ints for set_bit() */
-	int					tx_full;
-	int					lock;
+/* These two must be longs for set_bit() */
+	long				tx_full;
+	long				lock;
 };
 
 /* I/O register access macros */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/hamradio/6pack.h working-2.4.0-test11-5/drivers/net/hamradio/6pack.h
--- linux-2.4.0-test11-5/drivers/net/hamradio/6pack.h	Fri Oct 15 15:51:16 1999
+++ working-2.4.0-test11-5/drivers/net/hamradio/6pack.h	Fri Nov 17 09:08:34 2000
@@ -101,7 +101,8 @@
   int			mtu;		/* Our mtu (to spot changes!)   */
   int                   buffsize;       /* Max buffers sizes            */
 
-  unsigned char		flags;		/* Flag values/ mode etc	*/
+  unsigned long		flags;		/* Flag values/ mode etc	*/
+					/* long req'd for set_bit --RR */
   unsigned char		mode;		/* 6pack mode			*/
 
 /* 6pack stuff */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/hamradio/mkiss.h working-2.4.0-test11-5/drivers/net/hamradio/mkiss.h
--- linux-2.4.0-test11-5/drivers/net/hamradio/mkiss.h	Fri Oct 15 15:51:16 1999
+++ working-2.4.0-test11-5/drivers/net/hamradio/mkiss.h	Fri Nov 17 09:08:35 2000
@@ -42,7 +42,8 @@
 	int                 buffsize;		/* Max buffers sizes            */
 
 
-	unsigned char       flags;		/* Flag values/ mode etc	*/
+	unsigned long   flags;		/* Flag values/ mode etc	*/
+					/* long req'd: used by set_bit --RR */
 #define AXF_INUSE	0		/* Channel in use               */
 #define AXF_ESCAPE	1               /* ESC received                 */
 #define AXF_ERROR	2               /* Parity, etc. error           */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/ni52.c working-2.4.0-test11-5/drivers/net/ni52.c
--- linux-2.4.0-test11-5/drivers/net/ni52.c	Thu Nov  9 16:15:56 2000
+++ working-2.4.0-test11-5/drivers/net/ni52.c	Thu Nov 16 19:43:03 2000
@@ -219,7 +219,8 @@
 	struct net_device_stats stats;
 	unsigned long base;
 	char *memtop;
-	int lock,reseted;
+	long int lock;
+	int reseted;
 	volatile struct rfd_struct	*rfd_last,*rfd_top,*rfd_first;
 	volatile struct scp_struct	*scp;	/* volatile is important */
 	volatile struct iscp_struct	*iscp;	/* volatile is important */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/pcmcia/ray_cs.h working-2.4.0-test11-5/drivers/net/pcmcia/ray_cs.h
--- linux-2.4.0-test11-5/drivers/net/pcmcia/ray_cs.h	Fri Jul 21 02:30:52 2000
+++ working-2.4.0-test11-5/drivers/net/pcmcia/ray_cs.h	Fri Nov 17 07:07:34 2000
@@ -33,8 +33,8 @@
     UCHAR *rmem;                   /* pointer to receive buffer window       */
     dev_link_t *finder;            /* pointer back to dev_link_t for card    */
     struct timer_list timer;
-    int tx_ccs_lock;
-    int ccs_lock;
+    long tx_ccs_lock;		   /* long req'd for set_bit() --RR */
+    long ccs_lock;		   /* long req'd for set_bit() --RR */
     int   dl_param_ccs;
     union {
         struct b4_startup_params b4;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/slip.h working-2.4.0-test11-5/drivers/net/slip.h
--- linux-2.4.0-test11-5/drivers/net/slip.h	Thu Oct  5 15:34:34 2000
+++ working-2.4.0-test11-5/drivers/net/slip.h	Thu Nov 16 19:40:58 2000
@@ -91,7 +91,7 @@
   int			xdata, xbits;	/* 6 bit slip controls 		*/
 #endif
 
-  unsigned int		flags;		/* Flag values/ mode etc	*/
+  unsigned long		flags;		/* Flag values/ mode etc	*/
 #define SLF_INUSE	0		/* Channel in use               */
 #define SLF_ESCAPE	1               /* ESC received                 */
 #define SLF_ERROR	2               /* Parity, etc. error           */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/sun3lance.c working-2.4.0-test11-5/drivers/net/sun3lance.c
--- linux-2.4.0-test11-5/drivers/net/sun3lance.c	Tue Feb  1 22:19:40 2000
+++ working-2.4.0-test11-5/drivers/net/sun3lance.c	Fri Nov 17 07:06:11 2000
@@ -147,9 +147,9 @@
      	int new_rx, new_tx;	/* The next free ring entry */
 	int old_tx, old_rx;     /* ring entry to be processed */
 	struct net_device_stats stats;
-/* These two must be ints for set_bit() */
-	int					tx_full;
-	int					lock;
+/* These two must be longs for set_bit() */
+	long					tx_full;
+	long					lock;
 };
 
 /* I/O register access macros */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/wan/comx-hw-mixcom.c working-2.4.0-test11-5/drivers/net/wan/comx-hw-mixcom.c
--- linux-2.4.0-test11-5/drivers/net/wan/comx-hw-mixcom.c	Wed Oct  4 15:16:40 2000
+++ working-2.4.0-test11-5/drivers/net/wan/comx-hw-mixcom.c	Fri Nov 17 06:46:17 2000
@@ -76,7 +76,7 @@
 struct mixcom_privdata {
 	u16	clock;
 	char	channel;
-	char	txbusy;
+	long	txbusy; /* Must be long: used with set_bit --RR */
 	struct sk_buff *sending;
 	unsigned tx_ptr;
 	struct sk_buff *recving;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/wan/comx.h working-2.4.0-test11-5/drivers/net/wan/comx.h
--- linux-2.4.0-test11-5/drivers/net/wan/comx.h	Thu Apr 27 12:57:32 2000
+++ working-2.4.0-test11-5/drivers/net/wan/comx.h	Fri Nov 17 09:08:36 2000
@@ -55,12 +55,12 @@
 	unsigned char	line_status;
 
 	struct timer_list lineup_timer;	// against line jitter
-	int		lineup_pending;
+	long int	lineup_pending; // long req'd: used in set_bit -- RR
 	unsigned char	lineup_delay;
 
 #if 0
 	struct timer_list reset_timer; // for board resetting
-	int		reset_pending;
+	long		reset_pending; // long req'd: used in set_bit -- RR
 	int		reset_timeout;
 #endif
 
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/wan/cosa.c working-2.4.0-test11-5/drivers/net/wan/cosa.c
--- linux-2.4.0-test11-5/drivers/net/wan/cosa.c	Thu Nov  9 16:15:57 2000
+++ working-2.4.0-test11-5/drivers/net/wan/cosa.c	Thu Nov 16 19:44:44 2000
@@ -165,8 +165,8 @@
 	int nchannels;			/* # of channels on this card */
 	int driver_status;		/* For communicating with firware */
 	int firmware_status;		/* Downloaded, reseted, etc. */
-	int rxbitmap, txbitmap;		/* Bitmap of channels who are willing to send/receive data */
-	int rxtx;			/* RX or TX in progress? */
+	long int rxbitmap, txbitmap;	/* Bitmap of channels who are willing to send/receive data */
+	long int rxtx;			/* RX or TX in progress? */
 	int enabled;
 	int usage;				/* usage count */
 	int txchan, txsize, rxsize;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/net/wan/x25_asy.h working-2.4.0-test11-5/drivers/net/wan/x25_asy.h
--- linux-2.4.0-test11-5/drivers/net/wan/x25_asy.h	Fri Oct 15 15:52:04 1999
+++ working-2.4.0-test11-5/drivers/net/wan/x25_asy.h	Thu Nov 16 19:48:17 2000
@@ -42,7 +42,8 @@
   int			mtu;		/* Our mtu (to spot changes!)   */
   int                   buffsize;       /* Max buffers sizes            */
 
-  unsigned int		flags;		/* Flag values/ mode etc	*/
+  unsigned long		flags;		/* Flag values/ mode etc	*/
+					/* long req'd for set_bit --RR  */
 #define SLF_INUSE	0		/* Channel in use               */
 #define SLF_ESCAPE	1               /* ESC received                 */
 #define SLF_ERROR	2               /* Parity, etc. error           */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/s390/char/hwc_rw.c working-2.4.0-test11-5/drivers/s390/char/hwc_rw.c
--- linux-2.4.0-test11-5/drivers/s390/char/hwc_rw.c	Thu May 18 18:10:15 2000
+++ working-2.4.0-test11-5/drivers/s390/char/hwc_rw.c	Fri Nov 17 08:21:44 2000
@@ -118,7 +118,8 @@
 static unsigned char
  _page[PAGE_SIZE] __attribute__ ((aligned (PAGE_SIZE)));
 
-typedef u32 kmem_pages_t;
+/* pedantic: long because we use set_bit on it --RR */
+typedef long kmem_pages_t;
 
 #define MAX_KMEM_PAGES (sizeof(kmem_pages_t) << 3)
 
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/s390/net/ctc.c working-2.4.0-test11-5/drivers/s390/net/ctc.c
--- linux-2.4.0-test11-5/drivers/s390/net/ctc.c	Thu May 18 18:10:15 2000
+++ working-2.4.0-test11-5/drivers/s390/net/ctc.c	Fri Nov 17 08:22:41 2000
@@ -128,7 +128,8 @@
  *
  */  
 
-static int channel_tab_initialized = 0;     /* channel[] structure initialized */
+/* long req'd by set_bit --RR */
+static long channel_tab_initialized = 0;     /* channel[] structure initialized */
 
 struct devicelist {  
         unsigned int  devno;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/scsi/3w-xxxx.h working-2.4.0-test11-5/drivers/scsi/3w-xxxx.h
--- linux-2.4.0-test11-5/drivers/scsi/3w-xxxx.h	Wed Oct  4 15:16:41 2000
+++ working-2.4.0-test11-5/drivers/scsi/3w-xxxx.h	Fri Nov 17 07:47:50 2000
@@ -289,7 +289,7 @@
 	unsigned short		aen_queue[TW_Q_LENGTH];
 	unsigned char		aen_head;
 	unsigned char		aen_tail;
-	u32			flags;
+	long			flags; /* long req'd for set_bit --RR */
 } TW_Device_Extension;
 
 /* Function prototypes */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/scsi/aic7xxx.c working-2.4.0-test11-5/drivers/scsi/aic7xxx.c
--- linux-2.4.0-test11-5/drivers/scsi/aic7xxx.c	Thu Nov  9 16:15:58 2000
+++ working-2.4.0-test11-5/drivers/scsi/aic7xxx.c	Fri Nov 17 07:42:35 2000
@@ -935,7 +935,7 @@
    * We are grouping things here....first, items that get either read or
    * written with nearly every interrupt
    */
-  volatile ahc_flag_type   flags;
+  volatile long            flags;	     /* long req'd for set_bit --RR */
   ahc_feature              features;         /* chip features */
   unsigned long            base;             /* card base address */
   volatile unsigned char  *maddr;            /* memory mapped address */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/scsi/ips.h working-2.4.0-test11-5/drivers/scsi/ips.h
--- linux-2.4.0-test11-5/drivers/scsi/ips.h	Wed Oct  4 15:16:47 2000
+++ working-2.4.0-test11-5/drivers/scsi/ips.h	Fri Nov 17 07:46:44 2000
@@ -929,7 +929,7 @@
    char              *ioctl_data;         /* IOCTL data area            */
    u32                ioctl_datasize;     /* IOCTL data size            */
    u32                cmd_in_progress;    /* Current command in progress*/
-   u32                flags;              /* HA flags                   */
+   long               flags;              /* HA flags: long req'd by set_bit */
    u8                 waitflag;           /* are we waiting for cmd     */
    u8                 active;
    u16                reset_count;        /* number of resets           */
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/drivers/scsi/ultrastor.c working-2.4.0-test11-5/drivers/scsi/ultrastor.c
--- linux-2.4.0-test11-5/drivers/scsi/ultrastor.c	Wed Oct  4 15:16:50 2000
+++ working-2.4.0-test11-5/drivers/scsi/ultrastor.c	Fri Nov 17 07:43:38 2000
@@ -252,7 +252,7 @@
 #if ULTRASTOR_MAX_CMDS == 1
   unsigned char mscp_busy;
 #else
-  unsigned short mscp_free;
+  unsigned long mscp_free; /* long req'd for set_bit --RR */
 #endif
   volatile unsigned char aborted[ULTRASTOR_MAX_CMDS];
   struct mscp mscp[ULTRASTOR_MAX_CMDS];
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/asm-generic/bitops.h working-2.4.0-test11-5/include/asm-generic/bitops.h
--- linux-2.4.0-test11-5/include/asm-generic/bitops.h	Tue Jul 21 10:23:32 1998
+++ working-2.4.0-test11-5/include/asm-generic/bitops.h	Fri Nov 17 06:44:22 2000
@@ -9,14 +9,14 @@
  * disable interrupts while they operate.  (You have to provide inline
  * routines to cli() and sti().)
  *
- * Also note, these routines assume that you have 32 bit integers.
+ * Also note, these routines assume that you have 32 bit longs.
  * You will have to change this if you are trying to port Linux to the
  * Alpha architecture or to a Cray.  :-)
  * 
  * C language equivalents written by Theodore Ts'o, 9/26/92
  */
 
-extern __inline__ int set_bit(int nr,int * addr)
+extern __inline__ int set_bit(int nr,long * addr)
 {
 	int	mask, retval;
 
@@ -29,7 +29,7 @@
 	return retval;
 }
 
-extern __inline__ int clear_bit(int nr, int * addr)
+extern __inline__ int clear_bit(int nr, long * addr)
 {
 	int	mask, retval;
 
@@ -42,7 +42,7 @@
 	return retval;
 }
 
-extern __inline__ int test_bit(int nr, int * addr)
+extern __inline__ int test_bit(int nr, long * addr)
 {
 	int	mask;
 
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/asm-ia64/hardirq.h working-2.4.0-test11-5/include/asm-ia64/hardirq.h
--- linux-2.4.0-test11-5/include/asm-ia64/hardirq.h	Thu Nov  9 16:16:05 2000
+++ working-2.4.0-test11-5/include/asm-ia64/hardirq.h	Fri Nov 17 08:56:27 2000
@@ -49,7 +49,7 @@
 #include <asm/smp.h>
 
 extern unsigned int global_irq_holder;
-extern volatile unsigned int global_irq_lock;
+extern volatile unsigned long global_irq_lock;
 
 static inline int irqs_running (void)
 {
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/asm-mips/semaphore.h working-2.4.0-test11-5/include/asm-mips/semaphore.h
--- linux-2.4.0-test11-5/include/asm-mips/semaphore.h	Tue May 23 02:43:26 2000
+++ working-2.4.0-test11-5/include/asm-mips/semaphore.h	Fri Nov 17 08:35:49 2000
@@ -215,7 +215,7 @@
 	atomic_t		count;
 	/* bit 0 means read bias granted;
 	   bit 1 means write bias granted.  */
-	unsigned		granted;
+	unsigned long		granted; /* pendant: long req'd for set_bit */
 	wait_queue_head_t	wait;
 	wait_queue_head_t	write_bias_wait;
 #if WAITQUEUE_DEBUG
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/asm-mips64/semaphore.h working-2.4.0-test11-5/include/asm-mips64/semaphore.h
--- linux-2.4.0-test11-5/include/asm-mips64/semaphore.h	Tue May 23 02:43:27 2000
+++ working-2.4.0-test11-5/include/asm-mips64/semaphore.h	Fri Nov 17 08:58:01 2000
@@ -196,7 +196,7 @@
 	atomic_t		count;
 	/* bit 0 means read bias granted;
 	   bit 1 means write bias granted.  */
-	unsigned		granted;
+	unsigned long		granted; /* long req'd for set_bit --RR */
 	wait_queue_head_t	wait;
 	wait_queue_head_t	write_bias_wait;
 #if WAITQUEUE_DEBUG
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/linux/agpgart.h working-2.4.0-test11-5/include/linux/agpgart.h
--- linux-2.4.0-test11-5/include/linux/agpgart.h	Thu Oct  5 15:33:45 2000
+++ working-2.4.0-test11-5/include/linux/agpgart.h	Fri Nov 17 07:37:51 2000
@@ -207,7 +207,7 @@
 	struct _agp_file_private *next;
 	struct _agp_file_private *prev;
 	pid_t my_pid;
-	u32 access_flags;
+	long access_flags;	/* long req'd for set_bit --RR */
 } agp_file_private;
 
 struct agp_front_data {
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/linux/atmdev.h working-2.4.0-test11-5/include/linux/atmdev.h
--- linux-2.4.0-test11-5/include/linux/atmdev.h	Fri Nov 10 12:37:40 2000
+++ working-2.4.0-test11-5/include/linux/atmdev.h	Thu Nov 16 19:39:44 2000
@@ -257,7 +257,8 @@
 #define ATM_ATMOPT_CLP	1	/* set CLP bit */
 
 
-typedef struct { unsigned int bits; } atm_vcc_flags_t;
+/* Needs to be unsigned long: used with bitops --RR */
+typedef struct { unsigned long bits; } atm_vcc_flags_t;
 
 
 struct atm_vcc {
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/linux/hdlcdrv.h working-2.4.0-test11-5/include/linux/hdlcdrv.h
--- linux-2.4.0-test11-5/include/linux/hdlcdrv.h	Wed Oct  4 15:17:09 2000
+++ working-2.4.0-test11-5/include/linux/hdlcdrv.h	Fri Nov 17 09:08:35 2000
@@ -199,7 +199,7 @@
 
 	struct hdlcdrv_hdlcrx {
 		struct hdlcdrv_hdlcbuffer hbuf;
-		int in_hdlc_rx;
+		long int in_hdlc_rx; /* long req'd: used by set_bit --RR */
 		/* 0 = sync hunt, != 0 receiving */
 		int rx_state;	
 		unsigned int bitstream;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/linux/netfilter_ipv4/ip_conntrack.h working-2.4.0-test11-5/include/linux/netfilter_ipv4/ip_conntrack.h
--- linux-2.4.0-test11-5/include/linux/netfilter_ipv4/ip_conntrack.h	Tue Nov  7 15:33:02 2000
+++ working-2.4.0-test11-5/include/linux/netfilter_ipv4/ip_conntrack.h	Thu Nov 16 19:38:19 2000
@@ -101,7 +101,7 @@
 	struct ip_conntrack_tuple_hash tuplehash[IP_CT_DIR_MAX];
 
 	/* Have we seen traffic both ways yet? (bitset) */
-	volatile unsigned int status;
+	volatile unsigned long status;
 
 	/* Timer function; drops refcnt when it goes off. */
 	struct timer_list timeout;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/linux/netfilter_ipv4/lockhelp.h working-2.4.0-test11-5/include/linux/netfilter_ipv4/lockhelp.h
--- linux-2.4.0-test11-5/include/linux/netfilter_ipv4/lockhelp.h	Fri Nov 10 12:40:00 2000
+++ working-2.4.0-test11-5/include/linux/netfilter_ipv4/lockhelp.h	Thu Nov 16 19:33:25 2000
@@ -19,8 +19,8 @@
 struct rwlock_debug
 {
 	rwlock_t l;
-	int read_locked_map;
-	int write_locked_map;
+	long read_locked_map; /* long req'd for set_bit */
+	long write_locked_map;
 };
 
 #define DECLARE_LOCK(l) 						\
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/linux/parport.h working-2.4.0-test11-5/include/linux/parport.h
--- linux-2.4.0-test11-5/include/linux/parport.h	Sat Oct  7 13:43:20 2000
+++ working-2.4.0-test11-5/include/linux/parport.h	Fri Nov 17 08:17:52 2000
@@ -229,7 +229,7 @@
 	unsigned long int time;
 	unsigned long int timeslice;
 	volatile long int timeout;
-	unsigned int waiting;
+	unsigned long waiting;		 /* long req'd for set_bit --RR */
 	struct pardevice *waitprev;
 	struct pardevice *waitnext;
 	void * sysctl_table;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/linux/spinlock.h working-2.4.0-test11-5/include/linux/spinlock.h
--- linux-2.4.0-test11-5/include/linux/spinlock.h	Fri Nov 10 12:31:22 2000
+++ working-2.4.0-test11-5/include/linux/spinlock.h	Thu Nov 16 19:32:34 2000
@@ -65,7 +65,7 @@
 #elif (DEBUG_SPINLOCKS < 2)
 
 typedef struct {
-	volatile unsigned int lock;
+	volatile unsigned long lock; /* long required for set_bit --RR */
 } spinlock_t;
 #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
 
@@ -80,7 +80,7 @@
 #else /* (DEBUG_SPINLOCKS >= 2) */
 
 typedef struct {
-	volatile unsigned int lock;
+	volatile unsigned long lock; /* long required for set_bit --RR */
 	volatile unsigned int babble;
 	const char *module;
 } spinlock_t;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/linux/stallion.h working-2.4.0-test11-5/include/linux/stallion.h
--- linux-2.4.0-test11-5/include/linux/stallion.h	Fri Oct 15 15:51:38 1999
+++ working-2.4.0-test11-5/include/linux/stallion.h	Fri Nov 17 07:40:39 2000
@@ -75,7 +75,7 @@
 	int			ioaddr;
 	int			uartaddr;
 	int			pagenr;
-	int			istate;
+	long			istate; /* long req'd for set_bit --RR */
 	int			flags;
 	int			baud_base;
 	int			custom_divisor;
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/linux/wanrouter.h working-2.4.0-test11-5/include/linux/wanrouter.h
--- linux-2.4.0-test11-5/include/linux/wanrouter.h	Fri Nov 10 12:38:30 2000
+++ working-2.4.0-test11-5/include/linux/wanrouter.h	Thu Nov 16 19:46:42 2000
@@ -442,7 +442,7 @@
 	char api_status;		/* device api status */
 	struct net_device_stats stats; 	/* interface statistics */
 	unsigned reserved[16];		/* reserved for future use */
-	unsigned critical;		/* critical section flag */
+	unsigned long critical;		/* critical section flag */
 					/****** device management methods ***/
 	int (*setup) (struct wan_device *wandev, wandev_conf_t *conf);
 	int (*shutdown) (struct wan_device *wandev);
diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/net/sunrpc/sched.c working-2.4.0-test11-5/net/sunrpc/sched.c
--- linux-2.4.0-test11-5/net/sunrpc/sched.c	Wed Oct  4 15:17:16 2000
+++ working-2.4.0-test11-5/net/sunrpc/sched.c	Thu Nov 16 19:38:33 2000
@@ -82,7 +82,7 @@
  * This is the last-ditch buffer for NFS swap requests
  */
 static u32			swap_buffer[PAGE_SIZE >> 2];
-static int			swap_buffer_used;
+static long			swap_buffer_used; /* long req'd for set_bit */
 
 /*
  * Make allocation of the swap_buffer SMP-safe
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
