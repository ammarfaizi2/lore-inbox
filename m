Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263081AbUJ1VMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbUJ1VMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUJ1VJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:09:07 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:21973 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263041AbUJ1VEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:04:32 -0400
Date: Thu, 28 Oct 2004 23:03:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Larry McVoy <lm@bitmover.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@novell.com>,
       Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <20041028030939.GA11308@work.bitmover.com>
Message-ID: <Pine.LNX.4.61.0410281120150.877@scrub.home>
References: <20041025162022.GA27979@work.bitmover.com>
 <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
 <Pine.LNX.4.61.0410252350240.17266@scrub.home> <20041026010141.GA15919@work.bitmover.com>
 <Pine.LNX.4.61.0410270338310.877@scrub.home> <20041027035412.GA8493@work.bitmover.com>
 <Pine.LNX.4.61.0410272214580.877@scrub.home> <20041028005412.GA8065@work.bitmover.com>
 <Pine.LNX.4.61.0410280314490.877@scrub.home> <20041028030939.GA11308@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 27 Oct 2004, Larry McVoy wrote:

> Warning: long message.  Reason you should read it: because I show you
> how you can independently verify, without a BK license, that Roman is
> spreading FUD.  So read this, check it out, you'll see that this is
> all Roman's nonsense.  If you already believe that, you can skip this
> but there is a lot of useful BK2CVS data in this message.  

I have to apologize, there is a little more data in cvs repository, but it 
doesn't change in any way what I was trying to tell Linus.
It seems I made another mistake, I have to apologize for. I didn't realize 
that the kernel repository is a private party and you are the bully at the 
door. Well, it seems I'm not cool enough and I deeply apologize for 
bothering you guys.

All I have left to say is that, what I said before is everything but 
nonsense and I invite everyone to verify what I say and whether Larry 
really tells the complete story.
So for example the 56% number is very real:

$ rlog ChangeSet,v | grep BKrev: | wc -l
23461

The number of the changesets in the bk repository is around 53000, this is 
the difference I talked about and it's real. What does this mean? The bk 
repository contains around 53000 snaphots of kernel development history, 
44% of these snapshots can be restored via bkcvs. So where is the rest?

bk preserves the history nonlinearly, e.g. something like this:

	t1 -> t2 -> t3 -> t4 -> t5
	 +--->  t1.1 -> t1.2 ---^

This means someone cloned the repo at t1 and committed some changes at 
t1.1 and t1.2, in the meantime the changes t2, t3, t4 were applied to the 
parent repo and at t5 the changes from the cloned repo were merged.

CVS by itself can't of course represent this history, so it only contains 
the changes from t1, t2, t3, t4, t5, the snapshots t1.1, t1.2 cannot be 
restored anymore reliably from bkcvs, one can only get the merged 
changeset t5. As it's rather likely that every commit changes different 
files, one can actually get 100% of the file changes, but you still have 
in this case only 71% percent of the commits. Why would anyone be 
interested in the remaining 29%? Only with the complete information one go 
back to any previous snapshot, so if e.g. something went wrong during the 
merge in t5, it's quite easy to tell that it still worked at t4 and t1.2. 
Without the extra information one only knows that it went wrong after t4. 
Applied to bkcvs this means a problem can be located with a precision of 
44% and this number is still quite high as I mentioned in the last mail. 
The more bk users the less this number becomes. Let's say 5 people set up 
a repo with 20 changes each to let Linus pull from them, instead of 
sending them to Andrew, so they can end up as just 24 commits in bkcvs. 
The little grepping I did on ChangeSet,v seems to backup my theory (if 
someone knows how to get real numbers, I'd love to hear them), I looked at 
pulls from the net, scsi and Greg's repo and most of them are indeed 
merged into a single bkcvs commit.

On the other hand Larry's 96% number sounds impressive, but it's the less 
interesting one, if some of the commit information is missing, it's 
nontrival to put the file changes in the correct context. In the example 
above this means the individual file patches of t1.1 and t1.2 have to be 
matched to the corresponding splitted changelog of t5, it's anything but 
trivial, if it's possible at all and it doesn't provide the information 
that t1.1 has to be applied on top of t1. This means that it's often 
possible to extract a changeset manually, but doing it automatically is 
rather impractical and not worth the trouble.

Now it's theoretically possible to extract data via bkweb, but I (and I 
hope not only me) still remember what happened last time Andrea tried 
that, so I haven't actually looked into it too deeply. It certainly is
possible to extract all commits, the problem starts with putting them into 
a context. The repository information in bkweb is a bit filtered (e.g. 
empty merges), which are of only little interest to the human viewer, but 
that makes it interesting to reliably tell where a branch starts and end. 
Without further research I can only guess, whether that information is 
deducible or has to be extrapolated.

Finally the commit mails have really only informational value, as they 
lack any usable context.

Well, that's about it about the usefulness of the public available 
information. So if anyone could tell me, what exactly is FUD about this, 
I certainly would love to know it.

So why do I actually care about this data? For one I have that weird idea 
that the goals of a free software project should be reflected in its 
development process, that I actually get insulted for this is a truly 
strange experience.
I would really like to have access to this data, it's data I contributed 
to, it's data I care about and which I'm working on a lot of time anyway, 
but unfortunately full access to this data is restricted to a private 
club. Consequently this means that there will never be a gateway to easily 
exchange data, if synchronization is limited to bkcvs, this will cause 
unnecessary conflicts. If the information has to go via 
scm->patch->bk->bkcvs->scm, some information obviously get lost and the 
scm can only guess whether the information has been merged or not. IOW an 
alternative scm will always be in a disadvantage...

Anyway, I will now go away and play with the other uncool kids.

bye, Roman
