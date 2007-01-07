Return-Path: <linux-kernel-owner+w=401wt.eu-S932520AbXAGMU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbXAGMU2 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 07:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbXAGMU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 07:20:28 -0500
Received: from il.qumranet.com ([62.219.232.206]:48809 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932520AbXAGMU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 07:20:27 -0500
Message-ID: <45A0E586.50806@qumranet.com>
Date: Sun, 07 Jan 2007 14:20:22 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
References: <20070105215223.GA5361@elte.hu>
In-Reply-To: <20070105215223.GA5361@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i'm pleased to announce the first release of paravirtualized KVM (Linux 
> under Linux), which includes support for the hardware cr3-cache feature 
> of Intel-VMX CPUs. (which speeds up context switches and TLB flushes)
>
> the patch is against 2.6.20-rc3 + KVM trunk and can be found at:
>
>    http://redhat.com/~mingo/kvm-paravirt-patches/
>
> Some aspects of the code are still a bit ad-hoc and incomplete, but the 
> code is stable enough in my testing and i'd like to have some feedback. 
>
> Firstly, here are some numbers:
>
> 2-task context-switch performance (in microseconds, lower is better):
>
>  native:                       1.11
>  ----------------------------------
>  Qemu:                        61.18
>  KVM upstream:                53.01
>  KVM trunk:                    6.36
>  KVM trunk+paravirt/cr3:       1.60
>
> i.e. 2-task context-switch performance is faster by a factor of 4, and 
> is now quite close to native speed!
>   

Very impressive!  The gain probably comes not only from avoiding the 
vmentry/vmexit, but also from avoiding the flushing of the global page 
tlb entries.

> "hackbench 1" (utilizes 40 tasks, numbers in seconds, lower is better):
>
>  native:                       0.25
>  ----------------------------------
>  Qemu:                         7.8
>  KVM upstream:                 2.8
>  KVM trunk:                    0.55
>  KVM paravirt/cr3:             0.36
>
> almost twice as fast.
>
> "hackbench 5" (utilizes 200 tasks, numbers in seconds, lower is better):
>
>  native:                       0.9
>  ----------------------------------
>  Qemu:                        35.2
>  KVM upstream:                 9.4
>  KVM trunk:                    2.8
>  KVM paravirt/cr3:             2.2
>
> still a 30% improvement - which isnt too bad considering that 200 tasks 
> are context-switching in this workload and the cr3 cache in current CPUs 
> is only 4 entries.
>   

This is a little too good to be true.  Were both runs with the same 
KVM_NUM_MMU_PAGES?

I'm also concerned that at this point in time the cr3 optimizations will 
only show an improvement in microbenchmarks.  In real life workloads a 
context switch is usually preceded by an I/O, and with the current sorry 
state of kvm I/O the context switch time would be dominated by the I/O time.

> the patchset does the following:
>
> - it provides an ad-hoc paravirtualization hypercall API between a Linux 
>   guest and a Linux host. (this will be replaced with a proper
>   hypercall later on.)
>
> - using the hypercall API it utilizes the "cr3 target cache" feature in 
>   Intel VMX CPUs, and extends KVM to make use of that cache. This 
>   feature allows the avoidance of expensive VM exits into hypervisor 
>   context. (The guest needs to be 'aware' and the cache has to be
>   shared between the guest and the hypervisor. So fully emulated OSs
>   wont benefit from this feature.)
>
> - a few simpler paravirtualization changes are done for Linux guests: IO 
>   port delays do not cause a VM exit anymore, the i8259A IRQ controller 
>   code got simplified (this will be replaced with a proper, hypercall
>   based and host-maintained IRQ controller implementation) and TLB 
>   flushes are more efficient, because no cr3 reads happen which would 
>   otherwise cause a VM exit. These changes have a visible effect
>   already: they reduce qemu's CPU usage when a guest idles in HLT, by 
>   about 25%. (from ~20% CPU usage to 14% CPU usage if an -rt guest has 
>   HZ=1000)
>
> Paravirtualization is triggered via the kvm_paravirt=1 boot option (for 
> now, this too is ad-hoc) - if that is passed then the KVM guest will 
> probe for paravirtualization availability on the hypervisor side - and 
> will use it if found. (If the guest does not find KVM-paravirt support 
> on the hypervisor side then it will continue as a fully emulated guest.)
>
> Issues: i only tested this on 32-bit VMX. (64-bit should work with not 
> too many changes, the paravirt.c bits can be carried over to 64-bit 
> almost as-is. But i didnt want to spread the code too wide.)
>
> Comments, suggestions are welcome!
>
> 	Ingo
>   

Some comments below on the code.

> +
> +/*
> + * Special, register-to-cr3 instruction based hypercall API
> + * variant to the KVM host. This utilizes the cr3 filter capability
> + * of the hardware - if this works out then no VM exit happens,
> + * if a VM exit happens then KVM will get the virtual address too.
> + */
> +static void kvm_write_cr3(unsigned long guest_cr3)
> +{
> +    struct kvm_vcpu_para_state *para_state = &get_cpu_var(para_state);
> +    struct kvm_cr3_cache *cache = &para_state->cr3_cache;
> +    int idx;
> +
> +    /*
> +     * Check the cache (maintained by the host) for a matching
> +     * guest_cr3 => host_cr3 mapping. Use it if found:
> +     */
> +    for (idx = 0; idx < cache->max_idx; idx++) {
> +        if (cache->entry[idx].guest_cr3 == guest_cr3) {
> +            /*
> +             * Cache-hit: we load the cached host-CR3 value.
> +             * This never causes any VM exit. (if it does then the
> +             * hypervisor could do nothing with this instruction
> +             * and the guest OS would be aborted)
> +             */
> +            asm volatile("movl %0, %%cr3"
> +                : : "r" (cache->entry[idx].host_cr3));
> +            goto out;
> +        }
> +    }
> +
> +    /*
> +     * Cache-miss. Load the guest-cr3 value into cr3, which will
> +     * cause a VM exit to the hypervisor, which then loads the
> +     * host cr3 value and updates the cr3_cache.
> +     */
> +    asm volatile("movl %0, %%cr3" : : "r" (guest_cr3));
> +out:
> +    put_cpu_var(para_state);
> +}

Well, you did say it was ad-hoc.  For reference, this is how I see the 
hypercall API:

- A virtual pci device exports a page through the pci rom interface.  
The page contains the hypercall code approriate for the current cpu.  
This allows migration to work across different cpu vendors.
- In case the pci rom is discovered too late in the boot process, the 
address (gpa) can also be exported via a kvm-specific msr.
- Guest/host communications is by guest physical addressed, as the 
virtual->physical translation is much cheaper on the guest (__pa() vs a 
page table walk).


>
> +
> +/*
> + * Simplified i8259A controller handling:
> + */
> +static void mask_and_ack_kvm(unsigned int irq)
> +{
> +    unsigned int irqmask = 1 << irq;
> +    unsigned long flags;
> +
> +    spin_lock_irqsave(&i8259A_lock, flags);
> +    cached_irq_mask |= irqmask;
> +
> +    if (irq & 8) {
> +        outb(cached_slave_mask, PIC_SLAVE_IMR);
> +        outb(0x60+(irq&7),PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
> +        outb(0x60+PIC_CASCADE_IR,PIC_MASTER_CMD); /* 'Specific EOI' 
> to master-IRQ2 */
> +    } else {
> +        outb(cached_master_mask, PIC_MASTER_IMR);
> +        /* 'Specific EOI' to master: */
> +        outb(0x60+irq, PIC_MASTER_CMD);
> +    }
> +    spin_unlock_irqrestore(&i8259A_lock, flags);
> +}

Any reason this can't be applied to mainline?  There's probably no 
downside to native, and it would benefit all virtualization solutions 
equally.

> Index: linux/drivers/kvm/kvm.h
> ===================================================================
> --- linux.orig/drivers/kvm/kvm.h
> +++ linux/drivers/kvm/kvm.h
> @@ -165,7 +165,7 @@ struct kvm_mmu {
>      int root_level;
>      int shadow_root_level;
>  
> -    u64 *pae_root;
> +    u64 *pae_root[KVM_CR3_CACHE_SIZE];

hmm.  wouldn't it be simpler to have pae_root always point at the 
current root?

>
> Index: linux/drivers/kvm/mmu.c
> ===================================================================
> --- linux.orig/drivers/kvm/mmu.c
> +++ linux/drivers/kvm/mmu.c
> @@ -779,7 +779,7 @@ static int nonpaging_map(struct kvm_vcpu
>  
>  static void mmu_free_roots(struct kvm_vcpu *vcpu)
>  {
> -    int i;
> +    int i, j;
>      struct kvm_mmu_page *page;
>  
>  #ifdef CONFIG_X86_64
> @@ -793,21 +793,40 @@ static void mmu_free_roots(struct kvm_vc
>          return;
>      }
>  #endif
> -    for (i = 0; i < 4; ++i) {
> -        hpa_t root = vcpu->mmu.pae_root[i];
> +    /*
> +     * Skip to the next cr3 filter entry and free it (if it's occupied):
> +     */
> +    vcpu->cr3_cache_idx++;
> +    if (unlikely(vcpu->cr3_cache_idx >= vcpu->cr3_cache_limit))
> +        vcpu->cr3_cache_idx = 0;
>  
> -        ASSERT(VALID_PAGE(root));
> -        root &= PT64_BASE_ADDR_MASK;
> -        page = page_header(root);
> -        --page->root_count;
> -        vcpu->mmu.pae_root[i] = INVALID_PAGE;
> +    j = vcpu->cr3_cache_idx;
> +    /*
> +     * Clear the guest-visible entry:
> +     */
> +    if (vcpu->para_state) {
> +        vcpu->para_state->cr3_cache.entry[j].guest_cr3 = 0;
> +        vcpu->para_state->cr3_cache.entry[j].host_cr3 = 0;
> +    }
> +    ASSERT(vcpu->mmu.pae_root[j]);
> +    if (VALID_PAGE(vcpu->mmu.pae_root[j][0])) {
> +        vcpu->guest_cr3_gpa[j] = INVALID_PAGE;
> +        for (i = 0; i < 4; ++i) {
> +            hpa_t root = vcpu->mmu.pae_root[j][i];
> +
> +            ASSERT(VALID_PAGE(root));
> +            root &= PT64_BASE_ADDR_MASK;
> +            page = page_header(root);
> +            --page->root_count;
> +            vcpu->mmu.pae_root[j][i] = INVALID_PAGE;
> +        }
>      }
>      vcpu->mmu.root_hpa = INVALID_PAGE;
>  }

You keep the page directories pinned here.  This can be a problem if a 
guest frees a page directory, and then starts using it as a regular 
page.  kvm sometimes chooses not to emulate a write to a guest page 
table, but instead to zap it, which is impossible when the page is 
freed.  You need to either unpin the page when that happens, or add a 
hypercall to let kvm know when a page directory is freed.

There is also a minor problem that changes to the pgd aren't caught by 
kvm.  It doesn't hurt much as this is PV and we can relax the guest/host 
contract a little.


>
>  static int alloc_mmu_pages(struct kvm_vcpu *vcpu)
>  {
>      struct page *page;
> -    int i;
> +    int i, j;
>  
>      ASSERT(vcpu);
>  
> @@ -1227,17 +1261,22 @@ static int alloc_mmu_pages(struct kvm_vc
>          ++vcpu->kvm->n_free_mmu_pages;
>      }
>  
> -    /*
> -     * When emulating 32-bit mode, cr3 is only 32 bits even on x86_64.
> -     * Therefore we need to allocate shadow page tables in the first
> -     * 4GB of memory, which happens to fit the DMA32 zone.
> -     */
> -    page = alloc_page(GFP_KERNEL | __GFP_DMA32);
> -    if (!page)
> -        goto error_1;
> -    vcpu->mmu.pae_root = page_address(page);
> -    for (i = 0; i < 4; ++i)
> -        vcpu->mmu.pae_root[i] = INVALID_PAGE;
> +    for (j = 0; j < KVM_CR3_CACHE_SIZE; j++) {
> +        /*
> +         * When emulating 32-bit mode, cr3 is only 32 bits even on
> +         * x86_64. Therefore we need to allocate shadow page tables
> +         * in the first 4GB of memory, which happens to fit the DMA32
> +         * zone:
> +         */
> +        page = alloc_page(GFP_KERNEL | __GFP_DMA32);
> +        if (!page)
> +            goto error_1;
> +
> +        ASSERT(!vcpu->mmu.pae_root[j]);
> +        vcpu->mmu.pae_root[j] = page_address(page);
> +        for (i = 0; i < 4; ++i)
> +            vcpu->mmu.pae_root[j][i] = INVALID_PAGE;
> +    }

Since a pae root uses just 32 bytes, you can store all cache entries in 
a single page.  Not that it matters much.

>  #define ENABLE_INTERRUPTS_SYSEXIT            \
> Index: linux/include/linux/kvm.h
> ===================================================================
> --- linux.orig/include/linux/kvm.h
> +++ linux/include/linux/kvm.h
> @@ -238,4 +238,44 @@ struct kvm_dirty_log {
>  
>  #define KVM_DUMP_VCPU             _IOW(KVMIO, 250, int /* vcpu_slot */)
>  
> +
> +#define KVM_CR3_CACHE_SIZE    4
> +
> +struct kvm_cr3_cache_entry {
> +    u64 guest_cr3;
> +    u64 host_cr3;
> +};
> +
> +struct kvm_cr3_cache {
> +    struct kvm_cr3_cache_entry entry[KVM_CR3_CACHE_SIZE];
> +    u32 max_idx;
> +};
> +
> +/*
> + * Per-VCPU descriptor area shared between guest and host. Writable to
> + * both guest and host. Registered with the host by the guest when
> + * a guest acknowledges paravirtual mode.
> + */
> +struct kvm_vcpu_para_state {
> +    /*
> +     * API version information for compatibility. If there's any support
> +     * mismatch (too old host trying to execute too new guest) then
> +     * the host will deny entry into paravirtual mode. Any other
> +     * combination (new host + old guest and new host + new guest)
> +     * is supposed to work - new host versions will support all old
> +     * guest API versions.
> +     */
> +    u32 guest_version;
> +    u32 host_version;
> +    u32 size;
> +    u32 __pad_00;
> +
> +    struct kvm_cr3_cache cr3_cache;
> +
> +} __attribute__ ((aligned(PAGE_SIZE)));
> +
> +#define KVM_PARA_API_VERSION 1
> +
> +#define KVM_API_MAGIC 0x87654321
> +

<linux/kvm.h> is the vmm userspace interface.  The guest/host interface 
should probably go somewhere else.

-- 
error compiling committee.c: too many arguments to function

