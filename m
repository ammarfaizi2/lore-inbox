Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbWGEX2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWGEX2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWGEX2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:28:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:38186 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965042AbWGEX2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:28:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XZn0/XW9fdKbV+tLCvgWSIWDR+QA1B42F5F34FYx2iBKOWmFq5re09RnHCqQTgJsVurArlGENsshpmcOX4orCkJC4ljVk80Xv0DzkwTZJfE03j3rUctW3EJ4g8gMDWst9F1fLKgU6F8BNZ3ENumwvhBEDaH3wiAE1x+Fqhw3nZE=
Message-ID: <a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com>
Date: Wed, 5 Jul 2006 16:28:39 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm6
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060705155037.7228aa48.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060703030355.420c7155.akpm@osdl.org>
	 <a762e240607051447x3c3c6e15k9cdb38804cf13f35@mail.gmail.com>
	 <20060705155037.7228aa48.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/06, Andrew Morton <akpm@osdl.org> wrote:
> "Keith Mannthey" <kmannth@gmail.com> wrote:
> >
> > On 7/3/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
> > >
> > >
> >
> > Moving from -mm4 to -mm6 I ran into this while trying to boot....
> > <snip>
> > Could not allocate 16 bytes percpu data
> > Could not allocate 16 bytes percpu data
> > sd_mod: Unknown symbol scsi_print_sense_hdr
> > sd_mod: Unknown symbol scsi_mode_sense
> > sd_mod: Unknown symbol scsi_device_get
> > sd_mod: Unknown symbol scsi_get_sense_info_fld
> > <snip>
> >
> > sd_mod (and later aacraid) are built into my initrd and loaded during boot.
> >
> > I doubled PERCPU_ENOUGH_ROOM to 65536 and was able to boot.  I am not
> > sure what is eating all the percpu room on the system.  I was using
> > this config with -mm4 just fine.
> >
> > I attached the dmesg and .config
> >
>
> Looks like we simply ran out.  Why?...
>
> patches/genirq-x86_64-irq-make-vector_irq-per-cpu.patch:+DEFINE_PER_CPU(vector_irq_t, vector_irq) = {
> patches/mm-implement-swap-prefetching.patch:+static DEFINE_PER_CPU(struct pagevec, lru_add_tail_pvecs) = { 0, };
> patches/origin.patch:+static DEFINE_PER_CPU(u64 *, tce_page) = NULL;
> patches/origin.patch:+DEFINE_PER_CPU(struct sys_device, device_mce);
> patches/origin.patch:+static DEFINE_PER_CPU(struct threshold_bank *, threshold_banks[NR_BANKS]);
> patches/origin.patch:+static DEFINE_PER_CPU(struct rq, runqueues);
> patches/origin.patch:+DEFINE_PER_CPU(struct vm_event_state, vm_event_states) = {{0}};
> patches/per-task-delay-accounting-taskstats-interface.patch:+static DEFINE_PER_CPU(__u32, taskstats_seqnum) = { 0 };
> patches/readahead-state-based-method-aging-accounting.patch:+DEFINE_PER_CPU(unsigned long, readahead_aging);
> patches/x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch:+static DEFINE_PER_CPU(unsigned long, perfctr_nmi_owner);
> patches/x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch:+static DEFINE_PER_CPU(unsigned long, evntsel_nmi_owner[3]);
> patches/x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch:+static DEFINE_PER_CPU(unsigned, perfctr_nmi_owner);
> patches/x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch:+static DEFINE_PER_CPU(unsigned, evntsel_nmi_owner[2]);
> patches/x86_64-mm-add-smp-support-on-i386-to-reservation-framework.patch:+static DEFINE_PER_CPU(struct nmi_watchdog_ctlblk, nmi_watchdog_ctlblk);
> patches/x86_64-mm-add-smp-support-on-x86_64-to-reservation-framework.patch:+static DEFINE_PER_CPU(struct nmi_watchdog_ctlblk, nmi_watchdog_ctlblk);
>
> Per-cpuifying the 2.5 kbyte runqueue struct will have hurt.
>
> [does readelf --section-headers drivers/scsi/sd_mod.ko, wonders why
> .data.percpu isn't there]

hmm.  There is no message from the readelf command but there it dosen't
report any  .data.percpu area.  The only sections for data are just .data  and
.rela.data

> Are you able to add this, see if we can work out where it all went?

I am still booting with the larger percpu size but I see

percpu_modalloc: allocating 16 bytes for module scsi_mod (vmlinux:41600)
percpu_modalloc: allocating 8 bytes for module ipv6 (vmlinux:41600)

from the log.  Something built in is eating it.

I am turing off the readhead to see if that helps.

Thanks,
  Keith
