Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUBWBdx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 20:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbUBWBdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 20:33:53 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:31826 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261703AbUBWBdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 20:33:47 -0500
Subject: RE: Cisco vpnclient prevents proper shutdown starting with 2.6.2
From: Patrick Toal <ptoal@cisco.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1077500017.1746.13.camel@ptoal-pc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 22 Feb 2004 20:33:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce wrote:
> I tried using this client with up to 2.6.1-mm5 and ended up with Dead
> processes for cvpnd and vpnclient, nothing else was affected, went
> back to 2.4.x kernel.
> Regards
> Sid

Sid, et al. 

First, before anyone starts deluging me with questions, you should know
that even though my details say Cisco, I am an SE in the field, _not_ a
developer.  Second, please reply to me off-list, as I do not subscribe
to the LK list.  

That being said, I think I've tracked this down to a recent change in
the net/core/dev.c file.  I reversed the patch to
register_netdevice_notifier below, and the vpnclient now works fine. 
This is called by the handle_vpnup routine in interceptor.c of the
vpnclient kernel module.

I am _not_ a kernel developer, nor do I spend the majority of my time
programming, so I haven't been able to figure out _why_ these changes
cause the module to freeze.  I'd be interested if anyone could tell me
the answer to that question. :-)

Regards,
Patrick

@@ -946,11 +996,29 @@
  *     The notifier passed is linked into the kernel structures and must
  *     not be reused until it has been unregistered. A negative errno code
  *     is returned on a failure.
+ *
+ *     When registered all registration and up events are replayed
+ *     to the new notifier to allow device to have a race free
+ *     view of the network device list.
  */
 
 int register_netdevice_notifier(struct notifier_block *nb)
 {
-       return notifier_chain_register(&netdev_chain, nb);
+       struct net_device *dev;
+       int err;
+
+       rtnl_lock();
+       err = notifier_chain_register(&netdev_chain, nb);
+       if (!err) {
+               for (dev = dev_base; dev; dev = dev->next) {
+                       nb->notifier_call(nb, NETDEV_REGISTER, dev);
+
+                       if (dev->flags & IFF_UP)
+                               nb->notifier_call(nb, NETDEV_UP, dev);
+               }
+       }
+       rtnl_unlock();
+       return err;
 }
 
 /**


-- 
Patrick J. Toal, Systems Engineer, CCCS
Cisco Systems Canada Co.
181 Bay Street, Bay Wellington Tower, Suite 3400
Toronto, Ontario, Canada M5J 2T3
Phone: 416-306-7735     Pager: 1-800-682-4726

