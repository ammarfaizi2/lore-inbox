Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWDZHUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWDZHUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 03:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWDZHUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 03:20:33 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:48323 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751086AbWDZHUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 03:20:33 -0400
Date: Wed, 26 Apr 2006 15:20:30 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: Greg KH <greg@kroah.com>
Cc: Jens Axboe <axboe@suse.de>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 3/3] use kref for bio
Message-ID: <20060426072030.GA7693@miraclelinux.com>
References: <20060426021059.235216000@localhost.localdomain> <20060426021122.069267000@localhost.localdomain> <20060426022635.GF27946@ftp.linux.org.uk> <20060426051344.GT4102@suse.de> <20060426051813.GB332@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426051813.GB332@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 10:18:13PM -0700, Greg KH wrote:
> > > Let's _not_.  It's extra overhead for no good reason.
> > 
> > Completely agree. That goes for the other block layer kref patches as
> > well.
> 
> I also agree, there's a reason I never tried to convert them in the past
> :)

kref has faster function for decrement refcount.

kref_put()
{
...

	/*
	 * if current count is one, we are the last user and can release object
	 * right now, avoiding an atomic operation on 'refcount'
	 */
	if ((atomic_read(&kref->refcount) == 1) ||
		(atomic_dec_and_test(&kref->refcount))) {
		release(kref);
		return 1;
	}

If this is good one and the places where Al Viro pointed out really affect
performance, should we propagate this faster one by introducing helper
function like:

static inline int refcount_test(atomic_t *refcount)
{
	return (atomic_read(refcount) == 1) || (atomic_dec_and_test(refcount));
}

and replace atomic_dec_and_test with it?

