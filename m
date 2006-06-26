Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWFZJrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWFZJrs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 05:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWFZJrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 05:47:48 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:27923 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1751311AbWFZJrr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 05:47:47 -0400
Message-ID: <20060626134711.A28729@castle.nmd.msu.ru>
Date: Mon, 26 Jun 2006 13:47:11 +0400
From: Andrey Savochkin <saw@sw.ru>
To: dlezcano@fr.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain> <20060609210625.144158000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20060609210625.144158000@localhost.localdomain>; from "dlezcano@fr.ibm.com" on Fri, Jun 09, 2006 at 11:02:04PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

It's good that you kicked off network namespace discussion.
Although I wish you'd Cc'ed someone at OpenVZ so I could notice it earlier :).

Indeed, the first point to agree in this discussion is device list.
In your patch, you essentially introduce a data structure parallel
to the main device list, creating a "view" of this list.
I see a fundamental problem with this approach.
When a device presents an skb to the protocol layer, it needs to know to which
namespace this skb belongs.
Otherwise you would never get rid of problems with bind: what to do if device
eth1 is visible in namespace1, namespace2, and root namespace, and each
namespace has a socket bound to 0.0.0.0:80?

We have to conclude that each device should be visible only in one namespace.
In this case, instead of introducing net_ns_dev and net_ns_dev_list
structures, we can simply have a separate dev_base list head in each namespace.
Moreover, separate device list in each namespace will be in line with
making namespace isolation complete.  Complete isolation will allow each
namespace to set up own tun/tap devices, have own routes, netfilter tables,
and so on.

My follow-up messages will contain the first set of patches with network
namespaces implemented in the same way as network isolation in OpenVZ.
This patchset introduces namespaces for device list and IPv4 FIB/routing.
Two technical issues are omitted to make the patch idea clearer: device moving
between namespaces, and selective routing cache flush + garbage collection.

If this patchset is agreeable, the next patchset will finalize integration
with nsproxy, add namespaces to socket lookup code and neighbour
cache, and introduce a simple device to pass traffic between namespaces.
Then we will turn to less obvious matters including netlink messages,
network statistics, representation of network information in proc and sysfs,
tuning of parameters through sysctl, IPv6 and other protocols, and
per-namespace netfilters.

Best regards
		Andrey
