Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbSJ1TqE>; Mon, 28 Oct 2002 14:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSJ1TqD>; Mon, 28 Oct 2002 14:46:03 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:23753 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261483AbSJ1TqC>; Mon, 28 Oct 2002 14:46:02 -0500
Message-ID: <3DBD9434.5050601@us.ibm.com>
Date: Mon, 28 Oct 2002 11:47:00 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: [rfc][patch] MAX_NR_NODES vs. MAX_NUMNODES
References: <3DB8927E.5090909@us.ibm.com> <20021025100028.A19335@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Oct 24, 2002 at 05:38:22PM -0700, Matthew Dobson wrote:
> 
>>Anyone who is more familiar with some of the architectures I mucked with 
>>(arm, alpha, ppc64), please let me know if what I've done looks wrong.
> 
> Well, this breaks ARM.  ARM needs MAX_NR_NODES even for the non-discontig
> mem case.  Also, I really don't like the idea of re-using param.h for
> something else - if its going to hoover up random constants, then its
> going to create the usual mess, where if you change one constant that's
> used in 1% of files, 100% of files gets rebuilt.
Hmmm...  MAX_NR_NODES is *definitely* available in the non-discontig 
case.  In include/linux/param.h, MAX_NR_NODES (ifndef'd) is defined to 
be 1.  This is the generic case.  linux/param.h first includes 
asm/param.h, so the architecture has the chance to define MAX_NR_NODES 
as appropriate for the specific arch.  Also, for clps711x and sa1100, 
MAX_NR_NODES is defined to be 4, as it NR_NODES was before the change. 
Are you sure this is really broken?  Have you tried out the patch?  I'd 
do it myself, but I don't have any access to appropriate machines.


> That is why arm has asm/memory.h to contain everything related to memory
> translation and discontig memory.
This isn't *just* a discontig change.  CONFIG_DISCONTIGMEM is a 
convenient option to key off of, but as the kernel becomes more and more 
NUMA aware, the number of nodes in the system becomes a useful bit of 
information to more and more of the code.  *That* is why (along with a 
suggestion from wli) I put the #defines in param.h.

> It would be better if it remained in mmzone.h for non-arm, and the
> memory.h files for arm.  I really never understood why numnodes.h was
> created when mmzone.h has works adequately well since 2.3.
The entire point of this patch is to make this sort of thing *more* 
consistent.  If this is really that bad for arm, then we can just forget 
the patch.  I have no desire to increase the complexity of this, or at 
best keep it the same.  As mentioned in the original post, I was trying 
to kill a bunch of (seemingly) unnecessary .h files (the numnodes.h's 
specifically), and remove the MAX_[NUM|NR_]NODES duality.  If that can't 
be accomplished, then all this would do is move the confusion around, 
and I don't want that...

If you feel param.h is the wrong place, I originally had the #define's 
in asm/topology.h.  I feel that is also an appropriate place, exists for 
every architecture, and my second choice.  I could fairly easily retool 
the patch to use that if that is decided to be more appropriate.

If you could give the patch a second read-through, noting the points in 
my first paragraph, I would really appreciate it.  If you still think 
it's broken, we can try and work out how to fix it, or we can drop it.

Cheers!

-Matt

