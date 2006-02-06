Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWBFJiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWBFJiS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWBFJiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:38:18 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:65423 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750854AbWBFJiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:38:18 -0500
Date: Mon, 6 Feb 2006 10:37:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206093701.GA16357@elte.hu>
References: <20060205220204.194ba477.akpm@osdl.org> <20060206061743.GA14679@elte.hu> <20060205232253.ddbf02d7.pj@sgi.com> <20060206074334.GA28035@elte.hu> <20060206001959.394b33bc.pj@sgi.com> <20060206082258.GA1991@elte.hu> <20060206084001.GA5600@elte.hu> <20060206010304.e79ca2e5.pj@sgi.com> <20060206090927.GA11933@elte.hu> <20060206012726.e3c7a537.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206012726.e3c7a537.pj@sgi.com>
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


* Paul Jackson <pj@sgi.com> wrote:

> Ingo asked:
> > what type of objects need to be spread (currently)? It seems that your 
> > current focus is on filesystem related objects: 
> 
> In addition to the filesystem related objects called out in this 
> current patch set, we also have some xfs directory and inode caches.  
> An xfs patch is winding its way toward lkml that will enhance the xfs 
> cache creation calls a little, so that we can pick off the particular 
> slab caches we need to be able to spread, while leaving other xfs slab 
> caches with the default node-local policy.
> 
> >  does any userspace mapped memory need to be spread 
> 
> I don't think so, but I am not entirely confident of my answer 
> tonight.  I would expect the applications I care about to place mapped 
> pages by being careful to make the first access (load or store) of 
> that page from a cpu on the node where they wanted that page placed.
> 
> So, yes, either mostly filesystem related objects, or all such.
> 
> I'm not sure which.

if that's the case, then i think the best way to express this would be 
to categorize file objects into two groups: "global" (spread-out) and 
"local". Since filesystem space is already categorized per-project, this 
is also practical for the admin to do.

i.e. mountpoints/directories/files would get a 'locality of reference' 
attribute, and whenever the VFS allocates memory related to those files, 
it will do so based on the attribute. (The attribute is inherited deeper 
in the hierarchy - i.e. setting a 'global' attribute for a mountpoint 
makes all files within that filesystem spread-out.)

this is much cleaner i think, and easy/intuitive to configure. This 
would have performance advantages over your current approach as well: 
e.g. /tmp would always stay "local", in all cpusets - while with your 
current patch they are spread out. Bigger applications (like databases) 
would set this attribute themselves - but sysadmins would do it too, on 
shared boxes.

	Ingo
