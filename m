Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTJENMz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 09:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbTJENMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 09:12:55 -0400
Received: from ozlabs.org ([203.10.76.45]:16070 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263106AbTJENMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 09:12:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16256.6322.388402.857084@cargo.ozlabs.ibm.com>
Date: Sun, 5 Oct 2003 23:12:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: oops when removing sbp2 module
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting an oops inside the sysfs stuff when I try to remove the
sbp2 (firewire disk) module.  I am running Linus' current BK tree as
of yesterday, i.e. 2.6.0-test6 (plus).  I'm not sure whether the
problem is in sysfs, kobject, scsi or ieee1394 stuff, which is why I'm
posting this to 3 lists.

I have a 40GB disk in a firewire enclosure.  To use it, I insert the
ohci1394 and sbp2 modules, and the disk appears as a SCSI disk.
If I then remove the sbp2 module I get an oops from a null pointer
dereference in sysfs_hash_and_remove.  At that point dir->d_inode is
NULL.  It turns out that sysfs_remove_dir has already been called for
the directory and that is why dir->d_inode is NULL.

In fact what is happening is that class_device_unregister gets called
twice for the same classdev.  This is because scsi_remove_device gets
called twice for the same device.  The first time, the call chain
looks like this:

scsi_remove_device
sbp2_remove_device
sbp2_remove
device_release_driver
driver_detach
bus_remove_driver
driver_unregister
hpsb_unregister_protocol
sbp2_module_exit

and the second time it looks like this:

scsi_remove_device
scsi_forget_host
scsi_remove_host
sbp2_remove_host
hpsb_unregister_highlevel
sbp2_module_exit

So, is this a reference counting problem on the classdev, a problem
where the scsi layer doesn't remove the scsi device from its internal
lists properly in scsi_remove_device, or a problem in the sbp2 code?
Anyone got a fix?

Thanks,
Paul.
