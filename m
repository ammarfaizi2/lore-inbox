Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWFUOLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWFUOLq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWFUOLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:11:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39395 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750827AbWFUOLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:11:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Mark Maule <maule@sgi.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Shaohua Li <shaohua.li@intel.com>,
       Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
Subject: [PATCH] Decouple IRQ issues (fix i386 compile issues)
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
	<20060620173017.A10402@unix-os.sc.intel.com>
Date: Wed, 21 Jun 2006 08:10:44 -0600
In-Reply-To: <20060620173017.A10402@unix-os.sc.intel.com> (Rajesh Shah's
	message of "Tue, 20 Jun 2006 17:30:18 -0700")
Message-ID: <m1hd2e7g63.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Shah <rajesh.shah@intel.com> writes:

> On Tue, Jun 20, 2006 at 04:24:35PM -0600, Eric W. Biederman wrote:
>> 
>> The primary aim of this patch is to remove maintenances problems caused
>> by the irq infrastructure.  The two big issues I address are an
>> artificially small cap on the number of irqs, and that MSI assumes
>> vector == irq.  My primary focus is on x86_64 but I have touched
>> other architectures where necessary to keep them from breaking.
>> 
> The MSI portions of this patchset is similar to the MSI cleanup
> I was working on. I'll drop my patchkit and instead comment on
> the relevant patches in this kit.
>
> I got a couple of minor compile errors on i386 (kernel/io_apic.c).
> I fixed them up by hand and the resulting kernel booted and
> worked with MSI in the limited testing I've done so far.


Somewhere in the final round of cleanups I missed these two
one liners.  This is what it takes to fix the i386 build.

Eric

diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index 18a5c2a..3068cde 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -1173,7 +1173,6 @@ next:
        if (current_vector >= FIRST_SYSTEM_VECTOR) {
                offset++;
                if (!(offset%8)) {
-                       spin_unlock_irqrestore(&vector_lock, flags);
                        return -ENOSPC;
                }
                current_vector = FIRST_DEVICE_VECTOR + offset;
@@ -2460,7 +2459,7 @@ void destroy_irq(unsigned int irq)
 {
        unsigned long flags;
 
-       dynmic_irq_cleanup(irq);
+       dynamic_irq_cleanup(irq);
 
        spin_lock_irqsave(&vector_lock, flags);
        irq_vector[irq] = 0;
