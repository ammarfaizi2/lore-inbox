Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWCFIuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWCFIuZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbWCFIuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:50:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752293AbWCFIuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:50:23 -0500
Date: Mon, 6 Mar 2006 00:48:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: greg@kroah.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: oops in choose_configuration()
Message-Id: <20060306004836.3db943e0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603051840280.13139@g5.osdl.org>
References: <20060304121723.19fe9b4b.akpm@osdl.org>
	<Pine.LNX.4.64.0603041235110.22647@g5.osdl.org>
	<20060304213447.GA4445@kroah.com>
	<20060304135138.613021bd.akpm@osdl.org>
	<20060304221810.GA20011@kroah.com>
	<20060305154858.0fb0006a.akpm@osdl.org>
	<Pine.LNX.4.64.0603051840280.13139@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> Andrew,
>  I'm worried about the fact that kmalloc() doesn't get redlining.
> 
> The lifetime rules for the pipe_info thing and the bprm seems totally 
> obvious, and we'd get slab errors if somebody was doing something strange 
> there anyway.
> 
> So I'd be more inclined to blame a buffer overflow on a kmalloc, and the 
> obvious target is the "add_uevent_var()" thing, since all/many of the 
> corruptions seem to come from uevent environment variable strings.
> 
> Because kmalloc() doesn't do redlining, we'd never see an overflow as an 
> error, and it would just overwrite the next block. Now, they are in 
> different slab blocks (the uevent strign allocation is a 2048-byte 
> allocation), but maybe it flows over into the next page entirely..
> 
> Now, it all uses "vnsprintf()" which _should_ be safe, but that in turn 
> uses pointer comparisons, so maybe gcc screws that up. Who knows. Gcc has 
> been known to use signed comparisons on pointers and other brokenness. And 
> we could just have screwed something up (not updating "len" when we update 
> the buffer start etc etc)

Maybe.  Something which is as deterministic as that would trip
CONFIG_DEBUG_PAGEALLOC though.

> Anyway, this trivial patch will check for buffer length consistency and 
> overflow by just putting a magic value at the end of the buffer, and 
> checking it. Maybe.
> 
> I don't see anything wrong there, and booting with this patch doesn't 
> trigger anything for me, but it's simple enough to be worth checking out.

Yup.  The wind changed direction and I lost the ability to reproduce it for
a few hours.  Going back to exactly the rc5-mm2 lineup did the trick.  Your
debug patch didn't trigger.



SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1141604160.744:3): policy loaded auid=4294967295
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
BUG: unable to handle kernel paging request at virtual address 44535955
 printing eip:
*pde = 00000000
Oops: 0000 [#1]
last sysfs file: /class/firmware/0000:06:0b.0/loading
Modules linked in: ide_cd cdrom ipw2200 ohci1394 ieee1394 ehci_hcd ieee80211 uhci_hcd sg joydev ieee80211_crypt snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm hw_random i2c_i801 snd_timer piix snd i2c_core soundcore snd_page_alloc generic ext3 jbd ide_disk ide_core
CPU:    0
EIP:    0060:[<c02437ed>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16-rc5-mm2 #302) 
EIP is at choose_configuration+0x58/0x13a
eax: 000000d2   ebx: f70aac00   ecx: 44535950   edx: 000001f4
esi: f76eca00   edi: 00000001   ebp: 00000000   esp: f7f3def8
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 114, threadinfo=f7f3d000 task=f7f3cab0)
Stack: <0>00000000 0000d000 f70aac00 f70aac00 00000000 00000001 c0243a5a 00000000 
       f70aac00 c1caa3c0 c0244ba1 00000000 0000000a f76ec814 f7029000 00000011 
       c1caa3c0 00000001 f7029000 00000001 c0244ff8 00000003 00000000 f76ec800 
Call Trace:
 <c0243a5a> usb_new_device+0x15a/0x1d0   <c0244ba1> hub_port_connect_change+0x1ad/0x343
 <c0244ff8> hub_events+0x2c1/0x3f1   <c0245128> hub_thread+0x0/0xe6
 <c0245132> hub_thread+0xa/0xe6   <c0128dfb> autoremove_wake_function+0x0/0x2d
 <c0128dfb> autoremove_wake_function+0x0/0x2d   <c0128b0c> kthread+0x9c/0xa1
 <c0128a70> kthread+0x0/0xa1   <c01012ed> kernel_thread_helper+0x5/0xb
Code: 00 58 39 fd c7 04 24 00 00 00 00 7d 53 0f b6 46 08 8b 8e 90 00 00 00 0f b7 93 18 02 00 00 01 c0 83 c1 08 39 d0 7f 2e 85 ed 75 0a <80> 79 05 02 0f 84 bf 00 00 00 80 bb 7c 01 00 00 ff 74 0a 80 79 
 <6>Non-volatile memory driver v1.2
BUG: unable to handle kernel paging request at virtual address 6963702f
 printing eip:
c01bc9b0
*pde = 00000000
Oops: 0000 [#2]
last sysfs file: /class/firmware/0000:06:0b.0/loading
Modules linked in: nvram ide_cd cdrom ipw2200 ohci1394 ieee1394 ehci_hcd ieee80211 uhci_hcd sg joydev ieee80211_crypt snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm hw_random i2c_i801 snd_timer piix snd i2c_core soundcore snd_page_alloc generic ext3 jbd ide_disk ide_core
CPU:    0
EIP:    0060:[<c01bc9b0>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16-rc5-mm2 #302) 
EIP is at kobject_uevent+0x28d/0x37c
eax: 00000000   ebx: f76f76c0   ecx: ffffffff   edx: f7176efc
esi: 0000002a   edi: 6963702f   ebp: f77542c0   esp: f7176f04
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 1025, threadinfo=f7176000 task=f7788ab0)
Stack: <0>f70f1000 c034da80 00000002 f70f1051 f8cf6e4d f7097640 c02e93d8 f76e9568 
       00000246 00000000 f7758a94 f76e9568 f76e9568 f76e9560 f76e9568 f8d28c40 
       c021e752 00000000 f70473a0 00000000 f76e9400 f76e9440 f76e9560 f763c000 
Call Trace:
 <c021e752> class_device_add+0x14e/0x201   <f8cf1efe> nodemgr_create_node+0x104/0x17b [ieee1394]
 <f8cf2b1a> nodemgr_node_scan_one+0x160/0x16e [ieee1394]   <f8cf2b76> nodemgr_node_scan+0x4e/0x50 [ieee1394]
 <f8cf3277> nodemgr_host_thread+0xdc/0x14c [ieee1394]   <f8cf319b> nodemgr_host_thread+0x0/0x14c [ieee1394]
 <c01012ed> kernel_thread_helper+0x5/0xb  
Code: 24 1c 68 01 1d 2f c0 57 e8 6e 25 00 00 c7 44 24 18 02 00 00 00 83 c4 10 83 7d 08 00 74 4f 8b 44 24 08 83 c9 ff 8b 7c 85 00 31 c0 <f2> ae f7 d1 49 83 7b 64 00 8d 71 01 8b bb 9c 00 00 00 75 61 01 
 <6>ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Lid Switch [LID0]


As is usual with this particular manifestation, we died here:

		if (i == 0 && desc->bInterfaceClass == USB_CLASS_COMM


(gdb) p sizeof(struct usb_interface_descriptor)
$3 = 9
(gdb) p sizeof(struct usb_host_config)
$4 = 280
(gdb) p sizeof(struct usb_interface_cache)
$5 = 8
(gdb) p sizeof(struct usb_host_interface)
$6 = 28
(gdb) offsetof usb_interface_descriptor bInterfaceClass
5 0x5

And that's quite different.  `struct usb_interface_cache' is only 8 bytes,
and the scribble is (as far as we know), not at offset zero.  Unless there
are a large number of `usb_host_interface's in `struct
usb_interface_cache's variable-sized array, we're not using the size-512
slab here.

<looks at choose_configuration()>

		struct usb_interface_descriptor	*desc =
				&c->intf_cache[0]->altsetting->desc;

Seems funny.

struct usb_interface_cache {
	unsigned num_altsetting;	/* number of alternate settings */
	struct kref ref;		/* reference counter */

	/* variable-length array of alternate settings for this interface,
	 * stored in no particular order */
	struct usb_host_interface altsetting[0];
};

A clearer way of coding that assignment would have been

		struct usb_interface_descriptor	*desc =
				&c->intf_cache[0]->altsetting[0].desc;

a) How come we're only considering the zeroth slot in that array in here?

b) How do we know that there's actually anything _there_?  The length of
   that variable-sized array doesn't seem to have been stored anywhere
   obvious by usb_parse_configuration() and choose_configuration() doesn't
   check.  What happens if the length was zero?

drivers/usb/core/config.c hasn't changed since October.  If it was this
easy, we'd have hit it before now.

Greg, who knows this code?  Can we triple-check it please?



Oh dear, there it goes.


SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1141605301.698:3): policy loaded auid=4294967295
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
------------[ cut here ]------------
kernel BUG at kernel/timer.c:213!
invalid opcode: 0000 [#1]
last sysfs file: /class/firmware/0000:06:0b.0/loading
Modules linked in: ide_cd cdrom ipw2200 ohci1394 ieee1394 ieee80211 ehci_hcd uhci_hcd ieee80211_crypt sg joydev snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm i2c_i801 hw_random piix snd_timer i2c_core snd soundcore snd_page_alloc generic ext3 jbd ide_disk ide_core
CPU:    0
EIP:    0060:[<c0120d68>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16-rc5-mm2 #302) 
EIP is at __mod_timer+0x5e/0x68
eax: f70a0898   ebx: f70a0898   ecx: 00000000   edx: fffef455
esi: fffef455   edi: 00000000   ebp: f7fadc48   esp: f77e4e10
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 613, threadinfo=f77e4000 task=f77d8570)
Stack: <0>00000000 f70a0840 f8d616e4 00000000 c022125f f706e240 f70faa0c f8d54328 
       f8d616e4 f8d54328 c0221323 00000001 f8d426d8 f70faa0c 00000000 00000003 
       f8d42a75 f8d54313 f70faa0c f70faa10 00000000 f7fadcb0 f8d4df95 f70faa0c 
Call Trace:
 <c022125f> _request_firmware+0x8f/0x14c   <c0221323> request_firmware+0x7/0x9
 <f8d426d8> ipw_get_fw+0x16/0xa0 [ipw2200]   <f8d42a75> ipw_load+0x232/0x799 [ipw2200]
 <f8d4df95> ipw_up+0x48/0x358 [ipw2200]   <f8d4e550> ipw_net_init+0x1c/0x3a [ipw2200]
 <c0271593> register_netdevice+0x4c/0x2da   <c0187433> create_files+0x23/0x44
 <c0271869> register_netdev+0x48/0x68   <f8d4e8b7> ipw_pci_probe+0x349/0x401 [ipw2200]
 <c0117484> __wake_up_locked+0x11/0x13   <c021db21> __driver_attach+0x0/0x6b
 <c01c693c> pci_call_probe+0xa/0xc   <c01c6972> __pci_device_probe+0x34/0x41
 <c01c699d> pci_device_probe+0x1e/0x32   <c021da87> driver_probe_device+0x49/0x8c
 <c021db77> __driver_attach+0x56/0x6b   <c021d2e2> bus_for_each_dev+0x44/0x59
 <c021db9d> driver_attach+0x11/0x13   <c021db21> __driver_attach+0x0/0x6b
 <c021d68e> bus_add_driver+0x57/0x81   <c021df2c> driver_register+0x70/0x75
 <c012f3bb> sys_init_module+0x66/0x15f   <c01c6b28> __pci_register_driver+0x37/0x49
 <c011a909> printk+0xe/0x11   <f8c93015> ipw_init+0x15/0x6a [ipw2200]
 <f8c93026> ipw_init+0x26/0x6a [ipw2200]   <c012f49c> sys_init_module+0x147/0x15f
 <c0102a9b> sysenter_past_esp+0x54/0x75  
Code: 20 00 a1 84 08 49 c0 39 c1 74 07 39 19 74 18 89 43 14 89 73 08 89 da e8 fb fe ff ff ff 34 24 9d 5a 89 f8 5b 5e 5f c3 89 c8 eb e7 <0f> 0b d5 00 c4 44 2e c0 eb a8 53 31 d2 8b 0d 84 08 49 c0 83 38 
 BUG: modprobe/613, lock held at task exit time!
 [c0357220] {rtnl_mutex}
.. held by:          modprobe:  613 [f77d8570, 113]
... acquired at:               register_netdev+0xb/0x68

