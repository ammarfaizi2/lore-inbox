Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbTFBXUq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 19:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbTFBXUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 19:20:46 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:37012
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264210AbTFBXUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 19:20:45 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
Subject: Re: BKCVS issue
Date: Mon, 2 Jun 2003 19:37:02 -0400
User-Agent: KMail/1.5
References: <20030602211436.GF14878@vitelus.com>
In-Reply-To: <20030602211436.GF14878@vitelus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306021937.03013.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 June 2003 17:14, Aaron Lehmann wrote:
> For the past few days, it seems like every time something changes in
> BK, the bkcvs repository has all of its files touched. At least, all
> files in the repository have a P preceding their names on a cvs up.
>
> It's not intolerable, but I was wondering if anyone's aware of it.

CVS thinks of changes as having been applied in a certain order, with each 
cange applying to the result of previous changes.

Bitkeeper does not.  Each change applies to a historical version of the tree, 
and when it gets two sets of changes based on the same historical tree 
neither one of them goes "before" the other, they both apply to the old tree.  
(This isn't a linear process, it's lots and lots of branches.  Conflicts 
don't come up at this point, think quantum indeterminacy and the trousers of 
time and all that.)

So finally, when you want to know what the code looks like with all the 
changes added, THEN it has to figure out what order the patches have to go in 
to make some sort of sense.  And it has to do that again the next time you 
ask what the tree looks like, because if you add new changes that are based 
on older versions of the tree, they don't go AFTER the most recent changes, 
they get stuck in before and the more recent changes apply to them as well.

Think about how you work:

Original: foo=bar+baz+1
Patch 1 (vs original):  foo=bar-baz+1
Patch 2 (vs original):  foo=bar+fred+1
Result with both changes applied: foo=bar-fred+1

You can come up with the result because you know what the original looked 
like.  The first batch said you should subtract the second variable rather 
than adding it, and the second patch said you should rename the second 
variable "fred".  If you do BOTH, you subtract fred.  But you can't figure 
out what each patch means without looking at the original, not just at the 
results of the previous patch.  This is the fundamental problem with purely a 
linear approach like CVS: you either get patch 2 stomping patch 1, or vice 
versa, or a "it just doesn't apply" error.

Creating a linear set of changes by coming up with a sane order to do it in, 
and adjusting later ones to take earlier ones into account, isn't that hard.  
But when you add more intermediate patches between point A and point B and 
come up with a new list, the new intermediate patches don't naturally go on 
the end, they go in the middle somewhere (since that's the version the 
changes were done against), and they may affect several of the patches after 
them slightly.

This is why the CVS repository has to be recreated from scratch every time.  
It's like the difference between a typewriter and a word processor, when you 
insert in the middle of the paragraph everything after it gets wordwrapped 
differently.  CVS is a typewriter that can only type at the end, and has to 
stick "errata" and correction notices at the end of the book you're writing 
to keep track of any changes you make.  Bitkeeper is more like a word 
processor, where the order changes are made in doesn't matter so much because 
it doesn't have to wordwrap the sucker into its final form until you're done.

Rob
