Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbTDHXPd (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTDHXPd (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:15:33 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:27618 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262515AbTDHXPa (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 19:15:30 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>, Alistair Strachan <alistair@devzero.co.uk>
Subject: Re: 2.5.67-mm1
Date: Tue, 8 Apr 2003 16:24:19 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200304081741.10129.alistair@devzero.co.uk> <20030408142853.74709a82.akpm@digeo.com>
In-Reply-To: <20030408142853.74709a82.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_J0T1CHDSZ7ZH5RQNXU7O"
Message-Id: <200304081624.19444.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_J0T1CHDSZ7ZH5RQNXU7O
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 08 April 2003 02:28 pm, Andrew Morton wrote:
> Alistair Strachan <alistair@devzero.co.uk> wrote:
> > On attempting to boot this kernel, I get the following just before in=
it:
> > Kernel panic: VFS: Unable to mount root fs on 03:05
> >
> > 2.5.67 base works fine. I discovered that reverting the following
> > patches allows me to boot. I can increase the granularity of my searc=
h
> > if nothing comes immediately to mind:
> >
> > aggregated-disk-stats.patch
> > dynamic-hd_struct-allocation-fixes.patch
> > dynamic-hd_struct-allocation.patch
>
> Ah, good detective work, thanks.  It looks like the hd_struct dynamic
> allocation patch has broken devfs partition discovery somehow.

Okay !! My bad.=20

Here is the patch for 2.5.67-mm1. Could you try and let me know ?

Thanks,
Badari


--------------Boundary-00=_J0T1CHDSZ7ZH5RQNXU7O
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="devfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="devfs.patch"

--- linux-2.5.67/fs/partitions/check.c	Tue Apr  8 16:21:30 2003
+++ linux-2.5.67.new/fs/partitions/check.c	Tue Apr  8 16:26:01 2003
@@ -163,13 +163,13 @@ static void devfs_register_partition(str
 	struct hd_struct *p = dev->part;
 	char devname[16];
 
-	if (p[part-1].de)
+	if (p[part-1]->de)
 		return;
 	dir = dev->de;
 	if (!dir)
 		return;
 	sprintf(devname, "part%d", part);
-	p[part-1].de = devfs_register (dir, devname, 0,
+	p[part-1]->de = devfs_register (dir, devname, 0,
 				    dev->major, dev->first_minor + part,
 				    S_IFBLK | S_IRUSR | S_IWUSR,
 				    dev->fops, NULL);
@@ -281,14 +281,13 @@ void add_partition(struct gendisk *disk,
 	memset(p, 0, sizeof(struct hd_struct));
 	p->start_sect = start;
 	p->nr_sects = len;
+	p->partno = part;
+	disk->part[part-1] = p;
 	devfs_register_partition(disk, part);
 	snprintf(p->kobj.name,KOBJ_NAME_LEN,"%s%d",disk->kobj.name,part);
 	p->kobj.parent = &disk->kobj;
 	p->kobj.ktype = &ktype_part;
 	kobject_register(&p->kobj);
-
-	p->partno = part;
-	disk->part[part-1] = p;
 }
 
 static void disk_sysfs_symlinks(struct gendisk *disk)

--------------Boundary-00=_J0T1CHDSZ7ZH5RQNXU7O--

