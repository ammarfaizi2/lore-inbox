Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWDUDbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWDUDbl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 23:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWDUDbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 23:31:41 -0400
Received: from outmail96.yourhostingaccount.com ([65.254.253.96]:53223 "EHLO
	mailout12.yourhostingaccount.com") by vger.kernel.org with ESMTP
	id S932153AbWDUDbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 23:31:40 -0400
Message-ID: <4448520C.5080508@donlaw.com>
Date: Thu, 20 Apr 2006 23:31:24 -0400
From: Don Law <opendon@donlaw.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH linux-2.6.17-rc1] net: fix neigh_delete to handle mult. tables
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-EN-UserInfo: 00916540e7d738a24a7ba965d8bca573:eb482232937e409c7149bc02336d19dd
X-EN-AuthUser: poptest@salientsoftware.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The neigh_delete assumes that there is only one table with the desired
protocol family for the address being deleted.  This assumption is not
always valid.  For example, in a kernel configured with both the
typical Ethernet configuration (CONFIG_NET_ETHERNET=y etc.) as well
as ATM (CONFIG_ATM=y and CONFIG_ATM_CLIP=y), there are two tables, 
namely arp_tbl and clip_tbl, both with family AF_INET.

The problem fixed by this patch is that the "for" loop in neigh_delete
will not iterate further once it finds one table with a matching family.
The code changes refactor neigh_delete such that it will continue
to iterate through the neighbor tables until it finds a match or 
finishes the tables.

To see the symptom of the problem, you must have a kernel with more
than one AF_INET transport configured, then try to delete a neighbor
table entry.  The delete will fail with EINVAL.  For example:

    [root@bonefish ~]# ip neigh list dev eth4
    192.168.4.24 lladdr 00:90:fb:a1:07:2f nud reachable
    [root@bonefish ~]# ip neigh delete 192.168.4.24 dev eth4
    RTNETLINK answers: Invalid argument
    [root@bonefish ~]# ip neigh list dev eth4
    192.168.4.24 lladdr 00:90:fb:a1:07:2f nud reachable

One side effect of this change is that neigh_lookup is now called while
a read lock is held on neigh_tbl_lock.  neigh_lookup does take read
locks on the tbl->lock set.  However, this does not introduce any new lock
order dependencies, since we already have that precedent set in the
neightbl_set function.

Signed-off-by: Don Law <opendon@donlaw.com>

---

I have built this patch against the 2.6.17-rc1 kernel.

I tested this patch with the simple test case described above, plus let
it run for a few days on the box to make sure it behaves OK.  I also
verified that I can properly delete IPV6 neighbor entries.


--- linux-2.6.17-rc1/net/core/neighbour.c.orig  2006-04-11 16:28:10.000000000 -0
400
+++ linux-2.6.17-rc1/net/core/neighbour.c       2006-04-13 10:01:19.000000000 -0
400
@@ -1430,48 +1430,54 @@ int neigh_delete(struct sk_buff *skb, st
        struct rtattr **nda = arg;
        struct neigh_table *tbl;
        struct net_device *dev = NULL;
-       int err = -ENODEV;
+       int err;
 
        if (ndm->ndm_ifindex &&
-           (dev = dev_get_by_index(ndm->ndm_ifindex)) == NULL)
-               goto out;
+                       (dev = dev_get_by_index(ndm->ndm_ifindex)) == NULL)
+               return -ENODEV;
 
        read_lock(&neigh_tbl_lock);
-       for (tbl = neigh_tables; tbl; tbl = tbl->next) {
+       for (tbl = neigh_tables; ; tbl = tbl->next) {
                struct rtattr *dst_attr = nda[NDA_DST - 1];
                struct neighbour *n;
 
+               if (!tbl) {
+                       read_unlock(&neigh_tbl_lock);
+                       err = -EADDRNOTAVAIL;
+                       break;
+               }
                if (tbl->family != ndm->ndm_family)
                        continue;
-               read_unlock(&neigh_tbl_lock);
 
                err = -EINVAL;
-               if (!dst_attr || RTA_PAYLOAD(dst_attr) < tbl->key_len)
-                       goto out_dev_put;
+               if (!dst_attr || RTA_PAYLOAD(dst_attr) < tbl->key_len) {
+                       read_unlock(&neigh_tbl_lock);
+                       break;
+               }
 
                if (ndm->ndm_flags & NTF_PROXY) {
+                       read_unlock(&neigh_tbl_lock);
                        err = pneigh_delete(tbl, RTA_DATA(dst_attr), dev);
-                       goto out_dev_put;
+                       break;
                }
 
-               if (!dev)
-                       goto out;
+               if (!dev) {
+                       read_unlock(&neigh_tbl_lock);
+                       break;
+               }
 
                n = neigh_lookup(tbl, RTA_DATA(dst_attr), dev);
                if (n) {
-                       err = neigh_update(n, NULL, NUD_FAILED, 
+                       read_unlock(&neigh_tbl_lock);
+                       err = neigh_update(n, NULL, NUD_FAILED,
                                           NEIGH_UPDATE_F_OVERRIDE|
                                           NEIGH_UPDATE_F_ADMIN);
                        neigh_release(n);
+                       break;
                }
-               goto out_dev_put;
        }
-       read_unlock(&neigh_tbl_lock);
-       err = -EADDRNOTAVAIL;
-out_dev_put:
        if (dev)
                dev_put(dev);
-out:
        return err;
 }


