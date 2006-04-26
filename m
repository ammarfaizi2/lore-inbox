Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWDZHjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWDZHjr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 03:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWDZHjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 03:39:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35461 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751118AbWDZHjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 03:39:47 -0400
Date: Wed, 26 Apr 2006 08:39:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: Greg KH <greg@kroah.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 3/3] use kref for bio
Message-ID: <20060426073944.GL27946@ftp.linux.org.uk>
References: <20060426021059.235216000@localhost.localdomain> <20060426021122.069267000@localhost.localdomain> <20060426022635.GF27946@ftp.linux.org.uk> <20060426051344.GT4102@suse.de> <20060426051813.GB332@kroah.com> <20060426072030.GA7693@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426072030.GA7693@miraclelinux.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 03:20:30PM +0800, Akinobu Mita wrote:
> If this is good one and the places where Al Viro pointed out really affect
> performance, should we propagate this faster one by introducing helper
> function like:
> 
> static inline int refcount_test(atomic_t *refcount)
> {
> 	return (atomic_read(refcount) == 1) || (atomic_dec_and_test(refcount));
> }
> 
> and replace atomic_dec_and_test with it?

No.  It's obviously slower than atomic_dec_and_test() if refcount is
greater than 1.  And I'm less than sure that you can show that benefits
in case when it is 1 outweight that.  Moreover, for dentries, inodes,
superblocks and vfsmounts you'd have to pull spin_lock() in front of
it, which would _definitely_ hurt (these are atomic_dec_and_lock()).
