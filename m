Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVBRAVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVBRAVw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 19:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVBRAVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 19:21:52 -0500
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:21752 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S261258AbVBRAVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 19:21:45 -0500
Date: Thu, 17 Feb 2005 19:21:41 -0500
From: Chuck Berg <chuck@encinc.com>
To: linux-kernel@vger.kernel.org
Subject: cdrecord stuck in D state with USB DVD burner
Message-ID: <20050218002141.GA7760@encinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a system with two USB DVD burners. If I burn a disc on both at the
same time, one of the dvdrecord processes hangs (unkillably stuck in the
D state). The usb-storage kernel thread was also stuck in the D state.

I power-cycled both burners. The disconnect appeared in the logs but
they were not detected when I powered them back on. After this, khubd
and scsi_eh_12 kernel threads were stuck in the D state.

This is with kernel 2.6.11-rc4. Fedora's 2.6.10-1.766_FC3smp also has the
same problem.

This is repeatable. I have no trouble if I only write to one drive at a time.

The drives are:

kernel: USB Mass Storage support registered.
kernel:   Vendor: _NEC      Model: DVD_RW ND-3520A   Rev: 1.04
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 00
kernel: sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
kernel: Uniform CD-ROM driver Revision: 3.20
kernel:   Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.04
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 00
kernel: sr1: scsi3-mmc drive: 94x/94x writer cd/rw xa/form2 cdda tray

Here is sysrq-t output for the stuck processes:

cdrecord      D 00000000  5704  5885   5884  5892               (NOTLB)
f1eb3c20 00000082 c0101f64 00000000 c0350ff7 f700be00 f887e083 f89f4943 
       e921f380 e921f380 e921f380 232c9ac0 000f4281 f7a6b080 00000000 232c9ac0 
       000f4281 f43e9758 f1eb3d18 00000000 f1eb3d1c f1eb3c8c c03516d7 00000000 
Call Trace:
 [<c0101f64>] __up+0x1c/0x20
 [<c0350ff7>] __up_wakeup+0x7/0x10
 [<f887e083>] scsi_done+0x0/0x16 [scsi_mod]
 [<f89f4943>] .text.lock.scsiglue+0xb/0x48 [usb_storage]
 [<c03516d7>] wait_for_completion+0xce/0x2da
 [<f88858c8>] scsi_request_fn+0x392/0x862 [scsi_mod]
 [<c011a6ff>] default_wake_function+0x0/0xc
 [<c011a6ff>] default_wake_function+0x0/0xc
 [<c027b0b1>] blk_execute_rq+0x10d/0x12e
 [<c015a87f>] follow_page+0xd/0x11
 [<c015a9f9>] get_user_pages+0x156/0x63c
 [<c0279e4c>] __generic_unplug_device+0x16/0x31
 [<c027ec4e>] sg_io+0x189/0x2b6
 [<c027f2e5>] scsi_cmd_ioctl+0x2bb/0x426
 [<c01ddd75>] avc_has_perm_noaudit+0x56/0xf4
 [<c01e1c39>] selinux_file_ioctl+0xdc/0x310
 [<f89e51c3>] ehci_work+0x2b/0x94 [ehci_hcd]
 [<c02af7c0>] cdrom_ioctl+0x2f/0xc9e
 [<c011a6ff>] default_wake_function+0x0/0xc
 [<f8a1f786>] sr_block_ioctl+0x52/0x59 [sr_mod]
 [<c027d918>] blkdev_ioctl+0x123/0x393
 [<c017cdef>] block_ioctl+0x0/0xd
 [<c0188889>] do_ioctl+0x39/0x52
 [<c0188a37>] vfs_ioctl+0x57/0x195
 [<c0188bd4>] sys_ioctl+0x5f/0x6f
 [<c0103695>] sysenter_past_esp+0x52/0x75
cdrecord      D F7B10D90  4932  5892   5885                     (NOTLB)
e91a5c20 00000082 f7b10d90 f7b10d90 e921f680 f76c6600 f7c1aa24 f8a1f455 
       f76f8db4 00000046 c042f9c0 a0f09280 000f42be f7cee620 00000000 a0f09280 
       000f42be f3f4f468 e91a5d18 00000000 e91a5d1c e91a5c8c c03516d7 f7c1aa24 
Call Trace:
 [<f8a1f455>] sr_init_command+0x244/0x3f0 [sr_mod]
 [<c03516d7>] wait_for_completion+0xce/0x2da
 [<f88858c8>] scsi_request_fn+0x392/0x862 [scsi_mod]
 [<c011a6ff>] default_wake_function+0x0/0xc
 [<c011a6ff>] default_wake_function+0x0/0xc
 [<c027b0b1>] blk_execute_rq+0x10d/0x12e
 [<c0281df2>] as_set_request+0x14/0x63
 [<c0281dde>] as_set_request+0x0/0x63
 [<c0277fe8>] elv_set_request+0x20/0x23
 [<c027a89a>] get_request+0x2d5/0x592
 [<c0279e4c>] __generic_unplug_device+0x16/0x31
 [<c0279edc>] generic_unplug_device+0x75/0x151
 [<c0277e4f>] elv_next_request+0x2d/0xf0
 [<c027ec4e>] sg_io+0x189/0x2b6
 [<c027f2e5>] scsi_cmd_ioctl+0x2bb/0x426
 [<c01ddd75>] avc_has_perm_noaudit+0x56/0xf4
 [<c01e1c39>] selinux_file_ioctl+0xdc/0x310
 [<f89e51c3>] ehci_work+0x2b/0x94 [ehci_hcd]
 [<c02af7c0>] cdrom_ioctl+0x2f/0xc9e
 [<c01179a2>] do_page_fault+0x1c4/0x54b
 [<f8a1f786>] sr_block_ioctl+0x52/0x59 [sr_mod]
 [<c027d918>] blkdev_ioctl+0x123/0x393
 [<c017cdef>] block_ioctl+0x0/0xd
 [<c0188889>] do_ioctl+0x39/0x52
 [<c0188a37>] vfs_ioctl+0x57/0x195
 [<c0188bd4>] sys_ioctl+0x5f/0x6f
 [<c0103695>] sysenter_past_esp+0x52/0x75
scsi_eh_12    D 00000000  7608  2276      1          2277  1771 (L-TLB)
f7647e54 00000046 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 f7668b08 f77d3280 00000092 00000000 b41a6ac0 
       000f42af f772ecf8 f700bf70 f700be00 f700bf74 f7647ec0 c03516d7 f7668a00 
Call Trace:
 [<c03516d7>] wait_for_completion+0xce/0x2da
 [<c02b8501>] unlink1+0x16/0x26
 [<c02b88c7>] hcd_unlink_urb+0x3b6/0x4f6
 [<c011a6ff>] default_wake_function+0x0/0xc
 [<c011a6ff>] default_wake_function+0x0/0xc
 [<f89f41a6>] command_abort+0x8b/0x19f [usb_storage]
 [<c03512d2>] schedule+0x2d2/0x609
 [<f8881bb3>] scsi_try_to_abort_cmd+0xbd/0x1bd [scsi_mod]
 [<f8881ddd>] scsi_eh_abort_cmds+0x45/0xde [scsi_mod]
 [<c011a8bc>] __wake_up_locked+0x1f/0x21
 [<f888327f>] scsi_unjam_host+0x127/0x2ce [scsi_mod]
 [<c011a6ff>] default_wake_function+0x0/0xc
 [<f8883574>] scsi_error_handler+0x14e/0x205 [scsi_mod]
 [<f8883426>] scsi_error_handler+0x0/0x205 [scsi_mod]
 [<c0101291>] kernel_thread_helper+0x5/0xb
usb-storage   D 00000D80  6536  2277      1          2528  2276 (L-TLB)
f77f1dd8 00000046 f7b91c14 00000d80 00000080 376cd08d 50000c80 f77f1dc8 
       f700ce00 f700ce00 00000010 f77f1dc8 f7668b08 f89e558f 00000000 23882840 
       000f4281 f7a6b1e8 f77f1eac 00000000 f77f1eb0 f77f1e44 c03516d7 c02b8394 
Call Trace:
 [<f89e558f>] ehci_urb_enqueue+0x5b/0xb8 [ehci_hcd]
 [<c03516d7>] wait_for_completion+0xce/0x2da
 [<c02b8394>] hcd_submit_urb+0x1aa/0x2df
 [<f89e558f>] ehci_urb_enqueue+0x5b/0xb8 [ehci_hcd]
 [<c011a6ff>] default_wake_function+0x0/0xc
 [<c02b92cf>] usb_submit_urb+0x1c2/0x2b2
 [<c011a6ff>] default_wake_function+0x0/0xc
 [<f89f4ec5>] usb_stor_msg_common+0x1a4/0x1e8 [usb_storage]
 [<c02b9060>] urb_destroy+0x0/0x5
 [<c01f2ccd>] kref_put+0x28/0x63
 [<c02b9b77>] sg_clean+0x84/0x91
 [<f89f5354>] usb_stor_bulk_transfer_buf+0x69/0x9d [usb_storage]
 [<f89f5b42>] usb_stor_Bulk_transport+0x16d/0x2be [usb_storage]
 [<f89f54cb>] usb_stor_invoke_transport+0x1f/0x29b [usb_storage]
 [<c011a6ff>] default_wake_function+0x0/0xc
 [<f89f4ad2>] usb_stor_transparent_scsi_command+0xb/0x27 [usb_storage]
 [<f89f6430>] usb_stor_control_thread+0x2a8/0x428 [usb_storage]
 [<c0119fca>] schedule_tail+0x14/0x53
 [<c01035fa>] ret_from_fork+0x6/0x14
 [<f89f6188>] usb_stor_control_thread+0x0/0x428 [usb_storage]
 [<f89f6188>] usb_stor_control_thread+0x0/0x428 [usb_storage]
 [<c0101291>] kernel_thread_helper+0x5/0xb
