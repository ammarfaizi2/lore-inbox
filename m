Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945990AbWANDKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945990AbWANDKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 22:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945991AbWANDKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 22:10:05 -0500
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:1719 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1945990AbWANDKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 22:10:04 -0500
Date: Fri, 13 Jan 2006 22:07:33 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] kobject: don't oops on null kobject.name
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200601132209_MC3-1-B5D3-F9A9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060114000246.GA7549@kroah.com>

On Fri, 13 Jan 2006, Greg KH wrote:

> Hm, I looked at the only user of kobjects in the kernel that I know of
> that doesn't use sysfs (the cdev code) and even it sets the kobject name
> to something sane, so I think we should be safe with this.

Well, something is still wrong.

I applied your patch to prevent registration of objects with null names on
top of my patch, then applied this to see if my test still triggered, and
the message was printed:


--- 2.6.15a.orig/lib/kobject.c
+++ 2.6.15a/lib/kobject.c
@@ -72,8 +72,10 @@ static int get_kobj_path_length(struct k
 	 * Add 1 to strlen for leading '/' of each level.
 	 */
 	do {
-		if (kobject_name(parent) == NULL)
+		if (kobject_name(parent) == NULL) {
+			printk("get_kobj_path_length: encountered NULL name\n");
 			return 0;
+		}
 		length += strlen(kobject_name(parent)) + 1;
 		parent = parent->parent;
 	} while (parent);


To reproduce:

Start with vanilla 2.6.15 and apply the three patches, which I called:

        kobject_dont_register_null_name.patch  <- my original
        kobject_handle_null_object_name.patch  <- Greg's
        kobject_debug_null_path.patch          <- included above

On a machine with an ATAPI CD-ROM, boot with "hdx=ide-scsi" where
hdx is the CD-ROM's drivename.  Then try to mount a CD:

        mount -t iso9660 /dev/hdx /mnt/cdrom

Note that hdx is being controlled by ide-scsi so this should fail.  You
will see the message from my new patch print in the kernel log.

NOTE:  This won't happen on 2.6.15-current because
fs/super.c::kill_block_super() no longer calls kobject_uevent().

-- 
Chuck
Currently reading: _Olympos_ by Dan Simmons
