Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWCOBsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWCOBsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWCOBsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:48:32 -0500
Received: from fmr19.intel.com ([134.134.136.18]:32746 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932581AbWCOBsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:48:20 -0500
Subject: Re: [PATCH] kexec for ia64
From: Zou Nan hai <nanhai.zou@intel.com>
To: Khalid Aziz <khalid_aziz@hp.com>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Linux ia64 <linux-ia64@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <1142352485.18421.11.camel@lyra.fc.hp.com>
References: <1142271576.10787.15.camel@lyra.fc.hp.com>
	 <1142318909.2545.4.camel@linux-znh>
	 <1142352485.18421.11.camel@lyra.fc.hp.com>
Content-Type: text/plain
Organization: 
Message-Id: <1142381233.2684.19.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 Mar 2006 08:07:13 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 00:08, Khalid Aziz wrote:
> On Tue, 2006-03-14 at 14:48 +0800, Zou Nan hai wrote:
> > 3. Is the set ar.k0 code necessary? ar.k0 is already holding the right
> > value.
> 
> Purely defensive coding to ensure new kernel does not fall on its
> face :)
> 
  I am afraid purely defensive code should go through efi memory map and
find out the ar.k0. This can be done in purgatory code, In my current
pugatory implement, ar.k0 is take from the previous kernel, but I can
modify it to pick the value from efi memmap if this is really a concern.
	
> > 
> > 4. Is the VHPT disable code necessary? kernel will soon goes into
> > Physical mode and the new kernel will reset VHPT walker.
> 
> Again, playing it safe. We do not want VHPT walker waking up at this
> point. Instead of assuming code will not do anything that could cause
> VHPT walker to wake up, it is better to just disable it. This way, if
> any code makes erroneous references to a virtual address which causes
> VHPT walker to make a TLB entry, it will simply get a page fault and we
> can catch that. It is much harder to debug if VHPT walker silently makes
> a TLB entry for an unexpected virtual address reference and then things
> go wrong further down the line.
> 
  But we are running in physical mode, how could VHPT walker be
invoked?	
> > 
> > 5. Is the PCI disable code too complex?
> 
> I have simplified it as much as I can. Suggestions to simplify further
> would be appreciated.
> > 
   I am afraid the irq and device disable code in machine_shutdown in
your patch will never be called because kernel has already iterate on
each device and called the driver->shutdown method for them, and I don't
think we need to set affinity and power state here.

   Please take a look at my patch, machine_shutdown is empty except CPU
down code. There is another function device_shootdown used at the time
of crashing.
> > The overall concern is I am afraid the code is too much than
> > necessary. 
> > 
> 
> After testing this kexec code for over 10,000 iterations of kexec'ing, I
> have found not shutting devices down results in many corner cases that
> have been fairly hard to debug. Adding all this code to shut down as
> much of the hardware as possible has resulted in much more reliable
> kexec code.
  I have also tested tens of thousands round of kexec to kexec over my
patch, I have never seem device shutdown issue.
  
  I still prefer small and clean kernel patch than put too much
redundant code in kernel.

  Thanks.
Zou Nan hai

