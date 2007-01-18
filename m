Return-Path: <linux-kernel-owner+w=401wt.eu-S1751864AbXARBZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbXARBZv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 20:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbXARBZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 20:25:51 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60423 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbXARBZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 20:25:50 -0500
Date: Wed, 17 Jan 2007 17:25:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: menage@google.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, pj@sgi.com, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
Message-Id: <20070117172534.fbe92a88.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701171707430.8408@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	<20070116135325.3441f62b.akpm@osdl.org>
	<Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
	<20070116154054.e655f75c.akpm@osdl.org>
	<Pine.LNX.4.64.0701161602480.4263@schroedinger.engr.sgi.com>
	<20070116170734.947264f2.akpm@osdl.org>
	<Pine.LNX.4.64.0701161709490.4455@schroedinger.engr.sgi.com>
	<20070116183406.ed777440.akpm@osdl.org>
	<Pine.LNX.4.64.0701161920480.4677@schroedinger.engr.sgi.com>
	<20070116200506.d19eacf5.akpm@osdl.org>
	<Pine.LNX.4.64.0701162219180.5215@schroedinger.engr.sgi.com>
	<20070116230034.b8cb4263.akpm@osdl.org>
	<Pine.LNX.4.64.0701171140580.7397@schroedinger.engr.sgi.com>
	<20070117141046.cd19c9e8.akpm@osdl.org>
	<Pine.LNX.4.64.0701171707430.8408@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 17 Jan 2007 17:10:25 -0800 (PST) Christoph Lameter <clameter@sgi.com> wrote:
> On Wed, 17 Jan 2007, Andrew Morton wrote:
> 
> > > The inode lock is not taken when the page is dirtied.
> > 
> > The inode_lock is taken when the address_space's first page is dirtied.  It is
> > also taken when the address_space's last dirty page is cleaned.  So the place
> > where the inode is added to and removed from sb->s_dirty is, I think, exactly
> > the place where we want to attach and detach address_space.dirty_page_nodemask.
> 
> The problem there is that we do a GFP_ATOMIC allocation (no allocation 
> context) that may fail when the first page is dirtied. We must therefore 
> be able to subsequently allocate the nodemask_t in set_page_dirty(). 
> Otherwise the first failure will mean that there will never be a dirty 
> map for the inode/mapping.

True.  But it's pretty simple to change __mark_inode_dirty() to fix this.
