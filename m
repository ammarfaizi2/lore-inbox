Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVBJAPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVBJAPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 19:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVBJAPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 19:15:20 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:45189 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261982AbVBJAPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 19:15:02 -0500
Date: Thu, 10 Feb 2005 01:14:43 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Larry McVoy <lm@bitmover.com>
cc: Nicolas Pitre <nico@cam.org>, Jon Smirl <jonsmirl@gmail.com>,
       tytso@mit.edu, Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Linux Kernel Subversion Howto
In-Reply-To: <20050209235312.GA25351@bitmover.com>
Message-ID: <Pine.LNX.4.61.0502100109050.6118@scrub.home>
References: <20050209184629.GR22893@bitmover.com>
 <Pine.LNX.4.61.0502091513060.7836@localhost.localdomain>
 <20050209235312.GA25351@bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Feb 2005, Larry McVoy wrote:

(I just sent a similiar mail in private and didn't immediately realize it 
didn't went to lkml, so sorry, who gets it twice.)

> On Wed, Feb 09, 2005 at 03:13:48PM -0500, Nicolas Pitre wrote:
> > I think what people want here is the tree structure representation in
> > whatever form, not necessarily in the BK format.  
> 
> That's fine, they can do that.  Get the patches and figure out how to
> put them back together.  These people do know how to use patch, right?
> OK, then they are welcome to patch things in, when they don't work, find
> a place they do work and create a branch, patch them, repeat.  Haven't
> they ever dealt with a patch reject before?  It's not that hard.

No, just impossible.

As I mentioned already previously, the main problem is restoring the 
changeset information, so one actually knows how the kernel tree looked at 
a specific point. I also mentioned that it's not really possible to find 
for all changesets their parent changesets, e.g. changeset 1.889 has 416 
branches which include 3560 changesets, that means some of the branches 
have over 3000 potential parents. Due to parallel changes to a file on 
multiple branches one can reduce that number, but it's likely still 
greater than one.

Now for a while I hoped to at least find the end of branch, that means 
where two branches get merged again. The gnupatches contain some 
information of what they merge, so that one could use the log text to find 
the changeset. The problem is that even these gnupatches don't contain 
information to reliable find its parents. First, they don't include other 
merge logs, so there are again multiple potential parents if there are 
merge changeset near the changeset identified by the log text. Second, 
there are completely empty changesets with no log text and so no 
indication what they are merging, I currently have 171 of them and of 
these 13 are at a start of the branch (and therefore have no usable 
information at all of either parent).

So why is this parent information so important? If the patches are not 
applied in the correct order, one simply gets the wrong kernel snapshot. 
What makes this more difficult are the merge changesets, as they don't 
contain the complete information of what has changed compared to one of 
the parents, they just contain the file conflicts. If one had the correct 
parent information this would not be a problem, repeating the merge is 
one of the smaller problems. But with fuzzy parent information one also 
only gets fuzzy merge results and if the parents have n potential parents 
that results in n^2 possible merge results in the worst case. Since the 
merge changeset only contains conflict information, that makes it rather 
likely one detects a problem (e.g. that a changeset doesn't apply) very 
late. So if one detects such problem after m merges, we have a worst case 
of n^(m+1). IOW the complexity of a bkweb export grows exponentially with 
the size of the repository! And there is still no guarantee to get a 
correct (that means only one) result.
So doing the work is one thing, getting a result within my lifetime would 
be nice too.

bye, Roman
