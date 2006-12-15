Return-Path: <linux-kernel-owner+w=401wt.eu-S1751681AbWLOAfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWLOAfd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbWLOAfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:35:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45941 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbWLOAfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:35:32 -0500
Date: Thu, 14 Dec 2006 16:35:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Eric Dumazet" <dada1@cosmosbay.com>, "Greg KH" <gregkh@suse.de>,
       "Arjan" <arjan@linux.intel.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: kref refcnt and false positives
Message-Id: <20061214163519.9e5f4f64.akpm@osdl.org>
In-Reply-To: <m13b7ivwlw.fsf@ebiederm.dsl.xmission.com>
References: <EB12A50964762B4D8111D55B764A8454010572C1@scsmsx413.amr.corp.intel.com>
	<m13b7ivwlw.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 17:19:55 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> writes:
> 
> >>But I believe Venkatesh problem comes from its release() 
> >>function : It is 
> >>supposed to free the object.
> >>If not, it should properly setup it so that further uses are OK.
> >>
> >>ie doing in release(kref)
> >>atomic_set(&kref->count, 0);
> >>
> >
> > Agreed that setting kref refcnt to 0 in release will solve the probloem.
> > But, once the optimization code is removed, we don't need to set it to
> > zero as release will only be called after the count reaches zero anyway.
> 
> The primary point of the optimization is to not write allocate a cache line
> unnecessarily.   I don't know it's value, but it can have one especially
> on big way SMP machines.

Guys, we have about 1000000000000000000000000000000 reports of weirdo
crashes, smashes, bashes and splats in the kref code.  The last thing we
need is some obscure, tricksy little optimisation which leads legitimate
uses of the API to mysteriously fail.  

If we are allocating and freeing kref-counted objects at a sufficiently
high frequency for this thing to make a difference then we should fix that
instead of trying to suck faster.
