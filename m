Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbUAAUZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264870AbUAAUWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:22:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:61092 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264981AbUAAUUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:20:14 -0500
Date: Thu, 1 Jan 2004 12:19:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
cc: Arjan van de Ven <arjanv@redhat.com>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Dri-devel] 2.6 kernel change in nopage
In-Reply-To: <1072967278.1603.270.camel@thor.asgaard.local>
Message-ID: <Pine.LNX.4.58.0401011205110.2065@home.osdl.org>
References: <20031231182148.26486.qmail@web14918.mail.yahoo.com> 
 <1072958618.1603.236.camel@thor.asgaard.local>  <1072959055.5717.1.camel@laptop.fenrus.com>
  <1072959820.1600.252.camel@thor.asgaard.local>  <20040101122851.GA13671@devserv.devel.redhat.com>
 <1072967278.1603.270.camel@thor.asgaard.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jan 2004, Michel Dänzer wrote:
>
> > well the advantage is that the ifdefs can just go away in kernel trees of
> > specific versions... (eg unifdef it)
> 
> Does this look better? Maybe a macro (or a typedef?) for the type of the
> last argument would still be a good idea? Or is there yet a better way?

My preference is either:

 - we can still undo the "nopage" argument change. It's been in the -mm 
   tree for a long time, and it _does_ solve a problem (page fault type 
   accounting), but the problem it solves is potentially so small that we
   might decide it's ok for 2.6.x.

   However, Andrew is king, and besides, it does fix a tiny bug, so I 
   don't think this is what we should do. I just wanted to put it on the 
   table as a possibility.

 - Use separate (and trivial) wrapper functions for this. Keep the "real" 
   function the same across everything, and just have a _static_ function 
   (ie no header file declaration crap) that does

   linux-new-vm.h:

	static int DRM(nopage_interface)(struct vm_area_struct * area, 
					 unsigned long address,
					 int *type)
	{
		*type = VM_FAULT_MINOR;
		DRM(nopage)(area, address);
	}


   linux-old-vm.h:

	static int DRM(nopage_interface)(struct vm_area_struct * area,
					 unsigned long address,   
					 int unused)
	{
		DRM(nopage)(area, address);
	}


   drm_vm.h:

	/*
	 * Or, poreferably, we could create a symlink and avoid
	 * the #if's at compile-time _entirely_.
	 */
	#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
	  #include "linux-new-vm.h"
	#else
	  #include "linux-old-v.h
	#endif

	..
	.nopage = nopage_interface;
	..

Done right, the virtualization could be a bit higher still, and maybe 
the BSD code can do the same thing.

In general, at least I personally _much_ prefer the #ifdef's etc to be 
outside the code. So even if you don't like to have separate small files 
for different architectures/ports/versions, I'd at least personally 
much rather have

	#if xxxx

	int onewholefunction(..)
	...
	

	#else

	int onewholefunction(..)
	...

	#endif

rather than the messy

	int onewholefunction(
	#if xxx
	..
	#else
	..
	#endif
	(
	{
	...
	#if xxxx
	..
	#endif

The latter is a huge pain not just to read (you go blind after a while), 
but it's also painful as _hell_ to merge anywhere else.

In contrast, full-file interfaces for different kernel versions are a 
_lot_ easier to merge and keep track of. They may look like "duplication", 
but the advantages are legion. You don't mix different OS's and different 
versions together, and that makes it much easier to support them all 
without going crazy.

		Linus

