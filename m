Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUCAGOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 01:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbUCAGOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 01:14:38 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:53976 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262253AbUCAGMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 01:12:01 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: finding unused globals in the kernel 
In-reply-to: Your message of "Sat, 28 Feb 2004 22:13:34 BST."
             <200402282213.34657.arnd@arndb.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Mar 2004 17:11:12 +1100
Message-ID: <5138.1078121472@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Feb 2004 22:13:34 +0100, 
Arnd Bergmann <arnd@arndb.de> wrote:
>I've been looking for a way to find symbols in the kernel that
>are not referenced anywhere and could be removed. This script is
>what I came up with, it's rather slow and complicated, but I have
>managed to find quite a bit of dead code with it.

It is a bit harder than a simple compare.  EXPORT_SYMBOL(foo) generates
a reference to foo even if nothing uses it, which hides unused
variables.  Certain symbols appear as unused but are really used by the
2.4 version of insmod.  Your script does not handle modules at all.

namespace.pl below handles all the special cases on kernels from 2.0
through 2.4.  It needs updating for 2.6 kernels, enjoy.

=========

#!/usr/bin/perl -w
#
#	namespace.pl.  Mon Jan 27 1997
#
#	Perform a name space analysis on the linux kernel.
#
#	Copyright Keith Owens <kaos@ocs.com.au>.  GPL.
#
#	Invoke by changing directory to the top of the kernel source
#	tree then namespace.pl, no parameters.
#
#	Tuned for 2.1.x kernels with the new module handling, it will
#	work with 2.0 kernels as well.  Last change 2.4.25 for ia64.
#
#	The source must be compiled/assembled first, the object files
#	are the primary input to this script.  Incomplete or missing
#	objects will result in a flawed analysis.  Compile both vmlinux
#	and modules.
#
#	Even with complete objects, treat the result of the analysis
#	with caution.  Some external references are only used by
#	certain architectures, others with certain combinations of
#	configuration parameters.  Ideally the source should include
#	something like
#
#	#ifndef CONFIG_...
#	static
#	#endif
#	symbol_definition;
#
#	so the symbols are defined as static unless a particular
#	CONFIG_... requires it to be external.
#

require 5;	# at least perl 5
use strict;
use File::Find;

my $nm = "/usr/bin/nm -p";	# in case somebody moves nm
$nm = "/sw/sdev/gcc+bin-ia64/as3-gcc323-bin2.14.90.0.4/bin/nm -p";	# in case somebody moves nm

if ($#ARGV != -1) {
	print STDERR "usage: $0 takes no parameters\n";
	die("giving up\n");
}

my %nmdata = ();	# nm data for each object
my %def = ();		# all definitions for each name
my %ksymtab = ();	# names that appear in __ksymtab_
my %ref = ();		# $ref{$name} exists if there is a true external reference to $name
my %export = ();	# $export{$name} exists if there is an EXPORT_... of $name

&find(\&linux_objects, '.');	# find the objects and do_nm on them
list_multiply_defined();
resolve_external_references();
list_extra_externals();

exit(0);

sub linux_objects
{
	# Select objects, ignoring objects which are only created by
	# merging other objects.  Also ignore all of modules, scripts
	# and compressed.
	my $basename = $_;
	$_ = $File::Find::name;
	s:^\./::;
	if (/.*\.o$/ && ! (
	    m:/fs.o$: || m:/isofs.o$: || m:/nfs.o$:
	    || m:/xiafs.o$: || m:/umsdos.o$: || m:/hpfs.o$:
	    || m:/smbfs.o$: || m:/ncpfs.o$: || m:/ufs.o$:
	    || m:/affs.o$: || m:/romfs.o$: || m:/kernel.o$:
	    || m:/mm.o$: || m:/ipc.o$: || m:/ext.o$:
	    || m:/msdos.o$: || m:proc/proc.o$: || m:/minix.o$:
	    || m:/ext2.o$: || m:/sysv.o$: || m:/fat.o$:
	    || m:/vfat.o$: || m:/unix.o$: || m:/802.o$:
	    || m:/appletalk.o$: || m:/ax25.o$: || m:/core.o$:
	    || m:/ethernet.o$: || m:/ipv4.o$: || m:/ipx.o$:
	    || m:/netrom.o$: || m:/ipv6.o$: || m:/x25.o$:
	    || m:/rose.o$: || m:/bridge.o$: || m:/lapb.o$:
	    || m:/sock_n_syms.o$: || m:/teles.o$: || m:/pcbit.o$:
	    || m:/isdn.o$: || m:/ftape.o$: || m:/scsi_mod.o$:
	    || m:/sd_mod.o$: || m:/sr_mod.o$:
	    || m:/sound.o$: || m:/piggy.o$: || m:/bootsect.o$:
	    || m:/boot/setup.o$: || m:^modules/: || m:^scripts/:
	    || m:/compressed/: || m:/vmlinux-obj.o$:
	    || m:/autofs.o$: || m:lockd/lockd.o$: || m:/nfsd.o$:
	    || m:/sunrpc.o$: || m:/scsi_n_syms.o$:
	    || m:boot/bbootsect.o$: || m:boot/bsetup.o$:
	    || m:misc/parport.o$: || m:nls/nls.o$:
	    || m:debug/debug.o$: || m:netlink/netlink.o$:
	    || m:sched/sched.o$: || m:sound/sb.o$: 
	    || m:sound/soundcore.o$: || m:pci/pci_syms.o$: 
	    || m:devpts/devpts.o$: || m:video/fbdev.o$: 
	    || m:arch/i386/kdb/kdba.o$: || m:crypto/crypto.o$:
	    || m:drivers/block/block.o$: || m:drivers/cdrom/driver.o$:
	    || m:drivers/char/char.o$:
	    || m:drivers/ide/arm/idedriver-arm.o$:
	    || m:drivers/ide/ide-core.o$: || m:drivers/ide/ide-detect.o$:
	    || m:drivers/ide/idedriver.o$:
	    || m:drivers/ide/legacy/idedriver-legacy.o$:
	    || m:drivers/ide/pci/idedriver-pci.o$:
	    || m:drivers/ide/ppc/idedriver-ppc.o$:
	    || m:drivers/ide/raid/idedriver-raid.o$:
	    || m:drivers/md/lvm-mod.o$: || m:drivers/md/mddev.o$:
	    || m:drivers/media/media.o$: || m:drivers/media/radio/radio.o$:
	    || m:drivers/media/video/video.o$: || m:drivers/misc/misc.o$:
	    || m:drivers/net/e1000/e1000.o$: || m:drivers/net/net.o$:
	    || m:lib/zlib_deflate/zlib_deflate.o$:
	    || m:net/8021q/8021q.o$:
	    || m:net/bluetooth/bluez.o$:
	    || m:net/ipv4/netfilter/ipchains.o$:
	    || m:net/ipv4/netfilter/iptable_nat.o$:
	    || m:net/ipv4/netfilter/ip_conntrack.o$:
	    || m:net/ipv4/netfilter/netfilter.o$:
	    || m:net/ipv6/netfilter/netfilter.o$:
	    || m:drivers/parport/driver.o$: || m:drivers/pci/driver.o$:
	    || m:drivers/scsi/aic7xxx/aic7xxx_drv.o$:
	    || m:drivers/scsi/aic7xxx/aic7xxx.o$:
	    || m:drivers/scsi/scsidrv.o$:
	    || m:drivers/sound/sounddrivers.o$: || m:drivers/video/video.o$:
	    || m:fs/autofs4/autofs4.o$: || m:fs/ext3/ext3.o$:
	    || m:fs/jbd/jbd.o$: || m:fs/partitions/partitions.o$:
	    || m:fs/ramfs/ramfs.o$: || m:fs/xfs/linux/linux_xfs.o$:
	    || m:fs/xfs/pagebuf/pagebuf.o$:
	    || m:fs/xfs/support/support_xfs.o$: || m:fs/xfs/xfs.o$:
	    || m:kdb/kdb.o$:
	    || m:lib/zlib_inflate/zlib_inflate.o$: || m:net/network.o$:
	    || m:net/packet/packet.o$:
	    || m:fs/xfs/quota/xfs_quota.o$:
	    || m:fs/udf/udf.o$:
	    || m:fs/intermezzo/intermezzo.o$:
	    || m:fs/hugetlbfs/hugetlbfs.o$:
	    || m:fs/freevxfs/freevxfs.o$:
	    || m:fs/devfs/devfs.o$:
	    || m:fs/cramfs/cramfs.o$:
	    || m:drivers/usb/hid.o$:
	    || m:drivers/usb/usbcore.o$:
	    || m:drivers/sound/emu10k1/emu10k1.o$:
	    || m:drivers/sound/cs4281/cs4281.o$:
	    || m:drivers/net/tulip/tulip.o$:
	    || m:drivers/net/sk98lin/sk98lin.o$:
	    || m:drivers/net/bonding/bonding.o$:
	    || m:drivers/message/fusion/fusion.o$:
	    || m:drivers/input/inputdrv.o$:
	    || m:drivers/ieee1394/ieee1394.o$:
	    || m:drivers/char/joystick/js.o$:
	    || m:drivers/char/agp/agpgart.o$:
	    || m:drivers/char/agp/agp.o$:
	    || m:drivers/bluetooth/hci_uart.o$:
	    || m:drivers/acpi/acpi.o$:
	    || m:drivers/acpi/utilities/utilities.o$:
	    || m:drivers/acpi/tables/tables.o$:
	    || m:drivers/acpi/resources/resources.o$:
	    || m:drivers/acpi/parser/parser.o$:
	    || m:drivers/acpi/namespace/namespace.o$:
	    || m:drivers/acpi/hardware/hardware.o$:
	    || m:drivers/acpi/executer/executer.o$:
	    || m:drivers/acpi/events/events.o$:
	    || m:drivers/acpi/dispatcher/dispatcher.o$:
	    || m:arch/ia64/lib/__divsi3.o$:
	    || m:arch/ia64/lib/__udivsi3.o$:
	    || m:arch/ia64/lib/__modsi3.o$:
	    || m:arch/ia64/lib/__umodsi3.o$:
	    || m:arch/ia64/lib/__divdi3.o$:
	    || m:arch/ia64/lib/__udivdi3.o$:
	    || m:arch/ia64/lib/__moddi3.o$:
	    || m:arch/ia64/lib/__umoddi3.o$:
	    || m:arch/ia64/ia32/ia32.o$:
	  )
	) {
		do_nm($basename, $_);
	}
	$_ = $basename;		# File::Find expects $_ untouched (undocumented)
}

sub do_nm
{
	my ($basename, $fullname) = @_;
	my ($source, $type, $name);
	if (! -e $basename) {
		printf STDERR "$basename does not exist\n";
		return;
	}
	if ($fullname !~ /\.o$/) {
		printf STDERR "$fullname is not an object file\n";
		return;
	}
	$source = $basename;
	$source =~ s/\.o$//;
	if (! -e "$source.c" && ! -e "$source.S") {
		printf STDERR "No source file found for $fullname\n";
		return;
	}
	if (! open(NMDATA, "$nm $basename|")) {
		printf STDERR "$nm $fullname failed $!\n";
		return;
	}
	my @nmdata;
	while (<NMDATA>) {
		chop;
		($type, $name) = (split(/ +/, $_, 3))[1..2];
		# Expected types
		# B weak external reference to data that has been resolved
		# C global variable, uninitialised
		# D global variable, initialised
		# G global variable, initialised, small data section
		# R global array, initialised
		# S global variable, uninitialised, small bss
		# T global label/procedure
		# U external reference
		# W weak external reference to text that has been resolved
		# a assembler equate
		# b static variable, uninitialised
		# d static variable, initialised
		# g static variable, initialised, small data section
		# r static array, initialised
		# s static variable, uninitialised, small bss
		# t static label/procedures
		# w weak external reference to text that has not been resolved
		# ? undefined type, used a lot by modules
		if ($type !~ /^[BCDGRSTUWabdgrstw?]$/) {
			printf STDERR "nm output for $fullname contains unknown type '$_'\n";
		}
		elsif ($name =~ /\./) {
			# name with '.' is local static
		}
		else {
			$type = 'R' if ($type eq '?');	# binutils replaced ? with R at one point
			$name =~ s/_R[a-f0-9]{8}$//;	# module versions adds this
			if ($type =~ /[BCDGRSTW]/ &&
				$name ne 'init_module' &&
				$name ne 'cleanup_module' &&
				$name ne 'Using_Versions' &&
				$name !~ /^Version_[0-9]+$/ &&
				$name !~ /^__module_parm_/ &&
				$name !~ /^__kstrtab/ &&
				$name !~ /^__ksymtab/ &&
				$name ne '__module_description' &&
				$name ne '__module_author' &&
				$name ne '__module_device' &&
				$name ne 'kernel_version') {
				if (!exists($def{$name})) {
					$def{$name} = [];
				}
				push(@{$def{$name}}, $fullname);
			}
			push(@nmdata, "$type $name");
			if ($name =~ /^__ksymtab_/) {
				$name = substr($name, 10);
				if (!exists($ksymtab{$name})) {
					$ksymtab{$name} = [];
				}
				push(@{$ksymtab{$name}}, $fullname);
			}
		}
	}
	close(NMDATA);
	if ($#nmdata < 0) {
		printf "No nm data for $fullname\n";
		return;
	}
	$nmdata{$fullname} = \@nmdata;
}

sub list_multiply_defined
{
	my ($name, $module);
	foreach $name (keys(%def)) {
		if ($#{$def{$name}} > 0) {
			printf "$name is multiply defined in :-\n";
			foreach $module (@{$def{$name}}) {
				printf "\t$module\n";
			}
		}
	}
}

sub resolve_external_references
{
	my ($object, $type, $name, $i, $j, $kstrtab, $ksymtab, $export);
	printf "\n";
	foreach $object (keys(%nmdata)) {
		my $nmdata = $nmdata{$object};
		for ($i = 0; $i <= $#{$nmdata}; ++$i) {
			($type, $name) = split(' ', $nmdata->[$i], 2);
			if ($type eq "U" || $type eq "w") {
				if (exists($def{$name}) || exists($ksymtab{$name})) {
					# add the owning object to the nmdata
					$nmdata->[$i] = "$type $name $object";
					# only count as a reference if it is not EXPORT_...
					$kstrtab = "R __kstrtab_$name";
					$ksymtab = "R __ksymtab_$name";
					$export = 0;
					for ($j = 0; $j <= $#{$nmdata}; ++$j) {
						if ($nmdata->[$j] eq $kstrtab ||
						    $nmdata->[$j] eq $ksymtab) {
							$export = 1;
							last;
						}
					}
					if ($export) {
						$export{$name} = "";
					}
					else {
						$ref{$name} = ""
					}
				}
				elsif ($name ne "mod_use_count_" &&
				       $name ne "__this_module" &&
				       $name ne "_etext" &&
				       $name ne "_edata" &&
				       $name ne "_end" &&
				       $name ne "__start___ksymtab" &&
				       $name ne "__start___ex_table" &&
				       $name ne "__stop___ksymtab" &&
				       $name ne "__stop___ex_table" &&
				       $name ne "__stop___ex_table" &&
				       $name ne "__bss_start" &&
				       $name ne "_text" &&
				       $name ne "_stext" &&
				       $name ne "__start_gate_section" &&
				       $name ne "__start___kallsyms" &&
				       $name ne "__stop___kallsyms" &&
				       $name ne "__gp" &&
				       $name ne "__start_gate_section" &&
				       $name ne "__stop_gate_section" &&
				       $name ne "ia64_unw_start" &&
				       $name ne "__setup_start" &&
				       $name ne "__setup_end" &&
				       $name ne "__initcall_start" &&
				       $name ne "__initcall_end" &&
				       $name ne "ia64_unw_end" &&
				       $name ne "__init_begin" &&
				       $name ne "__init_end") {
					printf "Cannot resolve reference to $name from $object\n";
				}
			}
		}
	}
}

sub list_extra_externals
{
	my %noref = ();
	my ($name, @module, $module, $export);
	foreach $name (keys(%def)) {
		if (! exists($ref{$name})) {
			@module = @{$def{$name}};
			foreach $module (@module) {
				if (! exists($noref{$module})) {
					$noref{$module} = [];
				}
				push(@{$noref{$module}}, $name);
			}
		}
	}
	if (%noref) {
		printf "\nExternally defined symbols with no external references\n";
		foreach $module (sort(keys(%noref))) {
			printf "  $module\n";
			foreach (sort(@{$noref{$module}})) {
				if (exists($export{$_})) {
					$export = " (export only)";
				}
				else {
					$export = "";
				}
				printf "    $_$export\n";
			}
		}
	}
}

=========

Example output against a 2.4.25 ia64 kernel.

"Externally defined symbols with no external references" means that
these are global symbols with no references from outside the object
they are defined in, when built for this architecture and this config.
It does not mean that the symbol is not used, only that it is not used
by name outside the current source for one architecture and one config.

Be warned: this script gets false positives.  Do not blindly change or
remove symbols.

For each suspect symbol, verify that there is no source that refers to
it, a config change might activate that source.  If no other source
refers to the symbol then change it to static and rebuild.  If gcc says
that the symbol is not used when it is marked static then remove it
completely.


No nm data for fs/filesystems.o
No nm data for fs/intermezzo/journal_obdfs.o
No nm data for fs/intermezzo/journal_reiserfs.o
No nm data for fs/intermezzo/journal_xfs.o
No nm data for drivers/ieee1394/oui.o
No nm data for drivers/ide/ide-probe-mini.o
uhci_device_operations is multiply defined in :-
	drivers/usb/host/uhci.o
	drivers/usb/host/usb-uhci.o
bust_spinlocks is multiply defined in :-
	lib/bust_spinlocks.o
	arch/ia64/kernel/traps.o

Cannot resolve reference to acpi_pci_link_exit from drivers/acpi/bus.o
Cannot resolve reference to __multi3 from drivers/usb/hid-core.o
Cannot resolve reference to __multi3 from drivers/ieee1394/ieee1394_core.o
Cannot resolve reference to __multi3 from fs/nfs/dir.o
Cannot resolve reference to __multi3 from fs/isofs/compress.o
Cannot resolve reference to msdos_partition from fs/partitions/check.o
Cannot resolve reference to __multi3 from net/ipv4/netfilter/ip_tables.o
Cannot resolve reference to __multi3 from drivers/message/fusion/mptbase.o
Cannot resolve reference to __multi3 from drivers/message/i2o/i2o_core.o
Cannot resolve reference to __multi3 from drivers/message/i2o/i2o_lan.o

Externally defined symbols with no external references
  arch/ia64/dig/setup.o
    drive_info
  arch/ia64/ia32/binfmt_elf32.o
    ia32_install_shared_page
    ia32_setup_arg_pages
    ia64_elf32_init
  arch/ia64/ia32/ia32_entry.o
    sys32_fork
    sys32_vfork
  arch/ia64/ia32/ia32_signal.o
    copy_siginfo_from_user32
    copy_siginfo_to_user32
  arch/ia64/ia32/ia32_support.o
    ia32_exec_domain
    ia32_gdt
  arch/ia64/ia32/sys_ia32.o
    sys32_recvmsg
    sys32_sendmsg
  arch/ia64/kernel/acpi.o
    acpi_find_vendor_resource
    acpi_get_interrupt_model
    acpi_get_sysname
    acpi_hp_csr_space (export only)
    acpi_madt
    acpi_register_irq
    acpi_vendor_resource_match
    hp_ccsr_descriptor
    platform_intr_list
  arch/ia64/kernel/efi.o
    efi_enter_virtual_mode
  arch/ia64/kernel/entry.o
    ia64_leave_syscall
    ia64_ret_from_execve_syscall
    sys_clone
    sys_clone2
    sys_rt_sigsuspend
  arch/ia64/kernel/head.o
    _start
    ia64_spinlock_contention
  arch/ia64/kernel/iosapic.o
    iosapic_fixup_pci_interrupt
    irq_type_iosapic_edge
  arch/ia64/kernel/irq.o
    handle_IRQ_event
    irq_err_count
    no_action
    probe_irq_mask (export only)
  arch/ia64/kernel/mca_asm.o
    ia64_os_mca_dispatch_end
  arch/ia64/kernel/pal.o
    ia64_pal_default_handler
  arch/ia64/kernel/pci.o
    pci_root_ops
    pci_sal_ops
    pcibios_fixup_device_resources
    pcibios_fixup_pbus_ranges
    pcibios_update_irq
  arch/ia64/kernel/perfmon.o
    pfm_init
    pfm_install_alternate_syswide_subsystem (export only)
    pfm_remove_alternate_syswide_subsystem (export only)
  arch/ia64/kernel/process.o
    default_idle
    do_copy_regs
    do_dump_fpu
  arch/ia64/kernel/sal.o
    ia64_ptc_domain_info
    ia64_sal_handler_init
  arch/ia64/kernel/salinfo.o
    salinfo_platform_oemdata
  arch/ia64/kernel/setup.o
    ia64_cycles_per_usec
    identify_cpu
    mmu_gathers
  arch/ia64/kernel/smpboot.o
    ia64_sync_itc
    sync_master
  arch/ia64/lib/csum_partial_copy.o
    csum_partial_copy
  arch/ia64/lib/memcpy.o
    bcopy
  arch/ia64/lib/strlen_user.o
    __strlen_user (export only)
  arch/ia64/mm/hugetlbpage.o
    free_huge_page
    set_hugetlb_mem_size
    try_to_free_low
    unmap_hugepage_range
    update_and_free_page
  arch/ia64/mm/init.o
    cdata
    ia64_set_rbs_bot
    put_gate_page
  arch/ia64/mm/tlb.o
    ia64_global_tlb_purge
  drivers/acpi/blacklist.o
    acpi_blacklisted
  drivers/acpi/bus.o
    acpi_bus_scan (export only)
    acpi_exit
    acpi_root
    acpi_setup
  drivers/acpi/button.o
    acpi_button_notify
    acpi_button_notify_fixed
  drivers/acpi/dispatcher/dsfield.o
    acpi_ds_get_field_names
  drivers/acpi/dispatcher/dsinit.o
    acpi_ds_init_one_object
  drivers/acpi/dispatcher/dsmthdat.o
    acpi_ds_method_data_delete_value
    acpi_ds_method_data_get_type
    acpi_ds_method_data_set_value
  drivers/acpi/dispatcher/dsobject.o
    acpi_ds_build_internal_object
  drivers/acpi/dispatcher/dsopcode.o
    acpi_ds_execute_arguments
    acpi_ds_init_buffer_field
  drivers/acpi/dispatcher/dswload.o
    acpi_ds_load1_begin_op
    acpi_ds_load1_end_op
  drivers/acpi/dispatcher/dswstate.o
    acpi_ds_obj_stack_delete_all
    acpi_ds_obj_stack_get_value
    acpi_ds_result_insert
    acpi_ds_result_remove
  drivers/acpi/events/evevent.o
    acpi_ev_fixed_event_dispatch
    acpi_ev_fixed_event_initialize
  drivers/acpi/events/evgpe.o
    acpi_ev_gpe_dispatch
  drivers/acpi/events/evmisc.o
    acpi_ev_notify_dispatch
  drivers/acpi/events/evxface.o
    acpi_acquire_global_lock (export only)
    acpi_install_gpe_handler (export only)
    acpi_release_global_lock (export only)
    acpi_remove_gpe_handler (export only)
  drivers/acpi/events/evxfevnt.o
    acpi_clear_event (export only)
    acpi_clear_gpe
    acpi_disable_gpe
    acpi_enable_gpe
    acpi_get_event_status
    acpi_get_gpe_status
    acpi_install_gpe_block (export only)
    acpi_remove_gpe_block (export only)
  drivers/acpi/events/evxfregn.o
    acpi_remove_address_space_handler (export only)
  drivers/acpi/executer/exconfig.o
    acpi_ex_add_table
  drivers/acpi/executer/exconvrt.o
    acpi_ex_convert_to_ascii
  drivers/acpi/executer/exdump.o
    acpi_ex_dump_node
    acpi_ex_dump_object_descriptor
    acpi_ex_out_address
    acpi_ex_out_integer
    acpi_ex_out_pointer
    acpi_ex_out_string
  drivers/acpi/executer/exfldio.o
    acpi_ex_field_datum_io
    acpi_ex_get_buffer_datum
    acpi_ex_register_overflow
    acpi_ex_set_buffer_datum
    acpi_ex_setup_region
    acpi_ex_write_with_update_rule
  drivers/acpi/executer/exmutex.o
    acpi_ex_link_mutex
  drivers/acpi/executer/exnames.o
    acpi_ex_allocate_name_string
    acpi_ex_name_segment
  drivers/acpi/executer/exoparg6.o
    acpi_ex_do_match
  drivers/acpi/executer/exresolv.o
    acpi_ex_resolve_object_to_value
  drivers/acpi/executer/exresop.o
    acpi_ex_check_object_type
  drivers/acpi/executer/exstore.o
    acpi_ex_store_object_to_index
  drivers/acpi/executer/exutils.o
    acpi_ex_digits_needed
  drivers/acpi/fan.o
    acpi_fan_add
    acpi_fan_dir
    acpi_fan_exit
    acpi_fan_init
    acpi_fan_remove
  drivers/acpi/hardware/hwsleep.o
    acpi_enter_sleep_state_s4bios (export only)
    acpi_get_firmware_waking_vector
    acpi_leave_sleep_state
    acpi_set_firmware_waking_vector
  drivers/acpi/hardware/hwtimer.o
    acpi_get_timer (export only)
    acpi_get_timer_duration (export only)
    acpi_get_timer_resolution
  drivers/acpi/namespace/nsalloc.o
    acpi_ns_remove_reference
  drivers/acpi/namespace/nsdump.o
    acpi_ns_dump_objects
    acpi_ns_dump_tables
  drivers/acpi/namespace/nsdumpdv.o
    acpi_ns_dump_one_device
    acpi_ns_dump_root_devices
  drivers/acpi/namespace/nseval.o
    acpi_ns_execute_control_method
    acpi_ns_get_object_value
  drivers/acpi/namespace/nsinit.o
    acpi_ns_init_one_device
    acpi_ns_init_one_object
  drivers/acpi/namespace/nsload.o
    acpi_ns_delete_subtree
    acpi_ns_load_table_by_type
    acpi_ns_unload_namespace
  drivers/acpi/namespace/nsnames.o
    acpi_ns_build_external_path
  drivers/acpi/namespace/nsparse.o
    acpi_ns_one_complete_parse
  drivers/acpi/namespace/nsutils.o
    acpi_ns_build_internal_name
    acpi_ns_externalize_name
    acpi_ns_find_parent_name
    acpi_ns_get_internal_name_length
    acpi_ns_valid_path_separator
  drivers/acpi/namespace/nsxfeval.o
    acpi_detach_data
    acpi_evaluate_object_typed
    acpi_get_devices (export only)
  drivers/acpi/osl.o
    acpi_os_get_line
    acpi_os_get_physical_address
    acpi_os_name_setup
    acpi_os_writable
  drivers/acpi/parser/psargs.o
    acpi_ps_get_next_field
    acpi_ps_get_next_package_length
  drivers/acpi/parser/psopcode.o
    acpi_gbl_aml_op_info
  drivers/acpi/parser/psparse.o
    acpi_ps_complete_this_op
    acpi_ps_get_opcode_size
    acpi_ps_next_parse_state
    acpi_ps_parse_loop
  drivers/acpi/parser/pstree.o
    acpi_ps_get_child
    acpi_ps_get_depth_next
  drivers/acpi/parser/psutils.o
    acpi_ps_get_name
  drivers/acpi/parser/pswalk.o
    acpi_ps_delete_completed_op
    acpi_ps_get_next_walk_op
  drivers/acpi/pci_bind.o
    acpi_os_get_pci_id
    acpi_pci_data_handler
  drivers/acpi/pci_irq.o
    acpi_pci_irq_enable (export only)
    acpi_pci_irq_init
    acpi_pci_irq_lookup (export only)
  drivers/acpi/pci_link.o
    acpi_irq_balance_set
  drivers/acpi/pci_root.o
    acpi_pci_register_driver (export only)
    acpi_pci_unregister_driver (export only)
  drivers/acpi/power.o
    acpi_power_add
    acpi_power_dir
    acpi_power_remove
  drivers/acpi/resources/rsdump.o
    acpi_rs_dump_address16
    acpi_rs_dump_address32
    acpi_rs_dump_address64
    acpi_rs_dump_dma
    acpi_rs_dump_extended_irq
    acpi_rs_dump_fixed_io
    acpi_rs_dump_fixed_memory32
    acpi_rs_dump_io
    acpi_rs_dump_irq
    acpi_rs_dump_irq_list
    acpi_rs_dump_memory24
    acpi_rs_dump_memory32
    acpi_rs_dump_resource_list
    acpi_rs_dump_start_depend_fns
    acpi_rs_dump_vendor_specific
  drivers/acpi/resources/rsxface.o
    acpi_get_current_resources (export only)
    acpi_get_possible_resources (export only)
  drivers/acpi/system.o
    sysrq_acpi_poweroff_op
  drivers/acpi/tables.o
    acpi_table_parse_madt_family
    acpi_table_print
  drivers/acpi/tables/tbget.o
    acpi_tb_get_this_table
    acpi_tb_table_override
  drivers/acpi/tables/tbgetall.o
    acpi_tb_get_primary_table
    acpi_tb_get_secondary_table
  drivers/acpi/tables/tbinstal.o
    acpi_tb_match_signature
  drivers/acpi/tables/tbutils.o
    acpi_tb_handle_to_object
  drivers/acpi/tables/tbxface.o
    acpi_get_table_header
    acpi_load_table
    acpi_unload_table
  drivers/acpi/tables/tbxfroot.o
    acpi_find_root_pointer
    acpi_get_firmware_table (export only)
    acpi_tb_find_rsdp
    acpi_tb_scan_memory_for_rsdp
  drivers/acpi/utilities/utalloc.o
    acpi_ut_allocate
    acpi_ut_callocate
    acpi_ut_dump_allocation_info
    acpi_ut_find_allocation
    acpi_ut_remove_allocation
    acpi_ut_track_allocation
  drivers/acpi/utilities/utcopy.o
    acpi_ut_copy_esimple_to_isimple
    acpi_ut_copy_ielement_to_eelement
    acpi_ut_copy_ielement_to_ielement
    acpi_ut_copy_ipackage_to_ipackage
    acpi_ut_copy_simple_object
  drivers/acpi/utilities/utdelete.o
    acpi_ut_delete_internal_obj
  drivers/acpi/utilities/utglobal.o
    acpi_gbl_abort_method
    acpi_gbl_acpi_hardware_present
    acpi_gbl_breakpoint_walk
    acpi_gbl_cm_single_step
    acpi_gbl_current_node_size
    acpi_gbl_db_output_flags
    acpi_gbl_db_terminate_threads
    acpi_gbl_debugger_configuration
    acpi_gbl_exception_names_aml
    acpi_gbl_exception_names_ctrl
    acpi_gbl_exception_names_env
    acpi_gbl_exception_names_pgm
    acpi_gbl_exception_names_tbl
    acpi_gbl_max_concurrent_node_count
    acpi_gbl_method_executing
    acpi_gbl_next_method_owner_id
    acpi_gbl_next_table_owner_id
    acpi_gbl_parsed_namespace_root
    acpi_gbl_pm1_enable_register_save
    acpi_gbl_ps_find_count
    acpi_gbl_region_types
    acpi_gbl_rsdp_original_location
    acpi_gbl_step_to_next_call
  drivers/acpi/utilities/utinit.o
    acpi_ut_terminate
  drivers/acpi/utilities/utmisc.o
    acpi_ut_create_mutex
    acpi_ut_create_pkg_state
    acpi_ut_create_pkg_state_and_push
    acpi_ut_delete_mutex
    acpi_ut_strupr
  drivers/acpi/utilities/utobject.o
    acpi_ut_allocate_object_desc_dbg
    acpi_ut_get_element_length
    acpi_ut_get_package_object_size
    acpi_ut_get_simple_object_size
  drivers/acpi/utilities/utxface.o
    acpi_get_system_info (export only)
    acpi_install_initialization_handler
    acpi_subsystem_status
  drivers/acpi/utils.o
    acpi_extract_package (export only)
  drivers/block/DAC960.o
    DAC960_KernelIOCTL
  drivers/block/blkpg.o
    add_partition
    blkpg_ioctl
    del_partition
  drivers/block/cciss.o
    cciss_init
    cciss_pci_device_id
  drivers/block/cpqarray.o
    cpqarray_init
    cpqarray_pci_device_id
    init_cpqarray_module
  drivers/block/elevator.o
    bh_rq_in_between
    elevator_noop_merge
    elevator_noop_merge_req
  drivers/block/genhd.o
    device_init
    gendisk_head
    walk_gendisk
  drivers/block/ll_rw_blk.o
    blk_grow_request_list
    blk_max_pfn
    drive_stat_acct
    req_merged_io
    req_new_io
  drivers/block/loop.o
    loop_exit
    loop_init
    loop_register_transfer
    loop_unregister_transfer
    none_funcs
    xfer_funcs
    xor_funcs
  drivers/block/nbd.o
    nbd_clear_que
    nbd_do_it
    nbd_read_stat
    nbd_send_req
  drivers/block/rd.o
    rd_blocksize
    rd_size
  drivers/bluetooth/hci_ldisc.o
    hci_uart_cleanup
    hci_uart_init
    hci_uart_register_proto
    hci_uart_tx_wakeup
    hci_uart_unregister_proto
  drivers/bluetooth/hci_usb.o
    _urb_alloc
    _urb_dequeue
    hci_usb_cleanup
    hci_usb_init
  drivers/bluetooth/hci_vhci.o
    hci_vhci_cleanup
    hci_vhci_init
  drivers/cdrom/cdrom.o
    cdrom_cdrom_table
    cdrom_count_tracks
    cdrom_find_device
    cdrom_get_disc_info
    cdrom_get_next_writable
    cdrom_get_track_info
    cdrom_root_table
    cdrom_select_disc
    cdrom_sysctl_info
    cdrom_sysctl_settings
    cdrom_table
    cdrom_update_settings
  drivers/char/agp/agpgart_be.o
    agp_gatt_table
    agp_init
    agp_memory_reserved
    agp_setup
  drivers/char/agp/agpgart_fe.o
    agp_find_private
    agp_insert_file_private
    agp_remove_file_private
  drivers/char/console.o
    console_blank_hook
    give_up_console
    kmsg_redirect
    set_palette
    vt_console_driver
    vt_console_print
    want_console
  drivers/char/consolemap.o
    con_protect_unimap
  drivers/char/defkeymap.o
    alt_map
    altgr_map
    ctrl_alt_map
    ctrl_map
    plain_map
    shift_ctrl_map
    shift_map
  drivers/char/joystick/a3d.o
    a3d_adc_cooked_read
    a3d_adc_open
    a3d_exit
    a3d_init
    a3d_names
  drivers/char/joystick/adi.o
    adi_exit
    adi_init
  drivers/char/joystick/analog.o
    analog_exit
    analog_init
    analog_types
  drivers/char/joystick/cobra.o
    cobra_exit
    cobra_init
  drivers/char/joystick/cs461x.o
    js_cs461x_exit
    js_cs461x_init
  drivers/char/joystick/emu10k1-gp.o
    emu_exit
    emu_init
  drivers/char/joystick/gameport.o
    gameport_rescan
  drivers/char/joystick/gf2k.o
    gf2k_exit
    gf2k_init
  drivers/char/joystick/grip.o
    grip_exit
    grip_init
  drivers/char/joystick/interact.o
    interact_exit
    interact_init
  drivers/char/joystick/lightning.o
    l4_exit
    l4_init
    l4_port
  drivers/char/joystick/magellan.o
    magellan_exit
    magellan_init
  drivers/char/joystick/ns558.o
    ns558_exit
    ns558_init
  drivers/char/joystick/pcigame.o
    pcigame_exit
    pcigame_init
  drivers/char/joystick/serio.o
    serio_rescan
  drivers/char/joystick/serport.o
    serport_exit
    serport_init
  drivers/char/joystick/sidewinder.o
    sw_exit
    sw_init
  drivers/char/joystick/spaceball.o
    spaceball_exit
    spaceball_init
  drivers/char/joystick/spaceorb.o
    spaceorb_exit
    spaceorb_init
  drivers/char/joystick/stinger.o
    stinger_exit
    stinger_init
  drivers/char/joystick/tmdc.o
    tmdc_exit
    tmdc_init
  drivers/char/joystick/warrior.o
    warrior_exit
    warrior_init
  drivers/char/keyboard.o
    pm_kbd_request_override
    put_queue
    register_leds
    to_utf8
  drivers/char/mem.o
    chr_dev_init
    kmem_vm_nopage
    kmem_vm_ops
    memory_devfs_register
  drivers/char/n_tty.o
    n_tty_chars_in_buffer
    n_tty_flush_buffer
  drivers/char/pc_keyb.o
    kbd_startup_reset
    panic_blink
    pckbd_pm_resume
    psaux_fops
  drivers/char/random.o
    batch_entropy_store
    generate_random_uuid
    rand_initialize_blkdev
    secure_ipv6_id (export only)
  drivers/char/raw.o
    raw_ctl_ioctl
    raw_ioctl
    raw_open
    raw_read
    raw_release
    raw_write
  drivers/char/serial.o
    early_serial_setup
    pci_siig10x_fn
    pci_siig20x_fn
    register_serial
    rs_table
    serial_icr_read
    serial_icr_write
    serial_nr_ports
    unregister_serial
  drivers/char/sysrq.o
    __handle_sysrq_nolock
    sysrq_power_off
  drivers/char/tty_io.o
    do_tty_hangup
    tty_default_put_char
    tty_ioctl
    tty_paranoia_check
  drivers/char/tty_ioctl.o
    send_prio_char
  drivers/char/vt.o
    _kbd_rate
    _kd_mksound
    complete_change_console
    default_font_height
    keyboard_type
    vt_dont_switch
    vt_waitactive
  drivers/ide/ide-cd.o
    ide_cdrom_abort
    ide_cdrom_dump_status
    ide_cdrom_error
    ignore
    packet_command_texts
    sense_data_texts
    sense_key_texts
  drivers/ide/ide-disk.o
    ide_disk_resume
    ide_disk_suspend
    ide_disk_unsuspend
    ide_disks_busy
    ide_multwrite
    idedisk_abort
    idedisk_error
    panic_box
    promise_rw_disk
  drivers/ide/ide-dma.o
    __ide_dma_bad_drive
    __ide_dma_check
    __ide_dma_count
    __ide_dma_good_drive
    __ide_dma_host_off
    __ide_dma_host_on
    __ide_dma_off
    __ide_dma_off_quietly
    __ide_dma_on
    __ide_dma_read
    __ide_dma_retune
    __ide_dma_test_irq
    __ide_dma_verbose
    __ide_dma_write
    drive_blacklist
    drive_whitelist
    ide_allocate_dma_engine
    ide_build_dmatable
    ide_destroy_dmatable
    ide_dma_intr
    ide_dma_iobase
    ide_iomio_dma
    ide_mapped_mmio_dma
    ide_mmio_dma
    ide_release_dma_engine
    ide_release_iomio_dma
    ide_release_mmio_dma
  drivers/ide/ide-geometry.o
    ide_xlate_1024
  drivers/ide/ide-io.o
    do_special
    drive_cmd_intr
    execute_drive_cmd
    ide_cmd
    ide_do_request
    try_to_flush_leftover_data
  drivers/ide/ide-iops.o
    __ide_set_handler
    ata_input_data
    ata_output_data
    ata_vlb_sync
    atapi_input_bytes
    atapi_output_bytes
    check_dma_crc
    default_hwif_mmiops
    ide_auto_reduce_xfer
    pre_reset
    read_24
    unplugged_hwif_iops
    wait_for_ready
  drivers/ide/ide-lib.o
    ide_pio_timings
    ide_xfer_verbose
  drivers/ide/ide-probe.o
    export_ide_init_queue
    hwif_init
    init_irq
    probe_hwif
    save_match
  drivers/ide/ide-proc.o
    create_proc_ide_drives
    destroy_proc_ide_device
    destroy_proc_ide_interfaces
    proc_ide_destroy
    proc_ide_read_channel
    proc_ide_read_config
    proc_ide_read_dmodel
    proc_ide_read_driver
    proc_ide_read_drivers
    proc_ide_read_identify
    proc_ide_read_imodel
    proc_ide_read_mate
    proc_ide_read_media
    proc_ide_read_settings
    proc_ide_write_driver
    proc_ide_write_settings
    recreate_proc_ide_device
  drivers/ide/ide-tape.o
    idetape_attach
    idetape_init
    idetape_seek_logical_blk
  drivers/ide/ide-taskfile.o
    flagged_pre_task_mulout_intr
    flagged_pre_task_out_intr
    flagged_task_in_intr
    flagged_task_mulin_intr
    flagged_task_mulout_intr
    flagged_task_no_data_intr
    flagged_task_out_intr
    ide_diag_taskfile
    ide_end_taskfile
    ide_handler_parser
    ide_init_drive_taskfile
    ide_post_handler_parser
    ide_pre_handler_parser
    ide_taskfile_ioctl
    ide_wait_cmd_task
    pre_task_mulout_intr
    pre_task_out_intr
    recal_intr
    set_geometry_intr
    set_multmode_intr
    task_in_intr
    task_map_rq
    task_mulin_intr
    task_mulout_intr
    task_no_data_intr
    task_out_intr
    task_read_24
    task_try_to_flush_leftover_data
    task_unmap_rq
    taskfile_dump_status
    taskfile_error
  drivers/ide/ide.o
    generic_subdriver_entries
    hwif_unregister
    ide_atapi_to_scsi
    ide_attach_drive
    ide_chipsets
    ide_driver_module
    ide_geninit
    ide_init
    ide_init_builtin_drivers
    ide_init_builtin_subdrivers
    ide_probe_module
    ide_register
    ide_register_driver
    ide_register_hw
    ide_remove_setting
    ide_revalidate_disk
    ide_setup
    ide_setup_ports
    ide_system_bus_speed
    ide_unregister
    idecd
    idedisk
    idefloppy
    idescsi
    idetape
  drivers/ide/pci/hpt366.o
    bad_ata100_5
    bad_ata33
    bad_ata66_3
    bad_ata66_4
    fifty_base_hpt370a
    fifty_base_hpt372
    forty_base_hpt366
    quirk_drives
    sixty_six_base_hpt370
    sixty_six_base_hpt370a
    sixty_six_base_hpt372
    thirty_three_base_hpt366
    thirty_three_base_hpt370
    thirty_three_base_hpt370a
    thirty_three_base_hpt372
    thirty_three_base_hpt374
    twenty_five_base_hpt366
  drivers/ide/pci/serverworks.o
    svwks_bad_ata100
  drivers/ieee1394/highlevel.o
    highlevel_host_reset (export only)
    highlevel_lock (export only)
    highlevel_lock64 (export only)
    highlevel_read (export only)
    highlevel_write (export only)
    hpsb_get_host_bykey (export only)
    hpsb_get_hostinfo_key (export only)
    hpsb_set_hostinfo (export only)
  drivers/ieee1394/ieee1394_core.o
    abort_requests
    handle_packet_response
    hpsb_speedto_str
    ieee1394_devfs_handle
  drivers/ieee1394/ieee1394_transactions.o
    hpsb_get_tlabel (export only)
    hpsb_lock64 (export only)
    hpsb_packet_success (export only)
    hpsb_send_gasp (export only)
  drivers/ieee1394/nodemgr.o
    hpsb_guid_get_entry (export only)
    hpsb_node_fill_packet (export only)
    hpsb_node_lock (export only)
    hpsb_node_read (export only)
    hpsb_node_write (export only)
    hpsb_nodeid_get_entry (export only)
    hpsb_release_unit_directory (export only)
  drivers/ieee1394/video1394.o
    video1394_mmap
    wakeup_dma_ir_ctx
    wakeup_dma_it_ctx
  drivers/input/keybdev.o
    keybdev_event
    keybdev_ledfunc
  drivers/input/mousedev.o
    mousedev_fops
  drivers/md/lvm-snap.o
    lvm_drop_snapshot
    lvm_snapshot_alloc_iobuf_pages
  drivers/md/lvm.o
    lvm_init
  drivers/md/md.o
    add_mddev_mapping
    del_mddev_mapping
    detect_old_array
    find_rdev
    md_do_recovery
    md_hd_struct
    md_init
    md_notifier
    md_notify_reboot
    md_run_setup
    md_setup_drive
    md_thread
    mddev_map
    raid_setup_args
    resync_wait
  drivers/md/multipath.o
    multipath_end_request
    multipath_retry_list
    multipath_retry_tail
  drivers/md/raid1.o
    raid1_end_request
    raid1_retry_list
    raid1_retry_tail
  drivers/md/raid5.o
    device_bsize
  drivers/message/fusion/mptbase.o
    fusion_init
    mpt_adapters
    mpt_add_chain
    mpt_deregister_ascqops_strings
    mpt_handshake_req_reply_wait
    mpt_ioc_proc_list
    mpt_lan_index
    mpt_proc_list
    mpt_proc_root_dir
    mpt_register_ascqops_strings
    mpt_stm_index
  drivers/message/fusion/mptctl.o
    mptctl_exit
    mptctl_init
  drivers/message/fusion/mptscsih.o
    mpt_ScsiHost_ErrorReport
    mptscsih_bios_param
    mptscsih_detect
    mptscsih_info
    mptscsih_old_abort
    mptscsih_old_reset
    mptscsih_proc_info
    mptscsih_qcmd
    mptscsih_release
    mptscsih_select_queue_depths
    mptscsih_setTargetNegoParms
    mptscsih_taskmgmt_bh
  drivers/message/i2o/i2o_config.o
    cfg_handler
    i2o_wait_queue
  drivers/message/i2o/i2o_core.o
    __i2o_delete_device
    i2o_activate_controller
    i2o_clear_controller
    i2o_clear_table
    i2o_controller_chain
    i2o_delete_device
    i2o_dump_message
    i2o_enable_controller
    i2o_install_device
    i2o_num_controllers
    i2o_quiesce_controller
    i2o_report_common_status
    i2o_report_controller_unit
    i2o_report_fail_status
    i2o_row_add_table
    i2o_wait_message
  drivers/message/i2o/i2o_lan.o
    i2o_lan_register_device
    i2o_lan_set_mc_filter
    i2o_lan_set_mc_table
    i2o_post_buckets_task
    run_i2o_post_buckets_task
  drivers/message/i2o/i2o_pci.o
    i2o_pci_install
    i2o_pci_scan
  drivers/message/i2o/i2o_proc.o
    i2o_get_connection_type
    i2o_get_connector_type
    i2o_proc_init
  drivers/net/acenic.o
    ace_module_init
    acenic_probe
  drivers/net/auto_irq.o
    autoirq_report
    autoirq_setup
  drivers/net/bonding/bond_3ad.o
    bond_3ad_rx_indication
  drivers/net/bonding/bond_alb.o
    rlb_choose_channel
    tlb_choose_channel
  drivers/net/bonding/bond_main.o
    arp_target_hw_addr
  drivers/net/bsd_comp.o
    bsdcomp_cleanup
    bsdcomp_init
  drivers/net/e1000/e1000_hw.o
    e1000_check_downshift
    e1000_check_polarity
    e1000_clear_hw_cntrs
    e1000_clear_vfta
    e1000_config_dsp_after_link_change
    e1000_config_fc_after_link_up
    e1000_detect_gig_phy
    e1000_get_cable_length
    e1000_init_rx_addrs
    e1000_mc_addr_list_update
    e1000_phy_igp_get_info
    e1000_phy_m88_get_info
    e1000_read_reg_io
    e1000_set_d3_lplu_state
    e1000_setup_link
    e1000_wait_autoneg
    e1000_write_reg_io
  drivers/net/e1000/e1000_main.o
    e1000_copyright
    e1000_driver_string
    e1000_notifier_reboot
  drivers/net/ns83820.o
    eeprom_clk_hi
    eeprom_clk_lo
    eeprom_readw
    eeprom_send_addr
    eeprom_writeb
    setup_ee_mem_bitbanger
  drivers/net/ppp_async.o
    ppp_crc16_table
  drivers/net/ppp_deflate.o
    deflate_cleanup
    deflate_init
    ppp_deflate
    ppp_deflate_draft
  drivers/net/ppp_generic.o
    ppp_init
  drivers/net/r8169.o
    mdio_read
    mdio_write
  drivers/net/sk98lin/skaddr.o
    OnesHash
    SkAddrGmacMcAdd
    SkAddrGmacMcClear
    SkAddrGmacMcUpdate
    SkAddrGmacPromiscuousChange
    SkAddrXmacMcAdd
    SkAddrXmacMcClear
    SkAddrXmacMcUpdate
    SkAddrXmacPromiscuousChange
    SkGmacMcHash
    SkXmacMcHash
  drivers/net/sk98lin/skcsum.o
    SkCsGetSendInfo
  drivers/net/sk98lin/skge.o
    SkPciWriteCfgDWord
  drivers/net/sk98lin/skgeinit.o
    SkGeInitRamIface
    SkGePollRxD
    SkGeXmitLED
  drivers/net/sk98lin/skgepnmi.o
    SkPnmiGetVar
    SkPnmiPreSetVar
    SkPnmiSetVar
  drivers/net/sk98lin/skgesirq.o
    SkHWLinkUp
  drivers/net/sk98lin/ski2c.o
    SkI2cReadSensor
    SkI2cWait
    SkI2cWrite
  drivers/net/sk98lin/skproc.o
    file
    len
  drivers/net/sk98lin/skrlmt.o
    BcAddr
  drivers/net/sk98lin/skvpd.o
    VpdErrLog
    VpdSetupPara
  drivers/net/sk98lin/skxmac2.o
    BcomRegA1Hack
    BcomRegC0Hack
    SkGmEnterLowPowerMode
    SkGmIrq
    SkGmLeaveLowPowerMode
    SkMacClearRst
    SkMacFlushRxFifo
    SkMacSetRxTxEn
    SkXmInitDupMd
    SkXmInitPauseMd
    SkXmIrq
  drivers/net/slhc.o
    slhc_i_status
    slhc_o_status
  drivers/net/sungem.o
    gem_debug
  drivers/net/sunhme.o
    happymeal_pci_ids
  drivers/net/tun.o
    tun_cleanup
    tun_init
    tun_net_init
  drivers/net/typhoon.o
    typhoon_firmware_image
  drivers/pci/compat.o
    pcibios_find_class (export only)
    pcibios_find_device (export only)
    pcibios_read_config_byte (export only)
    pcibios_read_config_dword (export only)
    pcibios_read_config_word (export only)
    pcibios_write_config_byte (export only)
    pcibios_write_config_dword (export only)
    pcibios_write_config_word (export only)
  drivers/pci/pci.o
    pci_add_new_bus
    pci_alloc_primary_bus
    pci_announce_device_to_drivers
    pci_bus_exists
    pci_dac_set_dma_mask
    pci_find_subsys
    pci_get_interrupt_pin
    pci_insert_device
    pci_pm_resume
    pci_read_bridge_bases
    pci_remove_device
    pci_scan_bus
    pci_scan_device
    pci_scan_slot
    pci_setup_device
  drivers/pci/proc.o
    pci_proc_attach_bus (export only)
    pci_proc_attach_device (export only)
    pci_proc_detach_bus (export only)
    pci_proc_detach_device (export only)
    proc_bus_pci_dir (export only)
  drivers/pci/quirks.o
    interrupt_line_quirk
    isa_dma_bridge_buggy (export only)
    pci_pci_problems (export only)
  drivers/pci/setup-res.o
    pdev_enable_device
    pdev_sort_resources
  drivers/scsi/constants.o
    print_Scsi_Cmnd (export only)
    print_driverbyte
    print_hostbyte
    print_msg (export only)
    print_status (export only)
  drivers/scsi/scsi.o
    last_cmnd
    scsi_bottom_half_handler
    scsi_do_cmd (export only)
    scsi_finish_command
    scsi_free_host_dev (export only)
    scsi_get_host_dev (export only)
    scsi_host_no_insert
    scsi_logging_level
    scsi_pid
    scsi_release_command (export only)
    scsi_setup
  drivers/scsi/scsi_dma.o
    scsi_need_isa_buffer (export only)
  drivers/scsi/scsi_error.o
    scsi_check_sense
    scsi_eh_action_done
    scsi_eh_completed_normally
    scsi_eh_done
    scsi_eh_finish_command
    scsi_eh_retry_command
    scsi_eh_times_out
    scsi_request_sense
    scsi_restart_operations
    scsi_send_eh_cmnd
    scsi_sleep_done
    scsi_test_unit_ready
    scsi_try_bus_device_reset
    scsi_try_bus_reset
    scsi_try_host_reset
    scsi_try_to_abort_command
    scsi_unit_is_ready
    scsi_unjam_host
  drivers/scsi/scsi_ioctl.o
    kernel_scsi_ioctl (export only)
  drivers/scsi/scsi_lib.o
    scsi_block_requests (export only)
    scsi_deregister_blocked_host (export only)
    scsi_end_request (export only)
    scsi_get_request_dev
    scsi_init_cmd_errh
    scsi_register_blocked_host (export only)
    scsi_report_bus_reset (export only)
    scsi_unblock_requests (export only)
  drivers/scsi/scsi_obsolete.o
    scsi_mark_host_reset (export only)
    update_timeout
  drivers/scsi/scsi_proc.o
    generic_proc_info
    parseFree
    parseInit
    parseOpt
  drivers/scsi/scsicam.o
    scsi_partsize (export only)
  drivers/scsi/sd.o
    revalidate_scsidisk
  drivers/scsi/sg.o
    sg_big_buff
  drivers/sound/ac97_codec.o
    ac97_register_driver
    ac97_restore_state
    ac97_save_state
    ac97_unregister_driver
  drivers/sound/cs4281/cs4281m.o
    cs4281_BuildDMAengine
    cs4281_BuildFIFO
    cs4281_InitPM
    cs4281_ResumeDMAengine
    cs4281_ResumeFIFO
    cs4281_SuspendDMAengine
    cs4281_SuspendFIFO
    cs4281_ac97_resume
    cs4281_ac97_suspend
    cs4281_cleanup_module
    cs4281_devs
    cs4281_init_module
    cs4281_pci_driver
    cs4281_pm_callback
    cs4281_resume
    cs4281_suspend
    dealloc_dmabuf
  drivers/sound/cs46xx.o
    InitArray
    SetCaptureSPValues
    cs46xx_ac97_resume
    cs46xx_ac97_suspend
    cs46xx_cleanup_module
    cs46xx_devs
    cs46xx_init_module
    cs46xx_null
    cs46xx_pci_driver
    cs46xx_pm_callback
    printioctl
  drivers/sound/emu10k1/audio.o
    emu10k1_mm_ops
    emu10k1_wavein_bh
    emu10k1_waveout_bh
  drivers/sound/emu10k1/cardmi.o
    emu10k1_mpuin_callback
    sblive_miState2Byte
    sblive_miState2ByteKey
    sblive_miState3Byte
    sblive_miState3ByteKey
    sblive_miState3ByteVel
    sblive_miStateEntry
    sblive_miStateInit
    sblive_miStateParse
    sblive_miStateSysCommon2
    sblive_miStateSysCommon2Key
    sblive_miStateSysCommon3
    sblive_miStateSysCommon3Key
    sblive_miStateSysCommon3Vel
    sblive_miStateSysExNorm
    sblive_miStateSysReal
  drivers/sound/emu10k1/cardwi.o
    query_format
  drivers/sound/emu10k1/efxmgr.o
    emu10k1_set_oss_vol
  drivers/sound/emu10k1/hwaccess.o
    emu10k1_set_stop_on_loop
    sumVolumeToAttenuation
  drivers/sound/maestro.o
    acpi_state_mask
    cleanup_maestro
    init_maestro
    mixer_defaults
    parse_power
  drivers/sound/maestro3.o
    alloc_dsp_suspendmem
    assp_kernel_image
    assp_minisrc_image
    external_amp
    free_dsp_suspendmem
    get_dma_pos
    get_dmaa
    get_dmac
    gpio_pin
    m3_ac97_read
    m3_ac97_write
    m3_reboot_nb
    remote_codec_config
  drivers/sound/rme96xx.o
    busmaster_free
    busmaster_malloc
    rme96xx_copyfromuser
    rme96xx_copytouser
    rme96xx_get_sample_rate_ctrl
    rme96xx_get_sample_rate_status
    rme96xx_gethwptr
    rme96xx_getispace
    rme96xx_getospace
    rme96xx_init
    rme96xx_set_ctrl
    rme96xx_setlatency
    rme96xx_unset_ctrl
  drivers/sound/sound_core.o
    register_sound_synth
    unregister_sound_synth
  drivers/sound/sound_firmware.o
    mod_firmware_load (export only)
  drivers/sound/trident.o
    res
  drivers/usb/CDCEther.o
    CDCEther_exit
    CDCEther_init
    log_device_info
  drivers/usb/dc2xx.o
    usb_dc2xx_cleanup
    usb_dc2xx_init
  drivers/usb/hcd.o
    usb_hcd_giveback_urb
    usb_hcd_pci_probe
    usb_hcd_pci_remove
    usb_hcd_pci_resume
    usb_hcd_pci_suspend
  drivers/usb/hid-core.o
    hid_blacklist
    hid_find_field
    hid_output_report
    hid_set_field
  drivers/usb/host/uhci.o
    uhci_device_operations
  drivers/usb/host/usb-uhci.o
    alloc_qh
    alloc_td
    alloc_uhci
    append_qh
    clean_descs
    clean_td_chain
    cleanup_skel
    correct_data_toggles
    delete_desc
    delete_qh
    dequeue_urb
    disable_desc_loop
    enable_desc_loop
    fill_td
    find_iso_limits
    init_skel
    insert_qh
    insert_td
    insert_td_horizontal
    iso_find_start
    process_interrupt
    process_iso
    process_transfer
    process_urb
    queue_urb
    queue_urb_unlocked
    reset_hc
    rh_init_int_timer
    rh_int_timer_do
    rh_send_irq
    rh_submit_urb
    rh_unlink_urb
    root_hub_config_des
    root_hub_dev_des
    root_hub_hub_des
    search_dev_ep
    start_hc
    uhci_alloc_dev
    uhci_check_timeouts
    uhci_clean_iso_step1
    uhci_clean_iso_step2
    uhci_clean_transfer
    uhci_cleanup_unlink
    uhci_device_operations
    uhci_devices
    uhci_free_dev
    uhci_get_current_frame_number
    uhci_interrupt
    uhci_map_status
    uhci_pci_probe
    uhci_pci_remove
    uhci_pci_resume
    uhci_pci_suspend
    uhci_release_bandwidth
    uhci_show_status
    uhci_start_usb
    uhci_submit_bulk_urb
    uhci_submit_control_urb
    uhci_submit_int_urb
    uhci_submit_iso_urb
    uhci_submit_urb
    uhci_switch_timer_int
    uhci_unlink_urb
    uhci_unlink_urb_async
    uhci_unlink_urb_sync
    uhci_unlink_urbs
    uhci_urb_dma_sync
    uhci_urb_dma_unmap
    unlink_qh
    unlink_td
  drivers/usb/hub.o
    usb_hub_port_disable
  drivers/usb/inode.o
    usbdevfs_read_super
  drivers/usb/kaweth.o
    kaweth_exit
    kaweth_init
    kaweth_internal_control_msg
    len_kaweth_new_code
    len_kaweth_new_code_fix
    len_kaweth_trigger_code
    len_kaweth_trigger_code_fix
  drivers/usb/mdc800.o
    usb_mdc800_cleanup
    usb_mdc800_init
  drivers/usb/pegasus.o
    pegasus_exit
    pegasus_init
  drivers/usb/rio500.o
    usb_rio_cleanup
    usb_rio_init
  drivers/usb/serial/io_edgeport.o
    edgeport_exit
    edgeport_init
  drivers/usb/serial/ipaq.o
    ipaq_device
  drivers/usb/serial/ir-usb.o
    ir_device
  drivers/usb/usb-debug.o
    usb_dump_urb
    usb_show_config_descriptor
    usb_show_device_descriptor
    usb_show_endpoint_descriptor
    usb_show_interface_descriptor
  drivers/usb/usb.o
    usb_bus_get_list
    usb_calc_bus_time
    usb_driver_get_list
    usb_get_current_frame_number
    usb_get_protocol
    usb_get_status
    usb_get_string
    usb_ifnum_to_ifpos
    usb_internal_control_msg
    usb_major_cleanup
    usb_major_init
    usb_parse_configuration
    usb_set_protocol
  drivers/usb/wacom.o
    wacom_features
    wacom_ids
  drivers/video/aty128fb.o
    aty128fb_init
    aty128fb_setup
  drivers/video/fbcon-cfb16.o
    fbcon_cfb16_bmove
  drivers/video/fbcon-cfb24.o
    fbcon_cfb24_bmove
  drivers/video/fbcon-cfb32.o
    fbcon_cfb32_bmove
  drivers/video/fbcon-cfb8.o
    fbcon_cfb8_bmove
  drivers/video/fbcon.o
    fbcon_redraw_bmove
    fbcon_redraw_clear
    linux_logo
    linux_logo16
    linux_logo_blue
    linux_logo_bw
    linux_logo_green
    linux_logo_red
  drivers/video/fbmem.o
    video_setup
  drivers/video/matrox/matroxfb_base.o
    matroxfb_driver_list
    matroxfb_list
    matroxfb_switch
  drivers/video/modedb.o
    fb_find_mode
  drivers/video/radeonfb.o
    common_regs
    common_regs_m6
    radeonfb_exit
    radeonfb_init
    radeonfb_setup
  drivers/video/sstfb.o
    sstfb_exit
    sstfb_init
    sstfb_setup
  drivers/video/tdfxfb.o
    default_mode
    mode
    tdfxfb_init
  fs/bad_inode.o
    bad_inode_ops
  fs/binfmt_script.o
    script_format
  fs/block_dev.o
    blkdev_close
    blkdev_open (export only)
    def_blk_aops
  fs/buffer.o
    __mark_dirty
    balance_dirty
    bdflush
    bdflush_wait
    generic_cont_expand (export only)
    kupdate
    sync_dev (export only)
  fs/dcache.o
    d_prune_aliases (export only)
    dquot_cachep
    prune_dcache (export only)
  fs/devfs/base.o
    devfs_get_first_child
    devfs_get_flags
    devfs_get_handle
    devfs_get_info
    devfs_get_name
    devfs_get_next_sibling
    devfs_get_unregister_slave
    devfs_put
    devfs_set_file_size
    devfs_set_flags
    devfs_set_info
  fs/devfs/util.o
    devfs_alloc_major
    devfs_dealloc_major
  fs/devices.o
    cdevname (export only)
  fs/devpts/inode.o
    devpts_read_super
  fs/exec.o
    copy_strings
    format_corename
  fs/ext2/balloc.o
    ext2_group_sparse
  fs/ext2/bitmap.o
    ext2_count_free
  fs/ext2/fsync.o
    ext2_fsync_inode
  fs/ext2/super.o
    ext2_put_super
    ext2_read_super
    ext2_remount
    ext2_statfs
  fs/ext3/balloc.o
    ext3_group_sparse
  fs/ext3/bitmap.o
    ext3_count_free
  fs/ext3/inode.o
    ext3_get_inode_loc
    ext3_writepage_trans_blocks
  fs/ext3/super.o
    ext3_put_super
    ext3_read_super
    ext3_remount
    ext3_statfs
    ext3_unlockfs
    ext3_write_super
    ext3_write_super_lockfs
    journal_no_write
  fs/fat/buffer.o
    fat_is_uptodate
    fat_ll_rw_block
  fs/fat/cache.o
    fat_get_cluster (export only)
  fs/fat/cvf.o
    register_cvf_format (export only)
    unregister_cvf_format (export only)
  fs/fat/dir.o
    fat_dir_ioctl (export only)
    fat_readdir (export only)
  fs/fat/file.o
    fat_file_read
    fat_file_write
  fs/fat/inode.o
    fat_clear_inode (export only)
    fat_delete_inode (export only)
    fat_dentry_to_fh
    fat_fh_to_dentry
    fat_inode_lock
    fat_statfs (export only)
    fat_write_inode (export only)
  fs/fat/misc.o
    fat_is_binary
  fs/file.o
    alloc_fd_array
    alloc_fdset
  fs/hugetlbfs/inode.o
    hugetlbfs_sync_file
    truncate_huge_page
    truncate_hugepages
  fs/inode.o
    ilookup (export only)
    inode_init_once (export only)
    prune_icache
  fs/intermezzo/dir.o
    presto_can_ilookup
    presto_lookup
    presto_triple_fulllock
    presto_triple_relock_other
    presto_triple_relock_sem
    presto_triple_unlock
    presto_unlink
  fs/intermezzo/fileset.o
    presto_get_lastrecno
    presto_set_fsetroot
  fs/intermezzo/inode.o
    presto_read_inode
    presto_sym_fops
    presto_sym_iops
  fs/intermezzo/journal.o
    izo_do_truncate
    izo_log_open
    izo_lookup_file
    presto_copy_kml_tail
    presto_finish_kml_truncate
    presto_read_kml_logical_offset
    presto_rewrite_close
    presto_write_kml_logical_offset
  fs/intermezzo/kml_reint.o
    branch_reinter
  fs/intermezzo/kml_unpack.o
    kml_unpack_prefix
    kml_unpack_suffix
    kml_unpack_version
  fs/intermezzo/methods.o
    filter_c2cdops
    filter_c2csfops
    filter_debug
    filter_print_entry
  fs/intermezzo/presto.o
    lento_complete_closes
    presto_path2fileset
    presto_set_max_kml_size
  fs/intermezzo/replicator.o
    izo_rep_cache_find
  fs/intermezzo/super.o
    exit_intermezzo_fs
    init_intermezzo_fs
    presto_read_super
  fs/intermezzo/sysctl.o
    intermezzo_mount_get_info
    proc_fs_intermezzo
  fs/intermezzo/vfs.o
    izo_get_rollback_data
    lento_do_rename
    lento_iopen
    presto_debug_fail_blkdev
    presto_do_rename
    presto_iopen
    presto_settime
  fs/iobuf.o
    alloc_kiobuf_bhs
    free_kiobuf_bhs
  fs/isofs/rock.o
    find_rock_ridge_relocation
    parse_rock_ridge_inode_internal
  fs/jbd/checkpoint.o
    journal_insert_checkpoint
    journal_remove_checkpoint
  fs/jbd/journal.o
    __journal_abort_soft
    __journal_internal_check
    current_journal
    jh_splice_lock
    journal_ack_err
    journal_check_used_features
    journal_dev_name
    journal_remove_journal_head
    kjournald
    read_jbd_debug
    shrink_journal_memory
    write_jbd_debug
  fs/jbd/recovery.o
    journal_recover (export only)
  fs/jbd/revoke.o
    insert_revoke_hash
  fs/jbd/transaction.o
    __journal_file_buffer
    journal_callback_set (export only)
  fs/lockd/clntproc.o
    nlmclnt_async_call
    nlmclnt_call
  fs/lockd/mon.o
    nsm_program
  fs/lockd/svc.o
    nlm_grace_period
    nlm_tcpport
    nlm_timeout
    nlm_udpport
    nlmsvc_program
  fs/msdos/namei.o
    msdos_create (export only)
    msdos_dir_inode_operations
    msdos_lookup (export only)
    msdos_mkdir (export only)
    msdos_put_super (export only)
    msdos_read_super (export only)
    msdos_rename (export only)
    msdos_rmdir (export only)
    msdos_unlink (export only)
  fs/namei.o
    link_path_walk
    page_follow_link (export only)
    page_readlink (export only)
    vfs_rename_dir
    vfs_rename_other
  fs/nfs/file.o
    nfs_lock
  fs/nfs/inode.o
    nfs_program
    nfs_read_super
    nfs_rpcstat
    nfs_wait_on_inode
  fs/nfs/write.o
    nfs_commit_file
    nfs_flush_file
  fs/nfsd/export.o
    exp_writelock
    expflags
  fs/nfsd/lockd.o
    nfsd_nlm_ops
  fs/nfsd/nfsctl.o
    proc_export_init
  fs/nfsd/nfsfh.o
    _fh_update
    _fh_update_old
    d_splice
    nfsd_findparent
  fs/nfsd/nfssvc.o
    nfsd_list
  fs/nfsd/vfs.o
    nfsd_dosync
    nfsd_sync
    nfsd_sync_dir
  fs/nls/nls_base.o
    charset2uni
  fs/pipe.o
    rdwr_pipe_fops
    read_pipe_fops
    write_pipe_fops
  fs/proc/generic.o
    proc_alloc_map_lock
    proc_mknod (export only)
  fs/proc/proc_misc.o
    proc_sprintf
  fs/quota.o
    dqstats
  fs/ramfs/inode.o
    ramfs_get_inode
  fs/read_write.o
    default_llseek (export only)
  fs/seq_file.o
    seq_release_private (export only)
    single_open (export only)
    single_release (export only)
  fs/smbfs/inode.o
    smb_read_super
  fs/smbfs/proc.o
    smb_decode_unix_basic
  fs/smbfs/symlink.o
    smb_follow_link
    smb_read_link
  fs/super.o
    get_anon_super
  fs/udf/directory.o
    udf_filead_read
    udf_get_fileextent
  fs/udf/fsync.o
    udf_fsync_inode
  fs/udf/inode.o
    __udf_read_inode
    udf_getblk
    udf_insert_aext
  fs/udf/misc.o
    udf64_high32
    udf64_low32
  fs/udf/super.o
    udf_error
  fs/udf/udftime.o
    __mon_yday
    year_seconds
  fs/udf/unicode.o
    udf_CS0toNLS
    udf_build_ustr_exact
    udf_dchars_to_ustr
    udf_dstring_to_ustr
    udf_translate_to_linux
    udf_ustr_to_char
    udf_ustr_to_dchars
    udf_ustr_to_dstring
  fs/vfat/namei.o
    vfat_create (export only)
    vfat_dir_inode_operations
    vfat_lookup (export only)
    vfat_mkdir (export only)
    vfat_read_super (export only)
    vfat_rename (export only)
    vfat_rmdir (export only)
    vfat_unlink (export only)
  fs/vfat/vfatfs_syms.o
    vfat_fs_type
  fs/xfs/linux/mrlock.o
    ismrlocked
    lock_wait
    mraccunlock
    mrlock
    mrtrypromote
  fs/xfs/linux/xfs_aops.o
    linvfs_unwritten_done
  fs/xfs/linux/xfs_buf.o
    _pagebuf_free_object
    pagebuf_iodone_sched
    pagebuf_lock_value
    pb_params
    pb_resv_bh
    pb_resv_bh_cnt
    pbd_waitq
    pbstats
  fs/xfs/linux/xfs_globals.o
    sys_cred_val
  fs/xfs/linux/xfs_vfs.o
    vfs_dmapiops
    vfs_insertbhv
    vfs_insertops
  fs/xfs/linux/xfs_vnode.o
    vn_generation
    vnumber_lock
    vsync
  fs/xfs/quota/xfs_dquot.o
    xfs_qm_dqinit
    xfs_qm_dqwarn
  fs/xfs/quota/xfs_dquot_item.o
    xfs_dquot_item_ops
    xfs_qm_qoff_logitem_ops
    xfs_qm_qoffend_logitem_ops
  fs/xfs/quota/xfs_qm.o
    xfs_qm_destroy
    xfs_qm_dqflush_all
    xfs_qm_dqhashlock_nowait
    xfs_qm_freelist_destroy
    xfs_qm_freelist_init
    xfs_qm_freelist_insert
    xfs_qm_init_quotainfo
    xfs_qm_mplist_nowait
    xfs_qm_shaker
  fs/xfs/quota/xfs_qm_syscalls.o
    xfs_qm_dqrele_all_inodes
  fs/xfs/quota/xfs_trans_dquot.o
    xfs_trans_apply_dquot_deltas
    xfs_trans_mod_dquot_byino
  fs/xfs/support/debug.o
    doass
  fs/xfs/support/uuid.o
    uuid_create_nil
  fs/xfs/xfs_alloc.o
    xfs_alloc_search_busy
  fs/xfs/xfs_attr.o
    attr_system
    attr_system_names
    posix_acl_access
    posix_acl_default
    xfs_attr_fetch
    xfs_attr_leaf_get
    xfs_attr_node_get
  fs/xfs/xfs_attr_leaf.o
    xfs_attr_leaf_create
    xfs_attr_leaf_entsize
    xfs_attr_leaf_freextent
    xfs_attr_leaf_inactive
    xfs_attr_node_inactive
    xfs_attr_put_listent
  fs/xfs/xfs_bit.o
    xfs_highbit
  fs/xfs/xfs_bmap.o
    xfs_bmap_do_search_extents
    xfs_bmap_isaeof
  fs/xfs/xfs_bmap_btree.o
    xfs_bmbt_disk_get_all
    xfs_bmbt_disk_get_startblock
    xfs_bmbt_disk_get_state
    xfs_bmbt_disk_set_all
    xfs_bmbt_disk_set_allf
    xfs_bmbt_get_block
    xfs_bmbt_lookup_le
  fs/xfs/xfs_btree.o
    xfs_btree_check_lptr
    xfs_btree_check_sptr
    xfs_btree_get_block
  fs/xfs/xfs_buf_item.o
    xfs_buf_item_abort
    xfs_buf_item_committed
    xfs_buf_item_committing
    xfs_buf_item_format
    xfs_buf_item_ops
    xfs_buf_item_pin
    xfs_buf_item_push
    xfs_buf_item_size
    xfs_buf_item_trylock
    xfs_buf_item_unlock
    xfs_buf_item_unpin
    xfs_buf_item_unpin_remove
  fs/xfs/xfs_da_btree.o
    xfs_da_blk_unlink
    xfs_da_state_kill_altpath
  fs/xfs/xfs_dir2.o
    xfs_dir2_isblock
    xfs_dir2_isleaf
  fs/xfs/xfs_dir2_data.o
    xfs_dir2_data_freefind
    xfs_dir2_data_freeremove
  fs/xfs/xfs_dir2_leaf.o
    xfs_dir2_leaf_log_bests
    xfs_dir2_leaf_log_tail
  fs/xfs/xfs_dir2_node.o
    xfs_dir2_free_log_bests
  fs/xfs/xfs_dir_leaf.o
    xfs_dir_leaf_create
  fs/xfs/xfs_error.o
    xfs_hex_dump
  fs/xfs/xfs_extfree_item.o
    xfs_efd_item_ops
    xfs_efi_item_ops
  fs/xfs/xfs_fsops.o
    xfs_fs_log_dummy
  fs/xfs/xfs_iget.o
    xfs_iextract
    xfs_inode_lock_init
  fs/xfs/xfs_inode.o
    xfs_ifree_cluster
    xfs_inobp_bwcheck
    xfs_inotobp
    xfs_iroundup
    xfs_iunpin_wait
    xfs_swappable
  fs/xfs/xfs_inode_item.o
    xfs_inode_item_ops
  fs/xfs/xfs_log.o
    xlog_iclogs_empty
    xlog_iodone
    xlog_state_clean_log
  fs/xfs/xfs_log_recover.o
    xlog_align
    xlog_bread
    xlog_bwrite
    xlog_find_cycle_start
    xlog_find_head
    xlog_find_tail
    xlog_get_bp
    xlog_put_bp
    xlog_recover_process_iunlinks
  fs/xfs/xfs_mount.o
    xfs_mount_common
  fs/xfs/xfs_rename.o
    rename_which_error_return
  fs/xfs/xfs_trans.o
    xfs_trans_callback
    xfs_trans_unreserve_and_mod_sb
  fs/xfs/xfs_trans_buf.o
    xfs_trans_bhold_until_committed
  fs/xfs/xfs_trans_inode.o
    xfs_trans_ihold_release
  fs/xfs/xfs_vfsops.o
    xfs_parseargs
    xfs_showargs
    xfs_syncsub
    xfs_unmount_flush
  fs/xfs/xfs_vnodeops.o
    xfs_alloc_file_space
  init/do_mounts.o
    rd_doload
    rd_image_start
    rd_prompt
    root_mountflags
  init/main.o
    cols
    execute_command
    rows
  ipc/sem.o
    sys_semtimedop
  kernel/capability.o
    task_capability_lock
  kernel/dma.o
    dma_spin_lock (export only)
    request_dma (export only)
  kernel/exec_domain.o
    abi_defhandler_coff
    abi_defhandler_elf
    abi_defhandler_lcall7
    abi_defhandler_libcso
    abi_fake_utsname
    abi_traceflg
    unregister_exec_domain
  kernel/exit.o
    end_lazy_tlb
    start_lazy_tlb
  kernel/fork.o
    lastpid_lock
    mm_cachep
  kernel/kmod.o
    exec_usermodehelper
  kernel/module.o
    find_module
    free_module
    inter_module_get (export only)
    inter_module_get_request (export only)
    inter_module_put (export only)
    kernel_module
  kernel/panic.o
    panic_notifier_list (export only)
  kernel/pm.o
    pm_find
    pm_send
    pm_send_all
    pm_unregister
  kernel/printk.o
    console_cmdline
    console_unblank
    unregister_console
  kernel/ptrace.o
    ptrace_readdata
    ptrace_writedata
  kernel/resource.o
    check_resource (export only)
  kernel/sched.o
    __cond_resched (export only)
  kernel/signal.o
    bad_signal
    block_all_signals
    kill_pg_info
    kill_proc_info
    kill_sl
    kill_sl_info
    sys_sigpending
    sys_sigprocmask
    unblock_all_signals
  kernel/softirq.o
    raise_softirq (export only)
    tasklet_hi_vec (export only)
    tasklet_vec (export only)
  kernel/sys.o
    notifier_lock
    sys_gethostname
  kernel/sysctl.o
    do_sysctl_strategy
    proc_dointvec_bset
    proc_doulongvec_ms_jiffies_minmax (export only)
    proc_sys_file_operations
    sysctl_string (export only)
  kernel/time.o
    do_adjtimex
    hardpps_ptr
    pps_calcnt
    pps_errcnt
    pps_jitcnt
    pps_offset
    pps_shift
    pps_stbcnt
  kernel/timer.o
    running_timer
    sync_timers
    tickadj
    time_adj
    time_adjust_step
    time_phase
    update_one_process
  lib/crc32.o
    crc32_be
  lib/string.o
    ___strtok (export only)
    strpbrk (export only)
  lib/vsprintf.o
    simple_strtoll
    vsscanf (export only)
  lib/zlib_deflate/deflate.o
    zlib_deflateCopy (export only)
    zlib_deflateInit_ (export only)
    zlib_deflateParams (export only)
    zlib_deflateSetDictionary
  lib/zlib_inflate/infblock.o
    zlib_inflate_set_dictionary
  lib/zlib_inflate/inflate.o
    zlib_inflateSync (export only)
    zlib_inflateSyncPoint (export only)
  mm/bootmem.o
    free_all_bootmem
    free_bootmem_node
    init_bootmem_node
    reserve_bootmem_node
  mm/filemap.o
    filemap_sync (export only)
    generic_buffer_fdatasync (export only)
    invalidate_inode_pages2
    sys_sendfile64
  mm/memory.o
    __free_pte
    highmem_start_page
    lock_kiovec (export only)
  mm/numa.o
    alloc_pages_node (export only)
  mm/oom_kill.o
    oom_kill_task
    out_of_memory
  mm/page_alloc.o
    __alloc_pages (export only)
    free_area_init
    show_free_areas_core
  mm/shmem.o
    shmem_inodes
  mm/slab.o
    kmem_cache_alloc_batch
    kmem_cpucache_init
    kmem_find_general_cachep (export only)
  mm/swapfile.o
    nr_swapfiles
    swap_info
    swap_list
    swaplock
  mm/vmalloc.o
    get_vm_area
    vmalloc_area_pages
    vmfree_area_pages
  mm/vmscan.o
    kswapd
  net/802/p8023.o
    destroy_8023_client
    make_8023_client
  net/8021q/vlan.o
    vlan_default_dev_flags
    vlan_ioctl_handler
    vlan_notifier_block
  net/bluetooth/af_bluetooth.o
    bluez_cleanup
    bluez_init
    bluez_sock_family_ops
  net/bluetooth/hci_conn.o
    hci_acl_connect
  net/bluetooth/hci_core.o
    hci_req_cancel
    hci_resume_dev (export only)
    hci_send_sco (export only)
    hci_suspend_dev (export only)
    hci_task_lock
    inquiry_cache_dump
    inquiry_cache_flush
  net/bluetooth/hci_sock.o
    hci_sock_family_ops
    hci_sock_getsockopt
    hci_sock_nblock
    hci_sock_ops
    hci_sock_setsockopt
  net/bluetooth/l2cap.o
    l2cap_cleanup
    l2cap_init
    l2cap_load
    l2cap_raw_recv
    l2cap_sk_list
    l2cap_sock_accept
    l2cap_sock_listen
  net/bluetooth/lib.o
    baswap (export only)
    bluez_dump (export only)
  net/bridge/br_stp_if.o
    br_make_port_id
  net/core/datagram.o
    skb_copy_and_csum_datagram
    skb_copy_datagram (export only)
  net/core/dev.o
    __dev_get_by_flags (export only)
    dev_alloc (export only)
    dev_get (export only)
    dev_new_index (export only)
    if_port_text (export only)
    netdev_boot_setup_add
    proc_net_drivers
  net/core/dst.o
    dst_dev_notifier
  net/core/iovec.o
    memcpy_tokerneliovec (export only)
  net/core/neighbour.o
    neigh_sysctl_template
    neigh_sysctl_unregister
  net/core/rtnetlink.o
    rtnetlink_dev_notifier
    rtnetlink_dump_all
    rtnetlink_dump_ifinfo (export only)
  net/core/skbuff.o
    kfree_skbmem
    skb_copy_and_csum_dev (export only)
  net/core/sock.o
    net_big_sklist_lock
    sklist_destroy_socket (export only)
    sklist_insert_socket (export only)
    sklist_remove_socket (export only)
    sock_alloc_send_pskb (export only)
    sock_def_destruct
    sock_def_error_report
    sock_def_readable
    sock_def_wakeup
    sock_def_write_space
    sock_no_bind (export only)
    sock_no_getname (export only)
    sock_no_poll (export only)
    sock_no_recvmsg (export only)
    sock_no_release (export only)
    sock_no_sendmsg (export only)
  net/ipv4/af_inet.o
    inet_bind
    inet_family_ops (export only)
    inet_getname
    inet_ioctl
    inet_register_protosw (export only)
    inetsw
  net/ipv4/arp.o
    arp_broken_ops (export only)
    arp_netdev_notifier
    arp_process
    arp_rcv (export only)
    arp_req_delete
    arp_req_set
  net/ipv4/devinet.o
    inet_dev_count
    inet_ifa_count
    inet_rtm_deladdr
    inet_rtm_newaddr
    ip_netdev_notifier
  net/ipv4/fib_frontend.o
    fib_inetaddr_notifier
    fib_netdev_notifier
  net/ipv4/fib_rules.o
    fib_rules_notifier
  net/ipv4/fib_semantics.o
    fib_info_cnt
  net/ipv4/igmp.o
    ip_mc_add_src
    ip_mc_dec_group (export only)
    ip_mc_del_src
    ip_mc_inc_group (export only)
    ip_mc_leave_src
  net/ipv4/inetpeer.o
    inet_peer_unused_head
  net/ipv4/ip_gre.o
    ipgre_err
    ipgre_rcv
  net/ipv4/ip_sockglue.o
    ip_cmsg_recv_retopts
  net/ipv4/ipip.o
    ipip_err
    ipip_init
    ipip_rcv
    ipip_tunnel_locate
  net/ipv4/ipmr.o
    cache_resolve_queue_len
    ipmr_expire_process
    ipmr_find_vif
    ipmr_mfc_add
    ipmr_mfc_delete
    mroute_do_assert
    mroute_do_pim
    mrt_cachep
    pim_protocol
    pim_rcv
  net/ipv4/netfilter/ip_conntrack_core.o
    ip_conntrack_expect_find_get (export only)
    ip_conntrack_expect_list (export only)
    ip_conntrack_expect_put (export only)
    ip_conntrack_expect_tuple_lock
    ip_conntrack_put (export only)
    ip_conntrack_unexpect_related (export only)
  net/ipv4/netfilter/ip_conntrack_ftp.o
    ip_conntrack_ftp
  net/ipv4/netfilter/ip_conntrack_irc.o
    dccprotos
    ip_conntrack_irc
    parse_dcc
  net/ipv4/netfilter/ip_conntrack_standalone.o
    ip_conntrack_protocol_register
    ip_conntrack_protocol_unregister
  net/ipv4/netfilter/ip_nat_core.o
    find_nat_proto
    place_in_hashes
    replace_in_hashes
  net/ipv4/netfilter/ip_nat_helper.o
    ip_nat_seqofs_lock
  net/ipv4/netfilter/ip_nat_rule.o
    alloc_null_binding
  net/ipv4/netfilter/ip_nat_standalone.o
    ip_nat_protocol_register
    ip_nat_protocol_unregister
  net/ipv4/netfilter/ipchains_core.o
    ip_fw_lock
    ipfw_forward_check
    ipfw_input_check
    ipfw_ops
    ipfw_output_check
  net/ipv4/raw.o
    raw_recvmsg
  net/ipv4/route.o
    ip_route_input_slow
    ip_route_output_slow
    ip_rt_error_burst
    ip_rt_error_cost
    ip_rt_gc_elasticity
    ip_rt_gc_interval
    ip_rt_gc_min_interval
    ip_rt_gc_timeout
    ip_rt_max_delay
    ip_rt_max_size
    ip_rt_min_advmss
    ip_rt_min_delay
    ip_rt_min_pmtu
    ip_rt_mtu_expires
    ip_rt_redirect_load
    ip_rt_redirect_number
    ip_rt_redirect_silence
    ip_rt_secret_interval
    ipv4_dst_ops
    rt_cache_flush_task
    rt_cache_stat
    rt_gc_task
  net/ipv4/tcp.o
    do_tcp_sendpages
  net/ipv4/tcp_diag.o
    bitstring_match
    tcpdiag_bc_audit
    tcpdiag_bc_run
    tcpdiag_dump
    valid_cc
  net/ipv4/tcp_input.o
    tcp_enter_frto_loss
    tcp_enter_quickack_mode
  net/ipv4/tcp_ipv4.o
    __tcp_put_port (export only)
    tcp_v4_lookup_listener (export only)
  net/ipv4/tcp_minisocks.o
    tcp_tw_schedule
    tcp_twcal_tasklet
    tcp_twcal_tick__thr
    tcp_twkill_task
  net/ipv4/tcp_output.o
    tcp_send_skb
    tcp_transmit_skb (export only)
  net/ipv4/tcp_timer.o
    timer_bug_msg
  net/ipv4/udp.o
    udp_recvmsg
    udp_v4_lookup
    udp_v4_lookup_longway
  net/ipv6/addrconf.o
    addrconf_verify
    in6addr_any
    in6addr_loopback
    inet6_dev_count
    inet6_ifa_count
    ipv6_addr_prefix
    ipv6_count_addresses
    register_inet6addr_notifier (export only)
    unregister_inet6addr_notifier (export only)
  net/ipv6/af_inet6.o
    inet6_bind (export only)
    inet6_family_ops
    inet6_getname (export only)
    inet6_ioctl (export only)
    inet6_release (export only)
    inet6_unregister_protosw (export only)
    inetsw6
    ipv6_unload
  net/ipv6/anycast.o
    inet6_ac_check
  net/ipv6/exthdrs.o
    hdrproc_lst
    ip6_tlvopt_unknown
    ipv6_build_rthdr
    tlvprocdestopt_lst
    tlvprochopopt_lst
  net/ipv6/icmp.o
    icmpv6_rcv
    sysctl_icmpv6_time
  net/ipv6/ip6_output.o
    ip6_call_ra_chain
    ip6_route_me_harder (export only)
  net/ipv6/ipv6_sockglue.o
    ipv6_packet_type
  net/ipv6/mcast.o
    all_nodes_addr
    igmp6_send
    ip6_mc_add_src
    ip6_mc_del_src
    ip6_mc_find_dev
    ip6_mc_leave_src
    mld2_all_mcr
  net/ipv6/ndisc.o
    ndisc_netdev_notifier
    ndisc_next_option
    ndisc_parse_options
    ndisc_recv_na
    ndisc_recv_ns
    ndisc_send_na
  net/ipv6/proc.o
    snmp6_list
  net/ipv6/raw.o
    rawv6_recvmsg
  net/ipv6/reassembly.o
    sysctl_ip6frag_high_thresh
    sysctl_ip6frag_low_thresh
    sysctl_ip6frag_time
  net/ipv6/route.o
    ip6_dst_ops
    ip6_route_del
    ip6_rt_gc_elasticity
    ip6_rt_gc_min_interval
    ip6_rt_gc_timeout
    ip6_rt_max_size
    ip6_rt_min_advmss
    ip6_rt_mtu_expires
  net/ipv6/sit.o
    ipip6_err
    ipip6_rcv
    ipip6_tunnel_locate
  net/ipv6/sysctl_net_ipv6.o
    ipv6_net_table
    ipv6_root_table
    ipv6_table
  net/ipv6/tcp_ipv6.o
    tcp_v6_err
    tcp_v6_lookup
    tcp_v6_rcv
  net/ipv6/udp.o
    udpv6_err
    udpv6_rcv
    udpv6_recvmsg
  net/netlink/af_netlink.o
    netlink_attach (export only)
    netlink_data_ready
    netlink_detach (export only)
    netlink_family_ops
    netlink_ops
    netlink_post (export only)
    netlink_sock_nr
  net/packet/af_packet.o
    packet_getsockopt
    packet_ops
    packet_ops_spkt
    packet_poll
    packet_sock_destruct
    packet_socks_nr
  net/sched/cls_api.o
    tcf_proto_lookup_ops
  net/sched/cls_fw.o
    cls_fw_ops
  net/sched/cls_route.o
    cls_route4_ops
  net/sched/cls_rsvp.o
    cls_rsvp_ops
  net/sched/cls_rsvp6.o
    cls_rsvp6_ops
  net/sched/cls_tcindex.o
    cls_tcindex_ops
  net/sched/cls_u32.o
    cls_u32_ops
  net/sched/sch_api.o
    psched_tick_per_us
    psched_time_base
    psched_us_per_tick
    qdisc_alloc_handle
    qdisc_graft
    qdisc_leaf
    qdisc_lookup_ops
  net/sched/sch_cbq.o
    cbq_copy_xstats
    cbq_qdisc_ops
  net/sched/sch_csz.o
    csz_class_ops
    csz_classify
    csz_qdisc_ops
  net/sched/sch_dsmark.o
    dsmark_init
    dsmark_qdisc_ops
  net/sched/sch_generic.o
    noqueue_qdisc
    noqueue_qdisc_ops
  net/sched/sch_gred.o
    gred_qdisc_ops
  net/sched/sch_ingress.o
    ingress_init
    ingress_qdisc_ops
  net/sched/sch_prio.o
    prio_qdisc_ops
  net/sched/sch_red.o
    red_copy_xstats
    red_qdisc_ops
  net/sched/sch_sfq.o
    sfq_qdisc_ops
  net/sched/sch_tbf.o
    tbf_qdisc_ops
  net/socket.o
    sock_map_fd (export only)
    sock_readv_writev
    sys_socketcall
  net/sunrpc/auth.o
    rpcauth_insert_credcache (export only)
    rpcauth_matchcred (export only)
    rpcauth_register (export only)
    rpcauth_unregister (export only)
  net/sunrpc/auth_unix.o
    authunix_fake_cred
  net/sunrpc/pmap_clnt.o
    pmap_program
  net/sunrpc/sched.o
    rpc_add_timer
    rpc_add_wait_queue
    rpciod_wake_up
  net/sunrpc/stats.o
    rpc_proc_exit
    rpc_proc_init
    rpc_proc_read (export only)
  net/sunrpc/svc.o
    svc_init_buffer
    svc_release_buffer
  net/sunrpc/svcauth.o
    svc_auth_register
    svc_auth_unregister
  net/sunrpc/xdr.o
    xdr_decode_netobj_fixed
    xdr_shift_iovec
    xdr_shrink_bufhead
  net/sunrpc/xprt.o
    xprt_clear_backlog
    xprt_default_timeout
    xprt_shutdown
  net/unix/af_unix.o
    unix_dgram_ops
    unix_family_ops
    unix_stream_ops
  net/unix/sysctl_net_unix.o
    unix_table

