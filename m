Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVGTAsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVGTAsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 20:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVGTAsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 20:48:37 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:10057 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S261260AbVGTAsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 20:48:36 -0400
Date: Tue, 19 Jul 2005 17:48:26 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: linux clustering <linux-cluster@redhat.com>
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Linux-cluster] [RFC] nodemanager, ocfs2, dlm
Message-ID: <20050720004826.GH14505@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050718061553.GA9568@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050718061553.GA9568@redhat.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, Jul 18, 2005 at 02:15:53PM +0800, David Teigland wrote:
> Some of the comments about the dlm concerned how it's configured (from
> user space.)  In particular, there was interest in seeing the dlm and
> ocfs2 use common methods for their configuration.
> 
> The first area I'm looking at is how we get addresses/ids of other nodes.
Right. So this doesn't take into account other parts of node management
(communication, heartbeat, etc). OCFS2 and dlm would still be handling that
stuff on their own for now. For OCFS2 that would mean that an
ocfs2_nodemanager would still exist, but as a much smaller module sitting on
top of 'nodemanager'.

> I've taken a stab at generalizing ocfs2_nodemanager so the dlm could use
> it (removing ocfs-specific stuff).  It still needs some work, but I'd like
> to know if this appeals to the ocfs group and to others who were
> interested in seeing some similarity in dlm/ocfs configuration.
While I agree that some things look like they still need a bit of work, I
like the direction this is taking - thanks for getting this ball rolling. My
questions and comments below:

> +enum {
> +	NM_NODE_ATTR_NODEID = 0,
> +	NM_NODE_ATTR_ADDRESS,
> +	NM_NODE_ATTR_LOCAL,
> +};
So no port attribute. The OCFS2 network code normally takes port from the
node manager in order to determine how to talk to a given node. We'll have
to figure out how to resolve that. The easiest would be to add 'port' back,
but I think that might be problematic if we have multiple cluster network
infrastructures as we do today.

Another way to handle this would be to have userspace symlink to the node
items as an attribute on an ocfs2_tcp item. We could store 'port' as a
second attribute. This would have the added benefit of pinning node
information while OCFS2 uses it.

> +struct node {
> +	spinlock_t		nd_lock;
> +	struct config_item	nd_item; 
> +	char			nd_name[NODEMANAGER_MAX_NAME_LEN+1];
An accessor function for this would be nice for pretty prints - maybe strcpy
into a passed string.

> +	int			nd_nodeid;
This definitely won't work with OCFS2... Nodeid (what used to be called
node_num) needs to be unsigned. Otherwise this will break all our nodemap
stuff which uses a bitmap to represent cluster state.

> +	u32			nd_ipv4_address;
> +	struct rb_node		nd_ip_node;
> +	int			nd_local;
> +	unsigned long		nd_set_attributes;
> +	struct idr		nd_status_idr;
> +	struct list_head	nd_status_list;
What are these two for? They don't seem to be referenced elsewhere...

> +static ssize_t node_local_write(struct node *node, const char *page,
> +				size_t count)
> +{
> +	struct cluster *cluster = node_to_cluster(node);
> +	unsigned long tmp;
> +	char *p = (char *)page;
> +
> +	tmp = simple_strtoul(p, &p, 0);
> +	if (!p || (*p && (*p != '\n')))
> +		return -EINVAL;
> +
> +	tmp = !!tmp; /* boolean of whether this node wants to be local */
> +
> +	/* the only failure case is trying to set a new local node
> +	 * when a different one is already set */
> +
> +	if (tmp && tmp == cluster->cl_has_local &&
> +	    cluster->cl_local_node != node->nd_nodeid)
> +		return -EBUSY;
> +
> +	if (!tmp && cluster->cl_has_local &&
> +	    cluster->cl_local_node == node->nd_nodeid) {
> +		cluster->cl_local_node = 0;
I think we might want to be setting cl_local_node to NODEMANAGER_MAX_NODES
here. It seems that ocfs2_nodemanager also does this so we might have just
caught a bug you inherited :)

> diff -urN a/drivers/nodemanager/nodemanager.h b/drivers/nodemanager/nodemanager.h
> --- a/drivers/nodemanager/nodemanager.h	1970-01-01 07:30:00.000000000 +0730
> +++ b/drivers/nodemanager/nodemanager.h	2005-07-18 13:41:35.377583200 +0800
> @@ -0,0 +1,37 @@
> +/*
> + * nodemanager.h
> + *
> + * Copyright (C) 2004 Oracle.  All rights reserved.
> + * Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + * 
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + * 
> + * You should have received a copy of the GNU General Public
> + * License along with this program; if not, write to the
> + * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
> + * Boston, MA 021110-1307, USA.
> + *
> + */
> +
> +#ifndef NODEMANAGER_H
> +#define NODEMANAGER_H
> +
> +#define NODEMANAGER_MAX_NODES		255
> +#define NODEMANAGER_INVALID_NODE_NUM	255
> +#define NODEMANAGER_MAX_NAME_LEN	__NEW_UTS_LEN	/* 64 */
> +
> +u32 nodemanager_nodeid_to_addr(int nodeid);
> +int nodemanager_addr_to_nodeid(u32 addr);
> +int nodemanager_our_nodeid(void);
> +u32 nodemanager_our_addr(void);
> +
> +#endif
You removed o2nm_configured_node_map but we need some sort of method for
enumerating over the set of configured nodes.

Also we need a method for querying the existence of a node.
The OCFS2 code usually uses o2nm_get_node_by_num(..) != NULL for this but a
simple boolean api call would be cleaner and would avoid exposing the node
structure.

That's it for my first pass - I might have additional comments after reading
through this some more :)
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
