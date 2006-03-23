Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWCWDbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWCWDbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWCWDbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:31:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2964 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932066AbWCWDbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:31:47 -0500
Date: Wed, 22 Mar 2006 19:31:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Junio C Hamano <junkio@cox.net>
cc: Daniel Barkalow <barkalow@iabervon.org>, linux-dvb-maintainer@linuxtv.org,
       akpm@osdl.org, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH 000/141] V4L/DVB updates part 1
In-Reply-To: <7vmzfi6u7x.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.4.64.0603221909420.26286@g5.osdl.org>
References: <20060320150819.PS760228000000@infradead.org>
 <Pine.LNX.4.64.0603210741120.3622@g5.osdl.org> <Pine.LNX.4.64.0603210748340.3622@g5.osdl.org>
 <1142962995.4749.39.camel@praia> <Pine.LNX.4.64.0603210946040.3622@g5.osdl.org>
 <1142965478.4749.58.camel@praia> <Pine.LNX.4.64.0603211035390.3622@g5.osdl.org>
 <1142968537.4749.96.camel@praia> <Pine.LNX.4.64.0603211126290.3622@g5.osdl.org>
 <Pine.LNX.4.64.0603211829430.6773@iabervon.org> <Pine.LNX.4.64.0603211630140.3622@g5.osdl.org>
 <7vmzfi6u7x.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Mar 2006, Junio C Hamano wrote:
> 
> I am curious how you found it initially.  After you pulled but
> before you did further work on top of the updated HEAD, I am
> suspecting that there is some sanity check done by you to detect
> that you pulled a faulty tree and decide to discard the merge.

I tend to have a two-level safety check. The first is that I just check 
the diffstat of the result of the pull (I realize that people hate the 
fact that the diffstat is often the most expensive part of a pull, but to 
me it's one of the more important things). 

So I check the diffstat not only for sanity (if somebody asks me to pull a 
tree that is ARM-specific, the diffstat should only show ARM files 
changing), but also tend to match it up against what the "please pull" 
email _claimed_ the diffstat should look like

This is why I ask people to include the diffstat and shortlog in their 
"please pull" messages: not only does it mean that I get a high-level idea 
of what the pull is going to do even before I do it, it also means that if 
my end result is different from the claimed one, it's likely some 
confusion with the tree (or I pulled the wrong branch because I didn't 
notice that it wasn't the main one).

This first-level safety check generally catches any serious mistakes, and 
it's helped me catch cases where the other end did something really stupid 
by mistake. 

However, in this case, the diffstat didn't actually show anything strange, 
because the problem was a bogus merge from my own tree, which obviously 
thus merged perfectly and caused no actual _data_ changes as far as the 
end result was concerned. 

So this one was caught by the fact that I'm just fairly anal about the 
history being sensible (as the ACPI people may remember ;), so I usually 
also do

	gitk ORIG_HEAD..

after pulling. That gives me a nice overview of what the heck the history 
looks like, and is what caught this one. I don't _always_ do it, and 
especially with people who have been merging with me since BK days I 
sometimes don't bother with this thing, but I do it most of the time.

Finally, I do a "git-fsck-cache" after pretty much every "git pull" 
sequence just because I'm anal.

Basically, if the history looks sane, and the diffstat doesn't raise any 
red flags, I'm then usually happy. Of course, since I only really pull 
from people that I trust _anyway_, none of this is about really trying to 
find "bad stuff" - it's more about

 (a) stupid mistakes. Especially early on, this (and some extra checks, 
     like doing "git-whatchanged ORIG_HEAD.." - which is just a much 
     easier way to scan the commits in more detail without actually seeing 
     the full patches than gitk) caught a number of cases where the other 
     end had simply done a mistake. We had a number of those. Happily, 
     people have clearly gotten more used to git, and I also think that 
     git simply doesn't allow some of those mistakes any more.

 (b) keeping the history clean. I _hate_ having an unreadable history. The 
     "whole project" history inevitably gets very complex after a while, 
     but I'm personally convinced that as long as the history makes sense 
     in the "small picture" (ie the "gitk ORIG_HEAD.." kind of thing), it 
     just helps the big picture.

So for _me_, I don't worry so much about the actual patch itself. I seldom 
have the time to look closely and the actual changed lines, although the 
merges with Andrew I tend to actually check those (partly because they 
aren't git merges and so I actually have to check the emails one by one 
_anyway_, but partly because unlike the git merges, Andrew's stuff tends 
to be all over the place and often to very core stuff, so I need to be 
more aware of them).

			Linus
