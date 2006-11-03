Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753465AbWKCTB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbWKCTB7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbWKCTB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:01:58 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:35983 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1753435AbWKCTB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:01:58 -0500
Date: Fri, 3 Nov 2006 20:01:56 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <20061103145329.GE11947@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.64.0611031953411.30722@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz>
 <20061103101901.GA11947@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0611031252430.17174@artax.karlin.mff.cuni.cz>
 <20061103122126.GC11947@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0611031428010.17427@artax.karlin.mff.cuni.cz>
 <20061103134802.GD11947@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0611031509500.27698@artax.karlin.mff.cuni.cz>
 <20061103145329.GE11947@wohnheim.fh-wedel.de>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1908636959-82419901-1162580294=:30722"
Content-ID: <Pine.LNX.4.64.0611031958480.30722@artax.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1908636959-82419901-1162580294=:30722
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0611031958481.30722@artax.karlin.mff.cuni.cz>



On Fri, 3 Nov 2006, Jörn Engel wrote:

> On Fri, 3 November 2006 15:19:09 +0100, Mikulas Patocka wrote:
>>
>>>> Really it can batch any number of modifications into one transaction
>>>> (unless fsync or sync is called). Transaction is closed only on
>>>> fsync/sync, if 2 minutes pass (can be adjusted) or when the disk runs out
>>>> of space.
>>>
>>> Interesting.  Let me pick an example and see where we're going from
>>> there.  You have four directories, A, B, C and D, none of which is the
>>> parent of another.  Two cross-directory renames happen:
>>> $ mv A/foo B/
>>> $ mv C/bar D/
>>>
>>> This will cause four modifications, one to each of the directories.  I
>>> would have assumed that the modifications to A and B receive one
>>> transaction number n, C and D get a different one, n+1 if nothing else
>>> is going on in between.
>>
>> They most likely receive the same transaction (this is not like journaling
>> transaction --- new transactions are issued only on conditions above).
>
> That means one transaction in your terminology contains many
> transactions in my terminology, which explains a bit of confusion.
>
>> They may be written in any order (that's some improvement over
>> journaling) by buffer thread.
>>
>> And when you sync, with one write of memory_cct to disk, you make old
>> entries permanently invalid and new entries permanently valid.
>
> Ok, I seem to understand it now.  Quite interesting.
>
>> If the machine crashes before sync (and some of directory sectors were
>> written and some not), new entries will always be considered invalid, and
>> old entries always valid, because new crash count will be used and crash
>> count table at old crash count index will never be modified.
>
> So the only overflow you have to fear is the 16-bit cc overflow.  Once
> that hits your filesystem is end-of-life and cannot be written to
> anymore.
>
> Has it ever occurred to you how similar your approach is to the
> venerable sprite lfs?  Lfs syncs by writing a "checkpoint", which
> contains quite a bit of information.  You sync by just writing a
> single number.  But in the end, both designs have a lot of
> non-committed data already written to disk which only becomes valid
> once the final (checkpoint|transaction count) is written.
>
> And considering that writing several kB of contiguous data to disk is
> nearly free, compared to the initial seek, both commit operations
> should take about the same time.
>
> So which, if I may ask, are the advantages of your design over sprite
> lfs?
>
> http://citeseer.ist.psu.edu/rosenblum91design.html
>
> Jörn

It is very different from LFS. LFS is log-filesystem, i.e. journal spans 
the whole device. The problem with this design is that it's fast for write 
(cool benchmark numbers) and slow in real-world workloads.

LFS places files according to time they were created, not according to 
their directory.

If you have directory with some project where you have files that you 
edited today, day ago, week ago, month ago etc., then any current 
filesystem (even ext2) will try to place files near each other --- while 
LFS will scatter the files over the whole partition according to time they 
were written. --- I believe that this is the reason why log-structured 
filesystems are not in wild use --- this is a case where optimizing for 
benchmark kills real-world performance.

Mikulas
--1908636959-82419901-1162580294=:30722--
