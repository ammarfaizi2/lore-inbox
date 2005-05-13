Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVEMX0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVEMX0J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVEMXZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:25:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29658 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262483AbVEMXX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:23:58 -0400
Date: Fri, 13 May 2005 19:23:57 -0400
From: Dave Jones <davej@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86 MTRR handling
Message-ID: <20050513232357.GB13846@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <s2832b02.028@emea1-mh.id2.novell.com> <20050512161825.GC17618@redhat.com> <20050512214118.GA25065@redhat.com> <42852CE2.4090102@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42852CE2.4090102@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 03:40:34PM -0700, H. Peter Anvin wrote:
 > Dave Jones wrote:
 > 
 > >+	switch (boot_cpu_data.x86_vendor) {
 > >+	case X86_VENDOR_AMD:
 > >+		wrmsr(IA32_CR_PAT, AMD_PAT_31_0, AMD_PAT_63_32);
 > >+		atomic_inc(&pat_cpus_enabled);
 > >+		break;
 > >+	case X86_VENDOR_INTEL:
 > >+		wrmsr(IA32_CR_PAT, INTEL_PAT_31_0, INTEL_PAT_63_32);
 > >+		atomic_inc(&pat_cpus_enabled);
 > >+		break;
 > >+	default:
 > >+		printk("Unknown vendor in setup_pat()\n");
 > >+	}
 > 
 > Drop the vendor check; PAT is a generic x86 feature.  If AMD is not 
 > compatible (see below), then use X86_VENDOR_AMD: and default:.

Done. Does transmeta have PAT btw ? I know newer VIA has it,
but I haven't looked through the docs to double check its
implementation yet.

 > >+	/* checks copied from arch/i386/kernel/cpu/mtrr/main.c */
 > >+	/* do these only apply to mtrrs or pat as well? */
 > 
 > It would apply to both; the chipset wouldn't even know how it got invoked.

ACK, Comment dropped.

 > >+/* Here is the PAT's default layout on ia32 cpus when we are done.
 > >+ * PAT0: Write Back
 > >+ * PAT1: Write Combine
 > >+ * PAT2: Uncached
 > >+ * PAT3: Uncacheable
 > >+ * PAT4: Write Through
 > >+ * PAT5: Write Protect
 > >+ * PAT6: Uncached
 > >+ * PAT7: Uncacheable
 > 
 > Bad move.  Some (Intel) processors drop the top bit, so it's much better 
 > to pick the protection methods one cares about (usually WB, WC, UC) and 
 > stick them in the first four, then duplicate the whole thing in the 
 > second half.

Noted.

 > >+ * Note: On Athlon cpus PAT2/PAT3 & PAT6/PAT7 are both Uncacheable since 
 > >+ *	 there is no uncached type.
 > If one sets the PAT to "uncached", does one get the same function as 
 > "uncachable"?

AIUI, only as long as we don't have an MTRR covering the same range marked WC.
It seems to be the only thing I could find documenting the differences
between 'uncached' and 'uncacheable' in this context.
Though I've only looked through the Intel & AMD K8 docs, I don't have
the K7 ones to hand.

		Dave

