Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTKQGFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 01:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTKQGFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 01:05:47 -0500
Received: from dp.samba.org ([66.70.73.150]:60822 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263343AbTKQGFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 01:05:42 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: file2alias - incorrect? aliases for USB 
In-reply-to: Your message of "Mon, 10 Nov 2003 01:37:03 -0800."
             <20031110093703.GA5449@kroah.com> 
Date: Mon, 17 Nov 2003 14:09:32 +1100
Message-Id: <20031117060542.489442C266@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031110093703.GA5449@kroah.com> you write:
> Hm, but that's no good either, because the visor driver trips over that
> with its entry:
> 	MODULE_ALIAS("usb:v*p*dl*dh*dc*dsc*dp*ic*isc*ip*");
> and the improper module is loaded.  That needs to be fixed up...
> 
> Rusty, any reason why the module alias code is turning an empty
> MODULE_PARAM structure, as is declared in drivers/usb/serial/visor.c
> with the line:
>         { },                                    /* optional parameter entry */ 
> 
> Into the above MODULE_ALIAS?  I don't think that's correct.

Sorry for the delay, was away and am catching up on mail.

Thanks to Andrey for the fix.  Greg, did you want to add something
else?  Either way, please forward to Linus.

Andrey: the reason everything is in there is I didn't know what Greg
wanted.  He OK'd it, but I'm happy for them to be trimmed, too.

Subject:  [PATCH][2.6.0-test9] prevent catch-all USB aliases in modules.alias
From:     Andrey Borzenkov
Date:     2003-11-03 16:45:03

visor.c defines one empty slot in USB ids table that can be filled in at 
runtime using module parameters. file2alias generates catch-all alias for it:

alias usb:v*p*dl*dh*dc*dsc*dp*ic*isc*ip* visor

patch adds the same sanity check as in depmod to scripts/file2alias.

regards

-andrey

*["2.6.0-test9-file2alias_visor.patch" (text/x-diff)]*

--- ../tmp/linux-2.6.0-test9/scripts/file2alias.c	2003-07-27 22:29:49.000000000 +0400
+++ linux-2.6.0-test9/scripts/file2alias.c	2003-11-03 19:40:47.744746456 +0300
@@ -52,6 +52,13 @@ static int do_usb_entry(const char *file
 	id->bcdDevice_lo = TO_NATIVE(id->bcdDevice_lo);
 	id->bcdDevice_hi = TO_NATIVE(id->bcdDevice_hi);
 
+	/*
+	 * Some modules (visor) have empty slots as placeholder for
+	 * run-time specification that results in catch-all alias
+	 */
+	if (!(id->idVendor | id->bDeviceClass | id->bInterfaceClass))
+		return 1;
+
 	strcpy(alias, "usb:");
 	ADD(alias, "v", id->match_flags&USB_DEVICE_ID_MATCH_VENDOR,
 	    id->idVendor);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
