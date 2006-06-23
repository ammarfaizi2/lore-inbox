Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWFWPpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWFWPpr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWFWPpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:45:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50826 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751468AbWFWPpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:45:46 -0400
Subject: Re: GFS2 and DLM
From: Steven Whitehouse <swhiteho@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060623145409.GB32694@infradead.org>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	 <20060623145409.GB32694@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 23 Jun 2006 16:54:04 +0100
Message-Id: <1151078044.3856.1595.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-06-23 at 15:54 +0100, Christoph Hellwig wrote:
> On Tue, Jun 20, 2006 at 01:17:13PM +0100, Steven Whitehouse wrote:
> > Hi,
> > 
> > Linus, Andrew suggested to me to send this pull request to you directly.
> > Please consider merging the GFS2 filesystem and DLM from (they are both
> > in the same tree for ease of testing):
> 
> What's going on with gfs2_repermission?  For one it's a totally useless
> wrapper.  Second we prefer to have everyone use vfs_permission or
> file_permission and third WTF is it doing anywhere?  Except for very rare
> cases checking permissions is the VFS's job.
> 

gfs2_repermission doesn't exist in the latest git tree. I had spotted
that one earlier and replaced it with direct calls to permission.
vfs_permission is just a wrapper for permission.

file_permission which you are advocating using has the comment:

/**
 * file_permission  -  check for additional access rights to a given file
 * @file:       file to check access rights for
 * @mask:       right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
 *
 * Used to check for read/write/execute permissions on an already opened
 * file.
 *
 * Note:
 *      Do not use this function in new code.  All access checks should
 *      be done using vfs_permission().
 */

so I guess thats not the right thing. I'm afraid I fail to see whats wrong
with just calling permission directly... we need to call it mainly because
the VFS only does locking within a single node and we recheck the permissions
in a few places after we've taken the glocks which provide cluster-wide
exclusion.

Steve.


