Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314610AbSEFRkz>; Mon, 6 May 2002 13:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314612AbSEFRky>; Mon, 6 May 2002 13:40:54 -0400
Received: from dsl-213-023-043-254.arcor-ip.net ([213.23.43.254]:20929 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314610AbSEFRkx>;
	Mon, 6 May 2002 13:40:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Mon, 6 May 2002 19:40:54 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E174Xc6-0004CU-00@starship> <20020506040622.J6712@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E174mTn-0004Kr-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This thread is already long enough, I propose that after your response
to this we take it private.  The executive summary of this post is:
"show me the code".

On Monday 06 May 2002 04:06, Andrea Arcangeli wrote:

> You can implement __va as you want, it doesn't need ot be a simple
> linear relation (see also the attached email from Roman),

Here's the relevant comment from Roman:

> I mean to map the memory where you need it. The physical<->virtual
> mapping won't be one to one, but you won't need another abstraction and
> the current vm is already basically able to handle it.
> 
> bye, Roman

Roman is talking about an implementation idea that so far hasn't been
presented in the form of working code.  I have already imlemented __va
as I want, it works, it's efficient, it's simple, clean, powerful and
extensible.  If Roman has an alternative, I'd be interested in looking
at the patch.

> but regardless
> what matters really is page_address and virt_to_page, not only __va,
> just initialize page->virtual to the static kernel window at boot time

OK, so you want to tie things to page->address.  It's an interesting
proposition, I'd like to see your code.

Keep in mind that your new use of page->address conflicts with the
current move to get rid of it from mainline, except for highmem use.
I also have doubts about the efficiency and cleanliness your proposal.
Your __pa and __va are going to get more expensive because they now
have to work through the struct page, requiring multiplies as well
as lookups.  I think you'll end up with something more complex and
less efficient than config_nonlinear - please prove me wrong by
showing me the code.

You also need some sort of structure that tells you how to set up your
static mapping in the kernel.  I already have that, you still need to
describe it.  In fact, config_nonlinear's way of doing the mem_map
initialization required no changes at all to the mem_map initialization
code.  Such results tend to suggest a particular design approach is
indeed correct.

Now, it would be interesting to see exactly what changes are required
to config_nonlinear to allow it to cover numa usage as well as
non-numa usage.  As far as I can see, I simply have to elaborate the
my mapping between pagenum and struct page, i.e., I have to do what's
necessary to put the mem_map structure into the local node.  I
believe that's possible without requiring any double table lookups.

Note that for NUMA-Q, the ->lmem_map arrays are currently off-node for
all but node zero, so the per-node ->lmem_map is doing nothing for
NUMA-Q at the moment.  In order for this to make sense for NUMA-Q, I
really do have to provide a local mapping of a portion of zone_numa,
otherwise we might as well just use config_nonlinear in its current
form.

-- 
Daniel
