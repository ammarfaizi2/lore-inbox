Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWEOGpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWEOGpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 02:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWEOGpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 02:45:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41357 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932344AbWEOGpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 02:45:53 -0400
Date: Sun, 14 May 2006 23:44:18 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       Christian.Limpach@cl.cam.ac.uk, xen-devel@lists.xensource.com,
       ian.pratt@xensource.com, zaitcev@redhat.com
Subject: Re: [RFC PATCH 08/35] Add Xen-specific memory management
 definitions
Message-Id: <20060514234418.65656de9.zaitcev@redhat.com>
In-Reply-To: <20060509085151.047254000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
	<20060509085151.047254000@sous-sol.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 May 2006 00:00:08 -0700, Chris Wright <chrisw@sous-sol.org> wrote:

I'm a little concerned with the code below being entirely too smart:

> +static inline unsigned long mfn_to_pfn(unsigned long mfn)
> +{
> +#ifndef CONFIG_XEN_SHADOW_MODE
> +	unsigned long pfn;
> +
> +	if (xen_feature(XENFEAT_auto_translated_physmap))
> +		return mfn;
> +
> +	/*
> +	 * The array access can fail (e.g., device space beyond end of RAM).
> +	 * In such cases it doesn't matter what we return (we return garbage),
> +	 * but we must handle the fault without crashing!
> +	 */
> +	asm (
> +		"1:	movl %1,%0\n"
> +		"2:\n"
> +		".section __ex_table,\"a\"\n"
> +		"	.align 4\n"
> +		"	.long 1b,2b\n"
> +		".previous"
> +		: "=r" (pfn) : "m" (machine_to_phys_mapping[mfn]) );
> +
> +	return pfn;
> +#else
> +	return mfn;
> +#endif
> +}

I found that if someone tries to use this too early, hypervisor terminates
the domain with a message like this:

(XEN) DOM0: (file=mm.c, line=486) Non-privileged attempt to map I/O space 000fec00

Why can't we use something like this, only a proper number of machine
pages:

diff -urp -X dontdiff linux-2.6.15-1.2054_FC5/include/asm-x86_64/mach-xen/asm/page.h linux-2.6.15-1.2054_FC5.z3/include/asm-x86_64/mach-xen/asm/page.h
--- linux-2.6.15-1.2054_FC5/include/asm-x86_64/mach-xen/asm/page.h	2006-03-17 17:52:38.000000000 -0800
+++ linux-2.6.15-1.2054_FC5.z3/include/asm-x86_64/mach-xen/asm/page.h	2006-05-11 20:36:16.000000000 -0700
@@ -101,26 +101,11 @@ static inline int phys_to_machine_mappin
 
 static inline unsigned long mfn_to_pfn(unsigned long mfn)
 {
-	unsigned long pfn;
-
 	if (xen_feature(XENFEAT_auto_translated_physmap))
 		return mfn;
-
-	/*
-	 * The array access can fail (e.g., device space beyond end of RAM).
-	 * In such cases it doesn't matter what we return (we return garbage),
-	 * but we must handle the fault without crashing!
-	 */
-	asm (
-		"1:	movq %1,%0\n"
-		"2:\n"
-		".section __ex_table,\"a\"\n"
-		"	.align 8\n"
-		"	.quad 1b,2b\n"
-		".previous"
-		: "=r" (pfn) : "m" (machine_to_phys_mapping[mfn]) );
-
-	return pfn;
+	if (mfn >= 1048576)	/* 4GB _machine_ RAM. XXX How to find out? */
+		return ~0;
+	return machine_to_phys_mapping[mfn];
 }
 
 /*

I'm sure you considered this, but decided to be tricky. Why?
No way to find the safe number of machine pages in a guest?

-- Pete
