Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWJIV7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWJIV7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 17:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWJIV7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 17:59:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:998 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964910AbWJIV7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 17:59:51 -0400
Subject: Re: 2.6.18 ext3 panic.
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com,
       Jan Kara <jack@ucw.cz>
In-Reply-To: <452AA716.7060701@sandeen.net>
References: <20061002194711.GA1815@redhat.com>
	 <20061003052219.GA15563@redhat.com>	<4521F865.6060400@sandeen.net>
	 <20061002231945.f2711f99.akpm@osdl.org>  <452AA716.7060701@sandeen.net>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 14:59:25 -0700
Message-Id: <1160431165.17103.21.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 14:46 -0500, Eric Sandeen wrote:
> Andrew Morton wrote:
> > On Tue, 03 Oct 2006 00:43:01 -0500
> > Eric Sandeen <sandeen@sandeen.net> wrote:
> > 
> >> Dave Jones wrote:
> >>
> >>> So I managed to reproduce it with an 'fsx foo' and a
> >>> 'fsstress -d . -r -n 100000 -p 20 -r'. This time I grabbed it from
> >>> a vanilla 2.6.18 with none of the Fedora patches..
> >>>
> >>> I'll give 2.6.18-git a try next.
> >>>
> >>> 		Dave
> >>>
> >>> ----------- [cut here ] --------- [please bite here ] ---------
> >>> Kernel BUG at fs/buffer.c:2791
> >> I had thought/hoped that this was fixed by Jan's patch at 
> >> http://lkml.org/lkml/2006/9/7/236 from the thread started at 
> >> http://lkml.org/lkml/2006/9/1/149, but it seems maybe not.  Dave hit this bug 
> >> first by going through that new codepath....
> > 
> > Yes, Jan's patch is supposed to fix that !buffer_mapped() assertion.  iirc,
> > Badari was hitting that BUG and was able to confirm that Jan's patch
> > (3998b9301d3d55be8373add22b6bc5e11c1d9b71 in post-2.6.18 mainline) fixed
> > it.
> 
> Looking at some BH traces*, it appears that what Dave hit is a truncate
> racing with a sync...
> 
> truncate ...
>   ext3_invalidate_page
>     journal_invalidatepage
>       journal_unmap buffer
> 
> going off at the same time as
> 
> sync ...
>   journal_dirty_data
>     sync_dirty_buffer
>       submit_bh <-- finds unmapped buffer, boom.
> 

I don't understand how this can happen ..

journal_unmap_buffer() zapping the buffer since its not attached to any
transaction. 

journal_unmap_buffer():[fs/jbd/transaction.c:1789] not on any
transaction: zap
     b_state:0x10402f b_jlist:BJ_None cpu:0 b_count:3 b_blocknr:52735707
     b_jbd:1 b_frozen_data:0000000000000000
b_committed_data:0000000000000000
     b_transaction:0 b_next_transaction:0 b_cp_transaction:0
b_trans_is_running:0
     b_trans_is_comitting:0 b_jcount:2 pg_dirty:1


journal_dirty_data() would do submit_bh() ONLY if its part of the older
transaction.

I need to take a closer look to understand the race.

BTW, is this 1k or 2k filesystem ? How easy is to reproduce the
problem ?

Thanks,
Badari



