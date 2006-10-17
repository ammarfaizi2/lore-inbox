Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWJQSNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWJQSNQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWJQSNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:13:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29339 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750740AbWJQSNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:13:15 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       <linux-kernel@vger.kernel.org>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Yinghai Lu <yinghai.lu@amd.com>
Subject: [PATCH] x86_64: Put more than one cpu in TARGET_CPUS
References: <m13b9makht.fsf@ebiederm.dsl.xmission.com>
	<m1y7re95o1.fsf@ebiederm.dsl.xmission.com>
Date: Tue, 17 Oct 2006 12:11:27 -0600
In-Reply-To: <m1y7re95o1.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Tue, 17 Oct 2006 12:08:14 -0600")
Message-ID: <m1u02295io.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


TARGET_CPUS is the default irq routing poicy.  It specifies which cpus
the kernel should aim an irq at.  In physflat delivery mode we can
route an irq to a single cpu.  But that doesn't mean our default
policy should only be a single cpu is allowed. 

By allowing the irq routing code to select from multiple cpus this
enables systems with more irqs then we can service on a single
processor to actually work. 

I just audited and tested the code and irqbalance doesn't care, and
the io_apic.c doesn't care if we have extra cpus in the mask.
Everything will use or assume we are using the lowest numbered cpu in
the mask if we can't use them all.

So this should result in no behavior changes except on systems that need it.

Thanks for YH Lu for spotting this problem in his testing.

Cc: Yinghai Lu <yinghai.lu@amd.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/genapic_flat.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/kernel/genapic_flat.c b/arch/x86_64/kernel/genapic_flat.c
index 0dfc223..7c01db8 100644
--- a/arch/x86_64/kernel/genapic_flat.c
+++ b/arch/x86_64/kernel/genapic_flat.c
@@ -153,7 +153,7 @@ struct genapic apic_flat =  {
 
 static cpumask_t physflat_target_cpus(void)
 {
-	return cpumask_of_cpu(0);
+	return cpu_online_map;
 }
 
 static cpumask_t physflat_vector_allocation_domain(int cpu)
-- 
1.4.2.rc3.g7e18e-dirty

