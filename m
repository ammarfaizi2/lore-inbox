Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSGYOvY>; Thu, 25 Jul 2002 10:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSGYOvY>; Thu, 25 Jul 2002 10:51:24 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:44297 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315374AbSGYOvW>; Thu, 25 Jul 2002 10:51:22 -0400
Date: Thu, 25 Jul 2002 15:54:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
Cc: linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: LVM 1.0.5 patch for Linux 2.4.19-rc3
Message-ID: <20020725155433.A12776@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Heinz J . Mauelshagen" <mauelshagen@sistina.com>,
	linux-kernel@vger.kernel.org, mge@sistina.com
References: <20020725153944.A8060@sistina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020725153944.A8060@sistina.com>; from mauelshagen@sistina.com on Thu, Jul 25, 2002 at 03:39:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, more comments on the actual patch:


+	/* remove pv's */
+	for(i = 0; i < vg_ptr->pv_max; i++)
+		if(vg_ptr->pv[i]) lvm_fs_remove_pv(vg_ptr, vg_ptr->pv[i]);
+

The code was carefully indented to match Documentation/CodingStyle.
Please don't mix random indentation changes with bugfixes..

--- linux-2.4.19-rc3.orig/drivers/md/lvm-internal.h	Thu Jul 25 13:05:13 2002
+++ linux-2.4.19-rc3/drivers/md/lvm-internal.h	Thu Jul 25 13:46:01 2002
@@ -49,6 +49,10 @@
 extern vg_t *vg[];
 extern struct file_operations lvm_chr_fops;
 
+#ifndef	uchar
+typedef	unsigned char	uchar;
+#endif

Do you _really_ have to use this non-standard type?  can't you use the
BSD u_char or sysv unchar?  and typedef/#define don't really mix nicely..

+#ifdef	list_move
+				list_move(next, hash_table);
+#else
 				list_del(next);
-				list_add(next, hash_table);
+#endif				list_add(next, hash_table);

In 2.5 list_move is a inline function, in 2.4 it is not present at all (yet).
An as LVM is utterly broken on 2.5 anyway this change has _no_ use at all.

 /* variables */
-char *lvm_version =
-    "LVM version " LVM_RELEASE_NAME "(" LVM_RELEASE_DATE ")";
+char *lvm_version = "LVM version "LVM_RELEASE_NAME"("LVM_RELEASE_DATE")";

when you change this anyway, what about const char[] to squeeze out a few bytes?

 struct file_operations lvm_chr_fops = {
-	open:lvm_chr_open,
-	release:lvm_chr_close,
-	ioctl:lvm_chr_ioctl,
+	owner:		THIS_MODULE,
+	open:		lvm_chr_open,
+	release:	lvm_chr_close,
+	ioctl:		lvm_chr_ioctl,
 };

when you update this you could move to C99 initializers, can't you?
 
+static struct gendisk lvm_gendisk =
+{
+	major:		MAJOR_NR,
+	major_name:	LVM_NAME,
+	minor_shift:	0,

this is in .bss, you don't need to initialize to zero.

-}				/* lvm_init() */
+} /* lvm_init() */


can't you just kill those silly end-of-function comments entirely?

 	case 0:
+		down_write(&lv->lv_lock);
 		lv->lv_snapshot_use_rate = lv_rate_req.rate;
+		up_write(&lv->lv_lock);
+		down_read(&lv->lv_lock);

you are sure youreally want to drop the lock here and not downgrade it?
(yes, I'm prodding for the downgrade patch to finally get merged..)

All in all this patch would be _soooo_ much easier to review if you wouldn't
mix random indentation changes with real fixes.
