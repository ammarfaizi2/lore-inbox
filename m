Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWDCVST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWDCVST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 17:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWDCVST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 17:18:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8672 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751707AbWDCVSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 17:18:18 -0400
Date: Mon, 3 Apr 2006 14:18:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: ntl@pobox.com, pj@sgi.com, linuxppc-dev@ozlabs.org, ak@suse.com,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Message-Id: <20060403141834.31cd9dea.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604031104110.20903@schroedinger.engr.sgi.com>
References: <20060402213216.2e61b74e.akpm@osdl.org>
	<Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
	<20060402221513.96f05bdc.pj@sgi.com>
	<Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com>
	<20060403141027.GB25663@localdomain>
	<Pine.LNX.4.64.0604031039560.20648@schroedinger.engr.sgi.com>
	<20060403180131.GD25663@localdomain>
	<Pine.LNX.4.64.0604031104110.20903@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Mon, 3 Apr 2006, Nathan Lynch wrote:
> 
> > > There are many other for_each_*_cpu loops in the kernel that do not have 
> > > any of the instrumentation you suggest. I suggest you come up with a 
> > > general solution and then go through all of them and fix this. Please be 
> > > aware that many of these loops are performance critical.
> > 
> > But this one isn't, right?
> 
> Right. One could use more expensive processing here.

Hopefully none of the for_each_foo() loops are performance-critical - those
things are expensive.

> > And I'm afraid there's a misunderstanding here -- only
> > for_each_online_cpu (or accessing the cpu online map in general) has
> > such restrictions -- for_each_possible_cpu doesn't require any locking
> > or preempt tricks since cpu_possible_map must not change after boot.

for_each_present_cpu() presumably has the same problems.

> Correct. We may want to audit the kernel and check that each 
> for_each_possible_cpu or for_each_cpu is really correct.

A fair bit of that has been happening in recent weeks.

But yes, we should be protecting these things with rcu_read_lock() if
possible, lock_cpu_hotplug() otherwise.

(rcu_read_lock() might not be the appropriate name for this operation -
maybe it should be an open-coded preempt_disable().  Or some other suitably
named alias; dunno).

