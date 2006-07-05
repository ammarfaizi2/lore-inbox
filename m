Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbWGEWrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWGEWrD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 18:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWGEWrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 18:47:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52149 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965038AbWGEWrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 18:47:02 -0400
Date: Wed, 5 Jul 2006 15:50:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Keith Mannthey" <kmannth@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-Id: <20060705155037.7228aa48.akpm@osdl.org>
In-Reply-To: <a762e240607051447x3c3c6e15k9cdb38804cf13f35@mail.gmail.com>
References: <20060703030355.420c7155.akpm@osdl.org>
	<a762e240607051447x3c3c6e15k9cdb38804cf13f35@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Keith Mannthey" <kmannth@gmail.com> wrote:
>
> On 7/3/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
> >
> >
> 
> Moving from -mm4 to -mm6 I ran into this while trying to boot....
> <snip>
> Could not allocate 16 bytes percpu data
> Could not allocate 16 bytes percpu data
> sd_mod: Unknown symbol scsi_print_sense_hdr
> sd_mod: Unknown symbol scsi_mode_sense
> sd_mod: Unknown symbol scsi_device_get
> sd_mod: Unknown symbol scsi_get_sense_info_fld
> <snip>
> 
> sd_mod (and later aacraid) are built into my initrd and loaded during boot.
> 
> I doubled PERCPU_ENOUGH_ROOM to 65536 and was able to boot.  I am not
> sure what is eating all the percpu room on the system.  I was using
> this config with -mm4 just fine.
> 
> I attached the dmesg and .config
> 

Looks like we simply ran out.  Why?...

patches/genirq-x86_64-irq-make-vector_irq-per-cpu.patch:+DEFINE_PER_CPU(vector_irq_t, vector_irq) = {
patches/mm-implement-swap-prefetching.patch:+static DEFINE_PER_CPU(struct pagevec, lru_add_tail_pvecs) = { 0, };
patches/origin.patch:+static DEFINE_PER_CPU(u64 *, tce_page) = NULL;
patches/origin.patch:+DEFINE_PER_CPU(struct sys_device, device_mce);
patches/origin.patch:+static DEFINE_PER_CPU(struct threshold_bank *, threshold_banks[NR_BANKS]);
patches/origin.patch:+static DEFINE_PER_CPU(struct rq, runqueues);
patches/origin.patch:+DEFINE_PER_CPU(struct vm_event_state, vm_event_states) = {{0}};
patches/per-task-delay-accounting-taskstats-interface.patch:+static DEFINE_PER_CPU(__u32, taskstats_seqnum) = { 0 };
patches/readahead-state-based-method-aging-accounting.patch:+DEFINE_PER_CPU(unsigned long, readahead_aging);
patches/x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch:+static DEFINE_PER_CPU(unsigned long, perfctr_nmi_owner);
patches/x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch:+static DEFINE_PER_CPU(unsigned long, evntsel_nmi_owner[3]);
patches/x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch:+static DEFINE_PER_CPU(unsigned, perfctr_nmi_owner);
patches/x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch:+static DEFINE_PER_CPU(unsigned, evntsel_nmi_owner[2]);
patches/x86_64-mm-add-smp-support-on-i386-to-reservation-framework.patch:+static DEFINE_PER_CPU(struct nmi_watchdog_ctlblk, nmi_watchdog_ctlblk);
patches/x86_64-mm-add-smp-support-on-x86_64-to-reservation-framework.patch:+static DEFINE_PER_CPU(struct nmi_watchdog_ctlblk, nmi_watchdog_ctlblk);

Per-cpuifying the 2.5 kbyte runqueue struct will have hurt.

[does readelf --section-headers drivers/scsi/sd_mod.ko, wonders why
.data.percpu isn't there]

Are you able to add this, see if we can work out where it all went?

--- a/kernel/module.c~a
+++ a/kernel/module.c
@@ -340,6 +340,9 @@ static void *percpu_modalloc(unsigned lo
 	unsigned int i;
 	void *ptr;
 
+	printk("%s: allocating %lu bytes for module %s (vmlinux:%lu)\n",
+		__FUNCTION__, size, name, block_size(pcpu_size[0]));
+
 	if (align > SMP_CACHE_BYTES) {
 		printk(KERN_WARNING "%s: per-cpu alignment %li > %i\n",
 		       name, align, SMP_CACHE_BYTES);
_

