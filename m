Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbUB1VT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 16:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUB1VT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 16:19:59 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:19939 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261919AbUB1VTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 16:19:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: kernel-janitors@lists.osdl.org
Subject: finding unused globals in the kernel
Date: Sat, 28 Feb 2004 22:13:34 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402282213.34657.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking for a way to find symbols in the kernel that
are not referenced anywhere and could be removed. This script is
what I came up with, it's rather slow and complicated, but I have
managed to find quite a bit of dead code with it.

It will also write a message for symbols that are both defined
static and global in some places, that information is available
for free here.

Going through the output might be a long-term task for the
janitors.

As an example, I'm including the output of the script for the
current i386 defconfig.

	Arnd <><

===== Makefile 1.458 vs edited =====
--- 1.458/Makefile	Wed Feb 18 04:52:33 2004
+++ edited/Makefile	Sat Feb 28 20:24:43 2004
@@ -945,6 +945,9 @@
 		-name '*.[hcS]' -type f -print | sort \
 		| xargs $(PERL) -w scripts/checkversion.pl
 
+unusedcheck: $(vmlinux-objs)
+	bash $(srctree)/scripts/checkunused.sh $(ARCH) $(vmlinux-objs)
+
 endif #ifeq ($(config-targets),1)
 endif #ifeq ($(mixed-targets),1)
 
--- /dev/null	2003-09-20 22:40:53.000000000 +0200
+++ ./scripts/checkunused.sh	2004-02-28 20:36:09.000000000 +0100
@@ -0,0 +1,44 @@
+#!/bin/bash
+RELOC=R_`echo $1 | tr a-z A-Z | sed -e 's/I386/386/' -e 's/S390X\?/390/'`
+shift
+objdump -Dr "$@" | 
+grep '\([0-9a-f].*>:$\|'"$RELOC"'[^.]*$\|^.*<[_a-zA-Z0-9+]*>$\)' | 
+sed -e 's/.*: [A-Z_0-9]*.\([a-zA-Z0-9_]*\).*$/ref \1/g' \
+    -e 's/^.*<\(.*\)>:/def \1/g' \
+    -e 's/.*<\([^-+]*\>\).*$/ref \1/g' | (
+	while read a b ; do
+		if [ "$a" = def ] ; then 
+			f=$b 
+		else
+			if [ "$f" != "$b" ] ; then 
+				echo $b $a
+			fi
+		fi 
+	done 
+	nm "$@" | grep '\<[UAWRTDBwrtdba]\>' |
+	sed -e 's/^.* [wrtdba] \(.*\)$/\1 local/g' \
+	    -e 's/^.* . \(.*\)$/\1 def/g' 
+) |
+sort | uniq | grep -v '\.' |
+while read a b ; do
+	if [ $b = ref ] ; then
+		if [ "$a" != "$sym" ] ; then
+			echo undefined reference $a
+			if [ "$sym" -a "$scope" = "def" ] ; then
+				echo unreferenced definition X $sym
+			fi
+		fi
+		sym=
+	else
+		if [ "$sym" -a "$scope" = "def" ] ; then
+			if [ "$sym" = "$a" ] ; then
+				echo defined static and global $sym
+			else
+				echo unreferenced definition $sym
+			fi
+		fi
+
+		sym=$a
+		scope=$b
+	fi
+done

bash /home/arnd/linux-2.6-ipc/scripts/checkunused.sh i386 arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  lib/built-in.o  arch/i386/lib/built-in.o  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  arch/i386/oprofile/built-in.o  arch/i386/power/built-in.o  net/built-in.o
unreferenced definition VSYSCALL_BASE
unreferenced definition Version_132611
unreferenced definition __journal_internal_check
unreferenced definition __pmd_alloc
unreferenced definition __send_IPI_shortcut
unreferenced definition _fh_update
unreferenced definition _fh_update_old
unreferenced definition acpi_clear_gpe
unreferenced definition acpi_detach_data
defined static and global acpi_disable
unreferenced definition acpi_ds_method_data_get_type
unreferenced definition acpi_ds_obj_stack_delete_all
unreferenced definition acpi_ds_obj_stack_get_value
unreferenced definition acpi_ds_result_insert
unreferenced definition acpi_ds_result_remove
unreferenced definition acpi_evaluate_object_typed
unreferenced definition acpi_gbl_abort_method
unreferenced definition acpi_gbl_breakpoint_walk
unreferenced definition acpi_gbl_method_executing
unreferenced definition acpi_gbl_nesting_level
unreferenced definition acpi_gbl_parsed_namespace_root
unreferenced definition acpi_gbl_pm1_enable_register_save
unreferenced definition acpi_gbl_step_to_next_call
unreferenced definition acpi_get_event_status
unreferenced definition acpi_get_firmware_waking_vector
unreferenced definition acpi_get_gpe_status
unreferenced definition acpi_get_table_header
unreferenced definition acpi_get_timer_resolution
unreferenced definition acpi_install_initialization_handler
unreferenced definition acpi_load_table
unreferenced definition acpi_ns_find_parent_name
unreferenced definition acpi_ns_unload_namespace
unreferenced definition acpi_os_get_line
unreferenced definition acpi_os_get_pci_id
unreferenced definition acpi_os_get_physical_address
unreferenced definition acpi_os_writable
unreferenced definition acpi_ps_get_child
unreferenced definition acpi_ps_get_depth_next
unreferenced definition acpi_ps_get_name
unreferenced definition acpi_ps_get_opcode_name
unreferenced definition acpi_save_state_disk
unreferenced definition acpi_subsystem_status
unreferenced definition acpi_tb_handle_to_object
unreferenced definition acpi_unload_table
unreferenced definition acpi_ut_create_pkg_state_and_push
unreferenced definition acpi_ut_dump_buffer
unreferenced definition acpi_ut_get_event_name
unreferenced definition acpi_ut_print_string
unreferenced definition acpi_ut_strupr
unreferenced definition alloc_null_binding
unreferenced definition bcopy
unreferenced definition blk_queue_resize_tags
defined static and global boot_cpu_logical_apicid
unreferenced definition boot_gdt
unreferenced definition bootmem_bootmap_pages
unreferenced definition cache_drop
unreferenced definition cache_find
defined static and global charset2uni
unreferenced definition compat_sys_futex
unreferenced definition con_protect_unimap
defined static and global debug
defined static and global dev_seq_next
defined static and global dev_seq_start
defined static and global dev_seq_stop
unreferenced definition dodgy_tsc
unreferenced definition early_serial_setup
unreferenced definition emergency_remount
unreferenced definition emergency_sync
unreferenced definition exp_pseudoroot
unreferenced definition ext2_count_free
unreferenced definition ext2_panic
unreferenced definition ext3_count_free
unreferenced definition ext3_panic
unreferenced definition free_cold_page
unreferenced definition get_fpu_twd
unreferenced definition hardpps_ptr
defined static and global helpers
unreferenced definition hid_find_field_in_report
unreferenced definition hid_find_report_by_usage
unreferenced definition highend_pfn
unreferenced definition highstart_pfn
unreferenced definition i830_alloc_pages
unreferenced definition i830_calloc
unreferenced definition i830_dma_service
unreferenced definition i830_do_cleanup_pageflip
unreferenced definition i830_driver_irq_postinstall
unreferenced definition i830_driver_irq_preinstall
unreferenced definition i830_driver_irq_uninstall
unreferenced definition i830_ioremap_nocache
unreferenced definition init_bootmem_node
unreferenced definition init_cpu_khz
unreferenced definition irq_entries_start
unreferenced definition ksize
unreferenced definition memcmp
unreferenced definition mp_bus_id_to_local
unreferenced definition mp_bus_id_to_node
unreferenced definition mtrr_centaur_report_mcr
unreferenced definition mtrr_if_name
defined static and global mtrr_state
unreferenced definition nfs_commit_release
unreferenced definition nfsd_dosync
unreferenced definition nlmsvc_decode_res
unreferenced definition node_online_map
unreferenced definition pci_assign_unassigned_resources
unreferenced definition pg1
unreferenced definition pmd_cache
unreferenced definition pmd_ctor
unreferenced definition print_all_local_APICs
unreferenced definition print_driverbyte
unreferenced definition print_hostbyte
unreferenced definition promise_rw_disk
unreferenced definition ptrace_readdata
unreferenced definition ptrace_writedata
unreferenced definition quad_local_to_mp_bus_id
unreferenced definition register_leds
unreferenced definition resize_screen
defined static and global resume_device
unreferenced definition rpc_pipe_iops
unreferenced definition rpciod_wake_up
unreferenced definition rtnetlink_send
unreferenced definition send_IPI_mask_bitmask
unreferenced definition send_IPI_mask_sequence
unreferenced definition set_fpu_cwd
unreferenced definition set_fpu_mxcsr
unreferenced definition set_fpu_swd
unreferenced definition set_fpu_twd
unreferenced definition set_pmd_pfn
unreferenced definition show_trace_task
unreferenced definition snd_ac97_suspend
unreferenced definition snd_pcm_format_cpu_endian
unreferenced definition snd_pcm_format_silence
unreferenced definition snd_pcm_format_silence_16
unreferenced definition snd_pcm_format_silence_32
unreferenced definition snd_pcm_hw_param_any
unreferenced definition snd_pcm_hw_param_setinteger
unreferenced definition snd_pcm_hw_params_any
unreferenced definition snd_pcm_plug_capture_channels_mask
unreferenced definition startup_32
unreferenced definition stext
unreferenced definition strcat
unreferenced definition strchr
unreferenced definition strcmp
unreferenced definition strncat
unreferenced definition strncmp
unreferenced definition strrchr
unreferenced definition svc_auth_register
unreferenced definition svc_auth_unregister
unreferenced definition sys_pciconfig_iobase
unreferenced definition sys_pciconfig_read
unreferenced definition sys_pciconfig_write
unreferenced definition sys_semop
unreferenced definition sysfs_mknod
unreferenced definition timer_bug_msg
unreferenced definition tr_table
unreferenced definition tty_paranoia_check
unreferenced definition tty_write_message
unreferenced definition uart_console_device
unreferenced definition udf64_high32
unreferenced definition udf64_low32
unreferenced definition udf_filead_read
unreferenced definition udf_get_fileextent
unreferenced definition unregister_cpu_notifier
unreferenced definition usb_stor_sense_notready
unreferenced definition xdr_decode_netobj_fixed
unreferenced definition xdr_kmap
unreferenced definition xdr_kunmap
unreferenced definition xdr_shift_iovec
unreferenced definition xquad_portio
