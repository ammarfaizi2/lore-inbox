Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVFQTXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVFQTXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 15:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVFQTXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 15:23:47 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:22145 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261196AbVFQTXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 15:23:43 -0400
Date: Fri, 17 Jun 2005 12:23:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: kus Kusche Klaus <kus@keba.com>, Serge Noiraud <serge.noiraud@bull.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RT and kernel debugger ( 2.6.12rc6  + RT  > 48-00 )
Message-ID: <20050617192341.GA4824@smtp.west.cox.net>
References: <AAD6DA242BC63C488511C611BD51F36732323B@MAILIT.keba.co.at> <20050614072015.GA31891@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614072015.GA31891@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 09:20:15AM +0200, Ingo Molnar wrote:
> 
> * kus Kusche Klaus <kus@keba.com> wrote:
> 
> > I was one of those who tried to get kgdb working.
> > 
> > Here I described how far I came:
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0505.1/0700.html
> 
> does ethernet debugging work if you disable the netpoll WARN_ON() that 
> triggers?

With the KGDB at http://kgdb.linsyssoft.com/cvs.htm the following is all
that's needed for PREEMPT_RT to work:
--- linux-2.6.10.orig/drivers/net/kgdb_eth.c
+++ linux-2.6.10/drivers/net/kgdb_eth.c
@@ -55,22 +55,49 @@ static int eth_getDebugChar(void)
 {
 	int chr;
 
-	while (atomic_read(&in_count) == 0)
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * A bit hairy. Netpoll API users uses mutexes (indirectly) and
+	 * thus must have interrupts enabled:
+	 */
+	local_irq_enable();
+#endif
+
+	while (atomic_read(&in_count) == 0) {
+		WARN_ON_RT(irqs_disabled());
 		netpoll_poll(&np);
+		WARN_ON_RT(irqs_disabled());
+	}
 
 	chr = in_buf[in_tail++];
 	in_tail &= (IN_BUF_SIZE - 1);
 	atomic_dec(&in_count);
+#ifdef CONFIG_PREEMPT_RT
+	local_irq_disable();
+#endif
 	return chr;
 }
 
 static void eth_flushDebugChar(void)
 {
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * A bit hairy. Netpoll API users uses mutexes (indirectly) and
+	 * thus must have interrupts enabled:
+	 */
+	local_irq_enable();
+#endif
+
 	if (out_count && np.dev) {
+		WARN_ON_RT(irqs_disabled());
 		netpoll_send_udp(&np, out_buf, out_count);
+		WARN_ON_RT(irqs_disabled());
 		memset(out_buf, 0, sizeof(out_buf));
 		out_count = 0;
 	}
+#ifdef CONFIG_PREEMPT_RT
+	local_irq_disable();
+#endif
 }
 
 static void eth_putDebugChar(int chr)
--- linux-2.6.10.orig/kernel/kgdb.c
+++ linux-2.6.10/kernel/kgdb.c
@@ -85,7 +85,7 @@ struct kgdb_arch *kgdb_ops = &arch_kgdb_
 
 static const char hexchars[] = "0123456789abcdef";
 
-static spinlock_t slavecpulocks[NR_CPUS];
+static raw_spinlock_t slavecpulocks[NR_CPUS];
 static volatile int procindebug[NR_CPUS];
 atomic_t kgdb_setting_breakpoint;
 struct task_struct *kgdb_usethread, *kgdb_contthread;

-- 
Tom Rini
http://gate.crashing.org/~trini/
