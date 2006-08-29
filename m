Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWH2QOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWH2QOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWH2QOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:14:15 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:36064 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S965050AbWH2QOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:14:14 -0400
Subject: observations on configfs
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@gmail.com>
Cc: joel.becker@oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Aug 2006 18:14:30 +0200
Message-Id: <1156868070.3788.38.camel@ux156>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
X-sips-origin: local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently tried to use configfs for configuring (virtual) network
interfaces on top of cfg80211. Here's what I noticed then and in later
thoughts about it.

Note that in this context I'm talking about 'virtual interfaces' but
this has nothing to do with namespace virtualisation, the 'virtual' here
comes from the fact that you have many 'virtual' interfaces associated
with a single wireless card.

 (1) it is possible to have

     | $ ls /config
     | 02-example  02-example

     Seems like that should be prohibited when registering the new
configfs subsystem.


 (2) why is are there no show/store in struct configfs_attribute? That
leads to complications like this (straight from ocfs2):

struct o2nm_node_attribute {
        struct configfs_attribute attr;
        ssize_t (*show)(struct o2nm_node *, char *);
        ssize_t (*store)(struct o2nm_node *, const char *, size_t);
};

static struct o2nm_node_attribute o2nm_node_attr_num = {
        .attr   = { .ca_owner = THIS_MODULE,
                    .ca_name = "num",
                    .ca_mode = S_IRUGO | S_IWUSR },
        .show   = o2nm_node_num_read,
        .store  = o2nm_node_num_write,
};

...

static ssize_t o2nm_node_show(struct config_item *item,
                              struct configfs_attribute *attr,
                              char *page)
{
        struct o2nm_node *node = to_o2nm_node(item);
        struct o2nm_node_attribute *o2nm_node_attr =
                container_of(attr, struct o2nm_node_attribute, attr);
        ssize_t ret = 0;

        if (o2nm_node_attr->show)
                ret = o2nm_node_attr->show(node, page);
        return ret;
}

I suppose I could ask the same of sysfs, but there it actually seems to
make sense because it only needs to be implemented once per subsystem.
The same is true of configfs, however for configfs one usually has to
implement a new subsystem to get useful functionality...


 (3) just thought about the pending/live thing a bit more. For one I
notice that it is not implemented, which is sad because I could really
use it well here. Secondly, and more importantly, I think the concept is
slightly flawed.

If I have virtual devices represented in configfs, they are all
net_devices at their core, of course. Assuming they are below
/config/cfg80211/wiphy0/, say eth0 is created as pending/eth0. Then, you
move it to live/eth0 at which point the netdevice is allocated and
registered (if it fails due to name collision you need to chose another
name by renaming it in pending).
This is all great, but say then I want to change a few parameters of the
interface. So I move it to pending again. At this point, we run into
problems. We can either (a) remove the net_device or (b) keep it live.
Both have problems. Case (a) would obviously be correct from a configfs
point of view, but not really usable. Tearing down the net_device etc.
isn't feasible for just changing the SSID for example... keeping it live
doesn't really work either though, if someone notices that 'eth0' exists
and belongs to wiphy0 (say through netlink) he would then proceed to
look at /config/cfg80211/wiphy0/live/eth0 which doesn't exist! This
problem happens because configfs is designed to be the primary namespace
for things which in the case of networking interfaces isn't true.

Hence, I think it should be slightly redesigned to allow for another
case, namely hardlinking the directory from live into pending (make sure
name stays the same) at which point it isn't removed. Then, moving it
from live to pending would be taken as an indication to actually remove
the net_device associated with it, and linking it just as a
reconfiguration request.
Then, moving it from pending to live over the existing one would
actually update the configuration.

Does that sound sane?

Thanks,
Johannes
