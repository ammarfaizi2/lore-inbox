Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVKGSnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVKGSnG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbVKGSnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:43:06 -0500
Received: from fmr21.intel.com ([143.183.121.13]:5299 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S964893AbVKGSnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:43:04 -0500
Date: Mon, 7 Nov 2005 10:41:50 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, kristen.c.accardi@intel.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: 2.6.14-mm1: drivers/pci/hotplug/: namespace clashes
Message-ID: <20051107104150.A4388@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20051106182447.5f571a46.akpm@osdl.org> <20051107173732.GG3847@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051107173732.GG3847@stusta.de>; from bunk@stusta.de on Mon, Nov 07, 2005 at 06:37:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 06:37:32PM +0100, Adrian Bunk wrote:
> <--  snip  -->
> 
> ...
>   LD      drivers/pci/hotplug/built-in.o
> drivers/pci/hotplug/shpchp.o: In function `get_hp_hw_control_from_firmware':
> : multiple definition of `get_hp_hw_control_from_firmware'
> drivers/pci/hotplug/pciehp.o:: first defined here
> ld: Warning: size of symbol `get_hp_hw_control_from_firmware' changed from 472 in drivers/pci/hotplug/pciehp.o to 25 in drivers/pci/hotplug/shpchp.o
> drivers/pci/hotplug/shpchp.o: In function `get_hp_params_from_firmware':
> : multiple definition of `get_hp_params_from_firmware'
> drivers/pci/hotplug/pciehp.o:: first defined here
> make[3]: *** [drivers/pci/hotplug/built-in.o] Error 1
> 
This patch should fix this:

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>

 drivers/pci/hotplug/pciehp.h           |    4 ++--
 drivers/pci/hotplug/pciehprm_acpi.c    |    4 ++--
 drivers/pci/hotplug/pciehprm_nonacpi.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.14-mm1/drivers/pci/hotplug/pciehp.h
===================================================================
--- linux-2.6.14-mm1.orig/drivers/pci/hotplug/pciehp.h
+++ linux-2.6.14-mm1/drivers/pci/hotplug/pciehp.h
@@ -191,8 +191,8 @@ extern u8	pciehp_handle_power_fault	(u8 
 /* pci functions */
 extern int	pciehp_configure_device		(struct slot *p_slot);
 extern int	pciehp_unconfigure_device	(struct slot *p_slot);
-extern int	get_hp_hw_control_from_firmware(struct pci_dev *dev);
-extern void	get_hp_params_from_firmware(struct pci_dev *dev,
+extern int	pciehp_get_hp_hw_control_from_firmware(struct pci_dev *dev);
+extern void	pciehp_get_hp_params_from_firmware(struct pci_dev *dev,
 	       	struct hotplug_params *hpp);
 
 
Index: linux-2.6.14-mm1/drivers/pci/hotplug/pciehprm_acpi.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/pci/hotplug/pciehprm_acpi.c
+++ linux-2.6.14-mm1/drivers/pci/hotplug/pciehprm_acpi.c
@@ -169,7 +169,7 @@ static int is_root_bridge(acpi_handle ha
 	return 0;
 }
 
-int get_hp_hw_control_from_firmware(struct pci_dev *dev)
+int pciehp_get_hp_hw_control_from_firmware(struct pci_dev *dev)
 {
 	acpi_status status;
 	acpi_handle chandle, handle = DEVICE_ACPI_HANDLE(&(dev->dev));
@@ -228,7 +228,7 @@ int get_hp_hw_control_from_firmware(stru
 	return -1;
 }
 
-void get_hp_params_from_firmware(struct pci_dev *dev,
+void pciehp_get_hp_params_from_firmware(struct pci_dev *dev,
 		struct hotplug_params *hpp)
 {
 	acpi_status status = AE_NOT_FOUND;
Index: linux-2.6.14-mm1/drivers/pci/hotplug/pciehprm_nonacpi.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/pci/hotplug/pciehprm_nonacpi.c
+++ linux-2.6.14-mm1/drivers/pci/hotplug/pciehprm_nonacpi.c
@@ -36,13 +36,13 @@
 
 #include "pciehp.h"
 
-void get_hp_params_from_firmware(struct pci_dev *dev,
+void pciehp_get_hp_params_from_firmware(struct pci_dev *dev,
 		struct hotplug_params *hpp)
 {
 	return;
 }
 
-int get_hp_hw_control_from_firmware(struct pci_dev *dev)
+int pciehp_get_hp_hw_control_from_firmware(struct pci_dev *dev)
 {
 	return 0;
 }
