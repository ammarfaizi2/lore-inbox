Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965264AbWJLEeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbWJLEeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 00:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965265AbWJLEeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 00:34:17 -0400
Received: from sccrmhc11.comcast.net ([204.127.200.81]:2517 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S965264AbWJLEeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 00:34:16 -0400
Message-ID: <452DC5C5.3040507@comcast.net>
Date: Wed, 11 Oct 2006 21:34:13 -0700
From: John Wendel <jwendel10@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Eric Sandeen <esandeen@redhat.com>
CC: Badari Pulavarty <pbadari@us.ibm.com>, Jan Kara <jack@suse.cz>,
       Eric Sandeen <sandeen@sandeen.net>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
References: <20061002231945.f2711f99.akpm@osdl.org>	 <452AA716.7060701@sandeen.net>	 <1160431165.17103.21.camel@dyn9047017100.beaverton.ibm.com>	 <20061009225036.GC26728@redhat.com>	 <20061010141145.GM23622@atrey.karlin.mff.cuni.cz>	 <452C18A6.3070607@redhat.com>	 <1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com>	 <452C4C47.2000107@sandeen.net>	 <20061011103325.GC6865@atrey.karlin.mff.cuni.cz>	 <452CF523.5090708@sandeen.net>	 <20061011142205.GB24508@atrey.karlin.mff.cuni.cz> <1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com> <452DAA26.6080200@redhat.com>
In-Reply-To: <452DAA26.6080200@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:
> Badari Pulavarty wrote:
>
>> Here is what I think is happening..
>>
>> journal_unmap_buffer() - cleaned the buffer, since its outside EOF, but
>> its a part of the same page. So it remained on the page->buffers
>> list. (at this time its not part of any transaction).
>>
>> Then, ordererd_commit_write() called journal_dirty_data() and we added
>> all these buffers to BJ_SyncData list. (at this time buffer is clean -
>> not dirty).
>>
>> Now msync() called __set_page_dirty_buffers() and dirtied *all* the
>> buffers attached to this page.
>>
>> journal_submit_data_buffers() got around to this buffer and tried to
>> submit the buffer...
>
> This seems about right, but one thing bothers me in the traces; it 
> seems like there is some locking that is missing.  In
> http://people.redhat.com/esandeen/traces/eric_ext3_oops1.txt
> for example, it looks like journal_dirty_data gets started, but then 
> the buffer_head is acted on by journal_unmap_buffer, which decides 
> this buffer is part of the running transaction, past EOF, and clears 
> mapped, dirty, etc.  Then journal_dirty_data picks up again, decides 
> that the buffer is not on the right list (now BJ_None) and puts it 
> back on BJ_SyncData.  Then it gets picked up by 
> journal_submit_data_buffers and submitted, and oops.
>
> Talking with Stephen, it seemed like the page lock should synchronize 
> these threads, but I've found that we can get to journal_dirty_data 
> acting on the buffer heads w/o having the page locked...
>
> I'm still digging, and, er, grasping at straws here... Am I off base?
>
> -Eric
>
>
>> Andrew is right - only option for us to check the filesize in the
>> write out path and skip the buffers beyond EOF.
>>
>> Thanks,
>> Badari
>>
Here's another data point for your consideration. I've been seeing this 
error since I started running 2.6.18, I assumed it was hardware, so I've 
tried 3 different disks, a PATA and 2 SATA drives, with VIA and Promise 
controllers, the error has occurred on all of them. I see the error 
infrequently, always when downloading lots of small files from Usenet 
and building, copying and deleting large (200 - 300 MB). I haven't ever 
had an oops/panic, just this error.  When I run fsck, I always see a 
single message that "deleted inode nnn has zero dtime". I hope this will 
be useful.

Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5): 
ext3_free_blocks_sb: bit already cleared for block 4740550
Oct 11 20:37:32 Godzilla kernel: Aborting journal on device hda5.
Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in 
ext3_free_blocks_sb: Journal has aborted
Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in 
ext3_free_blocks_sb: Journal has aborted
Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in 
ext3_reserve_inode_write: Journal has aborted
Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in 
ext3_truncate: Journal has aborted
Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in 
ext3_reserve_inode_write: Journal has aborted
Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in 
ext3_orphan_del: Journal has aborted
Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in 
ext3_reserve_inode_write: Journal has aborted
Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in 
ext3_delete_inode: Journal has aborted
Oct 11 20:37:32 Godzilla kernel: __journal_remove_journal_head: freeing 
b_committed_data
Oct 11 20:37:32 Godzilla kernel: __journal_remove_journal_head: freeing 
b_committed_data
Oct 11 20:37:32 Godzilla kernel: ext3_abort called.
Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5): 
ext3_journal_start_sb: Detected aborted journal
Oct 11 20:37:32 Godzilla kernel: Remounting filesystem read-only

