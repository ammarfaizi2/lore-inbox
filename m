Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTECTHI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 15:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTECTHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 15:07:08 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:60933 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263385AbTECTHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 15:07:04 -0400
Subject: Re: [RFC] support for sysfs string based properties for SCSI (1/3)
From: James Bottomley <James.Bottomley@steeleye.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       Mike Anderson <andmike@us.ibm.com>
In-Reply-To: <1051989099.2036.7.camel@mulgrave>
References: <1051989099.2036.7.camel@mulgrave>
Content-Type: multipart/mixed; boundary="=-fa00y8sLhK5Re6VaMnOQ"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 03 May 2003 14:19:23 -0500
Message-Id: <1051989565.2036.14.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fa00y8sLhK5Re6VaMnOQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2003-05-03 at 14:11, James Bottomley wrote:
> 
> This first patch is of general interest (the other two are going to the
> SCSI list only).
> 
> The problem this seeks to solve is that we have a bunch of properties in
> SCSI that we'd like to expose through the sysfs interface.  The
> mid-layer can get their values, but setting them requires co-operation
> from the host drivers, thus we'd like to expose a show/store interface
> to all the SCSI drivers.
> 
> The current one call back per sysfs file is a bit unwieldy for
> encapsulating in an interface like this.  what this patch does is to
> allow a fallback show/store method of the bus type (if the device type
> doesn't exist).  However, the bus_type show/store passes in the
> attribute so a comparison may be done against the name of the attribute.
> 
> For details of how all this gets used, see the following SCSI patches.
> 
> James

And this time with the correct attachment.

James


--=-fa00y8sLhK5Re6VaMnOQ
Content-Description: 
Content-Disposition: inline; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.1196  -> 1.1197=20
#	 drivers/base/core.c	1.65    -> 1.66  =20
#	include/linux/device.h	1.87    -> 1.88  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/03	jejb@raven.il.steeleye.com	1.1197
# sysfs: add default show/store for bus_type
#=20
# These are used if the device_attribute show/store are empty.  They
# allow buses to do string based parsing of the device properties.
# --------------------------------------------
#
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Sat May  3 14:18:21 2003
+++ b/drivers/base/core.c	Sat May  3 14:18:21 2003
@@ -42,6 +42,8 @@
=20
 	if (dev_attr->show)
 		ret =3D dev_attr->show(dev,buf);
+	else if (dev->bus->show)
+		ret =3D dev->bus->show(dev, buf, attr);
 	return ret;
 }
=20
@@ -55,6 +57,8 @@
=20
 	if (dev_attr->store)
 		ret =3D dev_attr->store(dev,buf,count);
+	else if (dev->bus->store)
+		ret =3D dev->bus->store(dev,buf,count,attr);
 	return ret;
 }
=20
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Sat May  3 14:18:21 2003
+++ b/include/linux/device.h	Sat May  3 14:18:21 2003
@@ -74,6 +74,10 @@
 	struct device * (*add)	(struct device * parent, char * bus_id);
 	int		(*hotplug) (struct device *dev, char **envp,=20
 				    int num_envp, char *buffer, int buffer_size);
+	ssize_t (*show)(struct device * dev, char * buf,
+			struct attribute *attr);
+	ssize_t (*store)(struct device * dev, const char * buf, size_t count,
+			 struct attribute *attr);
 };
=20
=20

--=-fa00y8sLhK5Re6VaMnOQ--

