Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268503AbUILHGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268503AbUILHGw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 03:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268502AbUILHGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 03:06:52 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:29437 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S268505AbUILHGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 03:06:25 -0400
Date: Sun, 12 Sep 2004 00:03:54 -0700
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: Possible dcache BUG
Message-ID: <20040912000354.7243a328@laptop.delusion.de>
In-Reply-To: <Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<20040808113930.24ae0273.akpm@osdl.org>
	<200408100012.08945.gene.heskett@verizon.net>
	<200408102342.12792.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
	<20040810211849.0d556af4@laptop.delusion.de>
	<Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
	<20040812180033.62b389db@laptop.delusion.de>
	<Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__12_Sep_2004_00_03_54_-0700_tspMnMIehuKSunJY"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__12_Sep_2004_00_03_54_-0700_tspMnMIehuKSunJY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 12 Aug 2004 18:31:31 -0700 (PDT) Linus Torvalds (LT) wrote:

LT> Your slab usage seems to be:
LT> 
LT> 	cumulative	     usage	name
LT> 	=========	    ======	====
LT> 		.....
LT> 	  4,994,684	   499,712	size-8192
LT> 	  5,912,188	   917,504	size-32768
LT> 	105,397,820	99,485,632	size-64
LT> 
LT> Something pretty much stands out.
LT> 
LT> What the _heck_ is doing 64-byte allocations and leaking them?

I think the offender is ACPI. I've been logging 64-byte slab allocations
for a while now and this is what I came up with:

The most frequent user of 64-byte allocations is:

 [<c013e98f>] __kmalloc+0x6f/0x80
 [<c016649e>] sys_poll+0xbe/0x230
 [<c0165201>] sys_ioctl+0x101/0x2a0
 [<c0165940>] __pollwait+0x0/0xc0
 [<c011f00c>] sys_gettimeofday+0x2c/0x70
 [<c01040db>] syscall_call+0x7/0xb

But that doesn't seem to leak, because I've had these happen for days before
things started getting bad.

However, then as slab usage went skyrocket after 3 days, I started logging
these:

 [<c013e98f>] __kmalloc+0x6f/0x80
 [<c0217af9>] acpi_os_allocate+0xa/0xb
 [<c022b9b6>] acpi_ut_callocate+0x30/0x7a
 [<c022b840>] acpi_ut_acquire_from_cache+0x9d/0xaa
 [<c022c7d8>] acpi_ut_create_generic_state+0xa/0x12
 [<c021b0b2>] acpi_ds_result_stack_push+0x8/0x25
 [<c021b268>] acpi_ds_create_walk_state+0x53/0x70
 [<c0227913>] acpi_ps_delete_parse_tree+0x20/0x89
 [<c0227238>] acpi_ps_parse_loop+0x550/0x7bb
 [<c02274f0>] acpi_ps_parse_aml+0x4d/0x1a1
 [<c0219dd4>] acpi_ds_call_control_method+0xd3/0x1b3
 [<c0227505>] acpi_ps_parse_aml+0x62/0x1a1
 [<c0227d1f>] acpi_psx_execute+0x13b/0x194
 [<c0225212>] acpi_ns_execute_control_method+0x3b/0x47
 [<c02251c0>] acpi_ns_evaluate_by_handle+0x6f/0x86
 [<c02250cd>] acpi_ns_evaluate_relative+0xa9/0xc3
 [<c02249c3>] acpi_evaluate_object+0xf3/0x1a0
 [<c0160f56>] link_path_walk+0xbe6/0xe70
 [<c022f496>] acpi_battery_get_status+0x68/0x102
 [<c022f9b6>] acpi_battery_read_state+0x88/0x275
 [<c018124b>] proc_file_read+0xbb/0x250
 [<c0152ea1>] vfs_read+0xd1/0x130
 [<c0153171>] sys_read+0x41/0x70
 [<c01040db>] syscall_call+0x7/0xb

 [<c013e98f>] __kmalloc+0x6f/0x80       
 [<c0217af9>] acpi_os_allocate+0xa/0xb  
 [<c022b9b6>] acpi_ut_callocate+0x30/0x7a
 [<c022b840>] acpi_ut_acquire_from_cache+0x9d/0xaa
 [<c022c7d8>] acpi_ut_create_generic_state+0xa/0x12
 [<c0227a31>] acpi_ps_push_scope+0xf/0x57          
 [<c0227180>] acpi_ps_parse_loop+0x498/0x7bb
 [<c02274f0>] acpi_ps_parse_aml+0x4d/0x1a1  
 [<c0227d1f>] acpi_psx_execute+0x13b/0x194
 [<c0225212>] acpi_ns_execute_control_method+0x3b/0x47
 [<c02251c0>] acpi_ns_evaluate_by_handle+0x6f/0x86    
 [<c02250cd>] acpi_ns_evaluate_relative+0xa9/0xc3 
 [<c02249c3>] acpi_evaluate_object+0xf3/0x1a0    
 [<c022370f>] acpi_hw_low_level_read+0x56/0x94
 [<c0230949>] acpi_ec_gpe_query+0xd5/0xec     
 [<c0218098>] acpi_os_execute_deferred+0xc/0x16
 [<c012a43e>] worker_thread+0x1ae/0x270        
 [<c021808c>] acpi_os_execute_deferred+0x0/0x16
 [<c0117d70>] default_wake_function+0x0/0x10   
 [<c0117db7>] __wake_up_common+0x37/0x70    
 [<c0117d70>] default_wake_function+0x0/0x10
 [<c012a290>] worker_thread+0x0/0x270       
 [<c012e266>] kthread+0x96/0xe0         
 [<c012e1d0>] kthread+0x0/0xe0
 [<c010229d>] kernel_thread_helper+0x5/0x18

 [<c013e98f>] __kmalloc+0x6f/0x80
 [<c0217af9>] acpi_os_allocate+0xa/0xb
 [<c022b9b6>] acpi_ut_callocate+0x30/0x7a
 [<c022b840>] acpi_ut_acquire_from_cache+0x9d/0xaa
 [<c022c7d8>] acpi_ut_create_generic_state+0xa/0x12
 [<c0227a31>] acpi_ps_push_scope+0xf/0x57
 [<c0227180>] acpi_ps_parse_loop+0x498/0x7bb
 [<c02274f0>] acpi_ps_parse_aml+0x4d/0x1a1
 [<c0219dd4>] acpi_ds_call_control_method+0xd3/0x1b3
 [<c0227505>] acpi_ps_parse_aml+0x62/0x1a1
 [<c0227d1f>] acpi_psx_execute+0x13b/0x194
 [<c0225212>] acpi_ns_execute_control_method+0x3b/0x47
 [<c02251c0>] acpi_ns_evaluate_by_handle+0x6f/0x86
 [<c02250cd>] acpi_ns_evaluate_relative+0xa9/0xc3
 [<c02249c3>] acpi_evaluate_object+0xf3/0x1a0
 [<c02185ff>] acpi_evaluate_integer+0x2d/0x4b
 [<c0146a17>] do_mmap_pgoff+0x537/0x710
 [<c0234048>] acpi_thermal_get_temperature+0x24/0x31
 [<c0234808>] acpi_thermal_temp_seq_show+0x12/0x4d
 [<c017125e>] seq_read+0xbe/0x280
 [<c0152ea1>] vfs_read+0xd1/0x130
 [<c0153171>] sys_read+0x41/0x70
 [<c01040db>] syscall_call+0x7/0xb

The machine is now allocating 64-byte slabs at about 20 objects per second.
I'm currently running 2.6.9-rc1-bk12 here.

-Udo.

--Signature=_Sun__12_Sep_2004_00_03_54_-0700_tspMnMIehuKSunJY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBQ/TfnhRzXSM7nSkRAimcAJ4vSfcXO+fAzCkObnacL9LVcVVtPwCeN5bc
eskw+tnnCQlt9UTFOJnAxk0=
=0hTw
-----END PGP SIGNATURE-----

--Signature=_Sun__12_Sep_2004_00_03_54_-0700_tspMnMIehuKSunJY--
