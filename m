Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVHHUUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVHHUUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVHHUUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:20:23 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:45267
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S932254AbVHHUUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:20:21 -0400
Date: Mon, 8 Aug 2005 16:18:48 -0400
From: Sonny Rao <sonny@burdell.org>
To: Andrew Morton <akpm@osdl.org>
Cc: rdunlap@xenotime.net, miles.lane@gmail.com, airlied@gmail.com,
       linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>,
       Greg KH <greg@kroah.com>
Subject: Re: OOPS in 2.6.13-rc1-mm1 -- EIP is at sysfs_release+0x49/0xb0
Message-ID: <20050808201848.GA27133@kevlar.burdell.org>
References: <a44ae5cd05070301417531fac2@mail.gmail.com> <21d7e9970507070331107831c6@mail.gmail.com> <1121055986.10029.9.camel@localhost.localdomain> <21d7e99705071300173ae0c39b@mail.gmail.com> <a44ae5cd05071307546d3f8f9e@mail.gmail.com> <20050713124215.77a6a6a1.rdunlap@xenotime.net> <20050808165352.GA20622@kevlar.burdell.org> <20050808104404.11846951.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808104404.11846951.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 10:44:04AM -0700, Andrew Morton wrote:
> Sonny Rao <sonny@burdell.org> wrote:
> >
> > On Wed, Jul 13, 2005 at 12:42:15PM -0700, randy_dunlap wrote:
> > > On Wed, 13 Jul 2005 09:54:10 -0500 Miles Lane wrote:
> > > 
> > > > On 7/13/05, Dave Airlie <airlied@gmail.com> wrote:
> > > > > > Thanks Dave,
> > > > > >
> > > > > > I switched to the i915 kernel driver and still got the OOPS.
> > > > > > I also continue to get the overlapping mtrr message.  I am currently
> > > > > > testing 2.6.13-rc2-git3.  I have tried to run strace with hald, but
> > > > > > cannot reproduce the problem this way.  I am not sure I am invoking the
> > > > > > command corrently.  I have written to the hal developers, but have not
> > > > > > received a response yet.  Here's the current output:
> > > > > >
> > > > > 
> > > > > Can you try and see if you apply the patch from
> > > > > 
> > > > > http://lkml.org/lkml/2005/7/8/257
> > > > > 
> > > > > It should apply to your kernel.. I cannot get this to happen on my
> > > > > system... the mtrr overlaps are just vesafb setting up the mtrrs, you
> > > > > might try without vesafb...
> > > > 
> > > > I will try booting without vesafb enabled.
> > > > 
> > > > I get an error building with the patch applied to 2.6.13-rc2-git3:
> > > > 
> > > > arch/i386/kernel/built-in.o(.text+0x4010): In function `die':
> > > > arch/i386/kernel/traps.c:343: undefined reference to `last_sysfs_name'
> > > > make: *** [.tmp_vmlinux1] Error 1
> > > 
> > > Miles,
> > > Here is an updated version of the patch that builds for me.
> > > (uses last_sysfs_file instead of last_sysfs_name)
> > 
> > I think I was able to reproduce this same bug on 2.6.13-rc4-mm1,
> > here's the output (w/ apologies for long lines):
> > 
> > Unable to handle kernel paging request at virtual address 762f7473
> >  printing eip:
> > c01a8bcc
> > *pde = 00000000
> > Oops: 0002 [#1]
> > PREEMPT SMP DEBUG_PAGEALLOC
> > last sysfs file: /class/vc/vcs5/dev
> 
> gotcha.
> 
> > Modules linked in: cpufreq_userspace cpufreq_stats freq_table cpufreq_powersave 
> > cpufreq_ondemand cpufreq_conservative ipv6 video thermal processor hotkey fan co
> > ntainer button battery ac nfs lockd sunrpc af_packet tg3 ohci_hcd usbcore generi
> > c serverworks i2c_piix4 i2c_core sworks_agp agpgart pcspkr rtc floppy tsdev dm_m
> > od parport_pc lp parport ide_generic ide_disk ide_cd cdrom ide_core unix
> > CPU:    0
> > EIP:    0060:[<c01a8bcc>]    Not tainted VLI
> > EFLAGS: 00010246   (2.6.13-rc4-mm1) 
> > EIP is at sysfs_release+0x4c/0xb0
> > eax: 762f7373   ebx: 762f7373   ecx: 00000001   edx: ef3c5000
> > esi: f596a188   edi: f21fecc0   ebp: ef3c5f3c   esp: ef3c5f2c
> > ds: 007b   es: 007b   ss: 0068
> > Process udev (pid: 11843, threadinfo=ef3c5000 task=ef78e550)
> > Stack: f596a188 00000010 f762d580 c21bc944 ef3c5f68 c0166cea c21bc944 f762d580 
> >        00000000 00000000 c2137980 ec7e9748 f762d580 dcae7300 00000000 ef3c5f78 
> >        c0166aeb f762d580 f762d580 ef3c5f94 c01650ab f762d580 dcae7300 dcae7300 
> > Call Trace:
> >  [<c010401f>] show_stack+0x7f/0xa0
> >  [<c01041d4>] show_registers+0x164/0x1d0
> >  [<c0104422>] die+0x122/0x1c0
> >  [<c030db1e>] do_page_fault+0x2ce/0x600
> >  [<c0103ccb>] error_code+0x4f/0x54
> >  [<c0166cea>] __fput+0x1da/0x1f0
> >  [<c0166aeb>] fput+0x2b/0x50
> >  [<c01650ab>] filp_close+0x4b/0x80
> >  [<c016514e>] sys_close+0x6e/0x90
> >  [<c010312f>] sysenter_past_esp+0x54/0x75
> > Code: 85 f6 8b 40 14 8b 58 04 74 08 89 34 24 e8 0d 97 04 00 85 db 74 38 b8 01 00
> >  00 00 e8 af 18 f7 ff e8 4a e5 04 00 c1 e0 07 8d 04 18 <ff> 88 00 01 00 00 83 3b
> >  02 74 49 b8 01 00 00 00 e8 cf 18 f7 ff 
> >  <6>note: udev[11843] exited with preempt_count 1
> > Using generic hotkey driver
> > ibm_acpi: acpi_evalf(DHKC, d, ...) failed: 4097
> > ibm_acpi: `enable,0xffff' invalid for parameter `hotkey'
> > toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
> > apm: BIOS not found.
> > 
> > Let me see if I can reproduce this on either 2.6.13-rc4 or  2.6.13-rc6 
> > 
> > Machine is an IBM x335 (dual P4), and I'm not using any framebuffer
> > stuff. 
> > 
> 
> Keith, does this look like the use-after-free which you've been hitting?

So, I've tried reproducing on 2.6.13-rc6, 2.6.13-rc5-mm1, and (the
original kernel where I hit this) 2.6.13-rc4-mm1 

I haven't been able to reproduce at all, unfortunately... 
As Keith noted before, this one is pretty elusive.  I'm still up for
trying patches and rebooting a million times if someone has an idea.

Sonny
