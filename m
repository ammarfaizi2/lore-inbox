Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVCCXCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVCCXCa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbVCCXAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:00:34 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:27888 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262691AbVCCW5s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:57:48 -0500
Date: Thu, 3 Mar 2005 16:55:42 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Rene Rebe <rene@exactcode.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, chrisw@osdl.org
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
Message-ID: <20050303225542.GB16886@austin.ibm.com>
References: <422751D9.2060603@exactcode.de> <422756DC.6000405@pobox.com> <16935.36862.137151.499468@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16935.36862.137151.499468@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 09:30:22AM +1100, Paul Mackerras wrote:
> > I nominate this as a candidate for linux-2.6.11 release branch.  :)
> 
> No.  Unfortunately if you fix ppc64 here you will break ppc, and vice
> versa.  Yes, we are going to reconcile the cur_cpu_spec definitions
> between ppc and ppc64. :)

The proper fix is to get the cpu_has_feature patch merged up from -mm,
but that's 99% cleanup and 1% bugfix. So here's a more appropriate fix
for the 2.6.11 patch stream. This goes on top of the one that just got
merged there.


-Olof


---


Here's a patch that will work for both PPC and PPC64. The proper way to
fix this in mainline is to merge -mm's cpu_has_feature patch, but for
the stable 2.6.11-series, this much less intrusive (i.e. just the pure
bugfix, not the cleanup part).

Signed-off-by: Olof Johansson <olof@austin.ibm.com>


Index: linux-2.5/drivers/md/raid6altivec.uc
===================================================================
--- linux-2.5.orig/drivers/md/raid6altivec.uc	2005-03-03 16:46:47.000000000 -0600
+++ linux-2.5/drivers/md/raid6altivec.uc	2005-03-03 16:48:03.000000000 -0600
@@ -108,7 +108,11 @@ int raid6_have_altivec(void);
 int raid6_have_altivec(void)
 {
 	/* This assumes either all CPUs have Altivec or none does */
+#ifdef CONFIG_PPC64
+	return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
+#else
 	return cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC;
+#endif
 }
 #endif
 
