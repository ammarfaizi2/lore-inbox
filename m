Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVCVKMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVCVKMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVCVKLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:11:02 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33709 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262603AbVCVKJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:09:54 -0500
Date: Tue, 22 Mar 2005 10:09:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [6/9] [RFC] Steps to fixing the driver model locking
Message-ID: <20050322100952.GA15582@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Mochel <mochel@digitalimplant.org>,
	linux-kernel@vger.kernel.org, greg@kroah.com
References: <Pine.LNX.4.50.0503211245530.20647-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0503211245530.20647-100000@monsoon.he.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 12:48:47PM -0800, Patrick Mochel wrote:
> 
> ChangeSet@1.2235, 2005-03-21 11:45:16-08:00, mochel@digitalimplant.org
>   [klist] Add initial implementation of klist helpers.

>   This klist interface provides a couple of structures that wrap around
>   struct list_head to provide explicit list "head" (struct klist) and
>   list "node" (struct klist_node) objects. For struct klist, a spinlock
>   is included that protects access to the actual list itself.

Not sure this is a good idea.  Usually you want a lock protect slightly
more than just list operations, e.g. refcounting of objects in list,
some short-term manipulations, etc.

>   struct
>   klist_node provides a pointer to the klist that owns it and a kref
>   reference count that indicates the number of current users of that node
>   in the list.
> 
>   The entire point is to provide an interface for iterating over a list
>   that is safe and allows for modification of the list during the
>   iteration (e.g. insertion and removal), including modification of the
>   current node on the list.
> 
>   It works using a 3rd object type - struct klist_iter - that is declared
>   and initialized before an iteration. klist_next() is used to acquire the
>   next element in the list. It returns NULL if there are no more items.
>   This klist interface provides a couple of structures that wrap around
>   struct list_head to provide explicit list "head" (struct klist) and
>   list "node" (struct klist_node) objects. For struct klist, a spinlock
>   is included that protects access to the actual list itself. struct
>   klist_node provides a pointer to the klist that owns it and a kref
>   reference count that indicates the number of current users of that node
>   in the list.

Yikes.  It's really not that hard to get traversal of a refcounted list
right, and you're adding lots of obsfucation over that rather easy thing.
The driver model and kfoo stuff already got us lots of layer of obsfucation,
but we should really stop at some point where it makes the underlying
operations much more complicated.

>   There are primitives for adding and removing nodes to/from a klist.
>   When deleting, klist_del() will simply decrement the reference count.
>   Only when the count goes to 0 is the node removed from the list.

This sounds rather odd, and doesn't make much sense to me.  In all cases
I've seen you want to disallow lookup imediately (list_del), which is
completly separate from object lifetime rules.

