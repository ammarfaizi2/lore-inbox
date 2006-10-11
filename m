Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWJKNoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWJKNoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWJKNoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:44:09 -0400
Received: from sandeen.net ([209.173.210.139]:63587 "EHLO sandeen.net")
	by vger.kernel.org with ESMTP id S1750925AbWJKNoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:44:05 -0400
Message-ID: <452CF523.5090708@sandeen.net>
Date: Wed, 11 Oct 2006 08:44:03 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: Badari Pulavarty <pbadari@us.ibm.com>, Eric Sandeen <esandeen@redhat.com>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
References: <20061003052219.GA15563@redhat.com> <4521F865.6060400@sandeen.net> <20061002231945.f2711f99.akpm@osdl.org> <452AA716.7060701@sandeen.net> <1160431165.17103.21.camel@dyn9047017100.beaverton.ibm.com> <20061009225036.GC26728@redhat.com> <20061010141145.GM23622@atrey.karlin.mff.cuni.cz> <452C18A6.3070607@redhat.com> <1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com> <452C4C47.2000107@sandeen.net> <20061011103325.GC6865@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20061011103325.GC6865@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara wrote:

>   Umm, but these two traces confuse me:
> 1) They are different traces that those you wrote about initially,
> aren't they? Because here we would not call sync_dirty_buffer() from
> journal_dirty_data().
>   BTW: Does this buffer trace lead to that Oops in submit_bh()? I guess not
> as the buffer is not dirty...

They do wind up at the same oops, from the same "testcase" (i.e. beat the tar 
out of the filesystem with multiple fsx's and fsstress...)

The buffer is not dirty at that tracepoint because it has just done
                 if (locked && test_clear_buffer_dirty(bh)) {
prior to the tracepoint...

>   Am I right that now there are no Oopses because of buffers submitted
> from the commit code? Only those from journal_dirty_data()?

Well, it's hard to sort out which thread is doing what; I added a pid to each 
tracepoint to try to make that a little easier.  Both of the traces I posted 
seem to be journal_submit_data_buffers leading to an unmapped buffer submitted 
in submit_bh.

> 2) Those buffers have strange states - they are !mapped, !dirty (so this
> is fine) 

Well, they were just undirtied in journal_submit_data_buffers.

See the whole traces at

http://people.redhat.com/esandeen/traces/eric_ext3_oops1.txt
http://people.redhat.com/esandeen/traces/eric_ext3_oops2.txt

I will try to reproduce with fewer threads, to see if we can find a simpler 
sequence of events...

As an aside, when we do journal_unmap_buffer... should it stay on t_sync_datalist?

Thanks,
-Eric

> but they are also JBD_Dirty and ion BJ_SyncData. This is really
> strange! Either it is ordered data buffer and should not be JBD_Dirty or
> it is not ordered data buffer and then it should not be in BJ_SyncData!
> The second buffer even has JBD_JWrite set so it really was metadabuffer
> under commit and later something took it from the committing transaction
> (without clearing the JWrite bit) and filed it in the SyncData list...
> Umm, this reminds me something... <looks into commit code> Oh no, who could
> write that BJ_Forget list handling.. me? ;)
> 
> I think the problem is in my change to BJ_Forget list handling - if we
> find out buffer has b_next_transaction set, we just refile it
> (previously we BUGged). That it just fine, except when we are in the
> ordered mode and the buffer is reallocated as data. Then we refile the
> buffer to BJ_Metadata or BJ_Reserved list, instead of BJ_SyncData.  What
> then happens is uncertain but probably something gets (rightfully so)
> confused and JBD_Dirty buffer gets to BJ_SyncData list.  This bug does
> not seem to cause those problems with unmapped buffers but still we
> should fix it as it is asking for trouble.
> 
> 								Honza

