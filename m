Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVA0L70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVA0L70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 06:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVA0L70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 06:59:26 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:45060 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262590AbVA0L6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 06:58:31 -0500
Date: Thu, 27 Jan 2005 11:58:29 +0000
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch 2/6 introduce helper infrastructure
Message-ID: <20050127115829.GB10237@infradead.org>
References: <20050127101117.GA9760@infradead.org> <20050127101228.GC9760@infradead.org> <m1is5j40iq.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1is5j40iq.fsf@muc.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 11:41:33AM +0100, Andi Kleen wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> > +unsigned int get_random_int(void)
> > +{
> > +	static unsigned int val = 0;
> > +
> > +	val += current->pid + jiffies;
> 
> Shouldn't there be some kind of locking for this? It's random,
> but still random corruption sounds a bit too random.
> 
> Also you probably have a very hot cache line here, which
> may hurt on the bigger machines.


actually the static was ther from a previous revision where the ip rng was
compiled out at times so it needed some RNG characteristic. Patch below just
removes the static; it's good enough.


The patch below introduces get_random_int() and randomize_range(), two
helpers used in later patches in the series. get_random_int() shares the
tcp/ip random number stuff so the CONFIG_INET ifdef needs to move slightly,
and to reduce the damange due to that, secure_ip_id() needs to move inside
random.c



diff -purN step1/drivers/char/random.c step2/drivers/char/random.c
--- step1/drivers/char/random.c	2005-01-26 18:24:36.000000000 +0100
+++ step2/drivers/char/random.c	2005-01-27 11:03:01.000000000 +0100
@@ -1965,7 +1965,6 @@ static void sysctl_init_random(struct en
  *
  ********************************************************************/
 
-#ifdef CONFIG_INET
 /*
  * TCP initial sequence number picking.  This uses the random number
  * generator to pick an initial secret value.  This value is hashed
@@ -2202,6 +2201,31 @@ __u32 secure_tcpv6_sequence_number(__u32
 EXPORT_SYMBOL(secure_tcpv6_sequence_number);
 #endif
 
+/*  The code below is shamelessly stolen from secure_tcp_sequence_number().
+ *  All blames to Andrey V. Savochkin <saw@msu.ru>.
+ */
+__u32 secure_ip_id(__u32 daddr)
+{
+	struct keydata *keyptr;
+	__u32 hash[4];
+
+	keyptr = get_keyptr();
+
+	/*
+	 *  Pick a unique starting offset for each IP destination.
+	 *  The dest ip address is placed in the starting vector,
+	 *  which is then hashed with random data.
+	 */
+	hash[0] = daddr;
+	hash[1] = keyptr->secret[9];
+	hash[2] = keyptr->secret[10];
+	hash[3] = keyptr->secret[11];
+
+	return halfMD4Transform(hash, keyptr->secret);
+}
+
+#ifdef CONFIG_INET
+
 __u32 secure_tcp_sequence_number(__u32 saddr, __u32 daddr,
 				 __u16 sport, __u16 dport)
 {
@@ -2242,28 +2266,7 @@ __u32 secure_tcp_sequence_number(__u32 s
 
 EXPORT_SYMBOL(secure_tcp_sequence_number);
 
-/*  The code below is shamelessly stolen from secure_tcp_sequence_number().
- *  All blames to Andrey V. Savochkin <saw@msu.ru>.
- */
-__u32 secure_ip_id(__u32 daddr)
-{
-	struct keydata *keyptr;
-	__u32 hash[4];
-
-	keyptr = get_keyptr();
-
-	/*
-	 *  Pick a unique starting offset for each IP destination.
-	 *  The dest ip address is placed in the starting vector,
-	 *  which is then hashed with random data.
-	 */
-	hash[0] = daddr;
-	hash[1] = keyptr->secret[9];
-	hash[2] = keyptr->secret[10];
-	hash[3] = keyptr->secret[11];
 
-	return halfMD4Transform(hash, keyptr->secret);
-}
 
 /* Generate secure starting point for ephemeral TCP port search */
 u32 secure_tcp_port_ephemeral(__u32 saddr, __u32 daddr, __u16 dport)
@@ -2383,3 +2386,41 @@ __u32 check_tcp_syn_cookie(__u32 cookie,
 }
 #endif
 #endif /* CONFIG_INET */
+
+
+/*
+ * Get a random word for internal kernel use only. Similar to urandom but with the goal
+ * of minimal entropy pool depletion. As a result, the random value is not cryptographically
+ * secure but for several uses the cost of depleting entropy is too high
+ */
+unsigned int get_random_int(void)
+{
+	unsigned int val;
+
+	val= current->pid + jiffies;
+
+	/*
+	 * Use IP's RNG. It suits our purpose perfectly: it re-keys itself
+	 * every second, from the entropy pool (and thus creates a limited
+	 * drain on it), and uses halfMD4Transform within the second. We
+	 * also mix it with jiffies and the PID:
+	 */
+	return secure_ip_id(val);
+}
+
+/* 
+ * randomize_range() returns a start address such that
+ *
+ *    [...... <range> .....]
+ *  start                  end
+ *
+ * a <range> with size "len" starting at the return value is inside in the
+ * area defined by [start, end], but is otherwise randomized.
+ */
+unsigned long randomize_range(unsigned long start, unsigned long end, unsigned long len)
+{
+	unsigned long range = end - len - start;
+	if (end <= start + len)
+		return 0;
+	return PAGE_ALIGN(get_random_int() % range + start);
+}
diff -purN step1/include/linux/random.h step2/include/linux/random.h
--- step1/include/linux/random.h	2005-01-26 18:24:39.000000000 +0100
+++ step2/include/linux/random.h	2005-01-27 10:52:56.000000000 +0100
@@ -70,6 +70,9 @@ extern __u32 secure_tcpv6_sequence_numbe
 extern struct file_operations random_fops, urandom_fops;
 #endif
 
+unsigned int get_random_int(void);
+unsigned long randomize_range(unsigned long start, unsigned long end, unsigned long len);
+
 #endif /* __KERNEL___ */
 
 #endif /* _LINUX_RANDOM_H */
