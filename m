Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbSBBXdM>; Sat, 2 Feb 2002 18:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbSBBXdD>; Sat, 2 Feb 2002 18:33:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10764 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S282967AbSBBXcs>;
	Sat, 2 Feb 2002 18:32:48 -0500
Message-ID: <3C5C76F2.78BA9A54@zip.com.au>
Date: Sat, 02 Feb 2002 15:32:02 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lars Christensen <larsch@cs.auc.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 agpgart process hang on crash
In-Reply-To: <3C5C68E2.32D11734@zip.com.au> <Pine.GSO.4.33.0202030009280.794-100000@peta.cs.auc.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Christensen wrote:
> 
> No luck. Still hangs (e.g. with ./testgart & pkill -ABRT testgart), with
> and without that patch and with and without 2.4.18-pre7. Does seem to
> happen when dumping core--it doesn't happen with core dumping disabled.
> 

This one, please:

--- linux-2.4.18-pre7/drivers/char/agp/agpgart_fe.c	Sun Aug 12 10:38:48 2001
+++ linux-akpm/drivers/char/agp/agpgart_fe.c	Sat Feb  2 15:29:49 2002
@@ -605,19 +605,18 @@ static int agp_mmap(struct file *file, s
 	agp_client *client;
 	agp_file_private *priv = (agp_file_private *) file->private_data;
 	agp_kern_info kerninfo;
+	int ret = -EPERM;
 
 	lock_kernel();
 	AGP_LOCK();
 
 	if (agp_fe.backend_acquired != TRUE) {
-		AGP_UNLOCK();
-		unlock_kernel();
-		return -EPERM;
+		ret = -EPERM;
+		goto out;
 	}
 	if (!(test_bit(AGP_FF_IS_VALID, &priv->access_flags))) {
-		AGP_UNLOCK();
-		unlock_kernel();
-		return -EPERM;
+		ret = -EPERM;
+		goto out;
 	}
 	agp_copy_info(&kerninfo);
 	size = vma->vm_end - vma->vm_start;
@@ -627,52 +626,46 @@ static int agp_mmap(struct file *file, s
 
 	if (test_bit(AGP_FF_IS_CLIENT, &priv->access_flags)) {
 		if ((size + offset) > current_size) {
-			AGP_UNLOCK();
-			unlock_kernel();
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		client = agp_find_client_by_pid(current->pid);
 
 		if (client == NULL) {
-			AGP_UNLOCK();
-			unlock_kernel();
-			return -EPERM;
+			ret = -EPERM;
+			goto out;
 		}
 		if (!agp_find_seg_in_client(client, offset,
 					    size, vma->vm_page_prot)) {
-			AGP_UNLOCK();
-			unlock_kernel();
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		if (remap_page_range(vma->vm_start,
 				     (kerninfo.aper_base + offset),
 				     size, vma->vm_page_prot)) {
-			AGP_UNLOCK();
-			unlock_kernel();
-			return -EAGAIN;
-		}
-		AGP_UNLOCK();
-		unlock_kernel();
-		return 0;
+			ret = -EAGAIN;
+			goto out;
+		}
+		ret = 0;
+		goto out;
 	}
 	if (test_bit(AGP_FF_IS_CONTROLLER, &priv->access_flags)) {
 		if (size != current_size) {
-			AGP_UNLOCK();
-			unlock_kernel();
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		if (remap_page_range(vma->vm_start, kerninfo.aper_base,
 				     size, vma->vm_page_prot)) {
-			AGP_UNLOCK();
-			unlock_kernel();
-			return -EAGAIN;
-		}
-		AGP_UNLOCK();
-		unlock_kernel();
-		return 0;
+			ret = -EAGAIN;
+			goto out;
+		}
+		ret = 0;
 	}
+out:
 	AGP_UNLOCK();
 	unlock_kernel();
+	if (ret == 0)
+		vma->vm_flags |= VM_IO;
 	return -EPERM;
 }
