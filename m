Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWEVJJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWEVJJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 05:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWEVJJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 05:09:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24713 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750739AbWEVJJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 05:09:47 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: NMI problems with Dell SMP Xeons
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 May 2006 19:08:04 +1000
Message-ID: <12475.1148288884@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: sending an IPI as NMI will reboot a Dell SMP Xeon box.  This
         looks like a problem with setting up the I/O APICs.

Debugging, crash dump etc. need to send an IPI to other processors to
bring them to a stopped state.  If the other cpus are spinning disabled
then the IPI needs to be sent as an NMI to override the disabled state.

Sending an IPI as NMI works fine on almost every bit of i386 and x86_64
SMP hardware that I have tried.  But not on some Dell Xeons,
specifically not on an SC1425 server.  On SC1425, when any IPI is sent
as NMI then it gets an instant reset, AFAICT it never gets to the NMI
routine.  Changing CONFIG_ACPI or booting with a different maxcpus will
change the behaviour.

Ugly test patch against 2.6.17-rc4 follows, plus .config and some boot
logs.  The problem exists in both 32 and 64 bit mode on the SC1425, but
this is an i386 build so it can be used on all my test boxes.

modprobe test_nmi sends four different IPIs, with a short pause between
them :-

(1) IPI 2, not marked as NMI.  This does _not_ call into the do_nmi()
    routine.

    People have been telling me (hi, Andi:) that sending interrupt 2 as
    an IPI automatically sends it as an NMI.  Every piece of hardware I
    have tested (including the Dell SC1425) shows that this is not
    true; instead IPI 2 routes as a normal interrupt, which agrees with
    Intel's documentation[1].

    Something strange, this IPI just disappears.  Not only is it not
    being delivered as an NMI, it does not seem to be delivered at all.
    This is true on all the hardware that I have tested.  Some of the
    hardware (but not all of it) reports APIC errors when sending IPI 2.

      APIC error on CPU0: 00(20)
      APIC error on CPU1: 00(40)

(2) IPI 20, not marked as NMI.  A test IPI which is used to check that
    other IPIs are getting through, and they are.  IOW, the test module
    is working fine, as long as it does not try to send IPI 2.

(3) IPI 2, marked as NMI (APIC_DM_NMI in smp.c).  If the machine stays
    up then this IPI does call into the do_nmi() routine.  The NMI
    handler gets dazed and confused, but that is expected.

(4) IPI 20, marked as NMI.  This also calls into the do_nmi() routine,
    as expected.

Typical log on an Intel motherboard, with 2 Xeon cpus.

   test_nmi_init: 1 cpu 0
   kaos_send_IPI_allbutself: ipi 2
   APIC error on CPU0: 00(20)
   APIC error on CPU1: 00(40)
   test_nmi_init: 2 cpu 0
   kaos_send_IPI_allbutself: ipi 20
   test_nmi_init: 3 cpu 0
   do_ipi_20: cpu 1
   kaos_send_IPI_allbutself: ipi 2
   __send_IPI_shortcut: cpu 0 cfg 0xc0c00
   test_nmi_init: 4 cpu 0
   do_nmi: cpu 1
   Uhhuh. NMI received for unknown reason 00 on CPU 1.
   Dazed and confused, but trying to continue
   Do you have a strange power saving mode enabled?
   kaos_send_IPI_allbutself: ipi 20
   __send_IPI_shortcut: cpu 0 cfg 0xc0c00
   do_nmi: cpu 1
   Uhhuh. NMI received for unknown reason 00 on CPU 1.
   Dazed and confused, but trying to continue
   Do you have a strange power saving mode enabled?

Typical log on Dell SC1425 system with 4 cpus, CONFIG_ACPI=y, booted
with maxcpus=2.

   test_nmi_init: 1 cpu 0
   kaos_send_IPI_allbutself: ipi 2
   APIC error on CPU0: 00(20)
   APIC error on CPU1: 00(40)
   test_nmi_init: 2 cpu 0
   kaos_send_IPI_allbutself: ipi 20
   test_nmi_init: 3 cpu 0
   do_ipi_20: cpu 1
   kaos_send_IPI_allbutself: ipi 2
   __send_IPI_shortcut: cpu 0 cfg 0xc0c00
   === Instant reset here ===

Swapping the order of the NMI IPIs in test_nmi() (send 20 before 2)
makes no difference on the SC1425.  If the problem exists then the
SC1425 always gets an instant reset on the first IPI that is sent as
NMI.

Typical log on SC1425 with 4 cpus, CONFIG_ACPI=y, booted without
maxcpus= or with maxcpus=4.

  test_nmi_init: 1 cpu 1
  kaos_send_IPI_allbutself: ipi 2
  APIC error on CPU1: 00(20)
  APIC error on CPU3: 00(40)
  APIC error on CPU2: 00(40)
  APIC error on CPU0: 00(40)
  test_nmi_init: 2 cpu 1
  kaos_send_IPI_allbutself: ipi 20
  test_nmi_init: 3 cpu 1
  do_ipi_20: cpu 3
  do_ipi_20: cpu 2
  do_ipi_20: cpu 0
  kaos_send_IPI_allbutself: ipi 2
  __send_IPI_shortcut: cpu 1 cfg 0xc0c00
  test_nmi_init: 4 cpu 1
  Uhhuh. NMI received for unknown reason 00 on CPU 2.
  Uhhuh. NMI received for unknown reason 00 on CPU 3.
  do_nmi: cpu 0
  Dazed and confused, but trying to continue
  Do you have a strange power saving mode enabled?
  Uhhuh. NMI received for unknown reason 30 on CPU 0.
  Dazed and confused, but trying to continue
  Dazed and confused, but trying to continue
  Do you have a strange power saving mode enabled?
  Do you have a strange power saving mode enabled?
  kaos_send_IPI_allbutself: ipi 20
  __send_IPI_shortcut: cpu 1 cfg 0xc0c00
  do_nmi: cpu 0
  Uhhuh. NMI received for unknown reason 00 on CPU 2.
  Uhhuh. NMI received for unknown reason 20 on CPU 0.
  Dazed and confused, but trying to continue
  Dazed and confused, but trying to continue
  do_nmi: cpu 3
  Do you have a strange power saving mode enabled?
  Do you have a strange power saving mode enabled?
  Uhhuh. NMI received for unknown reason 00 on CPU 3.
  Dazed and confused, but trying to continue
  Do you have a strange power saving mode enabled?

  The system keeps going.

The .config below has CONFIG_ACPI=y.  If the SC1425 is run with
CONFIG_ACPI=y and with no maxcpus= on the boot line then it runs fine.
Compile with CONFIG_ACPI=n or with CONFIG_ACPI=y and maxcpus= some
value less than the actual number of cpus and the SC1425 dies on the
first NMI IPI.

It is interesting that with CONFIG_ACPI=y, SC1425 has 4 cpus.  With
CONFIG_ACPI=n it only has 2.

My best guess is that this reset problem is being caused by an
incorrect or incomplete setup of the I/O APICs when ACPI is off or not
all the cpus are processed by the kernel at boot time.

The SC1425 is running BIOS 1.10 A03, which is the latest that I could
find on http://support.dell.com.

####################################################################

Stripped .config.

X86_32=y
SEMAPHORE_SLEEPERS=y
X86=y
MMU=y
GENERIC_ISA_DMA=y
GENERIC_IOMAP=y
GENERIC_HWEIGHT=y
ARCH_MAY_HAVE_PC_FDC=y
DMI=y
EXPERIMENTAL=y
LOCK_KERNEL=y
INIT_ENV_ARG_LIMIT=32
LOCALVERSION="-kaos"
SWAP=y
SYSVIPC=y
SYSCTL=y
RELAY=y
INITRAMFS_SOURCE=""
UID16=y
VM86=y
CC_OPTIMIZE_FOR_SIZE=y
KALLSYMS=y
KALLSYMS_ALL=y
HOTPLUG=y
PRINTK=y
BUG=y
ELF_CORE=y
BASE_FULL=y
FUTEX=y
EPOLL=y
SHMEM=y
SLAB=y
BASE_SMALL=0
MODULES=y
MODULE_UNLOAD=y
KMOD=y
STOP_MACHINE=y
LBD=y
IOSCHED_NOOP=y
DEFAULT_NOOP=y
DEFAULT_IOSCHED="noop"
SMP=y
X86_PC=y
M686=y
X86_CMPXCHG=y
X86_XADD=y
X86_L1_CACHE_SHIFT=5
RWSEM_XCHGADD_ALGORITHM=y
GENERIC_CALIBRATE_DELAY=y
X86_PPRO_FENCE=y
X86_WP_WORKS_OK=y
X86_INVLPG=y
X86_BSWAP=y
X86_POPAD_OK=y
X86_CMPXCHG64=y
X86_GOOD_APIC=y
X86_USE_PPRO_CHECKSUM=y
X86_TSC=y
HPET_TIMER=y
HPET_EMULATE_RTC=y
NR_CPUS=8
SCHED_SMT=y
SCHED_MC=y
PREEMPT=y
PREEMPT_BKL=y
X86_LOCAL_APIC=y
X86_IO_APIC=y
X86_MCE=y
X86_MCE_NONFATAL=y
X86_MCE_P4THERMAL=y
MICROCODE=m
X86_MSR=m
X86_CPUID=m
HIGHMEM4G=y
PAGE_OFFSET=0xC0000000
HIGHMEM=y
ARCH_FLATMEM_ENABLE=y
ARCH_SPARSEMEM_ENABLE=y
ARCH_SELECT_MEMORY_MODEL=y
SELECT_MEMORY_MODEL=y
FLATMEM_MANUAL=y
FLATMEM=y
FLAT_NODE_MEM_MAP=y
SPARSEMEM_STATIC=y
SPLIT_PTLOCK_CPUS=4
MTRR=y
IRQBALANCE=y
REGPARM=y
SECCOMP=y
HZ_250=y
HZ=250
PHYSICAL_START=0x100000
PM=y
ACPI=y
ACPI_AC=y
ACPI_BATTERY=y
ACPI_BUTTON=y
ACPI_VIDEO=y
ACPI_FAN=y
ACPI_PROCESSOR=y
ACPI_THERMAL=y
ACPI_BLACKLIST_YEAR=0
ACPI_EC=y
ACPI_POWER=y
ACPI_SYSTEM=y
X86_PM_TIMER=y
PCI=y
PCI_GOANY=y
PCI_BIOS=y
PCI_DIRECT=y
PCI_MMCONFIG=y
ISA_DMA_API=y
BINFMT_ELF=y
BINFMT_MISC=m
NET=y
PACKET=m
PACKET_MMAP=y
UNIX=y
INET=y
IP_FIB_HASH=y
SYN_COOKIES=y
INET_DIAG=y
INET_TCP_DIAG=y
TCP_CONG_BIC=y
NETFILTER=y
NETFILTER_NETLINK=m
NETFILTER_XTABLES=m
NETFILTER_XT_TARGET_CLASSIFY=m
NETFILTER_XT_TARGET_MARK=m
NETFILTER_XT_TARGET_NFQUEUE=m
NETFILTER_XT_TARGET_NOTRACK=m
NETFILTER_XT_MATCH_COMMENT=m
NETFILTER_XT_MATCH_CONNTRACK=m
NETFILTER_XT_MATCH_DCCP=m
NETFILTER_XT_MATCH_ESP=m
NETFILTER_XT_MATCH_HELPER=m
NETFILTER_XT_MATCH_LENGTH=m
NETFILTER_XT_MATCH_LIMIT=m
NETFILTER_XT_MATCH_MAC=m
NETFILTER_XT_MATCH_MARK=m
NETFILTER_XT_MATCH_MULTIPORT=m
NETFILTER_XT_MATCH_PKTTYPE=m
NETFILTER_XT_MATCH_REALM=m
NETFILTER_XT_MATCH_SCTP=m
NETFILTER_XT_MATCH_STATE=m
NETFILTER_XT_MATCH_STRING=m
NETFILTER_XT_MATCH_TCPMSS=m
IP_NF_CONNTRACK=m
IP_NF_CONNTRACK_NETLINK=m
IP_NF_FTP=m
IP_NF_IRC=m
IP_NF_H323=m
IP_NF_QUEUE=m
IP_NF_IPTABLES=m
IP_NF_MATCH_IPRANGE=m
IP_NF_MATCH_TOS=m
IP_NF_MATCH_RECENT=m
IP_NF_MATCH_ECN=m
IP_NF_MATCH_DSCP=m
IP_NF_MATCH_AH=m
IP_NF_MATCH_TTL=m
IP_NF_MATCH_OWNER=m
IP_NF_MATCH_ADDRTYPE=m
IP_NF_MATCH_HASHLIMIT=m
IP_NF_FILTER=m
IP_NF_TARGET_REJECT=m
IP_NF_TARGET_LOG=m
IP_NF_TARGET_ULOG=m
IP_NF_TARGET_TCPMSS=m
IP_NF_NAT=m
IP_NF_NAT_NEEDED=y
IP_NF_TARGET_MASQUERADE=m
IP_NF_TARGET_REDIRECT=m
IP_NF_TARGET_NETMAP=m
IP_NF_TARGET_SAME=m
IP_NF_NAT_SNMP_BASIC=m
IP_NF_NAT_IRC=m
IP_NF_NAT_FTP=m
IP_NF_NAT_H323=m
IP_NF_MANGLE=m
IP_NF_TARGET_TOS=m
IP_NF_TARGET_ECN=m
IP_NF_TARGET_DSCP=m
IP_NF_TARGET_TTL=m
IP_NF_RAW=m
IP_NF_ARPTABLES=m
IP_NF_ARPFILTER=m
IP_NF_ARP_MANGLE=m
NET_CLS_ROUTE=y
STANDALONE=y
PREVENT_FIRMWARE_BUILD=y
PARPORT=m
PARPORT_PC=m
BLK_DEV_FD=y
BLK_DEV_LOOP=m
BLK_DEV_RAM=y
BLK_DEV_RAM_COUNT=16
BLK_DEV_RAM_SIZE=4096
IDE=y
BLK_DEV_IDE=y
BLK_DEV_IDEDISK=y
IDEDISK_MULTI_MODE=y
BLK_DEV_IDECD=m
BLK_DEV_IDESCSI=m
IDE_GENERIC=y
BLK_DEV_IDEPCI=y
IDEPCI_SHARE_IRQ=y
BLK_DEV_GENERIC=y
BLK_DEV_IDEDMA_PCI=y
IDEDMA_PCI_AUTO=y
BLK_DEV_PIIX=y
BLK_DEV_IDEDMA=y
IDEDMA_AUTO=y
SCSI=y
SCSI_PROC_FS=y
BLK_DEV_SD=y
BLK_DEV_SR=m
BLK_DEV_SR_VENDOR=y
CHR_DEV_SG=m
SCSI_CONSTANTS=y
SCSI_LOGGING=y
SCSI_SPI_ATTRS=y
SCSI_SATA=y
SCSI_ATA_PIIX=y
SCSI_SATA_INTEL_COMBINED=y
SCSI_SYM53C8XX_2=y
SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
SCSI_SYM53C8XX_DEFAULT_TAGS=16
SCSI_SYM53C8XX_MAX_TAGS=64
SCSI_SYM53C8XX_MMIO=y
MD=y
BLK_DEV_MD=m
MD_LINEAR=m
MD_RAID0=m
MD_RAID1=m
MD_RAID10=m
MD_RAID5=m
MD_RAID6=m
MD_MULTIPATH=m
BLK_DEV_DM=m
DM_CRYPT=m
DM_SNAPSHOT=m
DM_MIRROR=m
DM_ZERO=m
NETDEVICES=y
DUMMY=m
TUN=m
NET_ETHERNET=y
MII=y
NET_PCI=y
E100=y
E1000=m
TIGON3=m
PPP=m
PPP_ASYNC=m
PPP_DEFLATE=m
PPP_BSDCOMP=m
INPUT=y
INPUT_MOUSEDEV=y
INPUT_MOUSEDEV_PSAUX=y
INPUT_MOUSEDEV_SCREEN_X=1024
INPUT_MOUSEDEV_SCREEN_Y=768
INPUT_KEYBOARD=y
KEYBOARD_ATKBD=y
INPUT_MOUSE=y
MOUSE_PS2=m
MOUSE_SERIAL=m
SERIO=y
SERIO_I8042=y
SERIO_PCIPS2=m
SERIO_LIBPS2=y
VT=y
VT_CONSOLE=y
HW_CONSOLE=y
SERIAL_8250=y
SERIAL_8250_CONSOLE=y
SERIAL_8250_PCI=y
SERIAL_8250_NR_UARTS=4
SERIAL_8250_RUNTIME_UARTS=4
SERIAL_CORE=y
SERIAL_CORE_CONSOLE=y
UNIX98_PTYS=y
LEGACY_PTYS=y
LEGACY_PTY_COUNT=256
PRINTER=m
WATCHDOG=y
SOFT_WATCHDOG=m
RTC=y
HWMON=y
VGA_CONSOLE=y
DUMMY_CONSOLE=y
USB_ARCH_HAS_HCD=y
USB_ARCH_HAS_OHCI=y
USB_ARCH_HAS_EHCI=y
EDAC=y
EDAC_DEBUG=y
EDAC_MM_EDAC=y
EDAC_E7XXX=m
EDAC_E752X=y
EDAC_I82875P=m
EDAC_I82860=m
EDAC_POLL=y
EXT2_FS=y
FS_POSIX_ACL=y
XFS_FS=y
XFS_EXPORT=y
XFS_QUOTA=y
ROMFS_FS=m
INOTIFY=y
QUOTACTL=y
DNOTIFY=y
AUTOFS_FS=m
AUTOFS4_FS=m
FUSE_FS=m
ISO9660_FS=m
JOLIET=y
ZISOFS=y
ZISOFS_FS=m
UDF_FS=m
UDF_NLS=y
FAT_FS=m
MSDOS_FS=m
VFAT_FS=m
FAT_DEFAULT_CODEPAGE=437
FAT_DEFAULT_IOCHARSET="iso8859-1"
NTFS_FS=m
PROC_FS=y
PROC_KCORE=y
SYSFS=y
TMPFS=y
RAMFS=y
EFS_FS=m
HPFS_FS=m
UFS_FS=m
NFS_FS=m
NFS_V3=y
NFS_V4=y
NFSD=m
NFSD_V3=y
NFSD_V4=y
NFSD_TCP=y
LOCKD=m
LOCKD_V4=y
EXPORTFS=y
NFS_COMMON=y
SUNRPC=m
SUNRPC_GSS=m
RPCSEC_GSS_KRB5=m
SMB_FS=m
MSDOS_PARTITION=y
NLS=y
NLS_DEFAULT="iso8859-1"
NLS_CODEPAGE_437=m
NLS_CODEPAGE_850=y
NLS_ISO8859_1=y
NLS_UTF8=m
MAGIC_SYSRQ=y
DEBUG_KERNEL=y
LOG_BUF_SHIFT=16
DEBUG_PREEMPT=y
DEBUG_MUTEXES=y
DEBUG_BUGVERBOSE=y
DEBUG_FS=y
FRAME_POINTER=y
FORCED_INLINING=y
EARLY_PRINTK=y
STACK_BACKTRACE_COLS=2
DEBUG_RODATA=y
4KSTACKS=y
X86_FIND_SMP_CONFIG=y
X86_MPPARSE=y
DOUBLEFAULT=y
CRYPTO=y
CRYPTO_MD5=y
CRYPTO_DES=m
CRC_CCITT=m
CRC32=m
ZLIB_INFLATE=m
ZLIB_DEFLATE=m
TEXTSEARCH=y
TEXTSEARCH_KMP=m
TEXTSEARCH_BM=m
TEXTSEARCH_FSM=m
GENERIC_HARDIRQS=y
GENERIC_IRQ_PROBE=y
GENERIC_PENDING_IRQ=y
X86_SMP=y
X86_HT=y
X86_BIOS_REBOOT=y
X86_TRAMPOLINE=y
KTIME_SCALAR=y

####################################################################

Ugly test_nmi patch, against 2.6.17-rc4.

Index: linux/arch/i386/kernel/smp.c
===================================================================
--- linux.orig/arch/i386/kernel/smp.c	2006-05-22 17:16:00.786735277 +1000
+++ linux/arch/i386/kernel/smp.c	2006-05-22 17:16:48.614239072 +1000
@@ -122,6 +122,8 @@ static inline int __prepare_ICR2 (unsign
 	return SET_APIC_DEST_FIELD(mask);
 }
 
+extern int kaos_expect_nmi;
+
 void __send_IPI_shortcut(unsigned int shortcut, int vector)
 {
 	/*
@@ -142,6 +144,11 @@ void __send_IPI_shortcut(unsigned int sh
 	 * No need to touch the target chip field
 	 */
 	cfg = __prepare_ICR(shortcut, vector);
+	if (vector == kaos_expect_nmi) {
+		cfg = (cfg&~APIC_VECTOR_MASK)|APIC_DM_NMI;
+		kaos_expect_nmi = -1;
+		printk("%s: cpu %d cfg 0x%x\n", __FUNCTION__, smp_processor_id(), cfg);
+	}
 
 	/*
 	 * Send the IPI. The write to APIC_ICR fires this off.
@@ -220,6 +227,11 @@ void send_IPI_mask_sequence(cpumask_t ma
 			 * program the ICR 
 			 */
 			cfg = __prepare_ICR(0, vector);
+			if (vector == kaos_expect_nmi) {
+				cfg = (cfg&~APIC_VECTOR_MASK)|APIC_DM_NMI;
+				kaos_expect_nmi = -1;
+				printk("%s: cpu %d cfg 0x%lx\n", __FUNCTION__, smp_processor_id(), cfg);
+			}
 			
 			/*
 			 * Send the IPI. The write to APIC_ICR fires this off.
@@ -562,6 +574,13 @@ int smp_call_function (void (*func) (voi
 }
 EXPORT_SYMBOL(smp_call_function);
 
+void kaos_send_IPI_allbutself(int ipi)
+{
+	printk("%s: ipi %d\n", __FUNCTION__, ipi);
+	send_IPI_allbutself(ipi);
+}
+EXPORT_SYMBOL(kaos_send_IPI_allbutself);
+
 static void stop_this_cpu (void * dummy)
 {
 	/*
Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c	2006-05-22 17:16:00.786735277 +1000
+++ linux/arch/i386/kernel/traps.c	2006-05-22 17:26:30.492419519 +1000
@@ -87,6 +87,7 @@ asmlinkage void general_protection(void)
 asmlinkage void page_fault(void);
 asmlinkage void coprocessor_error(void);
 asmlinkage void simd_coprocessor_error(void);
+asmlinkage void ipi_20(void);
 asmlinkage void alignment_check(void);
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
@@ -717,10 +718,17 @@ static int dummy_nmi_callback(struct pt_
 }
  
 static nmi_callback_t nmi_callback = dummy_nmi_callback;
+
+int kaos_expect_nmi;
+EXPORT_SYMBOL(kaos_expect_nmi);
  
 fastcall void do_nmi(struct pt_regs * regs, long error_code)
 {
 	int cpu;
+	if (kaos_expect_nmi) {
+		kaos_expect_nmi = 0;
+		printk("%s: cpu %d\n", __FUNCTION__, smp_processor_id());
+	}
 
 	nmi_enter();
 
@@ -734,6 +742,11 @@ fastcall void do_nmi(struct pt_regs * re
 	nmi_exit();
 }
 
+fastcall void do_ipi_20(struct pt_regs * regs, long error_code)
+{
+	printk("%s: cpu %d\n", __FUNCTION__, raw_smp_processor_id());
+}
+
 void set_nmi_callback(nmi_callback_t callback)
 {
 	vmalloc_sync_all();
@@ -1171,6 +1184,7 @@ void __init trap_init(void)
 	set_trap_gate(18,&machine_check);
 #endif
 	set_trap_gate(19,&simd_coprocessor_error);
+	set_trap_gate(20,&ipi_20);
 
 	if (cpu_has_fxsr) {
 		/*
Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile	2006-05-22 17:16:00.806263881 +1000
+++ linux/kernel/Makefile	2006-05-22 17:16:48.615215503 +1000
@@ -39,6 +39,8 @@ obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RELAY) += relay.o
 
+obj-m     += test_nmi.o
+
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond
Index: linux/kernel/test_nmi.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/kernel/test_nmi.c	2006-05-22 17:16:48.616191933 +1000
@@ -0,0 +1,40 @@
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+
+MODULE_LICENSE("GPL");
+
+extern void kaos_send_IPI_allbutself(int);
+extern int kaos_expect_nmi;
+
+static int __init
+test_nmi_init(void)
+{
+	int cpu = get_cpu();
+	kaos_expect_nmi = 0;
+	printk("%s: 1 cpu %d\n", __FUNCTION__, cpu);
+	mdelay(1000);
+	kaos_send_IPI_allbutself(2);
+	printk("%s: 2 cpu %d\n", __FUNCTION__, cpu);
+	mdelay(1000);
+	kaos_send_IPI_allbutself(20);
+	printk("%s: 3 cpu %d\n", __FUNCTION__, cpu);
+	mdelay(1000);
+	kaos_expect_nmi = 2;
+	kaos_send_IPI_allbutself(2);
+	printk("%s: 4 cpu %d\n", __FUNCTION__, cpu);
+	mdelay(1000);
+	kaos_expect_nmi = 20;
+	kaos_send_IPI_allbutself(20);
+	put_cpu();
+	return 0;
+}
+
+static void __exit
+test_nmi_exit(void)
+{
+}
+
+module_init(test_nmi_init)
+module_exit(test_nmi_exit)
Index: linux/arch/i386/kernel/entry.S
===================================================================
--- linux.orig/arch/i386/kernel/entry.S	2006-05-22 17:16:00.786735277 +1000
+++ linux/arch/i386/kernel/entry.S	2006-05-22 17:16:48.617168363 +1000
@@ -476,6 +476,11 @@ ENTRY(simd_coprocessor_error)
 	pushl $do_simd_coprocessor_error
 	jmp error_code
 
+ENTRY(ipi_20)
+	pushl $0
+	pushl $do_ipi_20
+	jmp error_code
+
 ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL

####################################################################

Boot log of SC1425 with CONFIG_ACPI=y, maxcpus=4.  This test works.

Linux version 2.6.17-rc4-kaos (kaos@linuxbuild) (gcc version 3.3.3 (SuSE Linux)) #53 SMP PREEMPT Mon May 22 17:29:17 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000007ffc0000 (usable)
 BIOS-e820: 000000007ffc0000 - 000000007ffcfc00 (ACPI data)
 BIOS-e820: 000000007ffcfc00 - 000000007ffff000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[32])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 32-55
ACPI: IOAPIC (id[0x0a] address[0xfec80800] gsi_base[64])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80800, GSI 64-87
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 3 I/O APICs
ACPI: HPET id: 0xffffffff base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7ffff000:60001000)
Built 1 zonelists
Kernel command line: root=/dev/sdb2 ro selinux=0 console=tty console=ttyS0,9600 maxcpus=4
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c03d3000 soft=c03cb000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2075288k/2096896k available (1828k kernel code, 20524k reserved, 813k data, 180k init, 1179392k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Using HPET for base-timer
Using HPET for gettimeofday
Detected 3000.240 MHz processor.
Using hpet for high-res timesource
Calibrating delay using timer specific routine.. 6005.07 BogoMIPS (lpj=12010151)
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c03d4000 soft=c03cc000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6000.31 BogoMIPS (lpj=12000634)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Booting processor 2/6 eip 2000
CPU 2 irqstacks, hard=c03d5000 soft=c03cd000
Initializing CPU#2
Calibrating delay using timer specific routine.. 6000.41 BogoMIPS (lpj=12000826)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (24) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Booting processor 3/7 eip 2000
CPU 3 irqstacks, hard=c03d6000 soft=c03ce000
Initializing CPU#3
Calibrating delay using timer specific routine.. 6000.33 BogoMIPS (lpj=12000673)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (24) available
CPU3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Total of 4 processors activated (24006.14 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 4 CPUs: passed.
Brought up 4 CPUs
migration_cost=4000,4000
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *6 7 10 11 12)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:01:00.0
  IO window: e000-efff
  MEM window: fe900000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: e000-efff
  MEM window: fe700000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fe500000-fe6fffff
  PREFETCH window: f0000000-f7ffffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
SGI XFS with large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
io scheduler noop registered (default)
Intel E7520/7320/7525 detected.<6>ACPI: Power Button (FF) [PWRF]
ACPI: Video Device [EVGA] (multi-head: no  rom: yes  post: no)
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 17
ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 17
ata1: dev 0 ATA-6, max UDMA/100, 156250000 sectors: LBA
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: WDC WD800JD-75JN  Rev: 06.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi disk sdb
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
EDAC MC: Ver: 2.0.0 May 22 2006
Contact your BIOS vendor to see if the E752x error registers can be safely un-hidden
TCP bic registered
NET: Registered protocol family 1
Starting balanced_irq
Using IPI Shortcut mode
input: AT Translated Set 2 keyboard as /class/input/input0
XFS mounting filesystem sdb2

####################################################################

Boot log of SC1425 with CONFIG_ACPI=y, maxcpus=2.  This test fails.

Linux version 2.6.17-rc4-kaos (kaos@linuxbuild) (gcc version 3.3.3 (SuSE Linux)) #52 SMP PREEMPT Mon May 22 17:17:11 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000007ffc0000 (usable)
 BIOS-e820: 000000007ffc0000 - 000000007ffcfc00 (ACPI data)
 BIOS-e820: 000000007ffcfc00 - 000000007ffff000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
WARNING: maxcpus limit of 2 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
WARNING: maxcpus limit of 2 reached. Processor ignored.
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[32])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 32-55
ACPI: IOAPIC (id[0x0a] address[0xfec80800] gsi_base[64])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80800, GSI 64-87
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 3 I/O APICs
ACPI: HPET id: 0xffffffff base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7ffff000:60001000)
Built 1 zonelists
Kernel command line: root=/dev/sdb2 ro selinux=0 console=tty console=ttyS0,9600 maxcpus=2
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c03d3000 soft=c03cb000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2075288k/2096896k available (1828k kernel code, 20460k reserved, 813k data, 180k init, 1179392k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Using HPET for base-timer
Using HPET for gettimeofday
Detected 3000.213 MHz processor.
Using hpet for high-res timesource
Calibrating delay using timer specific routine.. 6005.06 BogoMIPS (lpj=12010131)
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c03d4000 soft=c03cc000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6000.25 BogoMIPS (lpj=12000510)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Total of 2 processors activated (12005.32 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=8000
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *6 7 10 11 12)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:01:00.0
  IO window: e000-efff
  MEM window: fe900000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: e000-efff
  MEM window: fe700000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fe500000-fe6fffff
  PREFETCH window: f0000000-f7ffffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
SGI XFS with large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
io scheduler noop registered (default)
Intel E7520/7320/7525 detected.<6>ACPI: Power Button (FF) [PWRF]
ACPI: Video Device [EVGA] (multi-head: no  rom: yes  post: no)
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 17
ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 17
ata1: dev 0 ATA-6, max UDMA/100, 156250000 sectors: LBA
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: WDC WD800JD-75JN  Rev: 06.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi disk sdb
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
EDAC MC: Ver: 2.0.0 May 22 2006
Contact your BIOS vendor to see if the E752x error registers can be safely un-hidden
input: AT Translated Set 2 keyboard as /class/input/input0
TCP bic registered
NET: Registered protocol family 1
Starting balanced_irq
Using IPI Shortcut mode
XFS mounting filesystem sdb2

####################################################################

Boot log of SC1425 with CONFIG_ACPI=n, maxcpus not specified.  This
test fails.

Linux version 2.6.17-rc4-kaos (kaos@linuxbuild) (gcc version 3.3.3 (SuSE Linux)) #54 SMP PREEMPT Mon May 22 17:47:45 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000007ffc0000 (usable)
 BIOS-e820: 000000007ffc0000 - 000000007ffcfc00 (ACPI data)
 BIOS-e820: 000000007ffcfc00 - 000000007ffff000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: PE SC1425    APIC at: 0xFEE00000
Processor #0 15:4 APIC version 20
Processor #6 15:4 APIC version 20
I/O APIC #8 Version 32 at 0xFEC00000.
I/O APIC #9 Version 32 at 0xFEC80000.
I/O APIC #10 Version 32 at 0xFEC80800.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Processors: 2
Allocating PCI resources starting at 80000000 (gap: 7ffff000:60001000)
Built 1 zonelists
Kernel command line: root=/dev/sdb2 ro selinux=0 console=tty console=ttyS0,9600 maxcpus=2
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0397000 soft=c038f000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 3000.854 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2075552k/2096896k available (1689k kernel code, 20196k reserved, 728k data, 164k init, 1179392k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6009.37 BogoMIPS (lpj=12018756)
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Booting processor 1/6 eip 2000
CPU 1 irqstacks, hard=c0398000 soft=c0390000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6000.77 BogoMIPS (lpj=12001555)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Total of 2 processors activated (12010.15 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=1327
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc3de, last bus=4
Setting up standard PCI resources
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI->APIC IRQ transform: 0000:00:02.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:1d.7[D] -> IRQ 23
PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:1f.2[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:02:04.0[A] -> IRQ 24
PCI->APIC IRQ transform: 0000:04:03.0[A] -> IRQ 20
PCI->APIC IRQ transform: 0000:04:0d.0[A] -> IRQ 17
PCI: Bridge: 0000:01:00.0
  IO window: e000-efff
  MEM window: fe900000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: e000-efff
  MEM window: fe700000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fe500000-fe6fffff
  PREFETCH window: f0000000-f7ffffff
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
SGI XFS with large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
io scheduler noop registered (default)
Intel E7520/7320/7525 detected.<6>Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 18
ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 18
ata1: dev 0 ATA-6, max UDMA/100, 156250000 sectors: LBA
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: WDC WD800JD-75JN  Rev: 06.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi disk sdb
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
EDAC MC: Ver: 2.0.0 May 22 2006
Contact your BIOS vendor to see if the E752x error registers can be safely un-hidden
TCP bic registered
NET: Registered protocol family 1
Starting balanced_irq
Using IPI Shortcut mode
input: AT Translated Set 2 keyboard as /class/input/input0

####################################################################

[1] Extract of 25366819.pdf (IA-32 Intel Architecture Software
    Developer’s Manual Volume 3A: System Programming Guide, Part 1)

   5.3.3 Software-Generated Interrupts

   The INT n instruction permits interrupts to be generated from within
   software by supplying an interrupt vector number as an operand. For
   example, the INT 35 instruction forces an implicit call to the
   interrupt handler for interrupt 35.

   Any of the interrupt vectors from 0 to 255 can be used as a
   parameter in this instruction. If the processor ’s predefined NMI
   vector is used, however, the response of the processor will not be
   the same as it would be from an NMI interrupt generated in the
   normal manner. If vector number 2 (the NMI vector) is used in this
   instruction, the NMI interrupt handler is called, but the
   processor’s NMI-handling hardware is not activated.

   5.7 NONMASKABLE INTERRUPT (NMI)

   The nonmaskable interrupt (NMI) can be generated in either of two
   ways:

   * External hardware asserts the NMI pin.
   * The processor receives a message on the system bus (Pentium 4 and
     Intel Xeon processors) or the APIC serial bus (P6 family and
     Pentium processors) with a delivery mode NMI.

   When the processor receives a NMI from either of these sources, the
   processor handles it immediately by calling the NMI handler pointed
   to by interrupt vector number 2. The processor also invokes certain
   hardware conditions to insure that no other interrupts, including
   NMI interrupts, are received until the NMI handler has completed
   executing (see Section 5.7.1, “Handling Multiple NMIs”).

   Also, when an NMI is received from either of the above sources, it
   cannot be masked by the IF flag in the EFLAGS register.

   It is possible to issue a maskable hardware interrupt (through the
   INTR pin) to vector 2 to invoke the NMI interrupt handler; however,
   this interrupt will not truly be an NMI interrupt. A true NMI
   interrupt that activates the processor’s NMI-handling hardware can
   only be delivered through one of the mechanisms listed above.

