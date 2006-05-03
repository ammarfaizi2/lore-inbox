Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbWECDY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWECDY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 23:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbWECDY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 23:24:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34999 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965079AbWECDY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 23:24:26 -0400
Date: Tue, 2 May 2006 20:24:12 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Hans A Eide <haeide@usit.uio.no>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block/ub.c: Increase number of partitions for usb
 storage
Message-Id: <20060502202412.0d68150f.zaitcev@redhat.com>
In-Reply-To: <mailman.1146575400.25877.linux-kernel2news@redhat.com>
References: <mailman.1146575400.25877.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006 14:59:52 +0200, Hans A Eide <haeide@usit.uio.no> wrote:

> I do backups to external USB storage and hit the 8 partitions limit  
> of ub.c
> This could also be a problem for others (HFS+ formatted iPods?)

It was a bad mistake in retrospect. I limited ub to 8 partitions
because I wanted to fit 26 devices into 8 bits of minor.

> Any reason for not increasing the partitions limit to 16?

Doing so would not be compatible for systems which do not run udevd.
Linus forbade such changes, and I agree. So, if we strongly needed
ub to go beyond 1+7 partitions, we would need some kind of a remapping
scheme. I have to discuss this with Greg or Harald. Making dis-
contiguous nodes is easy with mknod, but I do not know if udev
supports it.

> +++ drivers/block/ub.c  2006-04-30 13:37:34.000000000 +0200
> @@ -113,7 +113,7 @@
> /*
>    */
> -#define UB_PARTS_PER_LUN      8
> +#define UB_PARTS_PER_LUN      16
> #define UB_MAX_CDB_SIZE      16                /* Corresponds to Bulk */

Your mailer corrupted your patch. The attached ought to work better,
but it's a subject to aforementioned compatibility problems.

-- Pete

--- linux-2.6.17-rc2/drivers/block/ub.c	2006-04-23 21:05:39.000000000 -0700
+++ linux-2.6.17-rc2-lem/drivers/block/ub.c	2006-05-02 20:14:15.000000000 -0700
@@ -113,7 +109,7 @@
 /*
  */
 
-#define UB_PARTS_PER_LUN      8
+#define UB_PARTS_PER_LUN     16
 
 #define UB_MAX_CDB_SIZE      16		/* Corresponds to Bulk */
 
diff -urp -X dontdiff linux-2.6.17-rc2/Documentation/devices.txt linux-2.6.17-rc2-lem/Documentation/devices.txt
--- linux-2.6.17-rc2/Documentation/devices.txt	2006-01-03 20:02:51.000000000 -0800
+++ linux-2.6.17-rc2-lem/Documentation/devices.txt	2006-05-02 20:13:17.000000000 -0700
@@ -2557,10 +2557,10 @@ Your cooperation is appreciated.
 		 66 = /dev/usb/cpad0	Synaptics cPad (mouse/LCD)
 
 180 block	USB block devices
-		0 = /dev/uba		First USB block device
-		8 = /dev/ubb		Second USB block device
-		16 = /dev/ubc		Thrid USB block device
-		...
+		  0 = /dev/uba		First USB block device
+		 16 = /dev/ubb		Second USB block device
+		 32 = /dev/ubc		Third USB block device
+		    ...
 
 181 char	Conrad Electronic parallel port radio clocks
 		  0 = /dev/pcfclock0	First Conrad radio clock
