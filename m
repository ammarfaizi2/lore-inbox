Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWBKWqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWBKWqB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 17:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWBKWqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 17:46:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:23168 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750778AbWBKWqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 17:46:01 -0500
Date: Sat, 11 Feb 2006 14:45:26 -0800
From: Greg KH <greg@kroah.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysfs-related oops during module unload (2.6.16-rc2)
Message-ID: <20060211224526.GA25237@kroah.com>
References: <20060211220351.GA3293@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060211220351.GA3293@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 04:03:53PM -0600, Nathan Lynch wrote:
> If the refcnt attribute of a module is open when the module is
> unloaded, we get an oops when the file is closed.  I used ide_cd for
> this report but I don't think the oops is caused by the driver itself.
> This bug seems to be restricted to the /sys/module hierarchy; it
> doesn't happen with /sys/class etc.
> 
> I suspect it's an extra put or a missing get somewhere, but the fix
> isn't obvious to me after looking at it for a little while, so I'm
> punting.
> 
> I'm pretty sure this happens with 2.6.15; I can double-check if
> needed.

Ugh, we aren't setting the owner of these fields properly, good catch.

Does the patch below (built tested only), solve this for you?

thanks,

greg k-h

-----------------

 kernel/module.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/kernel/module.c	2006-01-17 08:27:49.000000000 -0800
+++ gregkh-2.6/kernel/module.c	2006-02-11 14:44:19.000000000 -0800
@@ -1085,8 +1085,10 @@
 
 	for (i = 0; (attr = modinfo_attrs[i]) && !error; i++) {
 		if (!attr->test ||
-		    (attr->test && attr->test(mod)))
+		    (attr->test && attr->test(mod))) {
+			attr->attr.owner = mod;
 			error = sysfs_create_file(&mod->mkobj.kobj,&attr->attr);
+		}
 	}
 	return error;
 }
