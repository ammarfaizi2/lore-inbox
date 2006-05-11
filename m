Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWEKQdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWEKQdp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWEKQdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:33:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030327AbWEKQdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:33:44 -0400
Date: Thu, 11 May 2006 09:27:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, aeb@cwi.nl
Subject: Re: [PATCH] make kernel ignore bogus partitions
Message-Id: <20060511092736.27cedfd5.akpm@osdl.org>
In-Reply-To: <20060511161736.GB8124@beardog.cca.cpqcorp.net>
References: <20060503210055.GB31048@beardog.cca.cpqcorp.net>
	<20060509124138.43e4bac0.akpm@osdl.org>
	<20060511161736.GB8124@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net> wrote:
>
> On Tue, May 09, 2006 at 12:41:38PM -0700, Andrew Morton wrote:
> > "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net> wrote:
> > >
> > > Patch 1/1
> > > Sometimes partitions claim to be larger than the reported capacity of a
> > > disk device. This patch makes the kernel ignore those partitions.
> > > 
> > > Signed-off-by: Mike Miller <mike.miller@hp.com>
> > > Signed-off-by: Stephen Cameron <steve.cameron@hp.com>
> > > 
> > > Please consider this for inclusion.
> > > 
> > > 
> > >  fs/partitions/check.c |    5 +++++
> > >  1 files changed, 5 insertions(+)
> > > 
> > > --- linux-2.6.14/fs/partitions/check.c~partition_vs_capacity	2006-01-06 09:32:14.000000000 -0600
> > > +++ linux-2.6.14-root/fs/partitions/check.c	2006-01-06 11:24:50.000000000 -0600
> > > @@ -382,6 +382,11 @@ int rescan_partitions(struct gendisk *di
> > >  		sector_t from = state->parts[p].from;
> > >  		if (!size)
> > >  			continue;
> > > +		if (from+size-1 > get_capacity(disk)) {
> > > +			printk(" %s: p%d exceeds device capacity, ignoring.\n", 
> > > +				disk->disk_name, p);
> > > +			continue;
> > > +		}
> > >  		add_partition(disk, p, from, size);
> > >  #ifdef CONFIG_BLK_DEV_MD
> > >  		if (state->parts[p].flags)
> > 
> > Shouldn't that be
> > 
> > 	if (from+size > get_capacity(disk)) {
> > 
> > ?
> > 
> Since the partition size is 0-based this is correct:
> 
> 	if (from+size-1 > get_capacity(disk)) {
> 

Don't think so.

If `from' is 0 and `size' is 1025 and get_capacity() is 1024 then we have

	if (1024 > 1024)

which returns false.
