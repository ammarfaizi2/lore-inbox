Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132057AbRAXAfa>; Tue, 23 Jan 2001 19:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132196AbRAXAfU>; Tue, 23 Jan 2001 19:35:20 -0500
Received: from diver.doc.ic.ac.uk ([146.169.1.47]:31760 "EHLO
	diver.doc.ic.ac.uk") by vger.kernel.org with ESMTP
	id <S132126AbRAXAfP>; Tue, 23 Jan 2001 19:35:15 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: limit on number of kmapped pages
In-Reply-To: <y7rsnmav0cv.fsf@sytry.doc.ic.ac.uk>
	<m1r91udt59.fsf@frodo.biederman.org>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 24 Jan 2001 00:35:12 +0000
In-Reply-To: ebiederm@xmission.com's message of "23 Jan 2001 11:23:46 -0700"
Message-ID: <y7rofwxeqin.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:
> Why do you need such a large buffer? 

ext2 doesn't guarantee sustained write bandwidth (in particular,
writing a page to an ext2 file can have a high latency due to reading
the block bitmap synchronously).  To deal with this I need at least a
2MB buffer.

I've modifed ext2 slightly to avoid that problem, but I still expect
to need a 512KB buffer (though the usual requirements are much lower).
While that wouldn't hit the kmap limit, it would bring the system
closer to it.

Perhaps further tuning could reduce the buffer needs of my
application, but it is better to have the buffer too big than too
small.

> And why do the pages need to be kmapped? 

They only need to be kmapped while data is being copied into them.

> If you are doing dma there is no such requirement...  And
> unless you are running on something faster than a PCI bus I can't
> imagine why you need a buffer that big. 

Gigabit ethernet.

> My hunch is that it makes
> sense to do the kmap, and the i/o in the bottom_half.  What is wrong
> with that?

Do you mean kmap_atomic?  The comments around kmap don't mention
avoiding it in BHs, but I don't see what prevents kmap -> kmap_high ->
map_new_virtual -> schedule.

> kmap should be quick and fast because it is for transitory mappings.
> It shouldn't be something whose overhead you are trying to avoid.  If
> kmap is that expensive then kmap needs to be fixed, instead of your
> code working around a perceived problem.
> 
> At least that is what it looks like from here.

When adding the kmap/kunmap calls to my code I arranged them so they
would be used as infrequently as possible.  After working on making
the critical paths in my code fast, I didn't want to add operations
that have an uncertain cost into those paths unless there is a good
reason.  Which is why I'm asking how significant the kmap limit is.



David Wragg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
