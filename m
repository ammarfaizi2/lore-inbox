Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbWHUORA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbWHUORA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 10:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbWHUORA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 10:17:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:17552 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030496AbWHUOQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 10:16:59 -0400
From: Andi Kleen <ak@suse.de>
To: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [Fastboot] [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
Date: Mon, 21 Aug 2006 16:16:50 +0200
User-Agent: KMail/1.9.3
Cc: "Magnus Damm" <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ebiederm@xmission.com
References: <20060821095328.3132.40575.sendpatchset@cherry.local> <200608211219.09042.ak@suse.de> <aec7e5c30608210629r4f2cf5dlfb1ad7d6cc95745d@mail.gmail.com>
In-Reply-To: <aec7e5c30608210629r4f2cf5dlfb1ad7d6cc95745d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608211616.50387.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 August 2006 15:29, Magnus Damm wrote:
> On 8/21/06, Andi Kleen <ak@suse.de> wrote:
> >
> > >
> > > +     /* Reload CS with a value that is within our GDT. We need to do this
> > > +      * if we were loaded by a 64 bit bootloader that happened to use a
> > > +      * CS that is larger than the GDT limit. This is true if we came here
> > > +      * from kexec running under Xen.
> > > +      */
> > > +     movq    %rsp, %rdx
> > > +     movq    $__KERNEL_DS, %rax
> > > +     pushq   %rax /* SS */
> > > +     pushq   %rdx /* RSP */
> > > +     movq    $__KERNEL_CS, %rax
> > > +     movq    $cs_reloaded, %rdx
> > > +     pushq   %rax /* CS */
> > > +     pushq   %rdx /* RIP */
> > > +     lretq
> >
> > Can't you just use a normal far jump? That might be simpler.
> 
> I couldn't find a far jump that took a 64-bit address to jump to. But
> I guess that the kernel will be loaded in the lowest 4G regardless so
> I guess 32-bit pointers are ok, right? That will make it simpler for
> sure.

Yes, that code always runs in the identity mapping and at 2MB.

> 
> What do you think about reloading CS? Is it the right thing to do, or
> is it correct as it is today where we depend on that CS == _KERNEL_CS?
> I need to fix kexec-tools regardless, but maybe it is a good idea to
> make the 64-bit kernel boot a bit robust too.

Reloading CS is ok, although longer term I plan to switch the kernel
to uncompress already in 64bit. Then you would need the same GDT anyways.

-Andi


