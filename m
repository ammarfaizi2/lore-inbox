Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVJRHRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVJRHRw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 03:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVJRHRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 03:17:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:52146 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751448AbVJRHRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 03:17:51 -0400
Date: Tue, 18 Oct 2005 00:17:12 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, Brice Goglin <Brice.Goglin@ens-lyon.org>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.14-rc4-mm1
Message-ID: <20051018071712.GA12145@kroah.com>
References: <20051016154108.25735ee3.akpm@osdl.org> <20051017132242.2b872b08.akpm@osdl.org> <20051018065843.GB11858@kroah.com> <200510180209.49080.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510180209.49080.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 02:09:48AM -0500, Dmitry Torokhov wrote:
> On Tuesday 18 October 2005 01:58, Greg KH wrote:
> > On Mon, Oct 17, 2005 at 01:22:42PM -0700, Andrew Morton wrote:
> > > Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> > > > Modules linked in: pcspkr parport_pc parport irtty_sir sir_dev irda
> > > > crc_ccitt hw_random uhci_hcd usbcore snd_maestro3 snd_ac97_codec
> > > > snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc
> > > > snd soundcore yenta_socket rsrc_nonstatic pcmcia_core nls_iso8859_15
> > > > nls_cp850 vfat fat nls_base psmouse
> > > > CPU:    0
> > > > EIP:    0060:[<c01dda09>]    Not tainted VLI
> > > > EFLAGS: 00010246   (2.6.14-rc4-mm1=LoulousMobile)
> > > > EIP is at get_kobj_path_length+0x19/0x30
> > > > eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: e6efee50
> > > > esi: 00000001   edi: 00000000   ebp: e737eec8   esp: e737eebc
> > > > ds: 007b   es: 007b   ss: 0068
> > > > Process sed (pid: 3258, threadinfo=e737e000 task=e7970a90)
> > > > Stack: e6efe800 00000001 e6de4000 e737eee8 c01dda9a e6efee50 e6de42e4
> > > > 00000286
> > > >        e6efe800 00000001 e6de4000 e737ef24 c02a357f e6efee50 800000d0
> > > > 0000000f
> > > >        00000002 0000000a 00000000 e6efe800 00000000 000002e5 000002e5
> > > > e7e9ce60
> > > > Call Trace:
> > > >  [<c010414b>] show_stack+0xab/0xf0
> > > >  [<c010433f>] show_registers+0x18f/0x230
> > > >  [<c0104592>] die+0x102/0x1c0
> > > >  [<c035f27a>] do_page_fault+0x33a/0x66f
> > > >  [<c0103dbb>] error_code+0x4f/0x54
> > > >  [<c01dda9a>] kobject_get_path+0x1a/0x70
> > > >  [<c02a357f>] input_devices_read+0x53f/0x590
> > > >  [<c01a2e75>] proc_file_read+0x1b5/0x260
> > > >  [<c01689f8>] vfs_read+0xa8/0x190
> > > >  [<c0168dc7>] sys_read+0x47/0x70
> > > >  [<c0103325>] syscall_call+0x7/0xb
> > > > Code: f8 89 ec 5d c3 8d b6 00 00 00 00 8d bc 27 00 00 00 00 55 89 e5 8b
> > > > 55 08 57 56 be 01 00 00 00 53 31 db 8b 3a b9 ff ff ff ff 89 d8 <f2> ae
> > > > f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 e7 5b 89 f0 5e 5f
> > > > <6>input: isa0061/input0//class/input_dev as input3
> > > 
> > > Something went wrong under input_devices_read().   Probably culprits cc'ed.
> > 
> > I know this patch doesn't have the proc path, but it does fix an easy
> > oops that I can generate from sysfs input devices.  Can you try it out
> > to see if it fixes your issue too?
> >
> 
> I am confused - the only thing changed is the way you create attributes,
> not the way data is accessed. What is the difference and why does it fix
> the OOPS? 

Because before my patch, any class_device created for the input class,
had the name, phys, and uniq attributes created for them, including the
"simple" class device structures event0, event1, and so on.  The kobject
being passed back to those callback functions was not of the same type
of object as input0, input1 and so on.  So bad things happened.

I just moved the attribute group out of the class, and created it when
the proper input device was registered.  Hm, forgot to uncreate the
group too, I'll go do that now...

Hope this helps,

greg k-h
