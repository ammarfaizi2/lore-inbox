Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264274AbUE3Rif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbUE3Rif (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 13:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUE3Rif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 13:38:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4000 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264274AbUE3RiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 13:38:08 -0400
Date: Sun, 30 May 2004 14:38:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops, 2.4.26 and jfs
Message-ID: <20040530173858.GA11692@logos.cnet>
References: <Pine.LNX.4.58.0405281307550.18184@potato.cts.ucla.edu> <1085776292.13846.18.camel@shaggy.austin.ibm.com> <Pine.LNX.4.58.0405281757360.18184@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405281757360.18184@potato.cts.ucla.edu>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, May 28, 2004 at 06:16:22PM -0700, Chris Stromsoe wrote:
> On Fri, 28 May 2004, Dave Kleikamp wrote:
> 
> > On Fri, 2004-05-28 at 15:15, Chris Stromsoe wrote:
> > > This morning during a cron run while doing a find across /, I got the
> > > following oops.
> >
> > The oops is fixed in 2.4.27-pre3 with the patch:
> > http://linux.bkbits.net:8080/linux-2.4/cset@1.1359.20.3
> >
> > jfs still may give you problems if 0-order allocations are failing, but
> > it's not supposed to trap.
> 
> Thanks, patch applied.
> 
> 
> Aside from that:
> 
> > May 26 06:28:10 begonia kernel: __alloc_pages: 0-order allocation failed
> > (gfp=0x1f0/0)
> 
> I'm curious about why 0-order allocations would fail.  From everything
> I've read (google searching for the error message), that indicates an out
> of memory condition, which shouldn't be the case.
> 
> The box in question has 4Gb of physical ram (512Mb is used as tmpfs) and
> 9Gb of swap.  When the oops happened, no swap was in use.  Physical ram
> was pretty much filled, but no swap at all.  OOM_KILLER is not enabled.

Hi Chris, 

This seems to be a normal allocation (which can wait), it really
looks the system was out of memory. 

Can you stick a call to show_free_areas() in mm/page_alloc.c after 

        printk(KERN_NOTICE "__alloc_pages: %u-order allocation failed (gfp=0x%x/%i)\n",
               order, gfp_mask, !!(current->flags & PF_MEMALLOC));

so we know the state of the memory areas when it happens again.

Also turn on /proc/sys/vm/vm_gfp_debug.

> There's nothing especially exotic in the box.  It does a lot of network
> traffic (eepro100) and a lot of disk traffic (aic7xxx).  The morning cron
> jobs had just kicked off.  Two of them do "find /"  -- I believe that the
> second one was running when it happened.
