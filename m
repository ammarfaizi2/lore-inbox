Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268997AbRG3QFb>; Mon, 30 Jul 2001 12:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268994AbRG3QFV>; Mon, 30 Jul 2001 12:05:21 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:1299 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S268991AbRG3QFI>; Mon, 30 Jul 2001 12:05:08 -0400
Date: Mon, 30 Jul 2001 12:04:08 -0400
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Hans Reiser <reiser@namesys.com>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>,
        "Gryaznova E." <grev@namesys.botik.ru>,
        "Vladimir V. Saveliev" <monstr@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <305320000.996509048@tiny>
In-Reply-To: <3B65818D.13AA5A1D@zip.com.au>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Tuesday, July 31, 2001 01:47:25 AM +1000 Andrew Morton <akpm@zip.com.au>
wrote:

> Chris Mason wrote:
>> 
>> On Saturday, July 28, 2001 03:28:05 AM +1000 Andrew Morton
>> <akpm@zip.com.au> wrote:
>> 
>> [ patch to trigger data writes before commit in reiserfs ]
>> 
>> > 
>> > There's no disruption to disk format - it just simulates
>> > the user typing `sync' at the right time.  I think the
>> > concept is sound, and I'm sure Chris can find a more efficient
>> > way...
>> 
>> Well, its gets points for simplicity ;-)
> 
> Well, I tried system("/bin/sync"); but that didn't link.
> 
>> What I think we need is for commit_write to put new buffers a per super
>> list of new buffers, and then the journal code can flush that list on
>> commit.
> 
> whee.  Now there's an idea - If the fs keeps track of all its inodes
> then you can traverse those and flush out the i_dirty_buffers ring
> on each one.

It won't work as well in a generic sense, but I was planning on just using
the b_inode_buffers.  Instead of going onto the inode's dirty buffer list,
they go onto this special list instead (the reiserfs journal already has a
dummy inode used for this).

The advantage is that nothing extra is needed on the buffer head, but the
disadvantage is the buffer doesn't go on the inode's list.  Somebody needs
to flush the new list on fsync and such.  It works for reiserfs, but not in
general.

I think you're right about being able to clear BH_New once get_block tests
it.  Unless someone comes up with a reason against, I'll test it out.  I'm
guessing that we are wasting time rerunning unmap_underlying_metadata on
buffers marked BH_New.

-chris

