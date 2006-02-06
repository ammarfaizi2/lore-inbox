Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWBFObO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWBFObO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWBFObO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:31:14 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:965 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751095AbWBFObO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:31:14 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Check for references to discarded sections during build time 
In-reply-to: Your message of "Sun, 05 Feb 2006 01:20:16 BST."
             <20060205002016.GA6105@mars.ravnborg.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Feb 2006 01:31:11 +1100
Message-ID: <9750.1139236271@ocs3>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 11:50:25PM +0100, Sam Ravnborg wrote:
> Hi Keith.
> 
> While doing some other modpost.c changes I thought about the
> possibility to do the reference_init check during the modpost stage - so
> it is done early and author can catch warning when he made the error.
> Attached is first cut.
> 
> It does a much more lousy job than reference_init because it identifies
> the module and not the .o file. I hope to later identify the function
> where the illegal reference hapens.

My main concern is that we cannot get the .o file with this approach, I
am particulary concerned about this approach when processing vmlinux.
Static function names are duplicated in the kernel.  Reporting a
dangling reference to init or discarded data by function name rather
than by object will lead to confusion if the reference is from one of
the duplicate function names.

# nm vmlinux | fgrep ' t ' | awk '{print $3}' | sort | uniq -dc

produces this horrible list of duplicate function names (IA64):

      2 autofs_get_sb
      2 base_probe
      3 c_next
      2 count
      2 create_elf_tables
      2 c_show
      3 c_start
      3 c_stop
      3 default_handler
      3 destroy_inodecache
      2 dev_ifsioc
      3 disable_slot
      2 do_vfs_lock
      4 dst_output
      2 dump_seek
      2 dump_write
      2 elf_core_dump
      3 enable_slot
      2 error
      3 exact_lock
      3 exact_match
      2 fill_note
      2 fill_prstatus
      2 flush_window
      2 get_power_status
      2 getreg
      2 gzip_release
      2 huft_build
      2 huft_free
      2 inflate_codes
      2 inflate_dynamic
      2 inflate_fixed
      4 init
      2 __initcall_init
     14 init_once
      2 klist_devices_get
      2 klist_devices_put
      2 load_elf_binary
      2 load_elf_library
      5 machvec_noop
      4 machvec_noop_mm
      2 mark_clean
      2 maydump
      2 message.1
      3 m_next
      2 modalias_show
      3 m_start
      3 m_stop
      2 next_device
      3 notesize
      2 padzero
      2 parse_options
      2 proc_calc_metrics
      2 raw_ioctl
      2 read_block_bitmap
      2 read_inode_bitmap
      2 seq_next
      2 seq_show
      2 seq_start
      2 seq_stop
      2 set_brk
      2 setkey
      2 __setup_netdev_boot_setup
      2 __setup_str_netdev_boot_setup
      2 s_next
      2 s_show
      2 s_start
      2 s_stop
      2 state_show
      2 state_store
      2 store_uevent
      2 try_to_fill_dentry
      2 writenote
      2 xdr_decode_fattr

It will also be extremely difficult to track down entries from compiler
generated anonymous data areas.  They are hard enough to isolate when
looking at a single object.  When all the anonymous data has been
merged together in vmlinux, it will be beyond most people.

