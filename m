Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWJVPqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWJVPqq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 11:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWJVPqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 11:46:46 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:30602 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751019AbWJVPqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 11:46:45 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 22 Oct 2006 17:45:33 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [rfc patch] ieee1394: nodemgr: revise semaphore protection of
 driver core data
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
In-Reply-To: <tkrat.2407a13c0fa37837@s5r6.in-berlin.de>
Message-ID: <tkrat.dc92ad51062d41bb@s5r6.in-berlin.de>
References: <tkrat.2407a13c0fa37837@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
...
>  - nodemgr_remove_uds() iterated over nodemgr_ud_class.children without
>    proper protection.  This was never observed as a bug since the code
>    is usually only accessed by knodemgrd.  All knodemgrds are currently
>    globally serialized.  But userspace can trigger this code too by
>    writing to /sys/bus/ieee1394/destroy_node.
...
>  static void nodemgr_remove_uds(struct node_entry *ne)
>  {
> -	struct class_device *cdev, *next;
> -	struct unit_directory *ud;
> +	struct class_device *cdev;
> +	struct unit_directory *ud, **unreg;
> +	size_t i, count;
>  
> -	list_for_each_entry_safe(cdev, next, &nodemgr_ud_class.children, node) {
> -		ud = container_of(cdev, struct unit_directory, class_dev);
> +	/*
> +	 * This is awkward:
> +	 * Iteration over nodemgr_ud_class.children has to be protected by
> +	 * nodemgr_ud_class.sem, but class_device_unregister() will eventually
> +	 * take nodemgr_ud_class.sem too. Therefore store all uds to be
> +	 * unregistered in a temporary array, release the semaphore, and then
> +	 * unregister the uds.
> +	 *
> +	 * Since nodemgr_remove_uds can also run in other contexts than the
> +	 * knodemgrds (which are currently globally serialized), protect the
> +	 * gap after release of the semaphore by nodemgr_serialize_remove_uds.
> +	 */
...

Hmm. This worked with a few devices. I now tried one with a problematic
firmware and it didn't work so well. (I don't know if this is actually
related to the firmware. Or maybe it doesn't even have anything to do
with this patch.)

# modprobe -r ohci1394
Segmentation fault

Oct 22 17:24:08 shuttle kernel: ieee1394: Node removed: ID:BUS[1-01:1023]  GUID[00301bac00002ba4]
Oct 22 17:24:08 shuttle kernel: ieee1394: Node removed: ID:BUS[1-00:1023]  GUID[0030e005003b00c8]
Oct 22 17:24:08 shuttle kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000002c
Oct 22 17:24:08 shuttle kernel:  printing eip:
Oct 22 17:24:08 shuttle kernel: c02d72a4
Oct 22 17:24:08 shuttle kernel: *pde = 00000000
Oct 22 17:24:08 shuttle kernel: Oops: 0000 [#1]
Oct 22 17:24:08 shuttle kernel: PREEMPT SMP 
Oct 22 17:24:08 shuttle kernel: Modules linked in: ohci1394 ieee1394 ext3 jbd sd_mod scsi_mod nvidia(P) nfsd exportfs lockd sunrpc snd_via82xx snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd lp af_packet 8139too mii loop via_agp agpgart uhci_hcd
Oct 22 17:24:08 shuttle kernel: CPU:    0
Oct 22 17:24:08 shuttle kernel: EIP:    0060:[klist_del+20/80]    Tainted: P      VLI
Oct 22 17:24:08 shuttle kernel: EIP:    0060:[<c02d72a4>]    Tainted: P      VLI
Oct 22 17:24:08 shuttle kernel: EFLAGS: 00210286   (2.6.19-rc2 #4)
Oct 22 17:24:08 shuttle kernel: EIP is at klist_del+0x14/0x50
Oct 22 17:24:08 shuttle kernel: eax: f3e88e40   ebx: 00000000   ecx: 00000000   edx: 00000000
Oct 22 17:24:08 shuttle kernel: esi: f3e88d98   edi: f3e88e40   ebp: ed6e5d54   esp: ed6e5d44
Oct 22 17:24:08 shuttle kernel: ds: 007b   es: 007b   ss: 0068
Oct 22 17:24:08 shuttle kernel: Process modprobe (pid: 8585, ti=ed6e4000 task=c3e5d570 task.ti=ed6e4000)
Oct 22 17:24:08 shuttle kernel: Stack: ed6e5d54 f3e88e80 f3e88d98 f3e88e80 ed6e5d6c c023262b f3e88e40 f3e88d98 
Oct 22 17:24:08 shuttle kernel:        f3e88d98 f3e88d98 ed6e5d8c c0230e65 f3e88d98 f3e88ef4 f433b4d4 f3e88d98 
Oct 22 17:24:08 shuttle kernel:        00000001 f433b498 ed6e5d9c c0230ff2 f3e88d98 00000001 ed6e5dbc f9053b77 
Oct 22 17:24:08 shuttle kernel: Call Trace:
Oct 22 17:24:08 shuttle kernel:  [show_trace_log_lvl+47/80] show_trace_log_lvl+0x2f/0x50
Oct 22 17:24:08 shuttle kernel:  [<c010400f>] show_trace_log_lvl+0x2f/0x50
Oct 22 17:24:08 shuttle kernel:  [show_stack_log_lvl+151/192] show_stack_log_lvl+0x97/0xc0
Oct 22 17:24:08 shuttle kernel:  [<c01040f7>] show_stack_log_lvl+0x97/0xc0
Oct 22 17:24:08 shuttle kernel:  [show_registers+450/624] show_registers+0x1c2/0x270
Oct 22 17:24:08 shuttle kernel:  [<c0104352>] show_registers+0x1c2/0x270
Oct 22 17:24:08 shuttle kernel:  [die+297/544] die+0x129/0x220
Oct 22 17:24:08 shuttle kernel:  [<c01045f9>] die+0x129/0x220
Oct 22 17:24:08 shuttle kernel:  [do_page_fault+970/1616] do_page_fault+0x3ca/0x650
Oct 22 17:24:08 shuttle kernel:  [<c011495a>] do_page_fault+0x3ca/0x650
Oct 22 17:24:08 shuttle kernel:  [error_code+57/64] error_code+0x39/0x40
Oct 22 17:24:08 shuttle kernel:  [<c02da9d1>] error_code+0x39/0x40
Oct 22 17:24:08 shuttle kernel:  [bus_remove_device+139/176] bus_remove_device+0x8b/0xb0
Oct 22 17:24:08 shuttle kernel:  [<c023262b>] bus_remove_device+0x8b/0xb0
Oct 22 17:24:08 shuttle kernel:  [device_del+117/496] device_del+0x75/0x1f0
Oct 22 17:24:08 shuttle kernel:  [<c0230e65>] device_del+0x75/0x1f0
Oct 22 17:24:08 shuttle kernel:  [device_unregister+18/32] device_unregister+0x12/0x20
Oct 22 17:24:08 shuttle kernel:  [<c0230ff2>] device_unregister+0x12/0x20
Oct 22 17:24:08 shuttle kernel:  [pg0+950553463/1067643904] nodemgr_remove_uds+0x147/0x180 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [<f9053b77>] nodemgr_remove_uds+0x147/0x180 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [pg0+950553614/1067643904] nodemgr_remove_ne+0x5e/0x90 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [<f9053c0e>] nodemgr_remove_ne+0x5e/0x90 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [pg0+950553684/1067643904] __nodemgr_remove_host_dev+0x14/0x20 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [<f9053c54>] __nodemgr_remove_host_dev+0x14/0x20 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [device_for_each_child+50/96] device_for_each_child+0x32/0x60
Oct 22 17:24:08 shuttle kernel:  [<c0231052>] device_for_each_child+0x32/0x60
Oct 22 17:24:08 shuttle kernel:  [pg0+950553730/1067643904] nodemgr_remove_host_dev+0x22/0x90 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [<f9053c82>] nodemgr_remove_host_dev+0x22/0x90 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [pg0+950561495/1067643904] nodemgr_remove_host+0x37/0x40 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [<f9055ad7>] nodemgr_remove_host+0x37/0x40 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [pg0+950538732/1067643904] __unregister_host+0x8c/0xd0 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [<f90501ec>] __unregister_host+0x8c/0xd0 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [pg0+950541126/1067643904] highlevel_remove_host+0x36/0x60 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [<f9050b46>] highlevel_remove_host+0x36/0x60 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [pg0+950537299/1067643904] hpsb_remove_host+0x43/0x70 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [<f904fc53>] hpsb_remove_host+0x43/0x70 [ieee1394]
Oct 22 17:24:08 shuttle kernel:  [pg0+946126376/1067643904] ohci1394_pci_remove+0x68/0x240 [ohci1394]
Oct 22 17:24:08 shuttle kernel:  [<f8c1ae28>] ohci1394_pci_remove+0x68/0x240 [ohci1394]
Oct 22 17:24:08 shuttle kernel:  [pci_device_remove+56/64] pci_device_remove+0x38/0x40
Oct 22 17:24:08 shuttle kernel:  [<c01fe168>] pci_device_remove+0x38/0x40
Oct 22 17:24:08 shuttle kernel:  [__device_release_driver+163/192] __device_release_driver+0xa3/0xc0
Oct 22 17:24:08 shuttle kernel:  [<c0233353>] __device_release_driver+0xa3/0xc0
Oct 22 17:24:08 shuttle kernel:  [driver_detach+280/288] driver_detach+0x118/0x120
Oct 22 17:24:08 shuttle kernel:  [<c02334e8>] driver_detach+0x118/0x120
Oct 22 17:24:08 shuttle kernel:  [bus_remove_driver+68/112] bus_remove_driver+0x44/0x70
Oct 22 17:24:08 shuttle kernel:  [<c0232964>] bus_remove_driver+0x44/0x70
Oct 22 17:24:08 shuttle kernel:  [driver_unregister+18/32] driver_unregister+0x12/0x20
Oct 22 17:24:08 shuttle kernel:  [<c02337b2>] driver_unregister+0x12/0x20
Oct 22 17:24:08 shuttle kernel:  [pci_unregister_driver+21/48] pci_unregister_driver+0x15/0x30
Oct 22 17:24:08 shuttle kernel:  [<c01fe4c5>] pci_unregister_driver+0x15/0x30
Oct 22 17:24:08 shuttle kernel:  [pg0+946128034/1067643904] ohci1394_cleanup+0x12/0x14 [ohci1394]
Oct 22 17:24:08 shuttle kernel:  [<f8c1b4a2>] ohci1394_cleanup+0x12/0x14 [ohci1394]
Oct 22 17:24:08 shuttle kernel:  [sys_delete_module+342/384] sys_delete_module+0x156/0x180
Oct 22 17:24:08 shuttle kernel:  [<c0141256>] sys_delete_module+0x156/0x180
Oct 22 17:24:08 shuttle kernel:  [sysenter_past_esp+86/121] sysenter_past_esp+0x56/0x79
Oct 22 17:24:08 shuttle kernel:  [<c010324d>] sysenter_past_esp+0x56/0x79
Oct 22 17:24:08 shuttle kernel:  =======================
Oct 22 17:24:08 shuttle kernel: Code: c7 44 24 04 30 72 2d c0 83 c0 0c 89 04 24 e8 a4 b8 f1 ff c9 c3 89 f6 55 89 e5 83 ec 10 89 7d fc 8b 7d 08 89 5d f4 89 75 f8 8b 1f <8b> 73 2c 89 d8 e8 c2 2f 00 00 89 3c 24 e8 ba ff ff ff 85 c0 b8 
Oct 22 17:24:08 shuttle kernel: EIP: [klist_del+20/80] klist_del+0x14/0x50 SS:ESP 0068:ed6e5d44
Oct 22 17:24:08 shuttle kernel: EIP: [<c02d72a4>] klist_del+0x14/0x50 SS:ESP 0068:ed6e5d44


-- 
Stefan Richter
-=====-=-==- =-=- =-==-
http://arcgraph.de/sr/

