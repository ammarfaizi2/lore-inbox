Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbREYS5E>; Fri, 25 May 2001 14:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261681AbREYS4z>; Fri, 25 May 2001 14:56:55 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:59088 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261666AbREYS4q>; Fri, 25 May 2001 14:56:46 -0400
Date: Fri, 25 May 2001 16:45:05 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
Message-ID: <20010525164505.J7952@redhat.com>
In-Reply-To: <20010523205748.L8080@redhat.com> <Pine.LNX.4.31.0105231258420.6642-100000@penguin.transmeta.com> <20010524123627.L27177@redhat.com> <m1bsohh3da.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1bsohh3da.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Fri, May 25, 2001 at 09:09:37AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 25, 2001 at 09:09:37AM -0600, Eric W. Biederman wrote:

> The case we don't get quite right are partial reads that hit cached
> data, on a page that doesn't have PG_Uptodate set.  We don't actually
> need to do the I/O on the surrounding page to satisfy the read
> request.  But we do because generic_file_read doesn't even think about
> that case.

That's *precisely* the case in question.  The whole design of the page
cache involves reading entire pages at a time, in fact.  We _could_
read in only partial pages, but in that case we end up wasting a lot
of the page.

> For the small random read case we could use a 
> mapping->a_ops->readpartialpage 
> function that sees if a request can be satisfied entirely 
> from cached data.  But this is just to allow generic_file_read
> to handle this, case. 

Agreed.  The only case where blockdev-in-pagecache really results in
significantly more IO is partial writes followed by partial reads.
Reads from totally-uncached pages ought to just fill the entire page
from disk; it's only when there is something already present
in the cache for that page that we want to look for partial buffers.

--Stephen
