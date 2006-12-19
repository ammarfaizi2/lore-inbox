Return-Path: <linux-kernel-owner+w=401wt.eu-S932683AbWLSIrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbWLSIrx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWLSIrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:47:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49423 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932683AbWLSIrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:47:52 -0500
Subject: Re: [patch 1/2] agpgart - allow user-populated memory types.
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas@tungstengraphics.com>
Cc: Dave Jones <davej@redhat.com>, Dave Airlie <airlied@linux.ie>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1095.213.114.71.166.1165619148.squirrel@www.shipmail.org>
References: <4579ADE3.6040609@tungstengraphics.com>
	 <1165616236.27217.108.camel@laptopd505.fenrus.org>
	 <1095.213.114.71.166.1165619148.squirrel@www.shipmail.org>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Tue, 19 Dec 2006 09:47:44 +0100
Message-Id: <1166518064.3365.1188.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-09 at 00:05 +0100, Thomas Hellström wrote:
> > On Fri, 2006-12-08 at 19:24 +0100, Thomas HellstrÃ¶m wrote:
> >>
> >> +       }
> >> +
> >> +       if (alloc_size <= PAGE_SIZE) {
> >> +               new->memory = kmalloc(alloc_size, GFP_KERNEL);
> >> +       }
> >> +       if (new->memory == NULL) {
> >> +               new->memory = vmalloc(alloc_size);
> >
> > this bit is more or less evil as well...
> >
> > 1) vmalloc is expensive all the way, higher tlb use etc etc
> > 2) mixing allocation types is just a recipe for disaster
> > 3) if this isn't a frequent operation, kmalloc is fine upto at least 2
> > pages; I doubt you'll ever want more
> 
> I understand your feelings about this, and as you probably understand, the
> kfree / vfree thingy is a result of the above allocation scheme.

the kfree/vfree thing at MINIMUM should be changed though. Even if you
need both kfree and vfree, you should key it off of a flag that you
store, not off the address of the memory, that's just unportable and
highly fragile. You *know* which allocator you used, so store it and use
THAT info.



> The allocated memory holds an array of struct page pointers. The number of
> struct page pointers will range from 1 to about 8192, so the alloc size
> will range from 4bytes to 64K, but could go higher depending on
> architecture.

hmm 64Kb is a bit much indeed. You can't do an array of upto 16 entries
with one page in each array entry? 

>  I figured that kmalloc could fail, and, according to "linux
> device drivers" (IIRC), vmalloc is faster when allocation size exceeds 1
> page.

that is just plain incorrect. Vmalloc is really really slow, both in
allocating and in use. During use you trash the 4Kb tlbs all the time
for example, and that's just cost that accumulates.

> So we can't use only vmalloc, and we can't fail so we can't use only
> kmalloc. I'm open to suggestions on how to improve this.

cleanest is probably the array of pages thing. to index it then you
first calculate which entry to use (that's half a cycle since it's a
power of 2) and then you index inside that page... that's going to be
faster than the tlb miss no doubt.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

