Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWJWU3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWJWU3B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWJWU3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:29:01 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:37477 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1751202AbWJWU27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:28:59 -0400
Message-ID: <453D2604.5010208@qumranet.com>
Date: Mon, 23 Oct 2006 22:28:52 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/13] KVM: virtualization infrastructure
References: <453CC390.9080508@qumranet.com> <20061023133026.92C9F250143@cleopatra.q> <200610232135.02684.arnd@arndb.de>
In-Reply-To: <200610232135.02684.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Oct 2006 20:28:58.0682 (UTC) FILETIME=[DE7371A0:01C6F6E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Monday 23 October 2006 15:30, Avi Kivity wrote:
>   
>> - ioctl()
>> - mmap()
>> - vcpu context management (vcpu_load/vcpu_put)
>> - some control register logic
>>     
>
> Let me comment on coding style for now, I might come back with
> contents when I understand more of the code.
>
>   
>> +static struct dentry *debugfs_dir;
>> +static struct dentry *debugfs_pf_fixed;
>> +static struct dentry *debugfs_pf_guest;
>> +static struct dentry *debugfs_tlb_flush;
>> +static struct dentry *debugfs_invlpg;
>> +static struct dentry *debugfs_exits;
>> +static struct dentry *debugfs_io_exits;
>> +static struct dentry *debugfs_mmio_exits;
>> +static struct dentry *debugfs_signal_exits;
>> +static struct dentry *debugfs_irq_exits;
>>     
>
> How about making these an array?
>   

Okay.

>   
>> +static int rmode_tss_base(struct kvm* kvm);
>> +static void set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
>> +static void __set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
>> +static void lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
>> +static void set_cr3(struct kvm_vcpu *vcpu, unsigned long cr0);
>> +static void set_cr4(struct kvm_vcpu *vcpu, unsigned long cr0);
>> +static void __set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
>> +#ifdef __x86_64__
>> +static void __set_efer(struct kvm_vcpu *vcpu, u64 efer);
>> +#endif
>>     
>
> In general, you should try to avoid forward declarations for
> static functions. The expected reading order is that static
> functions are called only from other functions below them
> in the same file, or through callbacks.
>
>   

Okay.

>> +struct descriptor_table {
>> +	u16 limit;
>> +	unsigned long base;
>> +} __attribute__((packed));
>>     
>
> Is this a hardware structure? If not, packing it only
> make accesses rather inefficient.
>
>   

It is a hardware structure.

>> +static void get_gdt(struct descriptor_table *table)
>> +{
>> +	asm ( "sgdt %0" : "=m"(*table) );
>> +}
>>     
>
> Spacing:
>
> 	asm ("sgdt %0" : "=m" (*table));
>
>   

Ouch.  Will fix.

>> +static void load_fs(u16 sel)
>> +{
>> +	asm ( "mov %0, %%fs\n" : : "g"(sel) );
>> +}
>> +
>> +static void load_gs(u16 sel)
>> +{
>> +	asm ( "mov %0, %%gs\n" : : "g"(sel) );
>> +}
>>     
>
> Remove the '\n'.
>
>   

Okay.


>> +struct segment_descriptor {
>> +	u16 limit_low;
>> +	u16 base_low;
>> +	u8  base_mid;
>> +	u8  type : 4;
>> +	u8  system : 1;
>> +	u8  dpl : 2;
>> +	u8  present : 1;
>> +	u8  limit_high : 4;
>> +	u8  avl : 1;
>> +	u8  long_mode : 1;
>> +	u8  default_op : 1;
>> +	u8  granularity : 1;
>> +	u8  base_high;
>> +} __attribute__((packed));
>>     
>
> Bitfields are generally frowned upon. It's better to define
> constants for each of these and use a u64.
>
>   

Any specific reasons?  I find the code much more readable (and 
lowercase) with bitfields.

>> +
>> +#ifdef __x86_64__
>> +// LDT or TSS descriptor in the GDT. 16 bytes.
>> +struct segment_descriptor_64 {
>> +	struct segment_descriptor s;
>> +	u32 base_higher;
>> +	u32 pad_zero;
>> +} __attribute__((packed));
>> +#endif
>>     
>
> No need for packing this.
>
>   

Right.  Will remove.

>> +
>> +DEFINE_PER_CPU(struct vmcs *, vmxarea);
>> +DEFINE_PER_CPU(struct vmcs *, current_vmcs);
>>     
>
> If you make these
>
> DEFINE_PER_CPU(struct vmcs, vmxarea);
> DEFINE_PER_CPU(struct vmcs, current_vmcs);
>
> you no longer need to handle allocation of the structures
> yourself. Also, they should be 'static DEFINE_PER_CPU' if
> possible.
>
>   

The structure's size is defined by the hardware (struvt vmcs is just a 
header).  In addition, current_vmcs changes when another guest is 
switched in (it is somewhat like the scheduler's current for the VT 
hardware).

>> +static void set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
>> +{
>> +	if (cr0 & CR0_RESEVED_BITS) {
>> +		printk("set_cr0: 0x%lx #GP, reserved bits (0x%lx)\n", cr0, guest_cr0());
>> +		inject_gp(vcpu);
>> +		return;
>> +	}
>> +
>> +	if ((cr0 & CR0_NW_MASK) && !(cr0 & CR0_CD_MASK)) {
>> +		printk("set_cr0: #GP, CD == 0 && NW == 1\n");
>> +		inject_gp(vcpu);
>> +		return;
>> +	}
>> +
>> +	if ((cr0 & CR0_PG_MASK) && !(cr0 & CR0_PE_MASK)) {
>> +		printk("set_cr0: #GP, set PG flag and a clear PE flag\n");
>> +		inject_gp(vcpu);
>> +		return;
>> +	}
>> +
>> +	if (is_paging()) {
>> +#ifdef __x86_64__
>> +		if (!(cr0 & CR0_PG_MASK)) {
>> +			vcpu->shadow_efer &= ~EFER_LMA;
>> +			vmcs_write32(VM_ENTRY_CONTROLS,
>> +				     vmcs_read32(VM_ENTRY_CONTROLS) &
>> +				     ~VM_ENTRY_CONTROLS_IA32E_MASK);
>> +		}
>> +#endif
>> +	} else if ((cr0 & CR0_PG_MASK)) {
>> +#ifdef __x86_64__
>> +		if ((vcpu->shadow_efer & EFER_LME)) {
>> +			u32 guest_cs_ar;
>> +			u32 guest_tr_ar;
>> +			if (!is_pae()) {
>> +				printk("set_cr0: #GP, start paging in "
>> +				       "long mode while PAE is disabled\n");
>> +				inject_gp(vcpu);
>> +				return;
>> +			}
>> +			guest_cs_ar = vmcs_read32(GUEST_CS_AR_BYTES);
>> +			if (guest_cs_ar & SEGMENT_AR_L_MASK) {
>> +				printk("set_cr0: #GP, start paging in "
>> +				       "long mode while CS.L == 1\n");
>> +				inject_gp(vcpu);
>> +				return;
>> +
>> +			}
>> +			guest_tr_ar = vmcs_read32(GUEST_TR_AR_BYTES);
>> +			if ((guest_tr_ar & AR_TYPE_MASK) != AR_TYPE_BUSY_64_TSS) {
>> +				printk("%s: tss fixup for long mode. \n",
>> +				       __FUNCTION__);
>> +				vmcs_write32(GUEST_TR_AR_BYTES,
>> +					     (guest_tr_ar & ~AR_TYPE_MASK) |
>> +					     AR_TYPE_BUSY_64_TSS);
>> +			}
>> +			vcpu->shadow_efer |= EFER_LMA;
>> +			find_msr_entry(vcpu, MSR_EFER)->data |=
>> +							EFER_LMA | EFER_LME;
>> +			vmcs_write32(VM_ENTRY_CONTROLS,
>> +				     vmcs_read32(VM_ENTRY_CONTROLS) |
>> +				     VM_ENTRY_CONTROLS_IA32E_MASK);
>> +
>> +		} else
>> +#endif
>> +		if (is_pae() &&
>> +			    pdptrs_have_reserved_bits_set(vcpu, vcpu->cr3)) {
>> +			printk("set_cr0: #GP, pdptrs reserved bits\n");
>> +			inject_gp(vcpu);
>> +			return;
>> +		}
>> +
>> +	}
>> +
>> +	__set_cr0(vcpu, cr0);
>> +	kvm_mmu_reset_context(vcpu);
>> +	return;
>> +}
>>     
>
> This function is a little too complex to read. Can you split it up
> into smaller functions?
>
>   

Okay.

>> +	} else
>> +		printk("lmsw: unexpected\n");
>>     
>
> Make sure that all printk have KERN_* level in them.
>
>   

Okay.

>> +
>> +	#define LMSW_GUEST_MASK 0x0eULL
>>     
>
> Don't indent macro definition. Normally, these should to the top of your
> file.
>   


Okay.

>> +static long kvm_dev_ioctl(struct file *filp,
>> +			  unsigned int ioctl, unsigned long arg)
>> +{
>> +	struct kvm *kvm = filp->private_data;
>> +	int r = -EINVAL;
>> +
>> +	switch (ioctl) {
>> +	default:
>> +		;
>> +	}
>> +out:
>> +	return r;
>> +}
>>     
>
> Huh? Just leave out stuff like this. If the ioctl function is introduced
> in a later patch, you can still add the whole function there.	

Several different patches add content here, so I thought I wouldn't play 
favorite.

It also makes reordering the patches a little less painful.  Any tips on 
that or is that a normal ramp up?  I'm using quilt for now and syncing 
to a conventional source control repository.


Thanks for the review!  I'll go do my homework now.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

