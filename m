Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbUK0HGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUK0HGO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 02:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUK0HFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 02:05:32 -0500
Received: from zeus.kernel.org ([204.152.189.113]:18110 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261280AbUKZTH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:07:59 -0500
Date: Thu, 25 Nov 2004 21:54:31 -0600
From: Jack Steiner <steiner@sgi.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] - Externel SLIT table information thru sysfs
Message-ID: <20041126035431.GA4550@sgi.com>
References: <20041124165724.GA14544@sgi.com> <41A53D93.5070005@osdl.org> <20041125033931.GA25561@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125033931.GA25561@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend - first bounced)

On Wed, Nov 24, 2004 at 06:04:03PM -0800, Randy.Dunlap wrote:
> Jack Steiner wrote:
> >The ACPI SLIT table provides useful information on internode distances.
> >Here is a patch to externalize the SLIT information. 
> >
> >For example:
> >
> >        # cd /sys/devices/system
> >        # find .
> >        ./node
> >        ./node/node5
> >        ./node/node5/distance
> >        ./node/node5/numastat
> >        ./node/node5/meminfo
> >        ./node/node5/cpumap
> >
> >        # cat ./node/node0/distance
> >        10 20 64 42 42 22
> >
> >        # cat node/*/distance
> >        10 20 64 42 42 22
> >        20 10 42 22 64 84
> >        64 42 10 20 22 42
> >        42 22 20 10 42 62
> >        42 64 22 42 10 20
> >        22 84 42 62 20 10
> 
> Apparently I'm easily confused, but node_distance() {near end}
> seems to evaluate to either 10 or 20 (only), so what are
> all of these other numbers here?

On systems that provide the ACPI SLIT table, the distances come from
the SLIT table.  (See the ACPI spec for the full definition).
The example above is from the ACPI SLIT table of a 6-node SGI Altix 
system and the table is provided by the BIOS.

If the BIOS does not provide a SLIT table, the default distance is 10 for
local & 20 for remote. The value of 10 conforms to the spec for
local distance, 20 is arbitrary but indicates further than local.

> 
> And how many nodes are in this example?
> Maybe 6, numbered 0 thru 5?  Plz correct this guess....

Good guess.



> 
> >Index: linux/drivers/base/node.c
> >===================================================================
> >--- linux.orig/drivers/base/node.c	2004-11-05 08:34:42.461312000 -0600
> >+++ linux/drivers/base/node.c	2004-11-05 15:56:23.345662000 -0600
> >@@ -111,6 +111,24 @@ static ssize_t node_read_numastat(struct
> > }
> > static SYSDEV_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
> > 
> >+static ssize_t node_read_distance(struct sys_device * dev, char * buf)
> >+{
> >+	int nid = dev->id;
> >+	int len = 0;
> >+	int i;
> >+
> >+	/* buf currently PAGE_SIZE, need ~4 chars per node */
> >+	BUILD_BUG_ON(NR_NODES*4 > PAGE_SIZE/2);
> >+
> >+	for (i = 0; i < numnodes; i++)
> >+		len += sprintf(buf + len, "%s%d", i ? " " : "", 
> >node_distance(nid, i));
> >+		
> >+	len += sprintf(buf + len, "\n");
> >+	return len;
> >+}
> >+static SYSDEV_ATTR(distance, S_IRUGO, node_read_distance, NULL);
> >+
> >+
> >Index: linux/include/linux/topology.h
> >===================================================================
> >--- linux.orig/include/linux/topology.h	2004-11-05 
> >08:34:57.492932000 -0600
> >+++ linux/include/linux/topology.h	2004-11-23 10:03:26.700821978 -0600
> >@@ -55,7 +55,10 @@ static inline int __next_node_with_cpus(
> > 	for (node = 0; node < numnodes; node = __next_node_with_cpus(node))
> > 
> > #ifndef node_distance
> >-#define node_distance(from,to)	((from) != (to))
> >+/* Conform to ACPI 2.0 SLIT distance definitions */
> >+#define LOCAL_DISTANCE		10
> >+#define REMOTE_DISTANCE		20
> >+#define node_distance(from,to)	((from) == (to) ? LOCAL_DISTANCE : 
> >REMOTE_DISTANCE)
> Please add a space after "from,".
> 
> > #endif
> 
> -- 
> ~Randy

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.



