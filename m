Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265152AbUHCHwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUHCHwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 03:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUHCHwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 03:52:38 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:34965 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S265152AbUHCHwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 03:52:32 -0400
Message-ID: <410F443A.7050707@tungstengraphics.com>
Date: Tue, 03 Aug 2004 08:52:26 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Romanick <idr@us.ibm.com>
Cc: Dave Jones <davej@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
Subject: Re: DRM code reorganization
References: <20040802155312.56128.qmail@web14923.mail.yahoo.com> <410E81C3.2070804@us.ibm.com> <20040802185746.GA12724@redhat.com> <410E9FEE.60108@us.ibm.com> <20040802204553.GC12724@redhat.com> <410ED3F7.7090809@us.ibm.com>
In-Reply-To: <410ED3F7.7090809@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Romanick wrote:

> I think this is the right place to start.  A couple of these look easier 
> to get rid of than others.  __HAVE_MTRR and __HAVE_AGP are enabled in 
> every driver except ffb.  It should be easy enough to get rid of them. 
> It looks like __HAVE_RELEASE, __HAVE_DMA_READY, __HAVE_DMA_FLUSH, 
> __HAVE_DMA_QUIESCENT, and __HAVE_MULTIPLE_DMA_QUEUES (which looks broken 
> anyway) should also be low-hanging fruit.

We've actually managed to do a fair bit of cleanup already - if you look at 
the gamma driver, there's a lot of stuff in there which used to be shared but 
ifdef'ed out between all the drivers.  The __HAVE_MULTIPLE_DMA_QUEUES macro is 
a remnant of this, but I think you'll break gamma when you try & remove it.

It used to be the case that 50% of the #if hoo-hah was just to try & keep the 
gamma driver working.  I don't know how true this is anymore, though.

> If we get that far, I think the next step would be to replace the 
> DRIVER_* macros with a table of function pointers that would get passed 
> around.  Since I doubt any of those uses are performance critical, that 
> should be fine.
> 
> Then we can start looking at data structure refactoring.
> 
>>  > >If this kind of abuse wasn't so widespread, abstracting this code
>>  > >out into shared sections and driver specific parts would be a lot
>>  > >simpler. Sadly, this is the tip of the iceberg.
>>  >  > I think it comes down to the fact that the original DRM 
>> developers  > wanted templates.  C doesn't have them, so they did the 
>> "next best" thing.
>>
>> I vaguelly recall the code at one point not looking quite 'so bad',
>> it just grew and grew into this monster.  I'm sure it was done originally
>> with the best of intentions, but it seems someone along the line got
>> a bit carried away.
> 
> 
> There was a point when a *lot* of the device-dependent code was still in 
> the OS-dependent directories.  This is how the i810 and i830 drivers 
> still are.  I think as more of the code got moved into the 
> OS-independent directory, it got less pleasant to read.

Not a great deal changed as drivers got moved to shared/ -- things like 
copy_from_user() got replaced by DRM_COPY_FROM_USER(), etc, but that's about 
as far as it went.  The template abstractions haven't really changed a great 
deal with the introduction of freebsd support.  If anything, code has been 
simplified by moving the gamma-specific code out of the shared templates and 
into gamma_* files.

Keith


