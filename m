Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269326AbRGaPvL>; Tue, 31 Jul 2001 11:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269331AbRGaPvB>; Tue, 31 Jul 2001 11:51:01 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:23059
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S269326AbRGaPup>; Tue, 31 Jul 2001 11:50:45 -0400
Date: Tue, 31 Jul 2001 11:49:30 -0400
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
cc: Chris Wedgwood <cw@f00f.org>, Rik van Riel <riel@conectiva.com.br>,
        Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <45790000.996594570@tiny>
In-Reply-To: <3B66CD19.EE055198@namesys.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Tuesday, July 31, 2001 07:22:01 PM +0400 Hans Reiser <reiser@namesys.com>
wrote:

> Chris Mason wrote:
>> 
>> On Tuesday, July 31, 2001 02:59:46 PM +0400 Hans Reiser
>> <reiser@namesys.com> wrote:
>> 
>> [ CONFIG_REISERFS_CHECK ]
>> 
>> > Last I ran benchmarks the performance cost was 30-40%, but this was some
>> > time ago.  I think that the coders have been quietly culling some checks
>> > out of the FS, and so it does not cost as much anymore.  I would prefer
>> > that the "excesive" checks had stayed in.
>> > 
>> > Sigh, I see I cannot persuade in this argument.  It seems Linus is right,
>> > and debugging checks don't belong in debugged code even if they would
>> > make it easier for persons hacking on the code to debug their latest
>> > hacks.
>> > 
>> 
>> In the end, the distributions are responsible for their own quality
>> control, and they are free to turn on whatever debugging features they
>> like.  You can yell, scream, call them names, and in general piss them off
>> however you like and they will still be absolutely correct in turning on
>> whatever debugging check they feel is important.
> 
> If they tell the user that the debugging is on and the FS is slowed.  I
> think this is my solution, we will just make sure that the user knows with
> every mount and every boot that debug is on and things are going to be slow.

It already does.  Read the mount output ;-)

>> 
>> The right way to deal with this is ask why they think it's important to
>> turn on the checks.  The goal behind code under CONFIG_REISERFS_CHECK is
>> to add extra runtime consistency checks, but without CONFIG_REISERFS_CHECK
>> on, the code should still make sure it isn't hosing the disk.  In other
>> words, the goal is like this:
>> 
>> if (some_error) {
>> #ifdef CONFIG_REISERFS_CHECK
>>     panic("some_error") ;
>> #else
>>     gracefully_recover
>> #endif
>> 
>> There are places CONFIG_REISERFS_CHECK does extra scanning of the metadata
>> and such, but all of these are supposed to be things that can be recovered
>> from with the debugging off.  Anything else is a bug.
>> 
>> -chris
> 
> 
> I am sorry Chris, but I cannot see the sense in what you say. 
> CONFIG_REISERFS_CHECK is not a flag that indicates whether the user desires
> graceful recovery, it is a flag that indicates whether every imaginable
> check should be in the code, performance be damned, because there is a bug
> in the code somewhere, and we are desperately trying to get a clue about
> what its source is  earlier in its life prior to the machine hanging.

If graceful recovery is not possible with CONFIG_REISERFS_CHECK off, the FS
is supposed to panic (or remount readonly).  Anything less is a bug.

CONFIG_REISERFS_CHECK might put the panic in a different place, for example,
it might notice when a block is read in that one of the items is hosed.  That
doesn't mean we can completely ignore hosed items with CONFIG_REISERFS_CHECK
off though.

> (Bugs where there is a time lag between data structure corrupting and FS
> crashing are harder than others to debug, and checking the data structures
> excessively is one way to try to fing those bugs.)  Making graceful
> recovery a selectable option is a separate topic. 
> 
> There are lots of arguments that naturally arise in a development team about
> what checks are debug only and what ones belong outside.  I lose many of
> these arguments to the betterment of ReiserFS.  If persons not on the
> development team, and not involved in those discussions, and not end users,
> turn debug on and let users think it is normal slow motion reiserfs that
> they run, it screws our whole methodology.

Distributions have methodogies too, its their job to apply it to the products
they ship.  They aren't adding code or breaking existing code, they are
simply enabling one of the options we provide.  If you really don't want
anyone to enable it, it shouldn't be there at all.

> 
> It may help readers if they understand that Chris does not like the big
> heavy checks that one would not want to run all the time being inside
> CONFIG_REISERFS_CHECK.

As per the rules above, this is somewhat true.  I want the FS to be fast as
much as anyone else, but reasonable safety checks are much more important.  

> 
> Having levels of CONFIG_REISERFS_CHECK, in which one level is something to
> the effect of
> CHECK_EVERYTHING_YOU_CAN_WITHOUT_MY_NOTICING_THINGS_GOING_SLOWER, would be
> reasonable.  We have what we have though.  
> 

If you can do the check without being slower, why would anyone ever turn it
off?  Speed is not the determining factor in which checks are done, safety is.

-chris

