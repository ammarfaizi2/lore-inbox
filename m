Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTFJKJK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 06:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTFJKIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 06:08:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:63113 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261411AbTFJKGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 06:06:19 -0400
Date: Tue, 10 Jun 2003 15:52:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misc 2.5 Fixes: cp-user-zoran
Message-ID: <20030610102255.GL2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100643.GB2194@in.ibm.com> <20030610100746.GC2194@in.ibm.com> <20030610100905.GD2194@in.ibm.com> <20030610100950.GE2194@in.ibm.com> <20030610101035.GF2194@in.ibm.com> <20030610101121.GG2194@in.ibm.com> <20030610101318.GH2194@in.ibm.com> <20030610101503.GI2194@in.ibm.com> <20030610101801.GJ2194@in.ibm.com> <20030610102024.GK2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610102024.GK2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use copy_to_user/put_user with user buffers.


 drivers/media/video/zoran_procfs.c |    6 +++++-
 drivers/media/video/zr36120.c      |   12 ++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff -puN drivers/media/video/zoran_procfs.c~cp-user-zoran drivers/media/video/zoran_procfs.c
--- linux-2.5.70-ds/drivers/media/video/zoran_procfs.c~cp-user-zoran	2003-06-08 04:10:38.000000000 +0530
+++ linux-2.5.70-ds-dipankar/drivers/media/video/zoran_procfs.c	2003-06-08 04:10:38.000000000 +0530
@@ -119,7 +119,11 @@ static int zoran_write_proc(struct file 
 		printk(KERN_ERR "%s: write_proc: can not allocate memory\n", zr->name);
 		return -ENOMEM;
 	}
-	memcpy(string, buffer, count);
+	if(copy_from_user(string, buffer, count))
+	{
+		vfree(string);
+		return -EFAULT;
+	}
 	string[count] = 0;
 	DEBUG2(printk(KERN_INFO "%s: write_proc: name=%s count=%lu data=%x\n", zr->name, file->f_dentry->d_name.name, count, (int) data));
 	ldelim = " \t\n";
diff -puN drivers/media/video/zr36120.c~cp-user-zoran drivers/media/video/zr36120.c
--- linux-2.5.70-ds/drivers/media/video/zr36120.c~cp-user-zoran	2003-06-08 04:10:38.000000000 +0530
+++ linux-2.5.70-ds-dipankar/drivers/media/video/zr36120.c	2003-06-08 04:10:38.000000000 +0530
@@ -1693,12 +1693,12 @@ long vbi_read(struct video_device* dev, 
 			for (x=0; optr+1<eptr && x<-done->w; x++)
 			{
 				unsigned char a = iptr[x*2];
-				*optr++ = a;
-				*optr++ = a;
+				__put_user(a, optr++);
+				__put_user(a, optr++);
 			}
 			/* and clear the rest of the line */
 			for (x*=2; optr<eptr && x<done->bpl; x++)
-				*optr++ = 0;
+				__put_user(0, optr++);
 			/* next line */
 			iptr += done->bpl;
 		}
@@ -1715,10 +1715,10 @@ long vbi_read(struct video_device* dev, 
 		{
 			/* copy to doubled data to userland */
 			for (x=0; optr<eptr && x<-done->w; x++)
-				*optr++ = iptr[x*2];
+				__put_user(iptr[x*2], optr++);
 			/* and clear the rest of the line */
 			for (;optr<eptr && x<done->bpl; x++)
-				*optr++ = 0;
+				__put_user(0, optr++);
 			/* next line */
 			iptr += done->bpl;
 		}
@@ -1727,7 +1727,7 @@ long vbi_read(struct video_device* dev, 
 	/* API compliance:
 	 * place the framenumber (half fieldnr) in the last long
 	 */
-	((ulong*)eptr)[-1] = done->fieldnr/2;
+	__put_user(done->fieldnr/2, ((ulong*)eptr)-1);
 	}
 
 	/* keep the engine running */

_
