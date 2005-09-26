Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVIZJQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVIZJQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 05:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVIZJQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 05:16:19 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:18686 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932440AbVIZJQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 05:16:19 -0400
Date: Mon, 26 Sep 2005 11:15:37 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: export ipl device parameters
Message-ID: <20050926091537.GA10062@osiris.boeblingen.de.ibm.com>
References: <20050923095002.GA20928@osiris.boeblingen.de.ibm.com> <20050924004801.GB21283@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050924004801.GB21283@suse.de>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > +#ifdef CONFIG_SYSFS
> Does anyone build a s390 kernel without sysfs?  You can probably just
> drop this ifdef.

Yes, you're right.

> > +DEFINE_IPL_ATTR(lun, "0x%016llx\n", (unsigned long long)
> > +DEFINE_IPL_ATTR(bootprog, "%lld\n", (unsigned long long)
> Why have a format field, if you only use the same format?

I use two different formats (hexadecimal and decimal).

> > +	__ATTR(device, S_IRUGO, ipl_device_show, NULL);
> Why not use __ATTR_RO() like you did above?

The name of the attribute is supposed to be 'device'. If I would use
__ATTR_RO it stringifies the first parameter and the result would be
'ipl_device' because of the function name I use.
Otherwise I would have to rename my function, which is something I
don't want to do. Somehow __ATTR_RO doesn't fit.

> > +#define IPL_PARMBLOCK_ORIGIN	0x2000
> You are just directly addressing memory with this address, right?

Yes.

> Shouldn't you iomap it or something first?

No, we don't have memory mapped IO on S390.

How about this:

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Remove unnecessary ifdef + unused variable.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 arch/s390/kernel/setup.c |    6 ------
 1 file changed, 6 deletions(-)

diff -urN a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
--- a/arch/s390/kernel/setup.c	2005-09-26 10:48:31.000000000 +0200
+++ b/arch/s390/kernel/setup.c	2005-09-26 11:01:12.000000000 +0200
@@ -686,8 +686,6 @@
 	.show	= show_cpuinfo,
 };
 
-#ifdef CONFIG_SYSFS
-
 #define DEFINE_IPL_ATTR(_name, _format, _value)			\
 static ssize_t ipl_##_name##_show(struct subsystem *subsys,	\
 		char *page)					\
@@ -847,7 +845,6 @@
 
 static int __init
 ipl_device_sysfs_register(void) {
-	struct attribute_group *attr_group;
 	int rc;
 
 	rc = firmware_register(&ipl_subsys);
@@ -868,12 +865,9 @@
 	default:
 		sysfs_create_group(&ipl_subsys.kset.kobj,
 				   &ipl_unknown_attr_group);
-		attr_group = &ipl_unknown_attr_group;
 		break;
 	}
 	return 0;
 }
 
 __initcall(ipl_device_sysfs_register);
-
-#endif /* CONFIG_SYSFS */
