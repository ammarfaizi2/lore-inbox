Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319086AbSIDHVi>; Wed, 4 Sep 2002 03:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319088AbSIDHVh>; Wed, 4 Sep 2002 03:21:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58274 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319086AbSIDHVh>;
	Wed, 4 Sep 2002 03:21:37 -0400
Message-Id: <200209040725.g847PrUv089710@northrelay01.pok.ibm.com>
User-Agent: Pan/0.11.2 (Unix)
From: "Suparna Bhattacharya" <suparna@in.ibm.com>
To: "Linus Torvalds" <torvalds@transmeta.com>, "Jens Axboe" <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
Date: Wed, 04 Sep 2002 12:55:58 +0530
References: <Pine.LNX.4.44.0209031054290.1356-100000@home.transmeta.com> <20020903180203.GD13721@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Sep 2002 23:44:59 +0530, Jens Axboe wrote:

> On Tue, Sep 03 2002, Linus Torvalds wrote:
>> 
>> Ok,
>>  I found another major bio-related bug that definitely explains why the
>> floppy driver generated corruption - any partial request completion
>> would be totally messed up by the BIO layer (not the floppy driver).
>> 
>> Any other block device driver that did partial request completion might
>> also be impacted.
>> 
>> Jens, oops. We should not update the counts by how much was left
>> uncompleted, but by how much we successfully completed!
> 
> Yeah oops, the most embarassing thing is that Bart and I have both found
> this but independently months ago but it seems it got lost at my end (or
> your end, but lets not point fingers :-) :-(
> 

Oh yes, even I had this fixed this in the bio traversal patches 
I had posted (had this in the core patch, and mentioned it 
in the description in the note :) ), guess it went unnoticed.

BTW, any plans for including those patches ? So far all feedback
I've received (including Jens, Bart, James, Andrew ) seems to 
say OK to go from what I can tell. If it seems like the right 
thing to do, then I'd rather it go in sooner (at least the core
and comatibility portions), so subsequent driver changes etc 
are aligned with this (I've been chasing several kernel versions 
with this now :( )

I now have a latest version updated to 2.5.33, but dropped the 
IDE portions from it for now, in view of the ide switch and 
ongoing changes ... If Bart upgrades his corresponding patches 
then that would take care of it. Otherwise I could give that 
a go too you think that seems worthwhile and may relook at
whether the "traverse for submission" helpers I have can be
improved upon (maybe given better names too).

A quick recap:

BIO traversal enhancements
--------------------------
- Pre-req for full BIO splitting infrastructure [Splits
  in the middle of a segment can also share the same vec]
- Pre-req for attaching a pre-built vector (not owned by block)
  to a bio (e.g for aio)  [Avoids certain subtle side-effects in
  special cases like partial segment completion]
- Pre-req for IDE mult-count PIO write fixes w/o request copy
  [Ability to traverse a bio partially for i/o submission without
  effecting bio completion]

Introduces some new fields in the bio and request to help maintain
traversal state and handle partial segment bio clones, and comes
with a corresponding set of helpers to enable clean separation 
of traversal for i/o submission vs i/o completion.

Regards
Suparna

> Patch is ofcourse correct. I'm not sure other drivers have been hit (of
> the used ones), since they would have to use old style completions and
> do less than current_nr_sectors in one-go.
>
