Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWHYQ5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWHYQ5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 12:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422681AbWHYQ5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 12:57:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1446 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422673AbWHYQ5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 12:57:44 -0400
Date: Fri, 25 Aug 2006 09:57:18 -0700
From: Paul Jackson <pj@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, anton@samba.org,
       simon.derr@bull.net, nathanl@austin.ibm.com, akpm@osdl.org,
       y-goto@jp.fujitsu.com
Subject: Re: memory hotplug - looking for good place for cpuset hook
Message-Id: <20060825095718.9e22e777.pj@sgi.com>
In-Reply-To: <20060825184717.3dbb5325.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060825015359.1c9eab45.pj@sgi.com>
	<20060825184717.3dbb5325.kamezawa.hiroyu@jp.fujitsu.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kame wrote:
> maybe
> 
> if (new_pgdat) {
> 	register_one_node(nid); <-- add sysfs entry of node
> 	<here>
> }

I am not sure why you suggest this, but perhaps you ar saying that I
don't need to call my new cpuset hook (that tracks node_online_map)
everytime we set a bit here in node_online_map, but only when we set a
bit that wasn't previously set.

Hmmm ... this mm/memory_hotplug.c:add_memory() code seems to have
more code than it needs:

================================================================
int add_memory(int nid, u64 start, u64 size)
{
        pg_data_t *pgdat = NULL;
        int new_pgdat = 0;
        ...
        if (!node_online(nid)) {
                pgdat = hotadd_new_pgdat(nid, start);
                if (!pgdat)
                        return -ENOMEM;
		new_pgdat = 1;
                ...
        }
        ...
        /* we online node here. we can't roll back from here. */
        node_set_online(nid);

        if (new_pgdat) {
                ret = register_one_node(nid);                         
================================================================

It looks like the call to node_set_online() could also be called
only if it wasn't already set, and that the 'new_pgdat' is not
needed as we can just test for pgdat != NULL.

That leads to this code that's a couple lines shorter:

================================================================
int add_memory(int nid, u64 start, u64 size)
{
        pg_data_t *pgdat = NULL;
        ...
        if (!node_online(nid)) {
                pgdat = hotadd_new_pgdat(nid, start);
                if (!pgdat)
                        return -ENOMEM;
               ...
        }
        ...
        if (pgdat) {
                /* we online node here. we can't roll back from here. */
                node_set_online(nid);
                ret = register_one_node(nid);                         
================================================================

Is this second code chunk just as good?

I'd still be inclined to add my new cpuset hook to track
node_online_map right after the node_set_online() call, since
that's what changes node_online_map.  I don't think I care
whether or not the "sysfs entry of node" is setup or not.

> (When I implements node-hotplug invoked by cpu-hotplug, I'll care cpuset.)

Good - thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
