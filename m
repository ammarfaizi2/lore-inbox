Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUHCHst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUHCHst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 03:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUHCHst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 03:48:49 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:39150 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265098AbUHCHsp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 03:48:45 -0400
Date: Tue, 3 Aug 2004 13:15:14 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Add kref_read and kref_put_last primitives
Message-ID: <20040803074514.GA4432@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040726144856.GH1231@obelix.in.ibm.com> <20040726173151.A11637@infradead.org> <20040802200849.GG28374@kroah.com> <20040803054218.GA4443@in.ibm.com> <20040803065130.GA10696@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803065130.GA10696@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 11:51:30PM -0700, Greg KH wrote:
> On Tue, Aug 03, 2004 at 11:12:18AM +0530, Dipankar Sarma wrote:
> 
> > So, kref_read() as it is would look weird. But if we consider merging
> > the rest of the kref APIs (lock-free extensions) in future, then the
> > entire set including kref_read() would make sense.
> 
> No, even with rcu versions, I don't see the need for this in the api.

I agree that RCU versions really doesn't need it. However, there
is code in many places in the kernel where we actually read
the actual reference count value and even compare it with
constants. Those things are problematic because you can't
use kref there without a kref_read_count() type API.
In typical driver object maintenance, this is not an issue
and rightly not exported.

> Sure, for this specific implementation of a atomic_t, it is useful, as
> the value is checked.  But that means that you might just want to use an
> atomic_t, as it doesn't fit the model of a struct kref at all (something
> where you don't touch the reference count directly at all.)

Which prevents it from being used in many objects where we touch
the reference count directly. If we use atomic_t there, then we
need to abstract out inc/dec for RCU, which results in another
refcounter which you don't like (for good reasons, btw) ;-) 

> Becides, I don't think that people are convinced that this code needs to
> be changed anyway :)

Which code ? If you are talking about the lock-free fd lookup
code, think POSIX threaded apps doing lots of I/O. tiobench
results show how useful it is.

Thanks
Dipankar
