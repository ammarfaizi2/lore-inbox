Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269192AbUJFKmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269192AbUJFKmq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 06:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269169AbUJFKmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 06:42:46 -0400
Received: from mgw-x4.nokia.com ([131.228.20.27]:31195 "EHLO mgw-x4.nokia.com")
	by vger.kernel.org with ESMTP id S269192AbUJFKmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 06:42:36 -0400
X-Scanned: Wed, 6 Oct 2004 13:42:16 +0300 Nokia Message Protector V1.3.31 2004060815 - RELEASE
Message-ID: <4163CB64.1050000@nokia.com>
Date: Wed, 06 Oct 2004 13:39:32 +0300
From: =?ISO-8859-1?Q?Timo_Ter=E4s?= <ext-timo.teras@nokia.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ext Greg KH <greg@kroah.com>
CC: Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: kobject events questions
References: <415ABA96.6010908@nokia.com> <1096486749.4666.31.camel@betsy.boston.ximian.com> <415D28B7.5070306@nokia.com> <20041001164750.GA11646@kroah.com> <20041001184714.GA19587@two.research.nokia.com> <20041001192238.GA24404@kroah.com>
In-Reply-To: <20041001192238.GA24404@kroah.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA6A6048626702A8F554D11E5"
X-OriginalArrivalTime: 06 Oct 2004 10:42:15.0098 (UTC) FILETIME=[24E791A0:01C4AB91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA6A6048626702A8F554D11E5
Content-Type: multipart/mixed;
 boundary="------------000706090003020208060402"

This is a multi-part message in MIME format.
--------------000706090003020208060402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ext Greg KH wrote:
> That's the point.  It should "be difficult" in that you need to present
> a valid reason to the whole kernel community as to why a new event needs
> to be added.  But if you make a point that others agree with, then there
> should be no problem in adding it.

Ok. Now that I can implement my iptables plugin I need either:

1) A new event: something like "went idle". Which would be sent from the 
class_device kobject of related network interface.

or

2) I could use the class interface system to add an kobject (instead of 
writing a new class) for each network devices class_device. But to 
accomplish this I have to be able to register interfaces with net_class 
defined net-sysfs.c. See applied patch. It's provides similar functions 
as scsi layer (see scsi_register_interface).

Which one would be better choice? At least the option #2 is general 
purpose and some others might find it useful too. To whom/where I should 
send it?

- Timo


--------------000706090003020208060402
Content-Type: text/plain;
 name="netdev_interface.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdev_interface.diff"

Index: linux/net/core/net-sysfs.c
===================================================================
--- linux.orig/net/core/net-sysfs.c	2004-09-27 18:27:16.000000000 +0300
+++ linux/net/core/net-sysfs.c	2004-10-06 13:22:07.347392792 +0300
@@ -448,3 +448,11 @@
 {
 	return class_register(&net_class);
 }
+
+int netdev_register_interface(struct class_interface *intf)
+{
+	intf->class = &net_class;
+	return class_interface_register(intf);
+}
+
+EXPORT_SYMBOL_GPL(netdev_register_interface);
Index: linux/include/linux/netdevice.h
===================================================================
--- linux.orig/include/linux/netdevice.h	2004-09-27 18:27:54.000000000 +0300
+++ linux/include/linux/netdevice.h	2004-10-06 13:29:51.031902032 +0300
@@ -953,6 +953,12 @@
 extern char *net_sysctl_strdup(const char *s);
 #endif
 
+#ifdef CONFIG_SYSFS
+extern int netdev_register_interface(struct class_interface *intf);
+#define netdev_unregister_interface(intf) \
+	class_interface_unregister(intf)
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif	/* _LINUX_DEV_H */

--------------000706090003020208060402--

--------------enigA6A6048626702A8F554D11E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBY8tnFlRU9HaAsIcRAlBrAJ483znGzZCMB9Ir/Vpupj/bJkGQywCfbbUk
ytYNlvwMwCF5VFk943VFvMo=
=iJ3a
-----END PGP SIGNATURE-----

--------------enigA6A6048626702A8F554D11E5--
