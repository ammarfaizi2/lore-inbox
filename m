Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWHVAqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWHVAqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWHVAqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:46:52 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:30636 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1750986AbWHVAqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:46:51 -0400
Subject: Re: [Fastboot] [PATCH][RFC] x86_64: Reload CS when startup_64 is
	used.
From: Magnus Damm <magnus@valinux.co.jp>
To: Andi Kleen <ak@suse.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ebiederm@xmission.com
In-Reply-To: <200608211616.50387.ak@suse.de>
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
	 <200608211219.09042.ak@suse.de>
	 <aec7e5c30608210629r4f2cf5dlfb1ad7d6cc95745d@mail.gmail.com>
	 <200608211616.50387.ak@suse.de>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 09:47:08 +0900
Message-Id: <1156207628.21411.78.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 16:16 +0200, Andi Kleen wrote:
> On Monday 21 August 2006 15:29, Magnus Damm wrote:
> > On 8/21/06, Andi Kleen <ak@suse.de> wrote:
> > >
> > > >
> > > > +     /* Reload CS with a value that is within our GDT. We need to do this
> > > > +      * if we were loaded by a 64 bit bootloader that happened to use a
> > > > +      * CS that is larger than the GDT limit. This is true if we came here
> > > > +      * from kexec running under Xen.
> > > > +      */
> > > > +     movq    %rsp, %rdx
> > > > +     movq    $__KERNEL_DS, %rax
> > > > +     pushq   %rax /* SS */
> > > > +     pushq   %rdx /* RSP */
> > > > +     movq    $__KERNEL_CS, %rax
> > > > +     movq    $cs_reloaded, %rdx
> > > > +     pushq   %rax /* CS */
> > > > +     pushq   %rdx /* RIP */
> > > > +     lretq
> > >
> > > Can't you just use a normal far jump? That might be simpler.
> > 
> > I couldn't find a far jump that took a 64-bit address to jump to. But
> > I guess that the kernel will be loaded in the lowest 4G regardless so
> > I guess 32-bit pointers are ok, right? That will make it simpler for
> > sure.
> 
> Yes, that code always runs in the identity mapping and at 2MB.
> 
> > 
> > What do you think about reloading CS? Is it the right thing to do, or
> > is it correct as it is today where we depend on that CS == _KERNEL_CS?
> > I need to fix kexec-tools regardless, but maybe it is a good idea to
> > make the 64-bit kernel boot a bit robust too.
> 
> Reloading CS is ok, although longer term I plan to switch the kernel
> to uncompress already in 64bit. Then you would need the same GDT anyways.

I think reloading CS is the right thing to do. IMO it is not sane to
depend on that the 64-bit boot loader sets up CS to 0x18 for us.

Having a dependency like that (unless there is a good reason and it is
documented somehow) is good to avoid, regardless of 64-bit uncompress or
not. I mean, if you plan on making the bzImage code 64-bit then it needs
to reload CS too, right?

Thanks,

/ magnus

