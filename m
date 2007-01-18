Return-Path: <linux-kernel-owner+w=401wt.eu-S1751888AbXARBLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbXARBLu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 20:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbXARBLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 20:11:50 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:36582 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751874AbXARBLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 20:11:49 -0500
Date: Wed, 17 Jan 2007 17:10:25 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: menage@google.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, pj@sgi.com, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
In-Reply-To: <20070117141046.cd19c9e8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0701171707430.8408@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
 <20070116135325.3441f62b.akpm@osdl.org> <Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
 <20070116154054.e655f75c.akpm@osdl.org> <Pine.LNX.4.64.0701161602480.4263@schroedinger.engr.sgi.com>
 <20070116170734.947264f2.akpm@osdl.org> <Pine.LNX.4.64.0701161709490.4455@schroedinger.engr.sgi.com>
 <20070116183406.ed777440.akpm@osdl.org> <Pine.LNX.4.64.0701161920480.4677@schroedinger.engr.sgi.com>
 <20070116200506.d19eacf5.akpm@osdl.org> <Pine.LNX.4.64.0701162219180.5215@schroedinger.engr.sgi.com>
 <20070116230034.b8cb4263.akpm@osdl.org> <Pine.LNX.4.64.0701171140580.7397@schroedinger.engr.sgi.com>
 <20070117141046.cd19c9e8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2007, Andrew Morton wrote:

> > The inode lock is not taken when the page is dirtied.
> 
> The inode_lock is taken when the address_space's first page is dirtied.  It is
> also taken when the address_space's last dirty page is cleaned.  So the place
> where the inode is added to and removed from sb->s_dirty is, I think, exactly
> the place where we want to attach and detach address_space.dirty_page_nodemask.

The problem there is that we do a GFP_ATOMIC allocation (no allocation 
context) that may fail when the first page is dirtied. We must therefore 
be able to subsequently allocate the nodemask_t in set_page_dirty(). 
Otherwise the first failure will mean that there will never be a dirty 
map for the inode/mapping.

