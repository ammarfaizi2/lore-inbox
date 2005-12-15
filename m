Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVLOVgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVLOVgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVLOVgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:36:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64649 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751103AbVLOVgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:36:36 -0500
Date: Thu, 15 Dec 2005 13:36:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jordan Crouse" <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       info-linux@ldcmail.amd.com
Subject: Re: [PATCH 1/3] Base support for AMD Geode GX/LX processors.
Message-Id: <20051215133615.588d7e80.akpm@osdl.org>
In-Reply-To: <20051215211248.GE11054@cosmic.amd.com>
References: <20051215211248.GE11054@cosmic.amd.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jordan Crouse" <jordan.crouse@amd.com> wrote:
>
> +static void __init init_nsc(struct cpuinfo_x86 *c)
> +{
> +	int r;
> +
> +	/* There may be GX1 processors in the wild that are branded
> +	 * NSC and not Cyrix.
> +	 *
> +	 * This function only handles the GX processor, and kicks every
> +	 * thing else to the Cyrix init function above - that should
> +	 * cover any processors that might have been branded differently
> +	 * after NSC aquired Cyrix.
> +	 *
> +	 * If this breaks your GX1 horribly, please e-mail
> +	 * info-linux@ldcmail.amd.com to tell us.
> +	 */
> +
> +	/* Handle the GX (Formally known as the GX2) */
> +
> +	if ((c->x86 == 5) && (c->x86_model == 5)) {
> +		r = get_model_name(c);
> +		display_cacheinfo(c);
> +	}
> +	else
> +		init_cyrix(c);
> +}

What's `r' doing there?

How's this look?


From: Andrew Morton <akpm@osdl.org>

- coding style fixes

- remove unused variable.

- init_nsc() must be __devinit else it'll crash during x86 fake hotplugging.
  Which swsusp uses.

Cc: Jordan Crouse <jordan.crouse@amd.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/cpu/amd.c   |    4 +---
 arch/i386/kernel/cpu/cyrix.c |   15 +++++----------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff -puN arch/i386/kernel/cpu/amd.c~base-support-for-amd-geode-gx-lx-processors-tidy arch/i386/kernel/cpu/amd.c
--- 25/arch/i386/kernel/cpu/amd.c~base-support-for-amd-geode-gx-lx-processors-tidy	Thu Dec 15 13:33:50 2005
+++ 25-akpm/arch/i386/kernel/cpu/amd.c	Thu Dec 15 13:33:50 2005
@@ -162,14 +162,12 @@ static void __init init_amd(struct cpuin
 				break;
 			}
 
-			if ( c->x86_model == 10 ) {
+			if (c->x86_model == 10) {
 				/* AMD Geode LX is model 10 */
 				/* placeholder for any needed mods */
 				break;
 			}
-
 			break;
-
 		case 6: /* An Athlon/Duron */
  
 			/* Bit 15 of Athlon specific MSR 15, needs to be 0
diff -puN arch/i386/kernel/cpu/cyrix.c~base-support-for-amd-geode-gx-lx-processors-tidy arch/i386/kernel/cpu/cyrix.c
--- 25/arch/i386/kernel/cpu/cyrix.c~base-support-for-amd-geode-gx-lx-processors-tidy	Thu Dec 15 13:33:50 2005
+++ 25-akpm/arch/i386/kernel/cpu/cyrix.c	Thu Dec 15 13:35:25 2005
@@ -342,13 +342,11 @@ static void __init init_cyrix(struct cpu
 	return;
 }
 
-
-/* This function handles National Semiconductor branded processors */
-
-static void __init init_nsc(struct cpuinfo_x86 *c)
+/*
+ * Handle National Semiconductor branded processors
+ */
+static void __devinit init_nsc(struct cpuinfo_x86 *c)
 {
-	int r;
-
 	/* There may be GX1 processors in the wild that are branded
 	 * NSC and not Cyrix.
 	 *
@@ -363,15 +361,12 @@ static void __init init_nsc(struct cpuin
 
 	/* Handle the GX (Formally known as the GX2) */
 
-	if ((c->x86 == 5) && (c->x86_model == 5)) {
-		r = get_model_name(c);
+	if (c->x86 == 5 && c->x86_model == 5)
 		display_cacheinfo(c);
-	}
 	else
 		init_cyrix(c);
 }
 
-
 /*
  * Cyrix CPUs without cpuid or with cpuid not yet enabled can be detected
  * by the fact that they preserve the flags across the division of 5/2.
_

