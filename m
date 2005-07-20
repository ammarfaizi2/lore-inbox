Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVGTDar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVGTDar (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 23:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVGTDar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 23:30:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12270 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261523AbVGTDao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 23:30:44 -0400
Date: Wed, 20 Jul 2005 11:35:46 +0800
From: David Teigland <teigland@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] [RFC] nodemanager, ocfs2, dlm
Message-ID: <20050720033546.GB9747@redhat.com>
References: <20050718061553.GA9568@redhat.com> <20050719155214.GG13246@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719155214.GG13246@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 05:52:14PM +0200, Lars Marowsky-Bree wrote:

> The nodeid, I thought, was relative to a given DLM namespace, no? This
> concept seems to be missing here, or are you suggesting the nodeid to be
> global across namespaces?

I'm not sure I understand what you mean.  A node would have the same
nodeid across different dlm locking-domains, assuming, of course, those
dlm domains were in the context of the same cluster.  The dlm only uses
nodemanager to look up node addresses, though.

> Also, eventually we obviously need to have state for the nodes - up/down
> et cetera. I think the node manager also ought to track this.

We don't have a need for that information yet; I'm hoping we won't ever
need it in the kernel, but we'll see.

> How would kernel components use this and be notified about changes to
> the configuration / membership state?

"Nodemanager" is perhaps a poor name; at the moment its only substantial
purpose is to communicate node address/id associations in a way that's
independent of a specific driver or fs.

Changes to cluster configuration/membership happen in user space, of
course.  Those general events will have specific consequences to a given
component (fs, lock manager, etc).  These consequences vary quite widely
depending on the component you're looking at.

There are at least two ways to handle this:

1. Pass cluster events and data into the kernel (this sounds like what
you're talking about above), notify the effected kernel components, each
kernel component takes the cluster data and does whatever it needs to with
it (internal adjustments, recovery, etc).

2. Each kernel component "foo-kernel" has an associated user space
component "foo-user".  Cluster events (from userland clustering
infrastructure) are passed to foo-user -- not into the kernel.  foo-user
determines what the specific consequences are for foo-kernel.  foo-user
then manipulates foo-kernel accordingly, through user/kernel hooks (sysfs,
configfs, etc).  These control hooks would largely be specific to foo.

We're following option 2 with the dlm and gfs and have been for quite a
while, which means we don't need 1.  I think ocfs2 is moving that way,
too.  Someone could still try 1, of course, but it would be of no use or
interest to me.  I'm not aware of any actual projects pushing forward with
something like 1, so the persistent reference to it is somewhat baffling.

Dave

