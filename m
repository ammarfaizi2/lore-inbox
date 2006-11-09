Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423984AbWKIBHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423984AbWKIBHR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423982AbWKIBHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:07:16 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:61855 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1423980AbWKIBHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:07:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm1
Date: Thu, 9 Nov 2006 02:04:44 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20061108015452.a2bb40d2.akpm@osdl.org> <200611090144.53887.rjw@sisk.pl> <20061108165540.0d3c4340.akpm@osdl.org>
In-Reply-To: <20061108165540.0d3c4340.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611090204.45299.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 9 November 2006 01:55, Andrew Morton wrote:
> On Thu, 9 Nov 2006 01:44:53 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Thursday, 9 November 2006 01:17, Andrew Morton wrote:
> > > On Thu, 9 Nov 2006 00:31:34 +0100
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > On Wednesday, 8 November 2006 10:54, Andrew Morton wrote:
> > > > > 
> > > > > Temporarily at
> > > > > 
> > > > > http://userweb.kernel.org/~akpm/2.6.19-rc5-mm1/
> > > > > 
> > > > > will turn up at
> > > > > 
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm1/
> > > > > 
> > > > > when kernel.org mirroring catches up.
> > > > > 
> > > > > 
> > > > > 
> > > > > - Merged the Kernel-based Virtual Machine patches.  See kvm.sf.net for
> > > > >   userspace tools, instructions, etc.
> > > > > 
> > > > >   It needs a recent binutils to build.
> > > > > 
> > > > > - The hrtimer+dynticks code still doesn't work right for machines which halt
> > > > >   their TSC in low-power states.
> > > > 
> > > > On my HPC nx6325 it doesn't even reach the point in which the messages become
> > > > visible on the console, so I'm unable to get any debug info from it.
> > > 
> > > Nice.  You're using earlyprintk?
> > 
> > earlyprintk=vga doesn't show anything (ie. blank screen), so it seems to crash
> > really early.
> 
> OK, so it's definitely bisection time.

Well, I've got some data from earlyprintk (forgot I needed to boot with
vga=normal).

Unfortunately, I had to rewrite the trace manually:

clear_IO_APIC_pin+0x15/0x6a
try_apic_pin+0x7a/0x98
setup_IO_APIC+0x600/0xb7a
smp_prepare_cpus+0x33a/0x371
init+0x60/0x32d
child_rip+0xa/0x12

[And then the unwinder said it got stuck.]

RIP is reported to be at ioapic_read_entry+0x33/0x61, which according to gdb
is:

0xffffffff80271418 is in ioapic_read_entry (include/asm/io.h:204).
199
200     #define mmiowb()
201
202     static inline void __writel(__u32 b, volatile void __iomem *addr)
203     {
204             *(__force volatile __u32 *)addr = b;
205     }
206     static inline void __writeq(__u64 b, volatile void __iomem *addr)
207     {
208             *(__force volatile __u64 *)addr = b;

> > I'm unable to reproduce the problem on a non-SMP box (Asus L5D), which works
> > just fine with this kernel,

Well, it's booted with 'noapic', so no wonder ...

> > but on the other SMP box the framebuffer is broken 
> > (displays all fonts inverted, as in a mirror)
> 
> Which fbdev driver?  (suspect fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit.patch)

vga=792

> > and the kernel says it cannot mount the root fs (which is on an md-raid).
> 
> hm, there was probably some earlier message which tells us why that
> happened.  Doing a capure-and-compare on the dmesg output would be nice
> (netconsole?)

Tomorrow I'll try a serial one, but now I must get some sleep (I can hardly
see anything).
