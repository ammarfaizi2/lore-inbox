Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVHCSyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVHCSyi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 14:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVHCSyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 14:54:38 -0400
Received: from rgminet01.oracle.com ([148.87.122.30]:18423 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S262396AbVHCSyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 14:54:37 -0400
Date: Wed, 3 Aug 2005 11:54:01 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: David Teigland <teigland@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050803185401.GB21228@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050802071828.GA11217@redhat.com> <1122968724.3247.22.camel@laptopd505.fenrus.org> <20050803035618.GB9812@redhat.com> <20050803103744.GG11081@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803103744.GG11081@marowsky-bree.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 12:37:44PM +0200, Lars Marowsky-Bree wrote:
> On 2005-08-03T11:56:18, David Teigland <teigland@redhat.com> wrote:
> 
> > > * Why use your own journalling layer and not say ... jbd ?
> > Here's an analysis of three approaches to cluster-fs journaling and their
> > pros/cons (including using jbd):  http://tinyurl.com/7sbqq
> 
> Very instructive read, thanks for the link.
While it may be true that for a full log, flushing for a *single* lock may
be more expensive in OCFS2, Ken ignores the fact that in our one big flush
we've made all locks on journalled resources immediately releasable.
According to that description, GFS2 would have to do a seperate transaction
flush (including the extra step of writing revoke records) for each lock
protecting a journalled resource. Assuming the same number of locks are
required to be dropped under both systems then for a number of locks > 1
OCFS2 will actually do less work - the actual metadata blocks would be the
same on either end, but JBD only has to write that the journal is now clean
to the journal superblock whereas GFS2 has to revoke the blocks for each
dropped lock.

Of course all of this talk completely avoids the fact that in any case these
things are expensive so a cluster file system has to take care to ping locks
as little as possible. OCFS2 takes great pains to make as many operations
node local (requiring no cluster locks) as possible - data allocation is
usually done from a node local pool which is refreshed from the main bitmap.
Deallocation happens similarly - we have a truncate log in which we record
deleted clusters. Each node has their own inode and metadata chain
allocators which another node will only lock for delete (a truncate log
style local metadata delete log could easily be added if that ever became a
problem).
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
