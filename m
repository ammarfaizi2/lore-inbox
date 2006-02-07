Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWBGJld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWBGJld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWBGJk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:40:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:156 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932458AbWBGJkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:40:32 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Tue, 7 Feb 2006 10:31:39 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, clameter@engr.sgi.com, akpm@osdl.org,
       dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <20060206154537.a3e8cc25.pj@sgi.com> <20060207001902.GA18830@elte.hu>
In-Reply-To: <20060207001902.GA18830@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071031.40346.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 01:19, Ingo Molnar wrote:
> 
> * Paul Jackson <pj@sgi.com> wrote:
> 
> > First it might be most useful to explain a detail of your proposal 
> > that I don't get, which is blocking me from considering it seriously.
> > 
> > I understand mount options, but I don't know what mechanisms (at the 
> > kernel-user API) you have in mind to manage per-directory and per-file 
> > options.
> 
> well, i thought of nothing overly complex: it would have to be a 
> persistent flag attached to the physical inode. Lets assume XFS added 
> this - e.g. as an extended attribute.

There used to be a patch floating around to do policy for file caches
(or rather arbitary address spaces)
It used special ELF headers to set the policy. I thought about these policy EAs 
long ago. The main reason I never liked them much is that on some EA
implementations you have to fetch an separate block to get at the EA.
And this policy EA would need to be read all the time, thus adding lots
of additional seeks. That didn't seem worth it.


>  - default: the vast majority of inodes would have no flag set
> 
>  - some would have a 'cache:local' flag
> 
>  - some would have a 'cache:global' flag

If you do policy you could as well do the full policy states from
mempolicy.c. Both cache:local and cache:global can be expressed in it.

> which would result in every inode getting flagged as either 'local' or 
> 'global'. When the pagecache (and inode/dentry cache) gets populated, 
> the kernel will always know what the current allocation strategy is for 
> any given object:

In practice it will probably only set for a small minority of objects
if at all. I could imagine admining this policy could be a PITA too.

> workloads may share the same object and may want to use it in different 
> ways. E.g. there's one big central database file, and one job uses it in 
> a 'local' way another one uses it in a 'global' way. Each job would  
> have to set the attribute to the right value. Setting the flag for the 
> inode results in all existing pages for that inode to be flushed. The 
> jobs need to serialize their access to the object, as the kernel can 
> only allocate according to one policy.

I think we are much better off with some sensible defaults for file cache

- global or "nearby" for read/write
- global for inode/dcache
- local for mmap file data

I bet that will cover most cases quite nicely.

-Andi

