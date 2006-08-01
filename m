Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbWHAE5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWHAE5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbWHAE5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:57:19 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:21665 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1161004AbWHAE5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:57:18 -0400
Message-ID: <44CEDF2A.6080500@slaphack.com>
Date: Mon, 31 Jul 2006 23:57:14 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: tdwebste2@yahoo.com, Theodore Tso <tytso@mit.edu>,
       Nate Diller <nate.diller@gmail.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of  view"expressed
 by kernelnewbies.org regarding reiser4 inclusion]
References: <20060801034726.58097.qmail@web51311.mail.yahoo.com> <44CED777.5080308@slaphack.com> <Pine.LNX.4.63.0607312133080.15179@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0607312133080.15179@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> On Mon, 31 Jul 2006, David Masover wrote:
> 
>>> And perhaps a
>>> really good clustering filesystem for markets that
>>> require NO downtime. 
>>
>> Thing is, a cluster is about the only FS I can imagine that could 
>> reasonably require (and MAYBE provide) absolutely no downtime. 
>> Everything else, the more you say it requires no downtime, the more I 
>> say it requires redundancy.
>>
>> Am I missing any more obvious examples where you can't have enough 
>> redundancy, but you can't have downtime either?
> 
> just becouse you have redundancy doesn't mean that your data is idle 
> enough for you to run a repacker with your spare cycles.

Then you don't have redundancy, at least not for reliability.  In that 
case, you have redundancy for speed.

> to run a 
> repacker you need a time when the chunk of the filesystem that you are 
> repacking is not being accessed or written to.

Reasonably, yes.  But it will be an online repacker, so it will be 
somewhat tolerant of this.

> it doesn't matter if that 
> data lives on one disk or 9 disks all mirroring the same data, you can't 
> just break off 1 of the copies and repack that becouse by the time you 
> finish it won't match the live drives anymore.

Aha.  That really depends how you're doing the mirroring.

If you're doing it at the block level, then no, it won't work.  But if 
you're doing it at the filesystem level (a cluster-based FS, or 
something that layers on top of an FS), or (most likely) the 
database/application level, then when you come back up, the new data is 
just pulled in from the logs as if it had been written to the FS.

The only example I can think of that I've actually used and seen working 
is MySQL tables, but that already covers a huge number of websites.

> database servers have a repacker (vaccum), and they are under tremendous 
> preasure from their users to avoid having to use it becouse of the 
> performance hit that it generates. (the theory in the past is exactly 
> what was presented in this thread, make things run faster most of the 
> time and accept the performance hit when you repack). the trend seems to 
> be for a repacker thread that runs continuously, causing a small impact 
> all the time (that can be calculated into the capacity planning) instead 
> of a large impact once in a while.

Hmm, if that could be done right, it wouldn't be so bad -- if you get 
twice the performance but have to repack for 2 hrs at the end of the 
week, repacker is better, right?  So if you could spread the 2 hours out 
over the week, in theory, you'd still be pretty close to twice the 
performance.

But that is fairly difficult to do, and may be more difficult to do well 
than to implement, say, a Reiser4 plugin that operates about on the 
level of rsync, but on every file modification.

> the other thing they are seeing as new people start useing them is that 
> the newbys don't realize they need to do somthing as archaic as running 
> a repacker periodicly, as a result they let things devolve down to where 
> performance is really bad without understanding why.

Yikes.  But then, that may be a failure of distro maintainers for not 
throwing it in cron for them.

I had a similar problem with MySQL.  I turned on binary logging so I 
could do database replication, but I didn't realize I had to actually 
delete the logs.  I now have a daily cron job that wipes out everything 
except the last day's logs.  It could probably be modified pretty easily 
to run hourly, if I needed to.

Moral of the story?  Maybe there's something to this "continuous 
repacker" idea, but don't ruin a good thing for the rest of us because 
of newbies.
