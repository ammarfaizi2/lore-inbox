Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758543AbWLAOvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758543AbWLAOvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758851AbWLAOvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:51:15 -0500
Received: from mail.parknet.jp ([210.171.160.80]:8460 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1758543AbWLAOvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:51:14 -0500
X-AuthUser: hirofumi@parknet.jp
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [patch 3/3] fs: fix cont vs deadlock patches
References: <20061130072058.GA18004@wotan.suse.de>
	<20061130072202.GB18004@wotan.suse.de>
	<20061130072247.GC18004@wotan.suse.de>
	<20061130113241.GC12579@wotan.suse.de>
	<87r6vkzinv.fsf@duaron.myhome.or.jp>
	<20061201020910.GC455@wotan.suse.de>
	<87mz68xoyi.fsf@duaron.myhome.or.jp>
	<20061201050852.GA31347@wotan.suse.de>
	<20061130232102.0cc7fc0b.akpm@osdl.org>
	<20061201075341.GB31347@wotan.suse.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 01 Dec 2006 23:50:49 +0900
In-Reply-To: <20061201075341.GB31347@wotan.suse.de> (Nick Piggin's message of "Fri\, 1 Dec 2006 08\:53\:41 +0100")
Message-ID: <87slfzu0ty.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> writes:

>> >  		status = __block_prepare_write(inode, new_page, zerofrom,
>> >  						PAGE_CACHE_SIZE, get_block);
>> >  		if (status)
>> > @@ -2110,7 +2111,7 @@
>> >  		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
>> >  		flush_dcache_page(new_page);
>> >  		kunmap_atomic(kaddr, KM_USER0);
>> > -		generic_commit_write(NULL, new_page, zerofrom, PAGE_CACHE_SIZE);
>> > +		__block_commit_write(inode, new_page, zerofrom, PAGE_CACHE_SIZE);
>> 
>> Whatever function this is doesn't need to update i_size?
>
> Yes, it is the code in cont_prepare_write that is expanding a hole
> at the end of file.
>
> We can do this now because fat_commit_write is now changed to call
> generic_commit_write in the case of a non-zero length.
>
> I think it is an improvement because now the file will not get
> arbitrarily extended in the case of a write failure somewhere down
> the track.

Ah, unfortunately we can't this. If we don't update ->i_size before
page_cache_release, pdflush will think these pages is outside ->i_size
and just clean the page without writing it.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
