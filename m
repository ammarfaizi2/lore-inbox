Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVHQAKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVHQAKv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVHQAKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:10:50 -0400
Received: from rigel.cs.pdx.edu ([131.252.208.59]:62083 "EHLO rigel.cs.pdx.edu")
	by vger.kernel.org with ESMTP id S1750756AbVHQAKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:10:50 -0400
Message-ID: <000f01c5a2bf$f8e752d0$6401a8c0@woodworkxi42l4>
From: "Suzanne Wood" <suzannew@cs.pdx.edu>
To: <linux-kernel@vger.kernel.org>
Cc: <SteveW@ACM.org>, <paulmck@us.ibm.com>, <walpole@cs.pdx.edu>
Subject: rcu read-side protection
Date: Tue, 16 Aug 2005 17:09:29 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In dn_neigh_construct() of linux-2.6.12/net/decnet/dn_neigh.c

static int dn_neigh_construct(struct neighbour *neigh)
{
 struct net_device *dev = neigh->dev;
 struct dn_neigh *dn = (struct dn_neigh *)neigh;
 struct dn_dev *dn_db;
 struct neigh_parms *parms;

 rcu_read_lock();
 dn_db = rcu_dereference(dev->dn_ptr);
 if (dn_db == NULL) {
  rcu_read_unlock();
  return -EINVAL;
 }

 parms = dn_db->neigh_parms;
 if (!parms) {
  rcu_read_unlock();
  return -EINVAL;
 }

 __neigh_parms_put(neigh->parms);
 neigh->parms = neigh_parms_clone(parms);
 rcu_read_unlock();

 if (dn_db->use_long)
  neigh->ops = &dn_long_ops;
 else
  neigh->ops = &dn_short_ops;

 if (dn->flags & DN_NDFLAG_P3)
  neigh->ops = &dn_phase3_ops;

 neigh->nud_state = NUD_NOARP;
 neigh->output = neigh->ops->connected_output;

 if ((dev->type == ARPHRD_IPGRE) || (dev->flags & IFF_POINTOPOINT))
  memcpy(neigh->ha, dev->broadcast, dev->addr_len);
 else if ((dev->type == ARPHRD_ETHER) || (dev->type == ARPHRD_LOOPBACK))
  dn_dn2eth(neigh->ha, dn->addr);
 else {
  if (net_ratelimit())
   printk(KERN_DEBUG "Trying to create neigh for hw %d\n",  dev->type);
  return -EINVAL;
 }

A read-side critical section is marked to protect the dereference of the 
dn_ptr and assignment to dn_db which is a pointer to a dn_dev.  (struct 
net_device is defined in /linux/netdevice.h and its dn_ptr in 
/include/net/dn_dev.h)  Should this rcu-protection be extended to the line 
following rcu_read_lock()?  Even though use_long is a simple char, it 
appears to be a member of an rcu-protected structure.

Thank you.


