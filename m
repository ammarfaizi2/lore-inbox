Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVFTXFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVFTXFk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVFTXDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:03:50 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:4700 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261288AbVFTW4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:56:33 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 6/8] UML - Kill some useless vmalloc tlb flushing
Date: Tue, 21 Jun 2005 01:01:16 +0200
User-Agent: KMail/1.8.1
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <200506201851.j5KIpKPr008499@ccure.user-mode-linux.org>
In-Reply-To: <200506201851.j5KIpKPr008499@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506210101.17338.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 June 2005 20:51, Jeff Dike wrote:
> There is absolutely no reason to flush the kernel's VM area during a
> tlb_flush_mm.
>
> This results in a noticable performance increase in the kernel build
> benchmark.
Andrew: hold off this one, definitely.

Jeff: Have you verified this with both modules enabled and iptables (a vmalloc 
user) compiled modularly? Maybe even non-modular iptables will trigger the 
bug but let's go for sure.

This situation killed a conceptually similar patch in 2.4.24-2um (which did 
apply until 2.6.11):

diff -puN arch/um/kernel/skas/tlb.c~optimization-unstable 
arch/um/kernel/skas/tlb.c
--- UmWorklinux-2.4.24/arch/um/kernel/skas/tlb.c~optimization-unstable  
2004-07-02 13:45:07.057643968 +0200
+++ UmWorklinux-2.4.24-paolo/arch/um/kernel/skas/tlb.c  2004-07-02 
13:45:14.098573584 +0200
@@ -132,7 +132,9 @@ void flush_tlb_range_skas(struct mm_stru

 void flush_tlb_mm_skas(struct mm_struct *mm)
 {
+#if 0
        flush_tlb_kernel_vm_skas();
+#endif
        fix_range(mm, 0, host_task_size, 0);
 }

Given that:

void flush_tlb_kernel_vm_skas(void)
{
        flush_tlb_kernel_range_skas(start_vm, end_vm);
}

and flush_tlb_kernel_range_skas was renamed to _common, I argue that this 
patch is exactly the same one and will have the same bad effect.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>
> Index: linux-2.6.12/arch/um/kernel/skas/tlb.c
> ===================================================================
> --- linux-2.6.12.orig/arch/um/kernel/skas/tlb.c	2005-06-20
> 11:54:56.000000000 -0400 +++
> linux-2.6.12/arch/um/kernel/skas/tlb.c	2005-06-20 12:11:00.000000000 -0400
> @@ -76,7 +76,6 @@ void flush_tlb_mm_skas(struct mm_struct
>                  return;
>
>          fix_range(mm, 0, host_task_size, 0);
> -        flush_tlb_kernel_range_common(start_vm, end_vm);
>  }
>
>  void force_flush_all_skas(void)

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
