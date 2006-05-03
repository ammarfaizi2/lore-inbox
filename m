Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWECQLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWECQLs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 12:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWECQLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 12:11:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:37306 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964996AbWECQLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 12:11:47 -0400
Date: Wed, 3 May 2006 11:11:43 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, herbert@13thfloor.at,
       dev@sw.ru, linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
Message-ID: <20060503161143.GA18576@sergelap.austin.ibm.com>
References: <20060501203906.XF1836@sergelap.austin.ibm.com> <200605021017.19897.ak@suse.de> <20060502172031.GA22923@sergelap.austin.ibm.com> <200605021930.45068.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605021930.45068.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andi Kleen (ak@suse.de):
> On Tuesday 02 May 2006 19:20, Serge E. Hallyn wrote:
> > Quoting Andi Kleen (ak@suse.de):
> > > Have a proxy structure which has pointers to the many name spaces and a bit
> > > mask for "namespace X is different".
> > 
> > different from what?
> 
> From the parent.

...

> > Oh, you mean in case we want to allow cloning a namespace outside of
> > fork *without* cloning the nsproxy struct?
> 
> Basically every time any name space changes you need a new nsproxy.

But, either the nsproxy is shared between tasks and you need to copy
youself a new one as soon as any ns changes, or it is not shared, and
you don't need  that info at all (just make the change in the nsproxy
immediately)

What am I missing?

Should we talk about this  on irc someplace?  Perhaps drag in Eric as
well?

> > > This structure would be reference
> > > counted. task_struct has a single pointer to it.
> > 
> > If it is reference counted, that implies it is shared between some
> > processes.  But namespace pointers themselves are shared between some of
> > these nsproxy's.  The lifetime mgmt here is one reason I haven't tried a
> > patch to do this.
> 
> The livetime management is no different from having individual pointers.

That's true if we have one nsproxy per process or thread, which I didn't
think was the case.  Are you saying not to share nsproxy's among
processes which share all namespaces?

> > > With many name spaces you would have smaller task_struct, less cache 
> > > foot print, better cache use of task_struct because slab cache colouring
> > > will still work etc.
> > 
> > I suppose we could run some performance tests with some dummy namespace
> > pointers?  9 void *'s directly in the task struct, and the same inside a
> > refcounted container struct.  The results might add some urgency to
> > implementing the struct nsproxy.
> 
> Not sure you'll notice too much difference on the beginning. I am just

9 void*'s is probably more than we'll need, though, so it's not "the
beginning".   Eric previously mentioned uts, sysvipc, net, pid, and uid,
to which we might add proc, sysctl, and signals, though those are
probably just implied through the others.

What others do you see us needing?

If the number were more likely to be 50, then in the above experiment
use 50 instead - the point was to see the performance implications
without implementing the namespaces first.

Anyway I guess I'll go ahead and queue up some tests.

> the opinion memory/cache bloat needs to be attacked at the root, not
> when it's too late.

-serge
