Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVCWBug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVCWBug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 20:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVCWBug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 20:50:36 -0500
Received: from fmr20.intel.com ([134.134.136.19]:25805 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262175AbVCWBuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 20:50:25 -0500
Date: Tue, 22 Mar 2005 19:13:34 -0800
From: Dely Sy <dlsy@snoqualmie.dp.intel.com>
Message-Id: <200503230313.j2N3DYpE010786@snoqualmie.dp.intel.com>
To: gregkh@suse.de, rajesh.shah@intel.com
Subject: RE: [RFC/Patch 0/12] ACPI based root bridge hot-add
Cc: akpm@osdl.org, dely.l.sy@intel.com, len.brown@intel.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, tony.luck@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 21, 2005 5:07 PM, Dely Sy wrote:
> On Monday, March 21, 2005 10:05 AM, Rajesh Shah wrote:
> > On Fri, Mar 18, 2005 at 09:13:32PM -0800, Greg KH wrote:
> > > 	- Does this break the i386 acpiphp functionality?

> > Dely Sy had tested hotplug with an earlier version of my patches
> > (with minor differences from the current series) on i386 and it
> > worked fine. She probably hasn't tested the latest one. Dely,
> > could you check that please? 

> I tested an earlier version of this patch on my i386 system with
> PCI Express hot-plug slots.  The i386 acpiphp functionality worked
> fine - i.e. I was able to do hot-plug of single- & multi-function 
> cards.  

> I'll check this new patch on my system.

Earlier I reported that Matthew's acpiphp rewrite had problem in 
powering down slot on my i386 system.  The following patch is 
needed to get the acpiphp rewrite properly powering down the slot.
A similar patch was sent out to Matthew for comment and Rajesh 
had tested the patch on Tiger4.

I just did a test of Rajesh's latest patch on 2.6.11.5 with
Wilcox's acpiphp rewrite and the following patch.  Hot-plug of 
PCI Express card worked fine on my i386 system
 
Thanks,
Dely

Signed-off-by: Dely Sy <dely.l.sy@intel.com>

diff -urpN linux-2.6.11.5rbha/drivers/pci/hotplug/acpiphp_glue.c linux-2.6.11.5rbhatst/drivers/pci/hotplug/acpiphp_glue.c
--- linux-2.6.11.5rbha/drivers/pci/hotplug/acpiphp_glue.c	2005-03-22 00:56:04.000000000 -0800
+++ linux-2.6.11.5rbhatst/drivers/pci/hotplug/acpiphp_glue.c	2005-03-22 23:21:23.000000000 -0800
@@ -586,7 +586,7 @@ static int power_off_slot(struct acpiphp
 	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
-		if (func->pci_dev && (func->flags & FUNC_HAS_PS3)) {
+		if (func->flags & FUNC_HAS_PS3) {
 			status = acpi_evaluate_object(func->handle, "_PS3", NULL, NULL);
 			if (ACPI_FAILURE(status)) {
 				warn("%s: _PS3 failed\n", __FUNCTION__);
@@ -601,7 +601,7 @@ static int power_off_slot(struct acpiphp
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		/* We don't want to call _EJ0 on non-existing functions. */
-		if (func->pci_dev && (func->flags & FUNC_HAS_EJ0)) {
+		if (func->flags & FUNC_HAS_EJ0) {
 			/* _EJ0 method take one argument */
 			arg_list.count = 1;
 			arg_list.pointer = &arg;
