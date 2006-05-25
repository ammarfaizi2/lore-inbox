Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWEYSv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWEYSv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWEYSv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:51:26 -0400
Received: from mga03.intel.com ([143.182.124.21]:19243 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030329AbWEYSvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:51:25 -0400
X-IronPort-AV: i="4.05,173,1146466800"; 
   d="scan'208"; a="41628979:sNHT4328713676"
Subject: RE: 2.6.17-rc4-mm3 - kernel panic
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Andreas Saur <saur@acmelabs.de>, linux-acpi@vger.kernel.org, pavel@suse.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB68AD7E1@hdsmsx411.amr.corp.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB68AD7E1@hdsmsx411.amr.corp.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 May 2006 12:01:15 -0700
Message-Id: <1148583675.3070.41.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
X-OriginalArrivalTime: 25 May 2006 18:49:52.0803 (UTC) FILETIME=[020E0F30:01C6802C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 22:03 -0700, Brown, Len wrote:
> Same panic with and without a docking station present?
> 
> Does the panic go away with CONFIG_ACPI_DOCK=n?
> 
> -Len
> 

Can either Pavel or Andreas please try this little debugging patch and
send me the dmesg output?  Please enable the CONFIG_DEBUG_KERNEL option
in your .config as well so that I can get additional info.

Len (or anyone),
I had a theory that perhaps I'm having a race condition between the two
drivers, however, I'm not sure if this is even a possibility at boot
time, so I wanted to run this theory by you and see if you thought it
could happen.  

The dock driver calls acpi_walk_namespace to check for _DCK method.
When it finds it, it allocates a struct dock_station, and then calls
acpi_walk_namespace again to find all the dependent devices.  This is
all done as part of the dock driver's init.

When acpiphp driver is called, it also calls acpi_walk_namespace to
check for pci devices dependent on the dock station.  It calls a
function exported from the dock driver (is_dock_device) to determine
this.  is_dock_device should only be called *after* the dock driver is
finished it's init, because the driver *must* have completed it's search
for dependent devices before it can answer the question
is_dock_device()?.  

My understanding is that if your init routine is marked with the
module_init() macro, then all module init routines will be serialized
with respect to each other.  i.e., Can I expect that the function
indicated by module_init() would be completed before the function marked
by acpiphp's module_init() would be called?  How does the use of
acpi_walk_namespace affect serialization of the module_init?  Does it
allow the possibility that the acpiphp driver may enter it's module_init
before the dock driver has completed it's init?

Thanks,
Kristen


---
 drivers/acpi/dock.c |    4 ++++
 1 file changed, 4 insertions(+)

--- 2.6-mm.orig/drivers/acpi/dock.c
+++ 2.6-mm/drivers/acpi/dock.c
@@ -190,6 +190,10 @@ static int is_dock(acpi_handle handle)
  */
 int is_dock_device(acpi_handle handle)
 {
+	if (!dock_station) {
+		printk(KERN_ERR "Dock station not done being initialized!!!\n");
+		return 0;
+	}
 	if (is_dock(handle) || find_dock_dependent_device(dock_station, handle))
 		return 1;
 
