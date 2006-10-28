Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWJ1SjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWJ1SjZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWJ1SjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:39:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:31014 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751345AbWJ1SjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:39:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=g3l05vV4nAlLe00AD+VvJOoByNExpZD6uB5X6KZ2vWEeCIbWXRZBuHc/8wrX2ezTkLGOX2n++tDdCJym/IbQ5AIBNvG5j8TBfhKODbTRFyE2A6f/tC+FO1dPdTN/RNxkLYEFpIKFnOlwUyFy/0xtiAT8JmaQvdkpqZldCRvjG4c=
Date: Sun, 29 Oct 2006 03:39:43 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
       Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH] acpiphp: fix use of list_for_each macro
Message-ID: <20061028183943.GA9973@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
	Kristen Carlson Accardi <kristen.c.accardi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes invalid usage of list_for_each()

list_for_each (node, &bridge_list) {
	bridge = (struct acpiphp_bridge *)node;
	...
}

This code works while the member of list node is located at the
head of struct acpiphp_bridge.

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/pci/hotplug/acpiphp_glue.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Index: work-fault-inject/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- work-fault-inject.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ work-fault-inject/drivers/pci/hotplug/acpiphp_glue.c
@@ -1693,14 +1693,10 @@ void __exit acpiphp_glue_exit(void)
  */
 int __init acpiphp_get_num_slots(void)
 {
-	struct list_head *node;
 	struct acpiphp_bridge *bridge;
-	int num_slots;
-
-	num_slots = 0;
+	int num_slots = 0;
 
-	list_for_each (node, &bridge_list) {
-		bridge = (struct acpiphp_bridge *)node;
+	list_for_each_entry (bridge, &bridge_list, list) {
 		dbg("Bus %04x:%02x has %d slot%s\n",
 				pci_domain_nr(bridge->pci_bus),
 				bridge->pci_bus->number, bridge->nr_slots,
