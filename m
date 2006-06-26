Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWFZOCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWFZOCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWFZOCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:02:14 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:7593 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030216AbWFZOCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:02:13 -0400
Subject: [patch] lockdep annotate vlan net device as being a special class
From: Arjan van de Ven <arjan@linux.intel.com>
To: deweerdt@free.fr
Cc: greearb@candelatech.com, mingo@redhat.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <1150382401.449171412bdfe@imp1-g19.free.fr>
References: <1150382401.449171412bdfe@imp1-g19.free.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jun 2006 16:01:24 +0200
Message-Id: <1151330484.3185.42.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-15 at 16:40 +0200, deweerdt@free.fr wrote:
> Hi,
> 
> Assigning an inet address to a vlanized interface triggered the following BUG
> from the lock validator (kernel is 2.6.17-rc6-mm2):

ok below is a real working (cross my fingers) patch against the current
-mm tree:

vlan network devices have devices nesting below it, and are a special
"super class" of normal network devices; split their locks off into a
separate class since they always nest.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 net/8021q/vlan.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-2.6.17-lockdep/net/8021q/vlan.c
===================================================================
--- linux-2.6.17-lockdep.orig/net/8021q/vlan.c
+++ linux-2.6.17-lockdep/net/8021q/vlan.c
@@ -364,6 +364,14 @@ static void vlan_transfer_operstate(cons
 	}
 }
 
+/*
+ * vlan network devices have devices nesting below it, and are a special
+ * "super class" of normal network devices; split their locks off into a
+ * separate class since they always nest.
+ */
+static struct lock_class_key vlan_netdev_xmit_lock_key;
+
+
 /*  Attach a VLAN device to a mac address (ie Ethernet Card).
  *  Returns the device that was created, or NULL if there was
  *  an error of some kind.
@@ -460,6 +468,8 @@ static struct net_device *register_vlan_
 		    
 	new_dev = alloc_netdev(sizeof(struct vlan_dev_info), name,
 			       vlan_setup);
+
+	lockdep_set_class(&new_dev->_xmit_lock, &vlan_netdev_xmit_lock_key);
 	if (new_dev == NULL)
 		goto out_unlock;
 

