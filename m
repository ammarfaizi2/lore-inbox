Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUGFV2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUGFV2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 17:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUGFV2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 17:28:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61139 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264569AbUGFV2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 17:28:10 -0400
From: Daniel Phillips <phillips@redhat.com>
Organization: Red Hat
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Tue, 6 Jul 2004 17:34:51 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Lon Hohberger <lhh@redhat.com>
References: <200407050209.29268.phillips@redhat.com> <200407051627.51790.phillips@redhat.com> <20040706073444.GB19892@marowsky-bree.de>
In-Reply-To: <20040706073444.GB19892@marowsky-bree.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407061734.51023.phillips@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On Tuesday 06 July 2004 03:34, Lars Marowsky-Bree wrote:
> On 2004-07-05T16:27:51,
>
>    Daniel Phillips <phillips@redhat.com> said:
> > > Indeed. If your efforts in joining the infrastructure are more
> > > successful than ours have been, more power to you ;-)
> >
> > What problems did you run into?
>
> The problems were mostly political. Maybe we tried to push too early,
> but 1-3 years back, people weren't really interested in agreeing on
> some common components or APIs. In particular a certain Linux vendor
> didn't even join the group ;-)

*blush*

> And the "industry" was very reluctant 
> too. Which meant that everybody spend ages talking and not much
> happening.

We're showing up with loads of Sistina code this time.  It's up to 
everybody else to ante up, and yes, I see there's more code out there.  
It's going to be quite a summer reading project.

> However, times may have changed, and hopefully for the better. The
> push to get one solution included into the Linux kernel may be enough
> to convince people that this time its for real...

It's for real, no question.  There are at least two viable GPL code 
bases already, GFS and Lustre, with OCFS2 coming up fast.  And there 
are several commercial (binary/evil) cluster filesystems in service 
already, not that Linus should care about them, but they do lend 
credibility.

> There still is the Open Clustering Framework group though, which is a
> sub-group of the FSG and maybe the right umbrella to put this under,
> to stay away from the impression that it's a single vendor pushing.

Oops, another code base to read ;-)

> If we could revive that and make real progress, I'd be as happy as a
> well fed penguin.

Red Hat is solidly behind this as a _community_ effort.

> Now with OpenAIS on the table, the GFS stack, the work already done
> by OCF in the past (which is, admittedly, depressingly little, but I
> quite like the Resource Agent API for one) et cetera, there may be a
> good chance.
>
> I'll try to get travel approval to go to the meeting.

:-)

> BTW, is the mailing list working? I tried subscribing when you first
> announced it, but the subscription request hasn't been approved
> yet... Maybe I shouldn't have subscribed with the suse.de address ;-)

Perhaps it has more to do with a cross-channel grudge? <grin>

Just poke Alasdair, you know where to find him.

> > On a quick read-through, it seems quite straightforward for quorum,
> > membership and distributed locking.
>
> Believe me, you'd be amazed to find out how long you can argue on how
> to identify a node alone - node name, node number (sparse or
> continuous?), UUID...? ;-)

I can believe it.  What I have just done with my cluster snapshot target 
over the last couple of weeks is, removed _every_ dependency on cluster 
infrastructure and moved the one remaining essential interface to user 
space.  In this way the infrastructure becomes pluggable from the 
cluster block device's point of view and you can run the target without 
any cluster infrastructure at all if you want (just dmsetup and a 
utility for connecting a socket to the target).  This is a general 
technique that we're now applying to a second block driver.  It's a 
tiny amount of kernel and userspace code which I will post pretty soon.  
With this refactoring, the cluster block driver shrank to less than 
half its former size with no loss of functionality.

The nice thing is, I get to use the existing (SCA) infrastructure, but I 
don't have any dependency on it.

> And, how do you define quorum, and is it always needed? Some
> algorithms don't need quorum (ie, election algorithms can do fine
> without), so a membership service which only works with quorum isn't
> the right component etc...

Oddly enough, there has been much discussion about quorum here as well.  
This must be pluggable, and we must be able to handle multiple, 
independent clusters, with a single node potentially belonging to more 
than one at the same time.  Please see this, for a formal writeup on 
our 2.6 code base:

   http://people.redhat.com/~teigland/sca.pdf

Is this the key to the grand, unified quorum system that will do every 
job perfectly?  Good question, however I do know how to make it 
pluggable for my own component, at essentially zero cost.  This makes 
me optimistic that we can work out something sensible, and that perhaps 
it's already a solved problem.

It looks like fencing is more of an issue, because having several node 
fencing systems running at the same time in ignorance of each other is 
deeply wrong.  We can't just wave our hands at this by making it 
pluggable, we need to settle on one that works and use it.  I'll humbly 
suggest that Sistina is furthest along in this regard.

> > The idea of having more than one node fencing system running at the
> > same time seems deeply scary, we'd better make some effort to come
> > up with something common.
>
> Yes. This is actually an important point, and fencing policies are
> also reasonably complex. The GFS stack seems to tie fencing quite
> deeply into the system (which is understandable, since you always
> have shared storage, otherwise a node wouldn't be part of the GFS
> domain in the first place).

Oops, should have read ahead ;)  The DLM is also tied deeply into the 
GFS stack, but that factors out nicely, and in fact, GFS can currently 
use two completely different fencing systems (GULM vs SCA-Fence).  I 
think we can sort this out.

> However, the new dependency based cluster resource manager we are
> writing right now (which we simply call "Cluster Resource Manager"
> for lack of creativity ;) decides whether or not it needs to fence a
> node based on the resources in the cluster - if it isn't affecting
> the resources we can run on the remaining nodes, or none of the
> resources requires node-level fencing, no such operation will be
> done.

Cluster resource management is the least advanced of the components that 
our Red Hat Sistina group has to offer, mainly because it is seen as a 
matter of policy, and so the pressing need at this state is to provide 
suitable hooks.  Lon Hohberger is working on system that works with the 
SCA framework (Magma).  The preexisting Red Hat cluster team decided to 
re-roll their whole cluster suite within the new framework.  Perhaps 
you would like to take a look, and tell us why this couldn't possibly 
work for you?  (Or maybe we need to get you drunk first...)

> This has advantages in larger clusters (where, if split, each
> partition could still continue to run resources which are unaffected
> by the split even the other nodes cannot be fenced), in shared
> nothing clusters or resources which are self-fencing and do not need
> STONITH etc.

"STOMITH" :)  Yes, exactly.  Global load balancing is another big item, 
i.e., which node gets assigned the job of running a particular service, 
which means you need to know how much of each of several different 
kinds of resources a particular service requires, and what the current 
resource usage profile is for each node on the cluster.  Rik van Riel 
is taking a run at this.

It's a huge, scary problem.  We _must_ be able to plug in different 
solutions, all the way from completely manual to completely automagic, 
and we have to be able to handle more than one at once.

> The ties between membership, quorum and fencing are not as strong in
> these scenarios, at least not mandatory. So a stack which enforced
> fencing at these levels, and w/o coordinating with the CRM first,
> would not work out.

Yes, again, fencing looks like the one we have to fret about.  The 
others will be a lot easier to mix and match.

> And by pushing for inclusion into the main kernel, you'll also raise
> all sleeping zom^Wbeauties. I hope you have a long breath for the
> discussions ;-)

You know I do!

> There's lots of work there.

Indeed, and I didn't do any work today yet, due to answering email.

Incidently, there is already a nice crosssection of the cluster 
community on the way to sunny Minneapolis for the July meeting.  We've 
reached about 50% capacity, and we have quorum, I think :-)

Regards,

Daniel
