Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVCDCE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVCDCE1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVCDCBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:01:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:27881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262791AbVCDCA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:00:29 -0500
Date: Thu, 3 Mar 2005 17:59:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: olof@austin.ibm.com (Olof Johansson)
Cc: paulus@samba.org, jgarzik@pobox.com, rene@exactcode.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, greg@kroah.com, chrisw@osdl.org
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/
 Altivec
Message-Id: <20050303175951.41cda7a4.akpm@osdl.org>
In-Reply-To: <20050303225542.GB16886@austin.ibm.com>
References: <422751D9.2060603@exactcode.de>
	<422756DC.6000405@pobox.com>
	<16935.36862.137151.499468@cargo.ozlabs.ibm.com>
	<20050303225542.GB16886@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

olof@austin.ibm.com (Olof Johansson) wrote:
>
> Here's a patch that will work for both PPC and PPC64. The proper way to
>  fix this in mainline is to merge -mm's cpu_has_feature patch, but for
>  the stable 2.6.11-series, this much less intrusive (i.e. just the pure
>  bugfix, not the cleanup part).
> 
>  Signed-off-by: Olof Johansson <olof@austin.ibm.com>
> 
> 
>  Index: linux-2.5/drivers/md/raid6altivec.uc
>  ===================================================================
>  --- linux-2.5.orig/drivers/md/raid6altivec.uc	2005-03-03 16:46:47.000000000 -0600
>  +++ linux-2.5/drivers/md/raid6altivec.uc	2005-03-03 16:48:03.000000000 -0600
>  @@ -108,7 +108,11 @@ int raid6_have_altivec(void);
>   int raid6_have_altivec(void)
>   {
>   	/* This assumes either all CPUs have Altivec or none does */
>  +#ifdef CONFIG_PPC64
>  +	return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
>  +#else
>   	return cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC;
>  +#endif
>   }
>   #endif

This patch doesn't seem right - current 2.6.11 has:

        return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;

So anyway, I fixed it up as:

--- 25/drivers/md/raid6altivec.uc~ppc-raid6-altivec-build-fix	2005-03-03 17:56:21.000000000 -0800
+++ 25-akpm/drivers/md/raid6altivec.uc	2005-03-03 17:57:50.000000000 -0800
@@ -108,7 +108,11 @@ int raid6_have_altivec(void);
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
 
_


I'll assume that the above is suitable as a temp thing and I'll fix up
ppc-ppc64-abstract-cpu_feature-checks.patch
