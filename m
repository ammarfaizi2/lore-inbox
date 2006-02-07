Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWBGMO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWBGMO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWBGMO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:14:57 -0500
Received: from ns2.suse.de ([195.135.220.15]:53429 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965052AbWBGMO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:14:56 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Tue, 7 Feb 2006 13:14:34 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, clameter@engr.sgi.com, akpm@osdl.org,
       dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602071031.40346.ak@suse.de> <20060207115307.GA25110@elte.hu>
In-Reply-To: <20060207115307.GA25110@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071314.34879.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 12:53, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > On Tuesday 07 February 2006 01:19, Ingo Molnar wrote:
> > > 
> > > * Paul Jackson <pj@sgi.com> wrote:
> > > 
> > > > First it might be most useful to explain a detail of your proposal 
> > > > that I don't get, which is blocking me from considering it seriously.
> > > > 
> > > > I understand mount options, but I don't know what mechanisms (at the 
> > > > kernel-user API) you have in mind to manage per-directory and per-file 
> > > > options.
> > > 
> > > well, i thought of nothing overly complex: it would have to be a 
> > > persistent flag attached to the physical inode. Lets assume XFS added 
> > > this - e.g. as an extended attribute.
> > 
> > There used to be a patch floating around to do policy for file caches 
> > (or rather arbitary address spaces) It used special ELF headers to set 
> > the policy. I thought about these policy EAs long ago. The main reason 
> > I never liked them much is that on some EA implementations you have to 
> > fetch an separate block to get at the EA. And this policy EA would 
> > need to be read all the time, thus adding lots of additional seeks. 
> > That didn't seem worth it.
> 
> EAs would be fine - and they dont have to be propagated down into the 
> hierarchy. There's no reason to propagate them if the lack of EA means 
> 'inherit from parent'. Btw., not all filesystems need an extra block 
> seek - e.g. ext3 embedds them nicely into the raw inode.

If it's big enough. But to make it anywhere near usable for an admin
you would need to support inheritance from directories too
[I know from personal experience that ACLs without directory inheritance
are extremly messy to use], and with that it would get messy quickly
and require more overhead. 

I'm not really sure EAs are a good approach here.

Perhaps just a per super block setting if anything (tmpfs supports that
already) 


> > > which would result in every inode getting flagged as either 'local' or 
> > > 'global'. When the pagecache (and inode/dentry cache) gets populated, 
> > > the kernel will always know what the current allocation strategy is for 
> > > any given object:
> > 
> > In practice it will probably only set for a small minority of objects 
> > if at all. I could imagine admining this policy could be a PITA too.
> 
> It's so much cleaner and more flexible. I bet it's even a noticeable 
> speedup for users of the current cpuset-based approach: the cpuset 
> method forces _all_ 'large' objects to be allocated in a spread-out 
> form. While with the EA method you can pinpoint those few files (or 
> directories) that include the data that needs the spreading out. E.g.  
> /tmp would default to 'local' (unless the app creates a big /tmp file, 
> for which it should set the spread-out attribute).

It's unrealistic - no app will do that. It just needs good defaults.

I still don't really think it will make much difference if the file
cache is local or global. Compare to disk IO it is still infinitely
faster, so a relatively small slowdown from going off node is not
that big an issue.

> another thing: on NUMA, are the pagecache portions of readonly files 
> (such as /usr binaries, etc.) duplicated across nodes in current 
> kernels, or is it still random which node gets it? 

Random.

> This too could be an  
> EA caching attribute: whether to create per-node caches for file 
> content.

There were (ugly) patches floating around for text duplication, but iirc the benchmarkers
were still trying to figure out if it's even a good idea. My guess it is 
not because CPUs tend to have very aggressive prefetching for code streams which
can deal with latency well.
 
> This kind of stuff is precisely what EAs were invented for.

I'm not so sure.

-Andi
