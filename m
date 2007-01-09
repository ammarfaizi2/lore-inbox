Return-Path: <linux-kernel-owner+w=401wt.eu-S932068AbXAINhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbXAINhg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 08:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXAINhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 08:37:36 -0500
Received: from il.qumranet.com ([62.219.232.206]:45554 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbXAINhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 08:37:35 -0500
Message-ID: <45A39A97.5060807@qumranet.com>
Date: Tue, 09 Jan 2007 15:37:27 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: kvm-devel <kvm-devel@lists.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [RFC] Stable kvm userspace interface
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had originally hoped to get this in for 2.6.20.  It now looks like .20 
will have a shorter cycle than usual, and the mmu took a bit longer than 
expected, so it's more realistic to aim for 2.6.21.

The current kvm userspace interface has several deficiencies:

- open("/dev/kvm") returns a different object (a new vm) per invocation; 
this is "unusual" by Linux standards
- all vcpus share the same inode and struct file, which can cause 
scalability problems on very large smps.  This isn't a problem for 
current hardware, which has moderate core counts and huge vmexit 
latencies, not to mention a limit of one vcpu per vm, but I'd like to 
future-proof the interface.
- the KVM_VCPU_RUN ioctl() copies a needless chuck of data back and forth
- the PIO handlers communicate by means of registers (for single I/O) or 
virtual addresses (for string I/O).  Instead the values should be 
explicit fields in some structure, and physical addresses should be used 
to remove the need to translate addresses in userspace.
- the interrupt code still needs work to properly support the local apic 
with Windows guests.
- userspace must rely on delivered signals, which are slow, and cannot 
use queued signals (a la pselect()/ppoll()).

I propose the following as the new, stable, kvm api:

// open a handle to the kvm interface.  does not create a vm.
int kvm_fd = open("/dev/kvm", O_RDWR);

// the kvm interface supports just three ioctls:
ioctl(kvm_fd, KVM_GET_API_VERSION, 0);
ioctl(kvm_fd, KVM_GET_MSR_LIST, &msr_list);
int vm_fd = ioctl(kvm_fd, KVM_CREATE_VM, 0);

// vm ioctls:
ioctl(vm_fd, KVM_VM_CREATE_MEMORY_REGION, &slot);
ioctl(vm_fd, KVM_VM_GET_DIRTY_LOG, &dirty_log);
int vcpu_fd = ioctl(vm_fd, KVM_CREATE_VCPU, vcpu_slot_number);

// each vcpu is a separate fd/inode.  this ensures no cacheline bouncing
// when the kernel refcounts the inodes on syscalls.

// kvm_vcpu_area contains the exit reasons and associated data, and
// results returned by userspace to resolve the exit reasons.
struct kvm_vcpu_area *vcpu_area = mmap(NULL, PAGE_SIZE, ..., vcpu_fd, 0);

struct kvm_vcpu_area {
    u32 vcpu_area_size;
    u32 exit_reason;

    sigset_t sigmask;  // for use during vcpu execution

    union {
	struct kvm_pio pio;
	struct kvm_mmio mmio;
	struct kvm_cpuid cpuid;
	// etc.
	char padding[...];
    };

    struct kvm_irq irq; // acks from vm; injection from userspace
};


// vcpu ioctls

ioctl(vcpu_fd, KVM_VCPU_RUN, 0); // all comms through mmap()ed  vcpu_area
ioctl(vcpu_fd, KVM_VCPU_GET_REGS, &regs);
ioctl(vcpu_fd, KVM_VCPU_SET_REGS, &regs);
ioctl(vcpu_fd, KVM_VCPU_GET_SREGS, &sregs);
ioctl(vcpu_fd, KVM_VCPU_SET_SREGS, &sregs);
ioctl(vcpu_fd, KVM_VCPU_GET_MSRS, &msrs);
ioctl(vcpu_fd, KVM_VCPU_SET_MSRS, &msrs);
ioctl(vcpu_fd, KVM_VCPU_DEBUG_GUEST, &debug);


/* for KVM_VM_CREATE_MEMORY_REGION */
struct kvm_memory_region {
	__u32 slot;
	__u32 flags;
	__u64 guest_phys_addr;
	__u64 memory_size; /* bytes */
};

/* for kvm_memory_region::flags */
#define KVM_MEM_LOG_DIRTY_PAGES  1UL


#define KVM_EXIT_TYPE_FAIL_ENTRY 1
#define KVM_EXIT_TYPE_VM_EXIT    2

enum kvm_exit_reason {
	KVM_EXIT_UNKNOWN          = 0,
	KVM_EXIT_EXCEPTION        = 1,
	KVM_EXIT_IO               = 2,
	KVM_EXIT_CPUID            = 3,
	KVM_EXIT_DEBUG            = 4,
	KVM_EXIT_HLT              = 5,
	KVM_EXIT_MMIO             = 6,
	KVM_EXIT_IRQ_WINDOW_OPEN  = 7,
	KVM_EXIT_HYPERCALL        = 8,
};


/* for KVM_GET_REGS and KVM_SET_REGS */
struct kvm_regs {
        // note: no vcpu!

	/* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
	__u64 rax, rbx, rcx, rdx;
	__u64 rsi, rdi, rsp, rbp;
	__u64 r8,  r9,  r10, r11;
	__u64 r12, r13, r14, r15;
	__u64 rip, rflags;
};

struct kvm_segment {
	__u64 base;
	__u32 limit;
	__u16 selector;
	__u8  type;
	__u8  present, dpl, db, s, l, g, avl;
	__u8  unusable;
	__u8  padding;
};

struct kvm_dtable {
	__u64 base;
	__u16 limit;
	__u16 padding[3];
};

/* for KVM_VCPU_GET_SREGS and KVM_VCPU_SET_SREGS */
struct kvm_sregs {
	/* out (KVM_GET_SREGS) / in (KVM_SET_SREGS) */
	struct kvm_segment cs, ds, es, fs, gs, ss;
	struct kvm_segment tr, ldt;
	struct kvm_dtable gdt, idt;
	__u64 cr0, cr2, cr3, cr4, cr8;
};

struct kvm_msr_entry {
	__u32 index;
	__u32 reserved;
	__u64 data;
};

/* for KVM_VCPU_GET_MSRS and KVM_VCPU_SET_MSRS */
struct kvm_msrs {
	__u32 nmsrs; /* number of msrs in entries */
	__u32 padding;

	struct kvm_msr_entry entries[0];
};

/* for KVM_GET_MSR_INDEX_LIST */
struct kvm_msr_list {
	__u32 nmsrs; /* number of msrs in entries */
	__u32 indices[0];
};

struct kvm_breakpoint {
	__u32 enabled;
	__u32 padding;
	__u64 address;
};

/* for KVM_VCPU_DEBUG_GUEST */
struct kvm_debug_guest {
	__u32 enabled;
	__u32 singlestep;
	struct kvm_breakpoint breakpoints[4];
};

/* for KVM_VM_GET_DIRTY_LOG */
struct kvm_dirty_log {
	__u32 slot;
	__u32 padding;
	union {
		void __user *dirty_bitmap; /* one bit per page */
		__u64 padding;
	};
};


Comments and questions are welcome.


Thanks to Arnd Bergmann for his contributions and advice on this issue.

-- 
error compiling committee.c: too many arguments to function

