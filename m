Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTKYVYi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 16:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTKYVYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 16:24:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:45262 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263081AbTKYVYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 16:24:37 -0500
Date: Tue, 25 Nov 2003 13:24:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: jbarnes@sgi.com (Jesse Barnes)
Cc: steiner@sgi.com, jes@trained-monkey.org, viro@math.psu.edu,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: hash table sizes
Message-Id: <20031125132439.3c3254ff.akpm@osdl.org>
In-Reply-To: <20031125211424.GA32636@sgi.com>
References: <16323.23221.835676.999857@gargle.gargle.HOWL>
	<20031125204814.GA19397@sgi.com>
	<20031125130741.108bf57c.akpm@osdl.org>
	<20031125211424.GA32636@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) wrote:
>
> On Tue, Nov 25, 2003 at 01:07:41PM -0800, Andrew Morton wrote:
> > the size of these tables dependent upon the number of dentries/inodes/etc
> > which the system is likely to support.  And that does depend upon the
> > amount of direct-addressible memory.
> > 
> > 
> > So hum.  As a starting point, what happens if we do:
> > 
> > -	vfs_caches_init(num_physpages);
> > +	vfs_caches_init(min(num_physpages, pages_in_ZONE_NORMAL));
> > 
> > ?
> 
> Something like that might be ok, but on our system, all memory is in
> ZONE_DMA...
> 

Well yes, we'd want

	vfs_caches_init(min(num_physpages, some_platform_limit()));

which on ia32 would evaluate to nr_free_buffer_pages() and on ia64 would
evaluate to the size of one of those zones.

If the machine has zillions of small zones then perhaps this will result in
an undersized hashtable.
