Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVBZKq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVBZKq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 05:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVBZKq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 05:46:57 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:22980 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261154AbVBZKqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 05:46:24 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: Inconsistent kallsyms data (since 2.6.11-rc3 or so) 
In-reply-to: Your message of "Fri, 25 Feb 2005 11:33:48 BST."
             <Pine.LNX.4.62.0502251126090.28108@anakin> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 26 Feb 2005 21:45:53 +1100
Message-ID: <19338.1109414753@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2005 11:33:48 +0100 (CET), 
Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>One of my m68k configs has been giving
>
>| Inconsistent kallsyms data
>| Try setting CONFIG_KALLSYMS_EXTRA_PASS
>
>since 2.6.11-rc3 or so. Setting CONFIG_KALLSYMS_EXTRA_PASS, or applying Keith
>Owen's patch to fix an issue for SH
>(http://seclists.org/lists/linux-kernel/2005/Jan/0017.html) doesn't help.

This is either a toolchain bug or an error in vmlinux.lds for m68k.
Sections are overlapping in the .tmp_vmlinux files.  Merging the output
from objdump -h and nm into a single map and using type '0' as the
start of a section clearly shows that .bss, .data.cacheline_aligned and
.init.text are overlapping.  .bss variables (types b and B) appear
after the start of .data.cacheline_aligned, and even after the start of
.init.text.

kallsyms flags an error because some of the .bss variables are moving
from .data.cacheline_aligned to .init.text between pass 1 and 2.  That
changes the set of KALLSYMS symbols between pass 1 and 2, which trips
the verification bug.  This is not a kallsyms bug, it is an m68k
toolchain problem, kallsyms is just picking it up.

Patch for generating this map is in a separate mail.

00189c30 0 .bss
00189c30 b inbuf
00189c30 B ROOT_DEV
00189c30 B system_state
00189c30 B Version_132619
00189c34 B saved_command_line
00189c34 b window
00189c38 b insize
00189c3c b inptr
00189c40 b outcnt
00189c44 b exit_code
...
0018e2bc b acqseq.2953
0018e2bc b dummy.2902
0018e2bc b xfrm_state_bydst

0018e2c0 0 .data.cacheline_aligned
0018e2c0 d acct_globals
0018e2c0 D tasklist_lock
0018e2f0 A _edata
0018e2f0 D tcp_hashinfo
0018e32c B xfrm_policy_list
0018e330 b netdev_chain
0018e334 b dev_boot_setup
0018e344 b xfrm_policy_afinfo
0018e3c4 b xfrm_dst_cache
0018e3c8 b xfrm_policy_gc_work
0018e424 b gifconf_list
0018e9f8 b log_start
0018e9fc b con_start
0018ea00 b log_end
0018ea04 b logged_chars
0018ea08 b console_cmdline
0018ea88 b console_may_schedule

0018f000 0 .init.text
0018f000 A __init_begin
0018f000 T _sinittext
0018f000 T __start
0018f98c t nosmp
0018f998 t maxcpus
0018f9b4 t obsolete_checksetup
0018fa48 t debug_kernel
0018fa62 t quiet_kernel
0018fa7c t unknown_bootoption
0018fcc8 t init_setup
0018fcea t do_early_param
0018fd50 T parse_early_param
0018fd98 T start_kernel
0018ff3c t initcall_debug_setup
0018ff48 t do_initcalls
0019000e t do_basic_setup
00190034 t load_ramdisk
00190056 t readonly
0019006e t readwrite
00190088 t try_name
0019021e T name_to_dev_t
001902bc b xfrm_state_byspi		<====
001904a8 t root_dev_setup
001904c6 t root_data_setup
001904d4 t fs_names_setup
001904e2 t root_delay_setup
00190500 t get_fs_names
0019057c t do_mount_root
0019060e T mount_block_root
00190702 T change_floppy
001907d6 T mount_root
0019082e T prepare_namespace
00190934 t prompt_ramdisk
00190956 t ramdisk_start_setup
00190974 t identify_ramdisk_image
00190b46 T rd_load_image
00190df2 T rd_load_disk
00190e9c t huft_build
00191284 t huft_free
001912a8 t inflate_codes
00191668 t inflate_stored
001917d4 t inflate_fixed
001918fc t inflate_dynamic
00191e00 t inflate_block
00191ee0 t inflate
00191f86 t makecrc
00192000 t gunzip
001922bc b xfrm_state_afinfo		<====
0019233c b xfrm_state_gc_work		<====
00192560 t malloc
...

