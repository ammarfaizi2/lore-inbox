Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265147AbUFRNEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265147AbUFRNEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 09:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUFRNEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 09:04:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:17902 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265147AbUFRNEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 09:04:15 -0400
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the
	mapping
From: Chris Mason <mason@suse.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk>
References: <1087523668.8002.103.camel@watt.suse.com>
	 <20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1087563810.8002.116.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 09:03:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 22:10, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Thu, Jun 17, 2004 at 09:54:28PM -0400, Chris Mason wrote:
> > __bd_forget will change the mapping for filesystem inodes without 
> > waiting to make sure no users of the block device address space are 
> > using that mapping.
> 
> Filesystem block device inodes have no business even looking at their
> ->i_mapping.  Where do you need to do that?

sync_sb_inodes, the filesystem block device inode ends up on some dirty
list, and under memory pressure balance_dirty_pages_ratelimited will
trigger writeback on it.  

There's nothing to write back of course, the real block device address
space has no dirty pages at all.  But, writeback is looking through the
mapping and __bd_forget can't drop it until writeback has finished
checking it.

I've verified this really is happening ;-) The patch I sent is nasty but
I'm sure this is a real bug.

-chris


