Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVD2Fwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVD2Fwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 01:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVD2Fwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 01:52:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55244 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262393AbVD2Fwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 01:52:30 -0400
Date: Fri, 29 Apr 2005 13:56:19 +0800
From: David Teigland <teigland@redhat.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1a/7] dlm: core locking
Message-ID: <20050429055619.GD9900@redhat.com>
References: <20050425165705.GA11938@redhat.com> <20050427214136.GC938@ca-server1.us.oracle.com> <20050428034550.GA10628@redhat.com> <20050428192112.GA355@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428192112.GA355@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 12:21:12PM -0700, Mark Fasheh wrote:

> > Just to clarify, though:  when the LOCAL resource is immediately created
> > and mastered locally, there must be a resource directory entry added for
> > it, right?  For us, the resource directory entry is added as part of a new
> > master lookup (which is being skipped).  If you don't add a directory
> > entry, how does another node that later wants to lock the same resource
> > (without LOCAL) discover who the master is?

> Yes, I believe LOCAL would always have to at least add a directory entry.
> For the OCFS2 dlm which does not use a resource directory, the entry would
> just exist on the creating node and other nodes would discover it later via
> query.

OK, sounds like an interesting tradeoff.  If any node can be master of a
resource, and there's no resource directory, then any new non-LOCAL
request must query every other node to check if it's the master.  A look
at your dlm shows this is the case:

while ((nodenum = dlm_node_iter_next(&iter)) >= 0) {
        ret = dlm_do_master_request(mle, nodenum);

Of course with a directory you just query one node to find if/who the
master is.  Which is better would depend on the usage. 

If you wanted to do a similar optimization as LOCAL with our dlm, you'd
use parent/child locks where the parent at the top of the tree would
require a lookup but all the child locks would only require local
processing.


> > If I understand LOCAL correctly, it should be simple for us to do.  We'd
> > still have a LOCAL request _send_ the lookup to create the directory
> > entry, but we'd simply not wait for the reply.  We'd assume, based on
> > LOCAL, that the lookup result indicates we're the master.

> I assume then that you can do that without racing the node who sent the
> LOCAL request and another node who comes in (just afterwards) for a master
> lookup? I bet the answer to that question would come to me if I read more of
> the code :)

Nope, my speculation on how we might do LOCAL above wouldn't work.  It now
seems clear that LOCAL can't really be done with a directory.

Dave

