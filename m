Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVAMWNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVAMWNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVAMWNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:13:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:20928 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261693AbVAMV5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:57:31 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] dm snapshot problem
Date: Thu, 13 Jan 2005 15:58:20 -0600
User-Agent: KMail/1.7.1
Cc: Dave Olien <dmo@osdl.org>,
       "Rajesh S. Ghanekar" <rajesh_ghanekar@persistent.co.in>,
       DevMapper <dm-devel@redhat.com>, LKML <linux-kernel@vger.kernel.org>
References: <41E35950.9040201@persistent.co.in> <41E5116E.7000709@persistent.co.in> <20050112183549.GA14782@osdl.org>
In-Reply-To: <20050112183549.GA14782@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501131558.20075.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 January 2005 12:35 pm, Dave Olien wrote:
> I haven't looked at these numbers enough yet.  But it reminds me a lot
> of the "congestion" problem I described last summer.  What I saw was
> that the system ran out of bio structures in the global bio pool.
>
> The dm code has tried to avoid deadlock condition on bio pool exhaustion
> by creating local pools of bio structures for the cases where it needs
> to initiate new IO.  But I found a deadlock case that was missed
> (bio_alloc() call in dm.c, I think).  So the global bio pool exhaustion
> lead to deadlock.

Yep. This is one of the reasons we need to move the bio_set stuff from dm-io.c 
to bio.c so it becomes much easier for DM and other drivers to create new 
mempools for bios. Obviously you're already pondering that. :)

> The other I think is to improve the congestion control mechanism.
>
> The congestion case is basically this:  With snapshot enabled, every
> write to the origin must first spawn an additional read from the origin
> and a write to the snapshot volume.  So now every origin write becomes a
> read and two writes. Two new bio structures need to be allocated.

Well, yes and no. One incoming write can kick off a chunk-copy, but additional 
incoming writes to that same chunk will be queued on the already-in-progress 
copy job. And yes, we allocate new bios to do the copying of these chunks, 
but those bios come from the private bio pools in dm-io.c, not the global 
pool. And the bio for the read side of the copy is released back to the pool 
before the write side of the copy begins.

Another thing I just noticed is that each snapshot device pre-allocates a 
fixed number of pages (currently #define'd to 256) to actually hold chunk 
data that is being copied. This means that only a limited number of 
chunk-copies can be going on at a time, since kcopyd will effectively stop 
processing copy jobs for that snapshot until some of those data pages are 
freed (when a copy completes). This means the congestion could be even worse 
than I originally anticipated, since we aren't even driving all the possible 
copy jobs that we could be.

Also, kcopyd and dm-io certainly don't seem to be considering any of the 
congestion info from the lower-level devices, since they aren't going through 
the page-cache. They're just putting together bios and sending them down with 
submit_bio(). Not sure what kind of affect that is going to have.

Now my head is spinning. :)

> But the congestion feedback mechanism that's in dm right now doesn't
> do anything to keep the list of bio's submitted to the origin volume
> from consuming all of the global bio pool.  It only looks at the
> pending IO list down at the destination disks.  It doesn't look at
> the IO's in progress at the higher levels.  This triggers the deadlock
> case I mentioned above.

Yep, that sounds pretty similar to what I just told akpm. :)  I really should 
read through the whole thread before replying to individual posts.

Obviously DM's congestion handling needs some work. See my earlier reply for 
my thoughts on how we might do this.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
