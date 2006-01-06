Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWAFSt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWAFSt3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWAFSt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:49:28 -0500
Received: from mailhub5.stratus.com ([134.111.1.18]:42454 "EHLO
	mailhub5.stratus.com") by vger.kernel.org with ESMTP
	id S932356AbWAFSt1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:49:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: PATCH: hash-table corruption in bond_alb.c
Date: Fri, 6 Jan 2006 13:49:10 -0500
Message-ID: <92952AEF1F064042B6EF2522E0EEF437032252E1@EXNA.corp.stratus.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH: hash-table corruption in bond_alb.c
Thread-Index: AcYS8eE7Iv1WY/H/TKSbijpqyrm4bA==
From: "ODonnell, Michael" <Michael.ODonnell@stratus.com>
To: <bonding-devel@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Jan 2006 18:49:11.0395 (UTC) FILETIME=[E1F47330:01C612F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Our systems have been crashing during testing of PCI HotPlug
support in the various networking components.  We've faulted in
the bonding driver due to a bug in bond_alb.c:tlb_clear_slave()

In that routine, the last modification to the TLB hash table is
made without protection of the lock, allowing a race that can lead
tlb_choose_channel() to select an invalid table element.

Our patch file is included below.

Thanks,
  --Michael O'Donnell, Stratus Technologies, Maynard, MA  USA

Signed-off-by: Michael O'Donnell <Michael.ODonnell at stratus dot com>

--- drivers/net/bonding/bond_alb.c.orig	2006-01-06 10:28:33.000000000
-0500
+++ drivers/net/bonding/bond_alb.c	2006-01-06 10:30:06.000000000
-0500
@@ -30,20 +30,23 @@
  *	  handling required for ALB/TLB.
  *
  * 2003/12/01 - Shmulik Hen <shmulik.hen at intel dot com>
  *	- Code cleanup and style changes
  *
  * 2003/12/30 - Amir Noam <amir.noam at intel dot com>
  *	- Fixed: Cannot remove and re-enslave the original active slave.
  *
  * 2004/01/14 - Shmulik Hen <shmulik.hen at intel dot com>
  *	- Add capability to tag self generated packets in ALB/TLB modes.
+ *
+ * 2005/12/02 - Michael O'Donnell <Michael.ODonnell at stratus dot com>
+ *	- Stratus88746: tlb_clear_slave() must tlb_init_slave() while
locked.
  */
 
 //#define BONDING_DEBUG 1
 
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/pkt_sched.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -181,23 +184,23 @@ static void tlb_clear_slave(struct bondi
 	/* clear slave from tx_hashtbl */
 	tx_hash_table = BOND_ALB_INFO(bond).tx_hashtbl;
 
 	index = SLAVE_TLB_INFO(slave).head;
 	while (index != TLB_NULL_INDEX) {
 		u32 next_index = tx_hash_table[index].next;
 		tlb_init_table_entry(&tx_hash_table[index], save_load);
 		index = next_index;
 	}
 
-	_unlock_tx_hashtbl(bond);
+	tlb_init_slave(slave); /* Stratus88746: do this before unlocking
*/
 
-	tlb_init_slave(slave);
+	_unlock_tx_hashtbl(bond);
 }
 
 /* Must be called before starting the monitor timer */
 static int tlb_initialize(struct bonding *bond)
 {
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
 	int size = TLB_HASH_TABLE_SIZE * sizeof(struct tlb_client_info);
 	int i;
 
 	spin_lock_init(&(bond_info->tx_hashtbl_lock));
