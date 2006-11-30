Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759191AbWK3JG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759191AbWK3JG1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759193AbWK3JG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:06:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53432 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1759191AbWK3JGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:06:25 -0500
Subject: Re: [RFC][PATCH] Mount problem with the GFS2 code
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Srinivasa Ds <srinivasa@in.ibm.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, fabbione@ubuntu.com, bunk@stusta.de,
       aarora@linux.vnet.ibm.com, aarora@in.ibm.com
In-Reply-To: <20061130002934.829334a6.akpm@osdl.org>
References: <456EA5BF.6090304@in.ibm.com>
	 <20061130002934.829334a6.akpm@osdl.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 09:05:38 +0000
Message-Id: <1164877538.3752.93.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-11-30 at 00:29 -0800, Andrew Morton wrote:
> On Thu, 30 Nov 2006 15:04:55 +0530
> Srinivasa Ds <srinivasa@in.ibm.com> wrote:
> 
> > ==========================================================================
> > On debugging further we found that problem is while reading the super 
> > block(gfs2_read_super) and comparing the magic number in it.
> > When I  replace the submit_bio() call(present in gfs2_read_super) with 
> > the sb_getblk() and ll_rw_block(), mount operation succeded.
> 
> umm, why on earth does gfs2_read_super() go direct-to-BIO?
> 
We want to make 100% certain that we are not reading cached data in
either of the two cases in which we read the sb. It is read from disk
exactly twice on each mount of a GFS2 filesystem and is never touched
again while the fs is mounted. GFS2 never writes the sb, it is created
by mkfs and never changes.

The reason its read twice, is that the first time its read to get the
details of the locking protocol, the second time its called under a lock
in order to discover the location of various bits of metadata on the
disk.

> Switching to sb_getblk()+ll_rw_blk() sounds like a preferable fix.
> 
> Even better would be switching to a bare sb_bread().   If sb->s_blocksize
> isn't set up by then then either set it up or, if you must, use __bread().
> 
I'm not convinced yet... I'd be happy to take the patch as posted
assuming that the reason you are suggesting using sb_bread() or similar
is that you expected us to want to cache the sb. Was there another
reason for not using the bio routines?

Steve.


