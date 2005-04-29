Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVD2A0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVD2A0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 20:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVD2A0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 20:26:18 -0400
Received: from smtp.istop.com ([66.11.167.126]:19652 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262352AbVD2AZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 20:25:57 -0400
From: Daniel Phillips <phillips@istop.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Thu, 28 Apr 2005 20:26:35 -0400
User-Agent: KMail/1.7
Cc: David Teigland <teigland@redhat.com>, Steven Dake <sdake@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Patrick Caulfield <pcaulfie@redhat.com>
References: <20050425165826.GB11938@redhat.com> <200504280249.04735.phillips@istop.com> <20050428125512.GR21645@marowsky-bree.de>
In-Reply-To: <20050428125512.GR21645@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504282026.36273.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2005 08:55, Lars Marowsky-Bree wrote:
> On 2005-04-28T02:49:04, Daniel Phillips <phillips@istop.com> wrote:
> > > Just some food for thought how this all fits together rather
> > > neatly.
> >
> > It's actually the membership system that glues it all together.  The
> > dlm is just another service.
>
> Membership is one of the lowest level and high privileged inputs to the
> whole picture, of course.
>
> However, "membership" is already a pretty broad term, and one must
> clearly state what one is talking about. So we're clearly focused on
> node membership here, which is a special case of group membership; the
> top-level, sort of.

Indeed, you caught me being imprecise.  By "membership system" I mean cman, 
which includes basic cluster membership, service groups, socket interface, 
event messages, PF_CLUSTER, and a few other odds and ends.  Really, it _is_ 
our cluster infrastructure.  And it has warts, some really giant ones.  At 
least it did the last time I used it.  There is apparently a new, 
much-improved version I haven't seen yet.  I have heard that the re-rolled 
cman is in cvs somewhere.  Patrick?  Dave?

> Then every node has it's local view of node membership, constructed
> typically from observing node heartbeats.

Actually, it is constructed from observing cman events over the socket.

I see that some fantastical /sys/ filesystem has wormed itself into the 
machinery.  I need to check that this hasn't compromised the basic beauty of 
the event messaging model.

Fencing is a whole nuther issue.  It's sort of unclear how it is actually 
supposed to work, and judging from the number of complaints I see about it on 
mailing lists, it doesn't work very well.  We need to take a good look at 
that.

> Then the nodes communicate to reach concensus on the coordinated
> membership, which will usually be a set of nodes with full N:N
> connectivity (via the cluster messaging mechanism); and they'll also
> usually aim to identify the largest possible set.

Yes.  "Reaching consensus" is signalled to each node by cman sending a 
"finish" event, as in "finish recovering".  (To be sure, this is misleading 
terminology.  We should kill it before it has a chance to reproduce.)

> Eventually, there'll be a membership view which also implies certain
> shared data integrity guarantees if appropriate (ie, fencing in case a
> node didn't go down cleanly, and granting access on a clean join).

Each node's membership view is simply the cumulative state implied by the cman 
events.  Necessarily, this view will suffer some skew across the cluster.  
All cluster algorithms _must_ recognize and accomodate that.  This is where 
barriers come into play, though that mechanism is buried inside cman, and 
each node's view of barrier operations consists of cman events.  (The way 
this is actually implemented smells a little scary to me, but it seems to 
work ok for small numbers of nodes.)

> These steps but the last one usually happen completely internal to the
> membership layer; the last one requires coordination already, because
> the fencing layer itself might need recovery before it can fence
> something after a node failure.

Right, we need to do a lot more work on the fencing interface.  For example, I 
haven't even begun to analyze it from the point of view of memory inversion 
deadlock.  My spider sense tells me there is some of that in there.  Fencing 
is currently done via bash scripts, which alone sucks nearly beyond belief.

> And then there's quorum computation.

Aha!  There is a beautiful solution in the case of ddraid, i.e., any cluster 
with (m of n) redundant shared disks resident on the nodes themselves:

   http://sourceware.org/cluster/ddraid/

For ddraid order 1 and higher, there is no quorum ambiguity at all, because 
you _require_ a quorum of data nodes in order for any node to access the 
cluster filesystem data.  For example, for a five node ddraid distributed 
data cluster, you need four data nodes active or the cluster will only be 
able to sit there stupidly doing nothing.  Four data nodes is therefore the 
quorum group ordained by God.  Non-data nodes can come and go as they please, 
without ever worrying about split brain or other nasty quorum-related 
diseases.

> Certainly you could also try looking at it from a membership-centric
> angle, but the piece which coordinates the recovery of the various
> components which makes sure the right kind of membership events are
> delivered in the proper order, and errors during component recovery are
> appropriately handled, is, I think, pretty much distinct from the
> "membership" and a higher level component.

Sorry for the red herring.  Where I wrote "membership" I meant to write 
"cman", that is, cluster management.

> So I'm not sure I'd buy "the membership is what glues it all together"
> on eBay even for a low starting bid.

Though I'm not sure the concept is for sale, your buy-in will be appreciated 
nonetheless, no matter how many limp jokes we need to put up with on the way 
there.

Regards,

Daniel
