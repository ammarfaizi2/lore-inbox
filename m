Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVAQKQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVAQKQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 05:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVAQKQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 05:16:52 -0500
Received: from canuck.infradead.org ([205.233.218.70]:31501 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262378AbVAQKQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 05:16:42 -0500
Subject: Re: [PATCH] raid6: altivec support
From: David Woodhouse <dwmw2@infradead.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, hpa@zytor.com,
       torvalds@osdl.org
In-Reply-To: <20050109151353.GA9508@suse.de>
References: <200501082324.j08NOIva030415@hera.kernel.org>
	 <20050109151353.GA9508@suse.de>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 10:16:32 +0000
Message-Id: <1105956993.26551.327.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-09 at 16:13 +0100, Olaf Hering wrote:
> 
> > ChangeSet 1.2347, 2005/01/08 14:02:27-08:00, hpa@zytor.com
> > 
> >       [PATCH] raid6: altivec support
> >       
> >       This patch adds Altivec support for RAID-6, if appropriately configured on
> >       the ppc or ppc64 architectures.  Note that it changes the compile flags for
> >       ppc64 in order to handle -maltivec correctly; this change was vetted on the
> >       ppc64 mailing list and OK'd by paulus.
> 
> This fails to compile on ppc, enable_kernel_altivec() is an exported but
> undeclared function. cpu_features is also missing.
> 
> drivers/md/raid6altivec1.c: In function `raid6_altivec1_gen_syndrome':
> drivers/md/raid6altivec1.c:99: warning: implicit declaration of function `enable_kernel_altivec'
> drivers/md/raid6altivec1.c: In function `raid6_have_altivec':
> drivers/md/raid6altivec1.c:111: error: request for member `cpu_features' in something not a structure or union
> drivers/md/raid6altivec2.c: In function `raid6_altivec2_gen_syndrome':
> drivers/md/raid6altivec2.c:110: warning: implicit declaration of function `enable_kernel_altivec'

This makes it compile on PPC, but highlights the difference between
'cur_cpu_spec' on ppc32 and ppc64. Why is 'cur_cpu_spec' an array on
ppc32? Isn't 'cur' supposed to imply 'current'?

===== drivers/md/raid6altivec.uc 1.1 vs edited =====
--- 1.1/drivers/md/raid6altivec.uc	Sat Jan  8 05:44:07 2005
+++ edited/drivers/md/raid6altivec.uc	Mon Jan 17 09:45:20 2005
@@ -108,7 +108,11 @@
 int raid6_have_altivec(void)
 {
 	/* This assumes either all CPUs have Altivec or none does */
+#ifdef CONFIG_PPC64
 	return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
+#else
+	return cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC;
+#endif
 }
 #endif
 


-- 
dwmw2

