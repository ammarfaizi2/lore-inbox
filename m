Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVDUHbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVDUHbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVDUHbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:31:22 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:36279 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261425AbVDUHaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:07 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Date: Thu, 21 Apr 2005 02:07:02 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1306
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200504210207.02421.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I happened to take a look into drivers/w1 and found there bunch of thigs
that IMO should be changed:

- custom-made refcounting is racy
- lifetime rules need to be better enforced
- family framework is insufficient for many advanced w1 devices
- custom-made hotplug notification over netlink should be removed in favor
  of standard hotplug notification
- sysfs attributes have unnecessary prefixes (like w1_master) or not needed
  at all (w1_master_pointer)

Please consider series of patches below. Unfortunately I do not have any W1
equipment so it was only compile-tested. Please also note that lifetime and
locking rules were changed on object-by-object base so mid-series some stuff
may appear broken but as far as I can see the end result shoudl work pretty
well.

w1-whitespace.patch
   Whitespace fixes.

w1-formatting.patch
   Some formatting changes to bring the code in line with CodingStyle
   guidelines.

w1-master-attr-group.patch
   Use attribute_group to create master device attributes to guarantee
   proper cleanup in case of failure. Also, hide most of attribute define
   ugliness in macros.

w1-slave-attr-group.patc
   Add 2 default attributes "family" and "serial" to slave devices, every
   1-Wire slave has them. Use attribute_group to handle. The rest of slave
   attributes are left as is - will be dealt with later.
   
w1-lists-cleanup.patch
   List handling cleanup. Most of the list_for_each_safe users don't need
   *_safe variant, *_entry variant is better suited in most places. Also,
   checking retrieved list element for null is a bit pointless...

w1-drop-owner.patch
   Drop owner field from w1_master and w1_slave structures. Just having it
   there does not magically fixes lifetime rules.

w1-bus-ops.patch
   Cleanup bus operations code:
   - have bus operatiions accept w1_master instead of unsigned long and
     drop data field from w1_bus_master so the structure can be statically
     allocated by driver implementing it;
   - rename w1_bus_master to w1_bus_ops to avoid confusion with w1_master;
   - separate master registering and allocation so drivers can setup proper
     link between private data and master and set useable master's name.

w1-fold-w1-int.patch
   Fold w1_int.c into w1.c - there is no point in artificially separating
   code for master devices between 2 files.

w1-drop-netlink.patch
   Drop custom-made hotplug over netlink notification from w1 core.
   Standard hotplug mechanism should work just fine (patch will follow).

w1-drop-control-thread.patch
   Drop control thread from w1 core, whatever it does can also be done in
   the context of w1_remove_master_device. Also, pin the module when
   registering new master device to make sure that w1 core is not unloaded
   until last device is gone. This simplifies logic a lot.

w1-move-search-to-io.patch
   Move w1_search function to w1_io.c to be with the rest of IO code.

w1-master-drop-attrs.patch
   Get rid of unneeded master device attributes:
   - 'pointer' and 'attempts' are meaningless for userspace;
   - information provided by 'slaves' and 'slave_count' can be gathered
     from other sysfs bits;
   - w1_slave_found has to be rearranged now that slave_count field is gone.

w1-master-attr-cleanup.patch
   Clean-up master attribute implementation:
   - drop unnecessary "w1_master" prefix from attribute names;
   - do not acquire master->mutex when accessing attributes;
   - move attribute code "closer" to the rest of master code.

w1-master-scan-interval.patch
   More master attributes changes:
   - rename timeout parameter/attribute to scan_interval to better
     reflect its purpose;
   - make scan_timeout be a per-device attribute and allow changing
     it from userspace via sysfs;
   - allow changing max_slave_count it from userspace as well.

w1-master-add-ttl-attr.patch
   Add slave_ttl attribute to w1 masters.

w1-master-cleanup.patch
   Clean-up master device implementation:
   - get rid of separate refcount, rely on driver model to enforce
     lifetime rules;
   - use atomic to generate unique master IDs;
   - drop unused fields.

w1-slave-cleanup.patch
   Clean-up slave device implementation:
   - get rid of separate refcount, rely on driver model to enforce
     lifetime rules;
   - pin w1 module until slave device is registered with sysfs to make
     sure W1 core stays loaded.
   - drop 'name' attribute as we already have it in bus_id.

w1-family-cleanup.patch
   Clean-up family implementation:
   - get rid of w1_family_ops and template attributes in w1_slave
     structure and have family drivers create necessary attributes
     themselves. There are too many different devices using 1-Wire
     interface and it is impossible to fit them all into single
     attribute model. If interface unification is needed it can be
     done by building cross-bus class hierarchy.
   - rename w1_smem to w1_sernum because devices are called Silicon
     serial numbers, they have address (ID) but don't have memory
     in regular sense.
   - rename w1_therm to w1_thermal.

w1-family-is-driver.patch
   Convert family into proper device-model drivers:
   - embed driver structure into w1_family and register with the
     driver core;
   - do not try to manually bind slaves to familes, leave it to
     the driver core;
   - fold w1_family.c into w1.c

w1-device-id.patch
   Support for automatic family drivers loading via hotplug:
   - allow family drivers support list of families;
   - export supported families through MODULE_DEVICE_TABLE.

w1-hotplug.patch
   Implement W1 bus hotplug handler. Slave devices will define
   FID=%02x (family ID) end SN=%024llX environment variables.

w1-module-attrs.patch
   Allow changing w1 module parameters through sysfs, add parameter
   descriptions and document them in Documentation/kernel-parameters.txt

Thanks!

-- 
Dmitry
