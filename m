Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTHZSb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbTHZSb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:31:26 -0400
Received: from fmr09.intel.com ([192.52.57.35]:29386 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262150AbTHZSbW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:31:22 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH][2.6][2/5]Support for HPET based timer
Date: Tue, 26 Aug 2003 11:31:16 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1F8@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6][2/5]Support for HPET based timer
Thread-Index: AcNnCHCu9ngPWo70Q2ORc/h2Z0t5xgAMjVFQAHEKhPA=
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>, "Andi Kleen" <ak@suse.de>,
       <haveblue@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>,
       <mikpe@csd.uu.se>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Aug 2003 18:31:16.0697 (UTC) FILETIME=[3C7A8C90:01C36C00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

  This is an update on the option of using some sort of early_ioremap in
place of fixmap for 
HPET timers.

Problem Description:
  The requirement from HPET side is, we need to map HPET physical
address during timer_init() 
routine and also during any read/write HPET addresses. We need to have
this mapping kind of
permanently, as  we will do HPET reads/writes during every timer
interrupt and also during 
every gettimeofday (if we don't use tsc timer).
  And the timer_init() happens before mem_init() (but after paging
init()), so we cannot 
directly use ioremap(). Current implementation is using a separate
fixmap region for HPET.
 
Possible alternatives:
1) boot_ioremap - This looks like a temporary and very short time use
mapping. We may not be 
able to use it forever, for HPET purposes, as someone else can do the
mapping and overwrite 
HPET mapping anytime. Will need significant changes to supports multiple
users doing 
mapping/unmapping.
2) bt_ioremap - Even this seems to be aiming at temporary mapping.
Currently, this supports 
only one user at any time. This can be changed to support multiple users
and map and unmap 
depending on the address. But, bt_ioremap uses fixmap in its
implementation, and the fixmap 
is boot time only. So, we need to transparently switch to ioremap, at
some place before 
all inits are done.

Even after changing either boot_ioremap() or bt_ioremap(), we have to
add some more 
hooks to move from early ioremap to regular io_remap() after mem_init()
is done. And HPET 
addresses can get accessed from both process and interrupt context, may
make things slightly
more difficult. Still it is doable as we can move to regular ioremap
before smp_init(), without 
much of a race condition. So, possible changes in this scenario will be:
- Add support for multiple callers using different pages in
bt_ioremap(or  boot_ioremap).
- Add HPET specific hook, somewhere in between mem_init() and
smp_init(), to transparently
move from bt_ioremap to ioremap().

The question I have is,
- Is it really worth to move from the current fixmap implementation to
bt_ioremap/ioremap 
combination, given all the changes that is required?
- Isn't current implementation (using own fixmap) a cleaner way to do
it? Only drawback 
I see is it consumes one page in virtual memory when HPET is configured,
irrespective of 
HPET is used at run time or not.

Let me know your thoughts on this, and correct me if I am missing
anything here.

Thanks,
-Venkatesh


> -----Original Message-----
> From: Pallipadi, Venkatesh 
> Sent: Wednesday, August 20, 2003 10:02 AM
> To: Mikael Pettersson; Andi Kleen
> Cc: Vojtech Pavlik; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH][2.6][2/5]Support for HPET based timer
> 
> 
> 
> Yes. I hadn't thought about early_ioremap option. There seems to be
> multiple ways of doing early ioremap: bt_ioremap() and 
> boot_ioremap(). I
> will look at them closer and work on changing HPET code to use one of
> these in place of fixmap.
> 
> Thanks,
> -Venkatesh  
> 
> > -----Original Message-----
> > From: Mikael Pettersson [mailto:mikpe@csd.uu.se] 
> > Sent: Wednesday, August 20, 2003 3:47 AM
> > To: Andi Kleen
> > Cc: Vojtech Pavlik; linux-kernel@vger.kernel.org; 
> Pallipadi, Venkatesh
> > Subject: Re: [PATCH][2.6][2/5]Support for HPET based timer
> > 
> > 
> > Andi Kleen writes:
> >  > Vojtech Pavlik <vojtech@suse.cz> writes:
> >  > 
> >  > > On Tue, Aug 19, 2003 at 05:18:50PM -0700, Pallipadi, 
> > Venkatesh wrote:
> >  > > 
> >  > > > Fixmap is for HPET memory map address access. As the timer
> >  > > > initialization happen 
> >  > > > early in the boot sequence (before vm initialization), 
> > we need to have
> >  > > > fixmap() 
> >  > > > and fix_to_virt() to access HPET memory map address.
> >  > > 
> >  > > Ahh, yes, you're right. You can't use ioremap at that 
> > time. Actually I
> >  > > did the same on x86_64 not only because of vsyscalls.
> >  > 
> >  > iirc i386 has an ioremap_early or somesuch.
> > 
> > bt_ioremap(). I wrote it to support early DMI scan so DMI data
> > could be used to blacklist BIOSen that break local APICs.
> > This was done pretty much just to handle Dell laptops.
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
