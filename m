Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVBOMVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVBOMVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 07:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVBOMVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 07:21:16 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:42948 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261702AbVBOMR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 07:17:28 -0500
Date: Tue, 15 Feb 2005 06:15:52 -0600
From: Robin Holt <holt@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: Ray Bryant <raybry@sgi.com>, Andi Kleen <ak@muc.de>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, stevel@mvista.com
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
Message-ID: <20050215121552.GB20607@lnx-holt.americas.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215115302.GB19586@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215115302.GB19586@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 12:53:03PM +0100, Andi Kleen wrote:
> > (2)  You really only want to migrate pages once.  If a file is mapped
> >      into several of the pid's that are being migrated, then you want
> >      to figure this out and issue one call to have it moved wrt one of
> >      the pid's.
> >      (The page migration code from the memory hotplug patch will handle
> >      updating the pte's of the other processs (thank goodness for
> >      rmap...))
> 
> I don't get this. Surely the migration code will check if a page
> is already in the target node, and when that is the case do nothing.
> 
> How could this "double migration" happen? 

A node is not always equal distant to a cpu.  We need to keep node-to-cpu
distant relatively constant between the original and final placement.
There may be a time where you are moving stuff from node 8 to node 4
and stuff from node 12 to node 8.  If you scan the vmas for both the
processes in the wrong order you will migrate memory from node 12 to 8
for the second process and then from node 8 to node 4 for the second.

> > (3)  In the case where a particular file is mapped into different
> >      processes at different file offsets (and we are migrating both
> >      of the processes), one has to examine the file offsets to figure
> >      out if the mappings overlap or not. If they overlap, then you've
> >      got to issue two calls, each of which describes a non-overlapping
> >      region; both calls taken together would cover the entire range
> >      of pages mapped to the file.  Similarly if the ranges do not
> >      overlap.
> 
> That sounds like a quite obscure corner case which I'm not sure
> is worth all the complexity.

So obscure that nearly every example batch job we looked at had exactly
this circumstance.  Turns out that quite a few batch jobs we looked at
have a parent that maps their working set initially.  After the workers
are forked, they map some part of the same data file to different parts
of their own address space.  They also commonly map over the top of the
large file mapping that was originally done leaving us with a jumble of
address space.  This really showed the need for a user-space application
to figure the problem out and allow the flexibility to come up with more
advanced migration algorithms.

Thanks,
Robin
