Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030492AbWJJWDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030492AbWJJWDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbWJJWDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:03:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52430 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030492AbWJJWDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:03:30 -0400
Message-ID: <452C18A6.3070607@redhat.com>
Date: Tue, 10 Oct 2006 17:03:18 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: Dave Jones <davej@redhat.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Eric Sandeen <sandeen@sandeen.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
References: <20061002194711.GA1815@redhat.com> <20061003052219.GA15563@redhat.com> <4521F865.6060400@sandeen.net> <20061002231945.f2711f99.akpm@osdl.org> <452AA716.7060701@sandeen.net> <1160431165.17103.21.camel@dyn9047017100.beaverton.ibm.com> <20061009225036.GC26728@redhat.com> <20061010141145.GM23622@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20061010141145.GM23622@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara wrote:

>   I think it's really the 1KB block size that makes it happen.
> I've looked at journal_dirty_data() code and I think the following can
> happen:
>   sync() eventually ends up in journal_dirty_data(bh) as Eric writes.
> There is finds dirty buffer attached to the comitting transaction. So it drops
> all locks and calls sync_dirty_buffer(bh).
>   Now in other process, file is truncated so that 'bh' gets just after EOF.
> As we have 1kb buffers, it can happen that bh is in the partially
> truncated page. Buffer is marked unmapped and clean. But in a moment the page
> is marked dirty and msync() is called. That eventually calls
> set_page_dirty() and all buffers in the page are marked dirty.
>   The first process now wakes up, locks the buffer, clears the dirty bit
> and does submit_bh() - Oops.

Hm, just FWIW I have a couple traces* of the buffer getting unmapped
-before- journal_submit_data_buffers ever even finds it...

 journal_submit_data_buffers():[fs/jbd/commit.c:242] needs writeout,
adding to array pid 1836
     b_state:0x114025 b_jlist:BJ_SyncData cpu:0 b_count:2 b_blocknr:27130
     b_jbd:1 b_frozen_data:0000000000000000
b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0
b_trans_is_running:0
     b_trans_is_comitting:1 b_jcount:0 pg_dirty:0

so it's already unmapped at this point.  Could
journal_submit_data_buffers benefit from some buffer_mapped checks?  Or
is that just a bandaid too late...

-Eric

*http://people.redhat.com/esandeen/traces/eric_ext3_oops1.txt
 http://people.redhat.com/esandeen/traces/eric_ext3_oops2.txt
