Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267322AbUGNI2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267322AbUGNI2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 04:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267318AbUGNI2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 04:28:17 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:32385 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267325AbUGNI0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 04:26:32 -0400
Date: Wed, 14 Jul 2004 13:56:22 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040714082621.GA4291@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714070700.GA12579@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 12:07:00AM -0700, Greg KH wrote:
> On Wed, Jul 14, 2004 at 10:23:50AM +0530, Ravikiran G Thirumalai wrote:
> > 
> > The attatched patch provides infrastructure for refcounting of objects
> > in a rcu protected collection.
> 
> This is really close to the kref implementation.  Why not just use that
> instead?

Well, the kref has the same get/put race if used in a lock-free
look-up. When you do a kref_get() it is assumed that another
cpu will not see a 1-to-0 transition of the reference count.
If that indeed happens, ->release() will get invoked more
than once for that object which is bad. Kiran's patch actually
solves this fundamental lock-free ref-counting problem.

The other issue is that there are many refcounted data structures
like dentry, dst_entry, file etc. that do not use kref. If everybody
were to use kref, we could possibly apply Kiran's lock-free extensions
to kref itself and be done with it. Until then, we need the lock-free
refcounting support from non-kref refcounting objects.

Thanks
Dipankar
