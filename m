Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752978AbWKCOTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbWKCOTL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 09:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbWKCOTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 09:19:11 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:5856 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1752978AbWKCOTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 09:19:10 -0500
Date: Fri, 3 Nov 2006 15:19:09 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <20061103134802.GD11947@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.64.0611031509500.27698@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz>
 <20061103101901.GA11947@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0611031252430.17174@artax.karlin.mff.cuni.cz>
 <20061103122126.GC11947@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0611031428010.17427@artax.karlin.mff.cuni.cz>
 <20061103134802.GD11947@wohnheim.fh-wedel.de>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1908636959-679944023-1162563549=:27698"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1908636959-679944023-1162563549=:27698
Content-Type: TEXT/PLAIN; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

>> Really it can batch any number of modifications into one transaction
>> (unless fsync or sync is called). Transaction is closed only on
>> fsync/sync, if 2 minutes pass (can be adjusted) or when the disk runs out
>> of space.
>
> Interesting.  Let me pick an example and see where we're going from
> there.  You have four directories, A, B, C and D, none of which is the
> parent of another.  Two cross-directory renames happen:
> $ mv A/foo B/
> $ mv C/bar D/
>
> This will cause four modifications, one to each of the directories.  I
> would have assumed that the modifications to A and B receive one
> transaction number n, C and D get a different one, n+1 if nothing else
> is going on in between.

They most likely receive the same transaction (this is not like journaling 
transaction --- new transactions are issued only on conditions above).

A/foo entry is set with txc=memory_cct[memory_cc],cc=memory_cc
B/foo entry is set with txc=memory_cct[memoty_cc]|0x80000000,cc=memory_cc
C/foo entry is set with txc=memory_cct[memory_cc],cc=memory_cc
D/foo entry is set with txc=memory_cct[memoty_cc]|0x80000000,cc=memory_cc

They may be written in any order (that's some improvement over 
journaling) by buffer thread.

And when you sync, with one write of memory_cct to disk, you make old 
entries permanently invalid and new entries permanently valid.

If the machine crashes before sync (and some of directory sectors were 
written and some not), new entries will always be considered invalid, and 
old entries always valid, because new crash count will be used and crash 
count table at old crash count index will never be modified.

> To commit the first rename, n is written into cct[entry->cc].  To
> commit both, n+1 is written instead.  Committing the second
> transaction without committing the first is not possible.
>
> Now clearly we are disagreeing, so I must have misunderstood your
> design somehow.  Can you see how?
>
> Jörn

Mikulas
--1908636959-679944023-1162563549=:27698--
