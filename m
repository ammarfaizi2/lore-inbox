Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTKRWWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 17:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTKRWWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 17:22:23 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:31451
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263800AbTKRWWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 17:22:18 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Patrick's Test9 suspend code.
Date: Tue, 18 Nov 2003 16:12:51 -0600
User-Agent: KMail/1.5
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0311170844230.12994-100000@cherise> <200311180602.18511.rob@landley.net> <20031118182216.GB745@elf.ucw.cz>
In-Reply-To: <20031118182216.GB745@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311181612.52176.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 November 2003 12:22, Pavel Machek wrote:
> Hi!
>
> > It then saved happily but didn't resume because I hadn't told it the
> > default resume partition was /dev/hda2.  (I don't have to specify which
> > partition to save to, why do I have to specify which one to resume from? 
> > Oh
> > well...)
>
> Think again. How is kernel expected to find out partition which it
> should resume from? Try all of them?
>
> You did swapon before suspend, that's where you specified "which
> partition". You need to tell it what to resume from...

I know.  Then again, if grub can read ext2... :)

Better would be the initramfs stuff, though.  If there's a way to trigger a 
resume that kills all running processes and loads userspace from the swap 
partition, then you could do that from initramfs _after_ finding /root a 
checking fstab, life is good.  (of course ext3 is brain-dead enough to always 
replay the journal even if it mounts read-only, so you'd have to mount it 
ext2 or something...  Hmmm...)

> > Unable to handle kernel paging request at virtual address cc044120
> >  printing eip:
> > c0131bf3
> > *pde = 01276067
> > *pte = 00000000
> > Oops: 0002 [#1]
> > CPU:    0
> > EIP:    0060:[<c0131bf3>]    Not tainted
> > EFLAGS: 00010246
> > EIP is at module_unload_init+0xe/0x52
> > eax: cc044120   ebx: cc036df0   ecx: cc043c20   edx: 00000000
> > esi: cc039cef   edi: cc0436ff   ebp: c4e1ff28   esp: c4e1ff28
> > ds: 007b   es: 007b   ss: 0068
> > Process modprobe (pid: 920, threadinfo=c4e1e000 task=c4ba7310)
> > Stack: c4e1ff9c c0133364 cc043c20 00000000 000003e8 cb015da0 cc013000
> > 00000000 cc043c20 00000000 00000000 00000000 00000000 00000000 00000008
> > 00000012 00000010 0000000c 00000000 00000000 00000018 00000017 00000019
> > cc0393e0 Call Trace:
> >  [<c0133364>] load_module+0x4d8/0x7f7
> >  [<c01336fa>] sys_init_module+0x77/0x234
> >  [<c0108f85>] sysenter_past_esp+0x52/0x71
> >
> > Code: 89 81 00 05 00 00 89 81 04 05 00 00 89 c8 42 c7 80 00 01 00
> >  Stopping tasks: ============================
> >  stopping tasks failed (1 tasks remaining)
> > Restarting tasks...<6> Strange, modprobe not stopped
> >  done
>
> Strange, it looks like you tried suspending in the middle of module
> being [un]loaded?

This was _right_ after the system booted up.  Possibly hotplug was still 
finding stuff, or the pcmcia wireless card had just decided it had found its 
access point, or some such...

These kinds of asynchronous module loads and unloads do happen.  The orinoco 
card driver is broken enough to sometimes decide that when it loses 
connection with the access point, instead of toggling the link status it 
decides the card has been unplugged!  (Real pain when that happens, by the 
way...)

So I can imagine modprobe was running, yeah.  But I hadn't done it personally.

> 								Pavel

Rob
