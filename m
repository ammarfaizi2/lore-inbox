Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTJCMCT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 08:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbTJCMCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 08:02:18 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32436
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263722AbTJCMCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 08:02:13 -0400
Date: Fri, 3 Oct 2003 14:02:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa1: HZ not constant?
Message-ID: <20031003120236.GR13360@velociraptor.random>
References: <20031002152648.GB1240@velociraptor.random> <3F7D4C4D.78BB5D0C@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7D4C4D.78BB5D0C@eyal.emu.id.au>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 03, 2003 at 08:15:41PM +1000, Eyal Lebedinsky wrote:
> I am getting failures like this:
> 
> tr.c:81: initializer element is not constant
> make[3]: *** [tr.o] Error 1
> make[3]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre-aa/net/802'
> 
> 
> ecc.c:43: initializer element is not constant
> ecc.c:1495: warning: function declaration isn't a prototype
> make[2]: *** [ecc.o] Error 1
> make[2]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre-aa/drivers/char'
> 
> where the problem is a file level definition like
> 	static var = HZ;
> 
> and it seems that HZ is not anymore valid here (see include/linux/hz.h).

HZ isn't known at compile time anymore, you pass it to the kernel as
parameter dynamically.

the way to fix it is:

1) if the 'static var' variable is somehow visible to userspace then
   use USER_HZ and the user_to_kenrel_hz/user_to_kernel_hz_overflow
   (the latter is more efficient, it introduces zero branches , but it gives
   wrong results for very big inputs, it's ideal for sysctl set to
   things like 5*USER_HZ or anyways smaller than 2G/HZ ~= 1million).
2) if the static var is not visible to userspace (either via sysctl
   or module parameter) then we can just initialize it dynamically

This is the relevant fix for the above two problems. Please try again
and let me know if something else doesn't compile. Thanks!

--- x/drivers/char/ecc.c.~1~	2003-10-02 15:08:07.000000000 +0200
+++ x/drivers/char/ecc.c	2003-10-03 13:52:16.000000000 +0200
@@ -40,7 +40,7 @@
 #define max(a,b)	((a)>(b)?(a):(b))
 
 static int ecc_scrub = -1;
-static int ecc_ticks = HZ;
+static int ecc_ticks = USER_HZ;
 
 static spinlock_t ecc_lock = SPIN_LOCK_UNLOCKED;
 static int proc_ram_valid = 0;
@@ -1410,7 +1410,7 @@ static void check_ecc(unsigned long dumm
 	if (cs.clear_err)
 		cs.clear_err();
 
-	ecc_timer.expires = jiffies + ecc_ticks;
+	ecc_timer.expires = jiffies + user_to_kernel_hz_overflow(ecc_ticks);
 	add_timer(&ecc_timer);
 
 	spin_unlock (&ecc_lock);
@@ -1616,8 +1616,8 @@ static int __init ecc_init(void) 
 	spin_lock_bh (&ecc_lock);
 
 	printk(KERN_INFO "ECC: monitor version %s\n", ECC_VER);
-	if (ecc_ticks != HZ)
-		printk(KERN_INFO "ECC: interval=%d ticks\n", ecc_ticks);
+	if (user_to_kernel_hz_overflow(ecc_ticks) != HZ)
+		printk(KERN_INFO "ECC: interval=%d ticks\n", user_to_kernel_hz_overflow(ecc_ticks));
 
 	for (loop=0;loop<MAX_BANKS;loop++) {
 		bank[loop].endaddr = 0;
@@ -1650,7 +1650,7 @@ static int __init ecc_init(void) 
 
 	init_timer(&ecc_timer);
 	ecc_timer.function = check_ecc;
-	ecc_timer.expires = jiffies + ecc_ticks;
+	ecc_timer.expires = jiffies + user_to_kernel_hz_overflow(ecc_ticks);
 	add_timer(&ecc_timer);
 	ecc_timer_valid = 1;
 
@@ -1688,7 +1688,7 @@ MODULE_LICENSE("GPL");
 MODULE_PARM(ecc_scrub, "i");
 MODULE_PARM_DESC(ecc_scrub, "Force ECC scrubbing: 0=off 1=on");
 MODULE_PARM(ecc_ticks, "i");
-MODULE_PARM_DESC(ecc_ticks, "Timer interval (default HZ)");
+MODULE_PARM_DESC(ecc_ticks, "Timer interval (default USER_HZ)");
 
 module_init(ecc_init);
 module_exit(ecc_exit);
--- x/net/802/tr.c.~1~	2003-06-13 22:07:42.000000000 +0200
+++ x/net/802/tr.c	2003-10-03 13:59:02.000000000 +0200
@@ -69,7 +69,7 @@ struct rif_cache_s {	
 static rif_cache rif_table[RIF_TABLE_SIZE];
 static spinlock_t rif_lock = SPIN_LOCK_UNLOCKED;
 
-#define RIF_TIMEOUT 60*10*HZ
+#define RIF_TIMEOUT 60*10*USER_HZ
 #define RIF_CHECK_INTERVAL 60*HZ
 
 /*
@@ -78,7 +78,8 @@ static spinlock_t rif_lock = SPIN_LOCK_U
  
 static struct timer_list rif_timer;
 
-int sysctl_tr_rif_timeout = RIF_TIMEOUT;
+int __sysctl_tr_rif_timeout = RIF_TIMEOUT;
+#define sysctl_tr_rif_timeout user_to_kernel_hz_overflow(__sysctl_tr_rif_timeout)
 
 /*
  *	Put the headers on a token ring packet. Token ring source routing
@@ -545,7 +546,7 @@ static int rif_get_info(char *buffer,cha
 
 static int __init rif_init(void)
 {
-	rif_timer.expires  = RIF_TIMEOUT;
+	rif_timer.expires  = user_to_kernel_hz_overflow(RIF_TIMEOUT);
 	rif_timer.data     = 0L;
 	rif_timer.function = rif_check_expire;
 	init_timer(&rif_timer);
--- x/net/802/sysctl_net_802.c.~1~	2003-03-15 03:25:18.000000000 +0100
+++ x/net/802/sysctl_net_802.c	2003-10-03 13:59:19.000000000 +0200
@@ -19,9 +19,9 @@ ctl_table e802_table[] = {
 };
 
 #ifdef CONFIG_TR
-extern int sysctl_tr_rif_timeout;
+extern int __sysctl_tr_rif_timeout;
 ctl_table tr_table[] = {
-	{NET_TR_RIF_TIMEOUT, "rif_timeout", &sysctl_tr_rif_timeout, sizeof(int),
+	{NET_TR_RIF_TIMEOUT, "rif_timeout", &__sysctl_tr_rif_timeout, sizeof(int),
 	 0644, NULL, &proc_dointvec},
 	{0}
 };

Side note: there is no way that dynamic-hz could destabilize the kernel
(assuming you don't pass HZ != 100 at boot time which can trigger bugs
that would trigger anyways already on alpha or ia64). Every failure will
always happen at compile time (the worst one was HZ*0.1, but that's now
trapped by the -msoft-float, idea from Andi). I designed it strictly
that way, if you enable the CONFIG_DEBUG_HZ = y then even a reader of HZ
before the kernel parsing at boot initializes it will be safe defaulted
to USER_HZ and will only generate an harmless printk (this is useful to
port it to other archs).  However it's recommended to leave
CONFIG_DEBUG_HZ = n since enabling it would decrease performance due the
additional sanity checking. While dyanmic-hz with debugging disabled is
definitely not measurable in any benchmark and it allows to run true
desktop multimedia with a guarantee of timeslices that provides a
rescheduling rate higher than 50hz, that is the only way to reliably
fool our eyes. The scheduler heuristics still play an important role but
any heuristic isn't infallible and we can't depend on it. A desktop
isn't computing anyways, boosting the reschedule rate is perfectly
acceptable and the right thing to do IMHO.

Once somebody will start shipping cpus with address space numbers in the
tlb (no brainer and needed _huge_ hardware optimization), the slowdown
will be even less.

BTW, there's a -aa NUMA specific bug that is crashing my x86-64 in half
an hour (it's related to the paddr stuff needed for 32bit numa with PAE,
this mean 32bit NUMA is also unused), so don't compile a numa kernel,
select smp only. Next release should work fine with numa too.

> I have:
> # CONFIG_DEBUG_KERNEL is not set

that's ok, it's not related to this.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
