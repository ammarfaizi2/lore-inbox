Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbUKKB66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbUKKB66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 20:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUKKB65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 20:58:57 -0500
Received: from fmr04.intel.com ([143.183.121.6]:43182 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262081AbUKKB6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 20:58:54 -0500
Date: Wed, 10 Nov 2004 17:54:15 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Greg KH <greg@kroah.com>, Len Brown <len.brown@intel.com>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Hotplug List <linux-hotplug-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       ACPI Developer <acpi-devel@lists.sourceforge.net>
Subject: Re: [PATCH] kobject: fix double kobject_put in kobject_unregister()
Message-ID: <20041110175415.B14535@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20041110141923.A13668@unix-os.sc.intel.com> <20041110225421.GA16785@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041110225421.GA16785@kroah.com>; from greg@kroah.com on Wed, Nov 10, 2004 at 02:54:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 02:54:21PM -0800, Greg KH wrote:
> On Wed, Nov 10, 2004 at 02:19:23PM -0800, Keshavamurthy Anil S wrote:
> No, this is wrong.  Count the add and put in the sequence of:
> 	kobject_register()
> 	kobject_unregister()
> 
> they are balanced.

Yes, I agree now, but after investigating further here is what I have found.
If you think this is good, please ack this patch.


> 
> You mention you are seeing problems.  Have a trace?  Example code?

Here is what exactly happening. Please see the patch.
In ACPI, kobject_init() is called without initializing kobj.kset.
Due to this kset.kobj's refcount does not get incremented.
Again when we try to do kobject_unregister(), kset of the kobject
that is getting unregister is obtained and kset's kobject refcount
is decremented which was at teh first place never got inceremened.
Due to this kset's kobj's refcount is decremented with out getting
incremented and due to this bug, this kset.kobj is getting released.

Below fix fixes this problem. If you find this this Good patch,
please ack this patch. I am copying to Len too on this patch.


Signed-of-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---

 linux-2.6.10-rc1-mm4-askeshav/drivers/acpi/scan.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/acpi/scan.c~kobject_register_fix1 drivers/acpi/scan.c
--- linux-2.6.10-rc1-mm4/drivers/acpi/scan.c~kobject_register_fix1	2004-11-10 17:40:23.393117553 -0800
+++ linux-2.6.10-rc1-mm4-askeshav/drivers/acpi/scan.c	2004-11-10 17:41:45.844288418 -0800
@@ -112,13 +112,12 @@ static void acpi_device_register(struct 
 		list_add_tail(&device->wakeup_list,&acpi_wakeup_device_list);
 	spin_unlock(&acpi_device_lock);
 
-	kobject_init(&device->kobj);
 	strlcpy(device->kobj.name,device->pnp.bus_id,KOBJ_NAME_LEN);
 	if (parent)
 		device->kobj.parent = &parent->kobj;
 	device->kobj.ktype = &ktype_acpi_ns;
 	device->kobj.kset = &acpi_namespace_kset;
-	kobject_add(&device->kobj);
+	kobject_register(&device->kobj);
 	create_sysfs_device_files(device);
 }
 
_
