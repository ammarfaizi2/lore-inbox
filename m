Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVEETti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVEETti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVEETsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:48:43 -0400
Received: from smtp.istop.com ([66.11.167.126]:2776 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262186AbVEET1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 15:27:50 -0400
From: Daniel Phillips <phillips@istop.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Thu, 5 May 2005 15:29:31 -0400
User-Agent: KMail/1.7
Cc: Daniel McNeil <daniel@osdl.org>, David Teigland <teigland@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Patrick Caulfield <pcaulfie@redhat.com>
References: <20050425165826.GB11938@redhat.com> <200504300509.24887.phillips@istop.com> <1115295930.1988.229.camel@sisko.sctweedie.blueyonder.co.uk>
In-Reply-To: <1115295930.1988.229.camel@sisko.sctweedie.blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505051529.31980.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thursday 05 May 2005 08:25, Stephen C. Tweedie wrote:
> Hi,
>
> On Sat, 2005-04-30 at 10:09, Daniel Phillips wrote:
> > As you know, this is how I currently determine ownership of such
> > resources as cluster snapshot metadata and ddraid dirty log.  I find the
> > approach distinctly unsatisfactory.  The (g)dlm is rather verbose to use,
> > particularly taking into the account the need to have two different state
> > machine paths, depending on whether a lock happens to master locally or
> > not, and the need to coordinate a number of loosely coupled elements:
> > lock status blocks, asts, the calls themselves.  The result is quite a
> > _long_ and opaque program to do a very simple thing.
>
> Why on earth do you need to care where a lock is mastered?

That is just my point.  I wish I did not have to care.  But gdlm behaves 
differently - returns status in different ways - depending on whether a lock 
is mastered locally or not.

> Use of ASTs 
> etc. should be optional, too --- you can just use blocking variants of
> the lock primitives if you want.  There's a status block, sure, but you
> can call the lock grant function synchronously and the status block is
> guaranteed unambiguously to be filled on return.

Writing non-trivial code that is supposed to perform well under parallel loads 
is practically impossible with the blocking variants.  As far as I can see, 
for nontrivial applications, the blocking calls are just "training wheels" 
for the real api, 

> So the easy way to use the DLM for metadata ownership is simply to have
> a thread which tries, synchronously, to acquire an EX lock on a
> resource.  You get it or you stay waiting; when you get it, you own the
> metadata.  Pretty simple.  (The only real complication in this
> particular case is how to deal with the resource going away while you
> wait, eg. unmount.)

The complication arises from the fact that you then need to advise the rest of 
the cluster that you own the metadata.  How?  LVB, obviously.  But then you 
run smack into the whole culture of LVB semantics and oddball limitations.  
For example, what happens when the owner of a LVB dies, what is the value of 
the LVB then?  Can we prove that our metadata ownership scheme is still 
raceless?

Honestly, using the dlm is a perverse way to establish metadata ownership when 
we have a _far_ more direct way to do it.  As a fringe benefit, we lose the 
dlm dependency from a whole batch of cluster components, for example, all the 
cluster block devices.  This is clearly the Right Thing to Do[tm].

> > And indeed, instinct turns out to be correct: there is a far simpler way
> > to handle this: let the oldest member of the cluster decide who owns the
> > metadata resources.
>
> Deciding who owns it is one thing.  You still need the smarts to work
> out if recovery is *already* in progress somewhere, and to coordinate
> wakeup of whoever you've granted the new metadata ownership to, etc.

That is part of the service group recovery protocol ((re)start recovery/halt 
recovery/recovery success).

> Using a lock effectively gets you much of that for free, once you've
> done the work to acquire the EX lock in the first place.

I'm afraid that "free" is an illusion here.  The metadata ownership code is 
very, very ugly using the dlm approach, but is very nice using the cman event 
interface, and will become even nicer after we fix cman a little.

The reason for this is, cman membership events fit the problem better.  The 
dlm api just isn't suited to this.  It can be made to fit, but the result is 
predictably ugly.  We should not lose sight of the fact that the dlm is 
actually just implemented on top of a set of cluster synchronization 
messages, as is cman.  In fact, cman provides the messaging layer that dlm 
uses (or it does in the code that I am running here, I have not seen the 
rumoured new version of cman yet).  So the reason for not using cman directly 
is, what exactly?

Or putting it another way, what value does the dlm add to the metadata 
ownership code?  It sure does not simplify it.  And in my opinion, it does 
not make it more obviously correct either, quite the contrary.

> > Good instinct.  In fact, as I've said before, you don't necessarily need
> > a dlm in a cluster application at all.  What you need is _global
> > synchronization_, however that is accomplished.  For example, I have
> > found it simpler and more efficient to use network messaging for the
> > cluster applications I've tackled so far.
>
> Yes, there is definitely room for both.  In particular, the more your
> application looks like client/server, the less appropriate a DLM is.

True, very true.  And metadata ownership problems tend to look just like 
client/server problems, even if we break the metadata up into multiple parts 
and distribute it around the cluster.

Anyway, it turns out that a significant number of the cluster components have 
ended up looking like client/server architectures.  For the time being, the 
single - and major - exception is the distributed filesystem itself.  Oh, and 
gdlm and cman, which are self-fullfilling prophesies.

So we have, from the bottom up:

  - cman: distributed
  - block device export: client/server
  - cluster raid: client/server
  - cluster snapshot: client/server
  - gdlm: distributed
  - gfs: distributed
  - applications: need more data

We can be fairly sure that the current crop of gfs applications is _not_ using 
the dlm, for the simple reason that the dlm has not existed long enough.  How 
do existing application synchronize then?  The truth is, I do not know, 
because I have not conducted any survey.  However, the one major application 
I have looked at porting to gfs already has its synchronization working fine, 
using point-to-point socket connections.  The only major bit it needs to 
become a distributed cluster application is a distributed filesystem.  In the 
end, there will be no dlm anywhere to be seen at the application level.  The 
application is, in my humble opinion, better because of this.

> >    This suggests to me that the dlm is going to end up pretty much as
> > a service needed only by a cfs, and not much else.
>
> But once you've got a CFS, it suddenly becomes possible to do so much
> more in user-space in a properly distributed fashion, rather than via
> client/server.  Cluster-wide /etc/passwd?  Just lock for read, access
> the file, unlock.  Things like shared batch/print queues become easier.
> And using messaging is often completely the wrong model for such things,
> simply because there's no server to send the message to.  A DLM will
> often be a far better fit for such applications.

I think I can do a much better, cleaner job of distributed passwords by 
directly using cman service group events.  Do you want to see some code for 
that?

> > The corollary of that is,
> > we should concentrate on making the dlm work well for the cfs, and not
> > get too wrapped up in trying to make it solve every global
> > synchronization problem in the world.
>
> Trouble is, I think you're mixing problems here.  There are two
> different problems: whether the DLM locking model is a good primitive to
> use for a given case; and whether the specific DLM API in question is a
> good fit for the model itself.

Yes.

> And your initial complaints about needing to know local vs. remote
> master, dealing with ASTs etc. are really complaints about the API, not
> the model.

Those complaints were about the api.  Other complaints are about the model, 
and I have more complaints about the model than the ones I have already 
mentioned.  For example: the amount of data you can pass around together with 
a lock grant is pathetically limited.  (Other complaints can wait for the 
appropriate thread to pop up.)

> Using blocking, interruptible APIs gets rid of the AST issue 
> entirely for applications that don't need that level of complexity.  And 
> you obviously want to have an API variant that doesn't care where the
> lock gets mastered --- for one thing, a remotely mastered lock can turn
> into a locally mastered one after a cluster membership transition.

We should just lose the variant that cares.  There is no efficiency argument 
for including that brokenness in the api.

> So let's keep the two separate.  Sure, there will be cases where a DLM
> model is more or less appropriate; but given that there are cases where
> the model does work, what are the particular unnecessary complications
> that the current API forces on us?  Remove those and you've made the DLM
> model a lot more attractive to use for non-CFS applications.

Yes.  I would be perfectly happy to put aside the "alternatives to dlm" thread 
and concentrate purely on fixing the dlm api.  Please do not misinterpret my 
position: we do need a dlm in the cluster stack.  Now please let us ensure 
that _our_ dlm is a really, really nice dlm with a really, really, nice api.

Regards,

Daniel
