Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWCHBbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWCHBbQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWCHBbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:31:15 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:34729
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964875AbWCHBbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:31:15 -0500
Date: Tue, 7 Mar 2006 17:31:01 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net
Cc: Linus Torvalds <torvalds@osdl.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: oops in choose_configuration()
Message-ID: <20060308013101.GB24739@kroah.com>
References: <20060304121723.19fe9b4b.akpm@osdl.org> <Pine.LNX.4.64.0603041235110.22647@g5.osdl.org> <20060304213447.GA4445@kroah.com> <20060304135138.613021bd.akpm@osdl.org> <20060304221810.GA20011@kroah.com> <20060305154858.0fb0006a.akpm@osdl.org> <Pine.LNX.4.64.0603051840280.13139@g5.osdl.org> <20060306004836.3db943e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306004836.3db943e0.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 12:48:36AM -0800, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > 
> > Andrew,
> >  I'm worried about the fact that kmalloc() doesn't get redlining.
> > 
> > The lifetime rules for the pipe_info thing and the bprm seems totally 
> > obvious, and we'd get slab errors if somebody was doing something strange 
> > there anyway.
> > 
> > So I'd be more inclined to blame a buffer overflow on a kmalloc, and the 
> > obvious target is the "add_uevent_var()" thing, since all/many of the 
> > corruptions seem to come from uevent environment variable strings.
> > 
> > Because kmalloc() doesn't do redlining, we'd never see an overflow as an 
> > error, and it would just overwrite the next block. Now, they are in 
> > different slab blocks (the uevent strign allocation is a 2048-byte 
> > allocation), but maybe it flows over into the next page entirely..
> > 
> > Now, it all uses "vnsprintf()" which _should_ be safe, but that in turn 
> > uses pointer comparisons, so maybe gcc screws that up. Who knows. Gcc has 
> > been known to use signed comparisons on pointers and other brokenness. And 
> > we could just have screwed something up (not updating "len" when we update 
> > the buffer start etc etc)
> 
> Maybe.  Something which is as deterministic as that would trip
> CONFIG_DEBUG_PAGEALLOC though.
> 
> > Anyway, this trivial patch will check for buffer length consistency and 
> > overflow by just putting a magic value at the end of the buffer, and 
> > checking it. Maybe.
> > 
> > I don't see anything wrong there, and booting with this patch doesn't 
> > trigger anything for me, but it's simple enough to be worth checking out.
> 
> Yup.  The wind changed direction and I lost the ability to reproduce it for
> a few hours.  Going back to exactly the rc5-mm2 lineup did the trick.  Your
> debug patch didn't trigger.
> 
> 
> 
> SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
> SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
> audit(1141604160.744:3): policy loaded auid=4294967295
> SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
> BUG: unable to handle kernel paging request at virtual address 44535955
>  printing eip:
> *pde = 00000000
> Oops: 0000 [#1]
> last sysfs file: /class/firmware/0000:06:0b.0/loading
> Modules linked in: ide_cd cdrom ipw2200 ohci1394 ieee1394 ehci_hcd ieee80211 uhci_hcd sg joydev ieee80211_crypt snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm hw_random i2c_i801 snd_timer piix snd i2c_core soundcore snd_page_alloc generic ext3 jbd ide_disk ide_core
> CPU:    0
> EIP:    0060:[<c02437ed>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.16-rc5-mm2 #302) 
> EIP is at choose_configuration+0x58/0x13a
> eax: 000000d2   ebx: f70aac00   ecx: 44535950   edx: 000001f4
> esi: f76eca00   edi: 00000001   ebp: 00000000   esp: f7f3def8
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 114, threadinfo=f7f3d000 task=f7f3cab0)
> Stack: <0>00000000 0000d000 f70aac00 f70aac00 00000000 00000001 c0243a5a 00000000 
>        f70aac00 c1caa3c0 c0244ba1 00000000 0000000a f76ec814 f7029000 00000011 
>        c1caa3c0 00000001 f7029000 00000001 c0244ff8 00000003 00000000 f76ec800 
> Call Trace:
>  <c0243a5a> usb_new_device+0x15a/0x1d0   <c0244ba1> hub_port_connect_change+0x1ad/0x343
>  <c0244ff8> hub_events+0x2c1/0x3f1   <c0245128> hub_thread+0x0/0xe6
>  <c0245132> hub_thread+0xa/0xe6   <c0128dfb> autoremove_wake_function+0x0/0x2d
>  <c0128dfb> autoremove_wake_function+0x0/0x2d   <c0128b0c> kthread+0x9c/0xa1
>  <c0128a70> kthread+0x0/0xa1   <c01012ed> kernel_thread_helper+0x5/0xb
> Code: 00 58 39 fd c7 04 24 00 00 00 00 7d 53 0f b6 46 08 8b 8e 90 00 00 00 0f b7 93 18 02 00 00 01 c0 83 c1 08 39 d0 7f 2e 85 ed 75 0a <80> 79 05 02 0f 84 bf 00 00 00 80 bb 7c 01 00 00 ff 74 0a 80 79 
>  <6>Non-volatile memory driver v1.2
> BUG: unable to handle kernel paging request at virtual address 6963702f
>  printing eip:
> c01bc9b0
> *pde = 00000000
> Oops: 0000 [#2]
> last sysfs file: /class/firmware/0000:06:0b.0/loading
> Modules linked in: nvram ide_cd cdrom ipw2200 ohci1394 ieee1394 ehci_hcd ieee80211 uhci_hcd sg joydev ieee80211_crypt snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm hw_random i2c_i801 snd_timer piix snd i2c_core soundcore snd_page_alloc generic ext3 jbd ide_disk ide_core
> CPU:    0
> EIP:    0060:[<c01bc9b0>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.16-rc5-mm2 #302) 
> EIP is at kobject_uevent+0x28d/0x37c
> eax: 00000000   ebx: f76f76c0   ecx: ffffffff   edx: f7176efc
> esi: 0000002a   edi: 6963702f   ebp: f77542c0   esp: f7176f04
> ds: 007b   es: 007b   ss: 0068
> Process knodemgrd_0 (pid: 1025, threadinfo=f7176000 task=f7788ab0)
> Stack: <0>f70f1000 c034da80 00000002 f70f1051 f8cf6e4d f7097640 c02e93d8 f76e9568 
>        00000246 00000000 f7758a94 f76e9568 f76e9568 f76e9560 f76e9568 f8d28c40 
>        c021e752 00000000 f70473a0 00000000 f76e9400 f76e9440 f76e9560 f763c000 
> Call Trace:
>  <c021e752> class_device_add+0x14e/0x201   <f8cf1efe> nodemgr_create_node+0x104/0x17b [ieee1394]
>  <f8cf2b1a> nodemgr_node_scan_one+0x160/0x16e [ieee1394]   <f8cf2b76> nodemgr_node_scan+0x4e/0x50 [ieee1394]
>  <f8cf3277> nodemgr_host_thread+0xdc/0x14c [ieee1394]   <f8cf319b> nodemgr_host_thread+0x0/0x14c [ieee1394]
>  <c01012ed> kernel_thread_helper+0x5/0xb  
> Code: 24 1c 68 01 1d 2f c0 57 e8 6e 25 00 00 c7 44 24 18 02 00 00 00 83 c4 10 83 7d 08 00 74 4f 8b 44 24 08 83 c9 ff 8b 7c 85 00 31 c0 <f2> ae f7 d1 49 83 7b 64 00 8d 71 01 8b bb 9c 00 00 00 75 61 01 
>  <6>ACPI: AC Adapter [ACAD] (on-line)
> ACPI: Battery Slot [BAT1] (battery present)
> ACPI: Lid Switch [LID0]
> 
> 
> As is usual with this particular manifestation, we died here:
> 
> 		if (i == 0 && desc->bInterfaceClass == USB_CLASS_COMM
> 
> 
> (gdb) p sizeof(struct usb_interface_descriptor)
> $3 = 9
> (gdb) p sizeof(struct usb_host_config)
> $4 = 280
> (gdb) p sizeof(struct usb_interface_cache)
> $5 = 8
> (gdb) p sizeof(struct usb_host_interface)
> $6 = 28
> (gdb) offsetof usb_interface_descriptor bInterfaceClass
> 5 0x5
> 
> And that's quite different.  `struct usb_interface_cache' is only 8 bytes,
> and the scribble is (as far as we know), not at offset zero.  Unless there
> are a large number of `usb_host_interface's in `struct
> usb_interface_cache's variable-sized array, we're not using the size-512
> slab here.
> 
> <looks at choose_configuration()>
> 
> 		struct usb_interface_descriptor	*desc =
> 				&c->intf_cache[0]->altsetting->desc;
> 
> Seems funny.
> 
> struct usb_interface_cache {
> 	unsigned num_altsetting;	/* number of alternate settings */
> 	struct kref ref;		/* reference counter */
> 
> 	/* variable-length array of alternate settings for this interface,
> 	 * stored in no particular order */
> 	struct usb_host_interface altsetting[0];
> };
> 
> A clearer way of coding that assignment would have been
> 
> 		struct usb_interface_descriptor	*desc =
> 				&c->intf_cache[0]->altsetting[0].desc;

Agreed.

> a) How come we're only considering the zeroth slot in that array in here?

We start out with the first interface setting, as we always know we have
one of them as per the USB spec (I think, anyone from linux-usb-devel
want to verify this?)

> b) How do we know that there's actually anything _there_?  The length of
>    that variable-sized array doesn't seem to have been stored anywhere
>    obvious by usb_parse_configuration() and choose_configuration() doesn't
>    check.  What happens if the length was zero?

I don't think it is allowed to be, as all USB devices have to have at
least 1 interface.

> drivers/usb/core/config.c hasn't changed since October.  If it was this
> easy, we'd have hit it before now.
> 
> Greg, who knows this code?  Can we triple-check it please?

I'll walk through it again, it's some nasty crap, I agree.  Time to dig
out the USB spec...

Anyone else on linux-usb-devel want to verify it too?

thanks,

greg k-h
