Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUFFPJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUFFPJX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 11:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUFFPJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 11:09:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:11756 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263714AbUFFPJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 11:09:20 -0400
Date: Sun, 6 Jun 2004 17:07:59 +0200 (MEST)
Message-Id: <200406061507.i56F7xdS029391@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: pj@sgi.com, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Cc: Simon.Derr@bull.net, ak@muc.de, akpm@osdl.org, ashok.raj@intel.com,
       colpatch@us.ibm.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
       rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004 12:01:46 -0700, Paul Jackson wrote:
>William Lee Irwin III wrote:
>> +void bitmap_to_u32_array(u32 *dst, unsigned long *src, int nwords)
...
>Mikael - does William's routine look like the makings of something
>that fits your needs?

It could, except I think it gets the word order wrong:

+#if defined(__BIG_ENDIAN) && BITS_PER_LONG == 64
+void bitmap_to_u32_array(u32 *dst, unsigned long *src, int nwords)
+{
+	int i;
+
+	for (i = 0; i < nwords; ++i) {
+		u64 word = src[i];
+		dst[2*i] = word >> 32;
+		dst[2*i+1] = word;
+	}
+}
+#else
+void bitmap_to_u32_array(u32 *dst, unsigned long *src, int nwords)
+{
+	memcpy(dst, src, nwords*sizeof(unsigned long));
+}
+#endif

Notice how it emits the high int before the low int.
(Which btw also is the native big-endian storage order,
so the memcpy() would have done the same.)

Now consider the location of bit 0, with mask value 1(*),
on a 64-bit big-endian machine. The code above puts this
in the second int, as bit 0 in *((char*)dst + 7).
But a 32-bit user-space, or a 64-bit user-space that sees
an array of ints not longs, wants it in the first int,
as bit 0 in *((char*)dst + 3).

Perfctr's marshalling procedure for cpumask_t values
(drivers/perfctr/init.c:cpus_copy_to_user() in recent -mm)
is endian-neutral and converts each long by emitting the
ints from least significant to most significant.

Considering the API for retrieving an array of unknown size,
perfctr's marshalling procedure does the following:

>	const unsigned int k_nrwords = PERFCTR_CPUMASK_NRLONGS*(sizeof(long)/sizeof(int));
>	unsigned int u_nrwords;
>	if (get_user(u_nrwords, &argp->nrwords))
>		return -EFAULT;
>	if (put_user(k_nrwords, &argp->nrwords))
>		return -EFAULT;
>	if (u_nrwords < k_nrwords)
>		return -EOVERFLOW;

That is, it always tells user-space how much space is needed,
and if user-space provided too little, it gets EOVERFLOW.
Knowing the number of words in the encoded cpumask_t also
avoids having to know the exact value of NR_CPUS in user-space.

/Mikael

(*) Normal bit order, not IBM POWER's reversed bit order.
