Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbTEFNyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbTEFNxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:53:55 -0400
Received: from rth.ninka.net ([216.101.162.244]:52176 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263746AbTEFNxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:53:01 -0400
Subject: Re: [PATCH] kmalloc_percpu
From: "David S. Miller" <davem@redhat.com>
To: Rusty Russell <rusty@au1.ibm.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
In-Reply-To: <20030506082949.F2A3217DE0@ozlabs.au.ibm.com>
References: <20030506082949.F2A3217DE0@ozlabs.au.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052212999.983.23.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 02:23:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 01:03, Rusty Russell wrote:
> And #3 is, in fact, the one I care about.  The extra memory reference
> is already probably cachehot (all static per-cpu use it), and might be
> in a register on some archs.
> 
> Doesn't break with sparce CPU #s, but yes, it is inefficient.

Maybe we should treat this stuff like architecture ABIs that
have a "small data" section?

Before elaborating, let me state that if we are going to use this
for things like disk stats and per-interface ipv6 ICMP stats, a
fixed size pool is absolutely unacceptable.  People are configuring up
thousands upon thousands of VLAN net devices today, and if IPV6 is
enabled each of those will get a per-cpu ICMP stats block allocated.
And as Andrew said, there can be thousands of block devices.

Therefore, for these per-cpu applications there must be no limits built
into the mechanism.

Now, what I propose is that kmalloc_percpu() keeps it's current
implementation.  Then we have a kmalloc_percpu_small() that must only
be invoked during module init and we limit the size to some reasonable
amount.  This kmalloc_percpu_small() uses the 32K pool or whatever, as
does DECLARE_PERCPU in a module.

How about this?

-- 
David S. Miller <davem@redhat.com>
