Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUGSGCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUGSGCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 02:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUGSGCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 02:02:43 -0400
Received: from ozlabs.org ([203.10.76.45]:31953 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264702AbUGSGCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 02:02:40 -0400
Date: Mon, 19 Jul 2004 15:55:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: page align emergency stack
Message-ID: <20040719055542.GC11586@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
References: <20040715145708.GG27715@krispykreme> <20040716004729.GA24753@zax> <20040716011141.GC17574@krispykreme> <20040716013901.GC24753@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040716013901.GC24753@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 11:39:01AM +1000, David Gibson wrote:
> 
> On Fri, Jul 16, 2004 at 11:11:41AM +1000, Anton Blanchard wrote:
> >
> >
> > > Do we actually need to do this?  I noted that the old guard pages were
> > > page aligned, but couldn't see any particular reason for it, so I
> > > didn't transfer the alignment to the new version.
> >
> > The ABI requires us to have 128 bit alignment doesnt it? Im thinking
> > about what would happen if we saved altivec registers to the stack.
> 
> Ok, that's not quite the same thing as page alignment...

Ok, here's a patch that just applies the weaker 128-byte alignment
constraint.

Andrew, please apply

The PPC64 ABI requires the stack to be 128 byte aligned (and that can
become important if AltiVec registers are saved there).  In the
kernel, that's usually dealt with by the fact that the stack has a
page more-or-less to itself.  However, the emergency stacks (used in
SMP bringup and when we detect a bad stack pointer) aren't necessarily
page aligned, or anything aligned for that matter.  This patch applies
the necessary alignement constraint to them.

Signed-off-by: David Gibson <dwg@au.ibm.com>

Index: working-2.6/arch/ppc64/kernel/pacaData.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/pacaData.c
+++ working-2.6/arch/ppc64/kernel/pacaData.c
@@ -29,8 +29,10 @@
 
 /* Stack space used when we detect a bad kernel stack pointer, and
  * early in SMP boots before relocation is enabled.
+ *
+ * ABI requires stack to be 128-byte aligned
  */
-char emergency_stack[PAGE_SIZE * NR_CPUS];
+char emergency_stack[PAGE_SIZE * NR_CPUS] __attribute__((aligned(128)));
 
 /* The Paca is an array with one entry per processor.  Each contains an 
  * ItLpPaca, which contains the information shared between the 

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
