Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUHBS72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUHBS72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 14:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUHBS72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 14:59:28 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:13704 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261638AbUHBS7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 14:59:24 -0400
Date: Mon, 2 Aug 2004 19:57:47 +0100
From: Dave Jones <davej@redhat.com>
To: Ian Romanick <idr@us.ibm.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
Subject: Re: DRM code reorganization
Message-ID: <20040802185746.GA12724@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ian Romanick <idr@us.ibm.com>, Jon Smirl <jonsmirl@yahoo.com>,
	lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
	DRI developer's list <dri-devel@lists.sourceforge.net>
References: <20040802155312.56128.qmail@web14923.mail.yahoo.com> <410E81C3.2070804@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410E81C3.2070804@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 11:02:43AM -0700, Ian Romanick wrote:

 > This would be *very* non-trivial to do.  Doing the DRM like this has 
 > come up probably a dozen times (or more) over the last 3 years.

Which should ring alarm bells that something might not be quite right.

 > The problem is that each driver has different needs based on hardware 
 > functionality.

How does this differ from any other subsystem that supports
cards with features that may not be present in another model ?
Other subsystems have dealt with this problem without the need
to introduce horrors like the abstractions in DRM.
 
 > We've managed to classify these needs into a few groups, 
 > and drivers can select which functionality they need via a set of 
 > defines.  These per-driver defines determine what code gets compiled 
 > into the different routines (as well as which routines even get built).

And among other horrors, crap like typedef's that magically change their
type completely depending on which file they are #include'd into.
Overuse of typedefs is one thing, but what goes on with stuff like
DRIVER_BUF_PRIV_T is bordering on obscene.

If this kind of abuse wasn't so widespread, abstracting this code
out into shared sections and driver specific parts would be a lot
simpler. Sadly, this is the tip of the iceberg.

 > Trying to make this into a library would just be a mess.

Depends on which direction you're looking at things.
>From the view of many kernel developers, anything would be
better than the trainwreck of wrappers/macros/preprocessor abuse
that's there right now.  I'd put money on a lot more people being
prepared to hack on DRM's kernel code if it were more readable.

To give an example of just how bad some folks view on this code is:
An actual conversation at OLS last week..
"I found it easier to look at the C preprocessor output than the
 actual source code to find the types of the variables I was looking at".

 > If this is something that we really want to pursue, someone needs to dig 
 > in and figure out:
 > 
 > 1. How much / which code can be "trivially" shared?
 > 2. How much / which code can be shared with very little work?
 > 3. How much / which code would we rather get a root-canal than try to 
 > make shared?
 > 
 > The concern has been that, by making a "generic" library layer, we'd 
 > actually make the DRM more difficult to maintain.

I don't maintain upstream DRM, but I have a fair amount of responsibility
regarding the Fedora kernel, and I'll state publically that looking at
bugs in drivers/char/drm is right up there on my list of
"things I'd rather not do after lunch". Maintainability goes much
further than 'the guy that wrote the code can grok it'.

People trying to pick up 3d driver programming on Linux have a huge
hurdle in their place, as that code resembles *NO OTHER* driver code
in the tree.

 > Nobody has really had 
 > the time to do the research required to either substantiate or refute 
 > those claims.  Based on the little experience I have in the DRM, I tend 
 > to believe them.

I spent 2-3 days a few months back attempting to clean up some of the
goo, by peeling away the layers of abstraction.  After the 3rd day,
I'd estimate I wasn't even a fraction of the way through, and I lost
the will to keep fighting.

 > >ian: what about splitting the current memory management code into a
 > >module that can be swapped for your new version?
 > 
 > AFAIK, the only drivers that have any sort of in-kernel memory manager 
 > are the radeon (only used by the R200 driver) and i830.

ISTR SiS has some memory management code too, though I've not looked
too closely at that for a long time.

		Dave

