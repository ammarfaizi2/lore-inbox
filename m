Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269315AbRGaPWO>; Tue, 31 Jul 2001 11:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269320AbRGaPWG>; Tue, 31 Jul 2001 11:22:06 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:37388 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S269316AbRGaPV4>; Tue, 31 Jul 2001 11:21:56 -0400
Message-ID: <3B66CD19.EE055198@namesys.com>
Date: Tue, 31 Jul 2001 19:22:01 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Chris Wedgwood <cw@f00f.org>, Rik van Riel <riel@conectiva.com.br>,
        Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <687650000.996586885@tiny>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Chris Mason wrote:
> 
> On Tuesday, July 31, 2001 02:59:46 PM +0400 Hans Reiser <reiser@namesys.com>
> wrote:
> 
> [ CONFIG_REISERFS_CHECK ]
> 
> > Last I ran benchmarks the performance cost was 30-40%, but this was some
> > time ago.  I think that the coders have been quietly culling some checks
> > out of the FS, and so it does not cost as much anymore.  I would prefer
> > that the "excesive" checks had stayed in.
> >
> > Sigh, I see I cannot persuade in this argument.  It seems Linus is right,
> > and debugging checks don't belong in debugged code even if they would make
> > it easier for persons hacking on the code to debug their latest hacks.
> >
> 
> In the end, the distributions are responsible for their own quality control,
> and they are free to turn on whatever debugging features they like.  You can
> yell, scream, call them names, and in general piss them off however you like
> and they will still be absolutely correct in turning on whatever debugging
> check they feel is important.

If they tell the user that the debugging is on and the FS is slowed.  I think
this is my solution, we will just make sure that the user knows with every mount
and every boot that debug is on and things are going to be slow.
> 
> The right way to deal with this is ask why they think it's important to turn
> on the checks.  The goal behind code under CONFIG_REISERFS_CHECK is to add
> extra runtime consistency checks, but without CONFIG_REISERFS_CHECK on, the
> code should still make sure it isn't hosing the disk.  In other words, the
> goal is like this:
> 
> if (some_error) {
> #ifdef CONFIG_REISERFS_CHECK
>     panic("some_error") ;
> #else
>     gracefully_recover
> #endif
> 
> There are places CONFIG_REISERFS_CHECK does extra scanning of the metadata
> and such, but all of these are supposed to be things that can be recovered
> from with the debugging off.  Anything else is a bug.
> 
> -chris


I am sorry Chris, but I cannot see the sense in what you say. 
CONFIG_REISERFS_CHECK is not a flag that indicates whether the user desires
graceful recovery, it is a flag that indicates whether every imaginable check
should be in the code, performance be damned, because there is a bug in the code
somewhere, and we are desperately trying to get a clue about what its source is 
earlier in its life prior to the machine hanging.  (Bugs where there is a time
lag between data structure corrupting and FS crashing are harder than others to
debug, and checking the data structures excessively is one way to try to fing
those bugs.)  Making graceful recovery a selectable option is a separate topic. 

There are lots of arguments that naturally arise in a development team about
what checks are debug only and what ones belong outside.  I lose many of these
arguments to the betterment of ReiserFS.  If persons not on the development
team, and not involved in those discussions, and not end users, turn debug on
and let users think it is normal slow motion reiserfs that they run, it screws
our whole methodology.

It may help readers if they understand that Chris does not like the big heavy
checks that one would not want to run all the time being inside
CONFIG_REISERFS_CHECK.

Having levels of CONFIG_REISERFS_CHECK, in which one level is something to the
effect of CHECK_EVERYTHING_YOU_CAN_WITHOUT_MY_NOTICING_THINGS_GOING_SLOWER,
would be reasonable.  We have what we have though.  

Hans
