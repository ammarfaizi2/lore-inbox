Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVAQHiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVAQHiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 02:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVAQHiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 02:38:55 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:49595 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262721AbVAQHiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 02:38:13 -0500
Date: Sun, 16 Jan 2005 23:38:09 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH] __get_cpu_var should use __smp_processor_id() not smp_processor_id()
Message-ID: <20050117073809.GA3654@taniwha.stupidest.org>
References: <20050117055044.GA3514@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117055044.GA3514@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 09:50:44PM -0800, Chris Wedgwood wrote:

> Note, even with this removed I'm still seeing a few (many actually)
> "BUG: using smp_processor_id() in preemptible [00000001] code: xxx"
> messages which I've not seen before --- that might be unrelated but
> I do see *many* such messages so I'm sure I would have noticed this
> before or it would have broken something earlier.

Actually, it is unrelated.  Proposed fix:

---

It seems logical that __get_cpu_var should use __smp_processor_id()
rather than smp_processor_id().  Noticed when __get_cpu_var was making
lots of noise with CONFIG_DEBUG_PREEMPT=y

Signed-off-by: Chris Wedgwood <cw@f00f.org>



===== include/asm-generic/percpu.h 1.10 vs edited =====
--- 1.10/include/asm-generic/percpu.h	2004-01-18 22:28:34 -08:00
+++ edited/include/asm-generic/percpu.h	2005-01-16 22:32:07 -08:00
@@ -13,7 +13,7 @@ extern unsigned long __per_cpu_offset[NR
 
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
-#define __get_cpu_var(var) per_cpu(var, smp_processor_id())
+#define __get_cpu_var(var) per_cpu(var, __smp_processor_id())
 
 /* A macro to avoid #include hell... */
 #define percpu_modcopy(pcpudst, src, size)			\
