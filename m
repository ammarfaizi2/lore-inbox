Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269666AbUJACJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269666AbUJACJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 22:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269661AbUJACJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 22:09:58 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:28614 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269666AbUJACJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 22:09:53 -0400
Date: Fri, 01 Oct 2004 11:11:36 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] add hook for PCI resource deallocation
In-reply-to: <20040930160318.3cebcb89.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Message-id: <415CBCD8.4040206@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <41498CF6.9000808@jp.fujitsu.com>
 <20040924130251.A26271@unix-os.sc.intel.com> <20040924212208.GD7619@kroah.com>
 <4157CA04.5050604@jp.fujitsu.com> <20040930145014.71e04b25.akpm@osdl.org>
 <20040930152117.A30196@unix-os.sc.intel.com>
 <20040930160318.3cebcb89.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ashok Raj <ashok.raj@intel.com> wrote:
>>
>> On Thu, Sep 30, 2004 at 02:50:14PM -0700, Andrew Morton wrote:
>> > Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
>> > >
>> > > I'm attaching updated patches for adding pcibiod_disable_device()
>> > > hook based on the feedback from Ashok (Thank you, Ashok!).
>> > 
>> > This appears to be a patch-reversed version of the patch which is already
>> > in -mm:
>> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm4/broken-out/add-hook-for-pci-resource-deallocation.patch
>> > 
>> > So I'm not sure what you're trying to do here.
>> 
>> 
>> In the original patch, Kenji added a dummy function in several source files. Instead now
>> the new patch should have a single default implementation with a __attribute__((weak))
>> 
>> As a result its removing all the old additions and now keeping just a single default function.
> 
> Oh.  You may as well send a (chagelogged, signed off) new patch against
> current -linus in that case.
> 

I'm sorry about that.
Please use the following patch.

Thanks,
Kenji Kaneshige


Name:		add_pcibios_disable_device_hook.patch
Kernel Version:	2.6.9-rc2-mm1
Depends:	none
Change Log:

    - Chaged to use __attrubute__ ((weak)) instead of modifying all
      arch specific code.

Description:

This patch adds a hook 'pcibios_disable_device()' into
pci_disable_device() to call architecture specific PCI resource
deallocation code. It's a opposite part of pcibios_enable_device().
We need this hook to deallocate architecture specific PCI resource
such as IRQ resource, etc.. This patch is just for adding the hook, so
'pcibios_disable_device()' is defined as a null function on all
architecture so far.

I tested this patch on i386, x86_64 and ia64. But it has not been
tested on other architectures because I don't have these machines.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


---

 linux-2.6.9-rc2-mm1-kanesige/drivers/pci/pci.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -puN drivers/pci/pci.c~add_pcibios_disable_device_hook drivers/pci/pci.c
--- linux-2.6.9-rc2-mm1/drivers/pci/pci.c~add_pcibios_disable_device_hook	2004-09-27 11:10:54.000000000 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/drivers/pci/pci.c	2004-09-27 16:24:43.944414436 +0900
@@ -392,6 +392,16 @@ pci_enable_device(struct pci_dev *dev)
 }
 
 /**
+ * pcibios_disable_device - disable arch specific PCI resources for device dev
+ * @dev: the PCI device to disable
+ *
+ * Disables architecture specific PCI resources for the device. This
+ * is the default implementation. Architecture implementations can
+ * override this.
+ */
+void __attribute__ ((weak)) pcibios_disable_device (struct pci_dev *dev) {}
+
+/**
  * pci_disable_device - Disable PCI device after use
  * @dev: PCI device to be disabled
  *
@@ -411,6 +421,8 @@ pci_disable_device(struct pci_dev *dev)
 		pci_command &= ~PCI_COMMAND_MASTER;
 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
 	}
+
+	pcibios_disable_device(dev);
 }
 
 /**

_


