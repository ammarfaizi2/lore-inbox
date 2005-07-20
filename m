Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVGTELi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVGTELi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 00:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVGTELi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 00:11:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17550 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261580AbVGTELh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 00:11:37 -0400
Date: Wed, 20 Jul 2005 12:16:30 +0800
From: David Teigland <teigland@redhat.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       ocfs2-devel@oss.oracle.com
Subject: Re: [Linux-cluster] [RFC] nodemanager, ocfs2, dlm
Message-ID: <20050720041630.GC9747@redhat.com>
References: <20050718061553.GA9568@redhat.com> <20050720004826.GH14505@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050720004826.GH14505@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 05:48:26PM -0700, Mark Fasheh wrote:
> For OCFS2 that would mean that an ocfs2_nodemanager would still exist,
> but as a much smaller module sitting on top of 'nodemanager'.

Yep, factoring out the common bits.

> So no port attribute. The OCFS2 network code normally takes port from the
> node manager in order to determine how to talk to a given node. We'll have
> to figure out how to resolve that. The easiest would be to add 'port' back,
> but I think that might be problematic if we have multiple cluster network
> infrastructures as we do today.

The port is specific to the component using it (ocfs2, dlm, etc), so
defining port as a node property doesn't make sense if nodemanager is
providing node info to multiple components.

> Another way to handle this would be to have userspace symlink to the node
> items as an attribute on an ocfs2_tcp item. We could store 'port' as a
> second attribute. This would have the added benefit of pinning node
> information while OCFS2 uses it.

I expect each component will probably use another per-node configfs object
for component-specific attributes, using the common bits from the
nodemanager object.

> > +	char			nd_name[NODEMANAGER_MAX_NAME_LEN+1];
> An accessor function for this would be nice for pretty prints - maybe strcpy
> into a passed string.

ok

> > +	int			nd_nodeid;
> This definitely won't work with OCFS2... Nodeid (what used to be called
> node_num) needs to be unsigned. Otherwise this will break all our nodemap
> stuff which uses a bitmap to represent cluster state.

ok

> > +	struct list_head	nd_status_list;
> What are these two for? They don't seem to be referenced elsewhere...

Missed ripping them out with the other ocfs-specific stuff.

> > +	if (!tmp && cluster->cl_has_local &&
> > +	    cluster->cl_local_node == node->nd_nodeid) {
> > +		cluster->cl_local_node = 0;
> I think we might want to be setting cl_local_node to NODEMANAGER_MAX_NODES
> here. It seems that ocfs2_nodemanager also does this so we might have just
> caught a bug you inherited :)

yep

> You removed o2nm_configured_node_map but we need some sort of method for
> enumerating over the set of configured nodes.
> 
> Also we need a method for querying the existence of a node.
> The OCFS2 code usually uses o2nm_get_node_by_num(..) != NULL for this but a
> simple boolean api call would be cleaner and would avoid exposing the node
> structure.

Right, those should be on the TODO.

Thanks,
Dave

