Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932999AbWJITrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932999AbWJITrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933012AbWJITrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:47:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54937 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932999AbWJITrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:47:11 -0400
Message-ID: <452AA716.7060701@sandeen.net>
Date: Mon, 09 Oct 2006 14:46:30 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       esandeen@redhat.com, Badari Pulavarty <pbadari@us.ibm.com>,
       Jan Kara <jack@ucw.cz>
Subject: Re: 2.6.18 ext3 panic.
References: <20061002194711.GA1815@redhat.com>	<20061003052219.GA15563@redhat.com>	<4521F865.6060400@sandeen.net> <20061002231945.f2711f99.akpm@osdl.org>
In-Reply-To: <20061002231945.f2711f99.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 03 Oct 2006 00:43:01 -0500
> Eric Sandeen <sandeen@sandeen.net> wrote:
> 
>> Dave Jones wrote:
>>
>>> So I managed to reproduce it with an 'fsx foo' and a
>>> 'fsstress -d . -r -n 100000 -p 20 -r'. This time I grabbed it from
>>> a vanilla 2.6.18 with none of the Fedora patches..
>>>
>>> I'll give 2.6.18-git a try next.
>>>
>>> 		Dave
>>>
>>> ----------- [cut here ] --------- [please bite here ] ---------
>>> Kernel BUG at fs/buffer.c:2791
>> I had thought/hoped that this was fixed by Jan's patch at 
>> http://lkml.org/lkml/2006/9/7/236 from the thread started at 
>> http://lkml.org/lkml/2006/9/1/149, but it seems maybe not.  Dave hit this bug 
>> first by going through that new codepath....
> 
> Yes, Jan's patch is supposed to fix that !buffer_mapped() assertion.  iirc,
> Badari was hitting that BUG and was able to confirm that Jan's patch
> (3998b9301d3d55be8373add22b6bc5e11c1d9b71 in post-2.6.18 mainline) fixed
> it.

Looking at some BH traces*, it appears that what Dave hit is a truncate
racing with a sync...

truncate ...
  ext3_invalidate_page
    journal_invalidatepage
      journal_unmap buffer

going off at the same time as

sync ...
  journal_dirty_data
    sync_dirty_buffer
      submit_bh <-- finds unmapped buffer, boom.

I'm not sure what should be coordinating this, and I'm not sure why
we've not yet seen it on a stock kernel, but only FC6... I haven't found
anything in FC6 that looks like it may affect this.

-Eric

*http://people.redhat.com/esandeen/traces/davej_ext3_oops1.txt
