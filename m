Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWBGLyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWBGLyq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWBGLyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:54:46 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45215 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965033AbWBGLyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:54:45 -0500
Date: Tue, 7 Feb 2006 12:53:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Paul Jackson <pj@sgi.com>, clameter@engr.sgi.com, akpm@osdl.org,
       dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060207115307.GA25110@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <20060206154537.a3e8cc25.pj@sgi.com> <20060207001902.GA18830@elte.hu> <200602071031.40346.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602071031.40346.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Tuesday 07 February 2006 01:19, Ingo Molnar wrote:
> > 
> > * Paul Jackson <pj@sgi.com> wrote:
> > 
> > > First it might be most useful to explain a detail of your proposal 
> > > that I don't get, which is blocking me from considering it seriously.
> > > 
> > > I understand mount options, but I don't know what mechanisms (at the 
> > > kernel-user API) you have in mind to manage per-directory and per-file 
> > > options.
> > 
> > well, i thought of nothing overly complex: it would have to be a 
> > persistent flag attached to the physical inode. Lets assume XFS added 
> > this - e.g. as an extended attribute.
> 
> There used to be a patch floating around to do policy for file caches 
> (or rather arbitary address spaces) It used special ELF headers to set 
> the policy. I thought about these policy EAs long ago. The main reason 
> I never liked them much is that on some EA implementations you have to 
> fetch an separate block to get at the EA. And this policy EA would 
> need to be read all the time, thus adding lots of additional seeks. 
> That didn't seem worth it.

EAs would be fine - and they dont have to be propagated down into the 
hierarchy. There's no reason to propagate them if the lack of EA means 
'inherit from parent'. Btw., not all filesystems need an extra block 
seek - e.g. ext3 embedds them nicely into the raw inode.

> >  - default: the vast majority of inodes would have no flag set
> > 
> >  - some would have a 'cache:local' flag
> > 
> >  - some would have a 'cache:global' flag
> 
> If you do policy you could as well do the full policy states from
> mempolicy.c. Both cache:local and cache:global can be expressed in it.

sure.

> > which would result in every inode getting flagged as either 'local' or 
> > 'global'. When the pagecache (and inode/dentry cache) gets populated, 
> > the kernel will always know what the current allocation strategy is for 
> > any given object:
> 
> In practice it will probably only set for a small minority of objects 
> if at all. I could imagine admining this policy could be a PITA too.

It's so much cleaner and more flexible. I bet it's even a noticeable 
speedup for users of the current cpuset-based approach: the cpuset 
method forces _all_ 'large' objects to be allocated in a spread-out 
form. While with the EA method you can pinpoint those few files (or 
directories) that include the data that needs the spreading out. E.g.  
/tmp would default to 'local' (unless the app creates a big /tmp file, 
for which it should set the spread-out attribute).

another thing: on NUMA, are the pagecache portions of readonly files 
(such as /usr binaries, etc.) duplicated across nodes in current 
kernels, or is it still random which node gets it? This too could be an 
EA caching attribute: whether to create per-node caches for file 
content.

This kind of stuff is precisely what EAs were invented for.

	Ingo
