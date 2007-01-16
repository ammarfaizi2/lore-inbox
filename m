Return-Path: <linux-kernel-owner+w=401wt.eu-S1751333AbXAPUAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbXAPUAy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXAPUAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:00:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:58418 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751333AbXAPUAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:00:54 -0500
Date: Tue, 16 Jan 2007 12:00:30 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Menage <menage@google.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [RFC 8/8] Reduce inode memory usage for systems with a high
 MAX_NUMNODES
In-Reply-To: <6599ad830701161152q75ff29cdo7306c9b8df5c351b@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701161152450.2780@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
  <20070116054825.15358.65020.sendpatchset@schroedinger.engr.sgi.com>
 <6599ad830701161152q75ff29cdo7306c9b8df5c351b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007, Paul Menage wrote:

> On 1/15/07, Christoph Lameter <clameter@sgi.com> wrote:
> > 
> > This solution may be a bit hokey. I tried other approaches but this
> > one seemed to be the simplest with the least complications. Maybe someone
> > else can come up with a better solution?
> 
> How about a 64-bit field in struct inode that's used as a bitmask if
> there are no more than 64 nodes, and a pointer to a bitmask if there
> are more than 64 nodes. The filesystems wouldn't need to be involved
> then, as the bitmap allocation could be done in the generic code.

How would we decide if there are more than 64 nodes? Runtime or compile 
time?

If done at compile time then we will end up with a pointer to an unsigned 
long for a system with <= 64 nodes. If we allocate the nodemask via 
kmalloc then we will always end up with a mininum allocation size of 64 
bytes. Then there is the slab management overhead which will increase 
overhead closer to the 128 byte wastage that we have now. So its likely 
not worth it. There are some additional complications since there is a 
need to free and allocate the nodemask during inode initialization and 
disposal.

If the decision to allocate a node mask is made at run time then it gets 
even more complex. And we still have the same troubling issues with the 
64 byte mininum allocation by the slab.
