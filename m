Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWGEKYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWGEKYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 06:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWGEKYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 06:24:36 -0400
Received: from canuck.infradead.org ([205.233.218.70]:25997 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964793AbWGEKYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 06:24:35 -0400
Subject: Re: [CPUFREQ] Fix implicit declarations in ondemand.
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
In-Reply-To: <20060705025744.ea6ee5ed.akpm@osdl.org>
References: <20060705092254.GA30744@redhat.com>
	 <20060705023641.21507b34.akpm@osdl.org>
	 <1152092585.32572.45.camel@pmac.infradead.org>
	 <20060705094657.GB1877@redhat.com>  <20060705025744.ea6ee5ed.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jul 2006 11:24:26 +0100
Message-Id: <1152095066.32572.49.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 02:57 -0700, Andrew Morton wrote:
> On Wed, 5 Jul 2006 05:46:57 -0400
> Dave Jones <davej@redhat.com> wrote:
> 
> > On Wed, Jul 05, 2006 at 10:43:05AM +0100, David Woodhouse wrote:
> >  > On Wed, 2006-07-05 at 02:36 -0700, Andrew Morton wrote:
> >  > > On Wed, 5 Jul 2006 05:22:54 -0400 Dave Jones <davej@redhat.com> wrote:
> >  > > 
> >  > > > drivers/cpufreq/cpufreq_ondemand.c: In function ‘dbs_check_cpu’:
> >  > > > drivers/cpufreq/cpufreq_ondemand.c:238: error: implicit declaration
> >  > > of function ‘jiffies64_to_cputime64’
> >  > > > drivers/cpufreq/cpufreq_ondemand.c:239: error: implicit declaration
> >  > > of function ‘cputime64_sub’
> >  > 
> >  > > > +#include <asm/cputime.h>
> >  > 
> >  > > But kernel_stat.h already includes cputime.h, as does sched.h, and
> >  > > pretty much everything pulls in sched.h.
> >  > > 
> >  > > It's not bad to avoid a dependency upon nested includes, but I do
> >  > > wonder how this error came about?? 
> >  > 
> >  > asm-powerpc/cputime.h doesn't declare jiffies64_to_cputime64() or
> >  > cputime64_sub()
> > 
> > The curious part is why it isn't picking up the definition from asm-generic
> > like x86-64 & friends do.
> > 
> 
> CONFIG_VIRT_CPU_ACCOUNTING.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- linux-2.6.17.ppc64/include/asm-powerpc/cputime.h~	2006-06-18 02:49:35.000000000 +0100
+++ linux-2.6.17.ppc64/include/asm-powerpc/cputime.h	2006-07-05 11:19:35.000000000 +0100
@@ -43,6 +43,7 @@ typedef u64 cputime64_t;
 
 #define cputime64_zero			((cputime64_t)0)
 #define cputime64_add(__a, __b)		((__a) + (__b))
+#define cputime64_sub(__a, __b)		((__a) - (__b))
 #define cputime_to_cputime64(__ct)	(__ct)
 
 #ifdef __KERNEL__
@@ -74,6 +75,23 @@ static inline cputime_t jiffies_to_cputi
 	return ct;
 }
 
+static inline cputime64_t jiffies64_to_cputime64(const u64 jif)
+{
+	cputime_t ct;
+	u64 sec;
+
+	/* have to be a little careful about overflow */
+	ct = jif % HZ;
+	sec = jif / HZ;
+	if (ct) {
+		ct *= tb_ticks_per_sec;
+		do_div(ct, HZ);
+	}
+	if (sec)
+		ct += (cputime_t) sec * tb_ticks_per_sec;
+	return ct;
+}
+
 static inline u64 cputime64_to_jiffies64(const cputime_t ct)
 {
 	return mulhdu(ct, __cputime_jiffies_factor);

-- 
dwmw2

