Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVBWPvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVBWPvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 10:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVBWPvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 10:51:54 -0500
Received: from ida.rowland.org ([192.131.102.52]:9220 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261417AbVBWPvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 10:51:47 -0500
Date: Wed, 23 Feb 2005 10:51:46 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Parag Warudkar <kernel-stuff@comcast.net>
cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6: USB Storage hangs machine on bootup for
 ~2 minutes
In-Reply-To: <200502221749.13372.kernel-stuff@comcast.net>
Message-ID: <Pine.LNX.4.44L0.0502231047370.1031-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005, Parag Warudkar wrote:

> Alan,
> See below for stack traces and also note that the stack traces are after I 
> modified usb_device_read to do down_interruptible instead of down. (kudzu 
> gets stuck regardless though.) Let me know if you want me to revert the 
> down_interruptible change and repost the stack trace.
> 
> I wrongly related this to the 2 minute hang - this one is forever if I let 
> kudzu start during boot. If I run kudzu after boot is complete, it gets stuck 
> and everything else on that drive (mount, unmount ..) also gets stuck. Sorry 
> about the confusion.

Well, this problem looks like something for which a patch was submitted 
about a week ago.  Try applying

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=110859441830485&w=2

and see if it helps.  This doesn't bring us any closer to understanding 
the 2-minute delay, though.

> Attached is the disassembly of usb_device_read from my machine.

I hope it doesn't become necessary to decode that!

Alan Stern

> Parag
> 
> SysRQ + T for relevant processes
> ======================
> hald          D 00000020e12be31a     0  2558      1          3272  2545 
> (NOTLB)
> ffff81002c76fb48 0000000000000082 ffff81002c76fb28 ffffffff88515044
>        000000862c76fb08 ffff81002eb10800 0000000000000249 ffff810001c56030
>        ffff81002c76fc08 0000000000000002
> Call Trace:
> <ffffffff88515044>{:scsi_mod:scsi_request_fn+2356}
>        <ffffffff80385f0f>{io_schedule+15} <ffffffff801698d6>{sync_page+70}
>        <ffffffff80386295>{__wait_on_bit_lock+69} 
> <ffffffff80169890>{sync_page+0}
>        <ffffffff8016a1b7>{__lock_page+167} 
> <ffffffff8015c860>{wake_bit_function+0}
>        <ffffffff8015c860>{wake_bit_function+0} 
> <ffffffff8016aed4>{do_generic_mapping_read+660}
>        <ffffffff8016b1f0>{file_read_actor+0} 
> <ffffffff8016d1d4>{__generic_file_aio_read+420}
>        <ffffffff8016d39b>{generic_file_read+187} 
> <ffffffff8015c820>{autoremove_wake_function+0}
>        <ffffffff80186150>{do_brk+720} <ffffffff801998d1>{vfs_read+225}
>        <ffffffff80199bd0>{sys_read+80} <ffffffff8010ed1e>{system_call+126}
> 
>  scsi_eh_2     D 00000000ffffffff     0  3581      1          3582  3277 
> (L-TLB)
>  ffff81002bdc1d88 0000000000000046 00000000000001e3 ffff81002bed8800
>         ffff81002bdc1d48 ffff81002c25a800 0000000000000812 ffffffff803df080
>         ffff81002bdc1ed0 ffff81002c25a800
>  Call Trace:
>  <ffffffff803846d5>{wait_for_completion+437} 
> <ffffffff80133e30>{default_wake_function+0}
>         <ffffffff80133e30>{default_wake_function+0} 
> <ffffffff88535be3>{:usb_storage:usb_stor_stop_transport+35}
>         <ffffffff88534250>{:usb_storage:command_abort+256}
>         <ffffffff88511f9c>{:scsi_mod:scsi_error_handler+2172}
>         <ffffffff8010f7ef>{child_rip+8} 
> <ffffffff88511720>{:scsi_mod:scsi_error_handler+0}
>         <ffffffff8010f7e7>{child_rip+0}
>  usb-storage   D 00000000ffffffff     0  3582      1          3627  3581 
> (L-TLB)
>  ffff81002b8e1c08 0000000000000046 ffff81002b9e1000 0000000000000010
>         000000762b8e1c98 ffff81002bed8800 00000000000003dd ffff81002eb10800
>         00000000c0040280 000000000000001f
>  Call Trace:
>  <ffffffff803846d5>{wait_for_completion+437} 
> <ffffffff803843e1>{thread_return+253}
>         <ffffffff80133e30>{default_wake_function+0} 
> <ffffffff80133e30>{default_wake_function+0}
>         <ffffffff88535166>{:usb_storage:usb_stor_msg_common+550}
>         <ffffffff80120426>{dma_unmap_sg+134} 
> <ffffffff8853570f>{:usb_storage:usb_stor_bulk_transfer_buf+143}
>         <ffffffff88535f8b>{:usb_storage:usb_stor_Bulk_transport+203}
>         <ffffffff885358eb>{:usb_storage:usb_stor_invoke_transport+59}
>         <ffffffff88534dfb>{:usb_storage:usb_stor_transparent_scsi_command+27}
>         <ffffffff88536974>{:usb_storage:usb_stor_control_thread+756}
>         <ffffffff801337c3>{finish_task_switch+195} 
> <ffffffff8010f7ef>{child_rip+8}
>         <ffffffff88536680>{:usb_storage:usb_stor_control_thread+0}
>         <ffffffff8010f7e7>{child_rip+0}
> 
>  scsi_eh_3     S 00000000ffffffff     0  3627      1          3634  3582 
> (L-TLB)
>  ffff81002bd47d68 0000000000000046 ffff81002bd47d28 ffffffff80219b32
>         000000742bc387c0 ffff81002bc387c0 0000000000000226 ffff81002b9fc030
>         ffff81002bd47d48 ffffffff80147ab1
>  Call Trace:
>  <ffffffff80219b32>{_atomic_dec_and_lock+290} <ffffffff80147ab1>{free_uid+33}
>         <ffffffff80383bd6>{__down_interruptible+486} 
> <ffffffff80133e30>{default_wake_function+0}
>         <ffffffff80386928>{__down_failed_interruptible+53}
>         <ffffffff88512a75>{:scsi_mod:.text.lock.scsi_error+45}
>         <ffffffff8010f7ef>{child_rip+8} 
> <ffffffff88511720>{:scsi_mod:scsi_error_handler+0}
>         <ffffffff8010f7e7>{child_rip+0}
>  usb-storage   S 00000020f04e3d81     0  3634      1                3627 
> (L-TLB)
>  ffff81002bc53df8 0000000000000046 ffff81002bc53d80 0000000000001000
>         000000732b9eba7c ffff81002b9fc030 00000000000005ad ffff81002ebc9800
>         ffff81002bc53de8 ffffffff8853570f
>  Call Trace:
>  <ffffffff8853570f>{:usb_storage:usb_stor_bulk_transfer_buf+143}
>         <ffffffff80383bd6>{__down_interruptible+486} 
> <ffffffff80133e30>{default_wake_function+0}
>         <ffffffff80386928>{__down_failed_interruptible+53}
>         <ffffffff88537bb8>{:usb_storage:.text.lock.usb+5} 
> <ffffffff801337c3>{finish_task_switch+195}
>         <ffffffff8010f7ef>{child_rip+8} 
> <ffffffff88536680>{:usb_storage:usb_stor_control_thread+0}
>        <ffffffff8010f7e7>{child_rip+0}
> 
> khubd         S 0000001ddd381da1     0   125      1           182     9 
> (L-TLB)
> ffff810001ecbe18 0000000000000046 0000000000000246 ffff81002ba2c400
>        0000007401ecbdd8 ffff810001e9a800 0000000000003023 ffff81002bed8070
>        ffff810001ecbe18 ffffffff8015c4c9
> Call Trace:
> <ffffffff8015c4c9>{prepare_to_wait+345} <ffffffff802e0216>{hub_thread+4118}
>        <ffffffff8016f0cf>{free_pages_bulk+1007} 
> <ffffffff8015c820>{autoremove_wake_function+0}
>        <ffffffff8015c820>{autoremove_wake_function+0} 
> <ffffffff8010f7ef>{child_rip+8}
>        <ffffffff802df200>{hub_thread+0} <ffffffff8010f7e7>{child_rip+0}

