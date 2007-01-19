Return-Path: <linux-kernel-owner+w=401wt.eu-S932477AbXASQYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbXASQYJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 11:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbXASQYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 11:24:09 -0500
Received: from ns1.coraid.com ([65.14.39.133]:20153 "EHLO coraid.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932477AbXASQYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 11:24:08 -0500
Date: Fri, 19 Jan 2007 11:21:08 -0500
From: "Ed L. Cashin" <ecashin@coraid.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       xfs@oss.sgi.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re: bio pages with zero page reference count
Message-ID: <20070119162108.GG16715@coraid.com>
Reply-To: support@coraid.com
References: <20061209234305.c65b4e14.akpm@osdl.org> <20061218175300.GM23156@coraid.com> <20061218222109.GA23156@coraid.com> <20061218225343.GA30167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218225343.GA30167@infradead.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 10:53:43PM +0000, Christoph Hellwig wrote:
> On Mon, Dec 18, 2006 at 05:21:09PM -0500, Ed L. Cashin wrote:
...
> > If anyone has a better reference, I'd like to see it.
> 
> I searched around a little bit and found these:
> 
> 	http://groups.google.at/group/open-iscsi/browse_frm/thread/17fbe253cf1f69dd/f26cf19b0fee9147?tvc=1&q=kmalloc+iscsi+%22christoph+hellwig%22&hl=de#f26cf19b0fee9147
> 	http://www.ussg.iu.edu/hypermail/linux/kernel/0408.3/0061.html
> 
> But that's not the conclusion I was looking for.  

So it sounds like you've been advocating a general discussion of this
issue for a few years now.

To summarize the issue:

  1) users of the block layer assume that it's fine to associate pages
     that have a zero reference count with a bio before requesting
     I/O,

  2) intermediaries like iscsi, aoe, and drbd, associate the pages
     with the frags of skbuffs, but

  3) when the network layer has to linearize the skbuff for a network
     device that doesn't support scatter gather, it winds up doing a
     get_page and put_page on each page in the frags, despite the fact
     that the page reference count on each may already be zero.  The
     network layer is assuming that it's OK to do use these operations
     on any page in the frags.

Maybe the discussion is slow to start because too many parts of the
kernel are involved.  Here are a couple of specific questions.  Maybe
they'll help get the ball rolling.

 1) What are the disadvantages of making the network layer *not*
    to assume it's correct to use get/put_page on the frags when it
    linearizes an sk_buff?

    For example, the network layer could omit the get/put_page when
    the page reference count is zero.

 2) What are the disadvantages of having one part of the kernel (e.g.,
    XFS) reference a page before handing it off to another part of the
    kernel, e.g., in a bio?

    This change would require multiple parts of the kernel to change
    behavior, but it seems conceptually cleaner, since the reference
    count would reflect the reality that the page does have an owner
    (XFS or whoever).  I don't know how practical the implementation
    would be.

 3) It seems messy to handle this is in each of the individual
    intermediary drivers that sit between the block and network
    layers, but if that really is the place to do it, then is there a
    problem with simply incrementing the page reference counts upon
    getting a bio from the block layer, and later decrementing them
    before giving them back with bio_endio?

        bio_for_each_segment(bv, bio, i)
                atomic_inc(&bv->bv_page->_count);

    ... [and later]

        bio_for_each_segment(bv, bio, i)
                atomic_dec(&bv->bv_page->_count);

        bio_endio(bio, bytes_done, error);

    That seems to eliminate problems aoe users have with XFS on AoE
    devices that are accessible via network devices that don't support
    scatter gather, but is it the right fix?

    Andrew Morton changed "count" to "_count" to stop folks from
    directly manipulating the page struct member, but I don't see any
    get/put_page type operations that fit what the aoe driver has to
    do in this case.

-- 
  Ed L Cashin <ecashin@coraid.com>
