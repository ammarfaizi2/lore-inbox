Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316889AbSFMFWd>; Thu, 13 Jun 2002 01:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317456AbSFMFWc>; Thu, 13 Jun 2002 01:22:32 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:60826 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316889AbSFMFW2>; Thu, 13 Jun 2002 01:22:28 -0400
Date: Thu, 13 Jun 2002 15:01:19 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Message-Id: <20020613150119.16115952.rusty@rustcorp.com.au>
In-Reply-To: <20020612.022641.123609388.davem@redhat.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002 02:26:41 -0700 (PDT)
"David S. Miller" <davem@redhat.com> wrote:

>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Wed, 12 Jun 2002 16:58:23 +1000
> 
>    In message <20020611.021043.04190747.davem@redhat.com> you write:
>    > And remember, it's the anal "every microoptimization at all costs"
>    > people that keep the kernel sane and from running out of control bloat
>    > wise.
>    
>    But it also gave us crap like net/ipv4/route.c:ip_rt_acct_read() 8(
> 
> That's far from being an attempt optimization :-)

I was giving you the benifit of the doubt, that both the design (binary
data from /proc) and the code (#ifdef, cpu_logical_map(0), and "256"
sprinkled everywhere) were some insane attempt at speed, rather that
a demonstration of sheer programming idiocy.

I stand corrected 8).  This papers over the damage:

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.21/net/ipv4/route.c working-2.5.21-ipacct/net/ipv4/route.c
--- linux-2.5.21/net/ipv4/route.c	Mon May 13 12:00:40 2002
+++ working-2.5.21-ipacct/net/ipv4/route.c	Thu Jun 13 14:33:41 2002
@@ -2418,10 +2418,15 @@
 #ifdef CONFIG_NET_CLS_ROUTE
 struct ip_rt_acct *ip_rt_acct;
 
+/* This code sucks.  But you should have seen it before! --RR */
+
+/* IP route accounting ptr for this logical cpu number. */
+#define IP_RT_ACCT_CPU(i) (ip_rt_acct + cpu_logical_map(i) * 256)
+
 static int ip_rt_acct_read(char *buffer, char **start, off_t offset,
 			   int length, int *eof, void *data)
 {
-	*start = buffer;
+	unsigned int i;
 
 	if ((offset & 3) || (length & 3))
 		return -EIO;
@@ -2430,35 +2435,18 @@
 		length = sizeof(struct ip_rt_acct) * 256 - offset;
 		*eof = 1;
 	}
-	if (length > 0) {
-		u32 *dst = (u32*)buffer;
-		u32 *src = (u32*)(((u8*)ip_rt_acct) + offset);
-
-		memcpy(dst, src, length);
-
-#ifdef CONFIG_SMP
-		if (smp_num_cpus > 1 || cpu_logical_map(0) != 0) {
-			int i;
-			int cnt = length / 4;
-
-			for (i = 0; i < smp_num_cpus; i++) {
-				int cpu = cpu_logical_map(i);
-				int k;
 
-				if (cpu == 0)
-					continue;
-
-				src = (u32*)(((u8*)ip_rt_acct) + offset +
-					cpu * 256 * sizeof(struct ip_rt_acct));
+	/* Copy first cpu. */
+	*start = buffer;
+	memcpy(buffer, IP_RT_ACCT_CPU(0), length);
 
-				for (k = 0; k < cnt; k++)
-					dst[k] += src[k];
-			}
-		}
-#endif
-		return length;
+	/* Add the other cpus in, one int at a time */
+	for (i = 1; i < smp_num_cpus; i++) {
+		unsigned int j;
+		for (j = 0; j < length/4; j++)
+			((u32*)buffer)[j] += ((u32*)IP_RT_ACCT_CPU(i))[j];
 	}
-	return 0;
+	return length;
 }
 #endif
 
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
