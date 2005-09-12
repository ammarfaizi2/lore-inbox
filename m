Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVILVN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVILVN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVILVNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:13:25 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:54317 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932149AbVILVNZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:13:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ogRM1MgVv+uoHmZUuAGNBk5X2xQwGSdMBV5n4buBWVxxO9yfeSQQHVhKuovANKC6h45YybOnjf9YMIRST62MmiTXEEXAs8v6qKIU4oRk3dSBIXE0ZkWP8ZCnIWjYBK1RyMgpTF+vktTN1UiiELnAK3dxdeL67aTUWHTltzE3MdE=
Message-ID: <6bffcb0e05091214133c189d05@mail.gmail.com>
Date: Mon, 12 Sep 2005 23:13:21 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: Alexander Nyberg <alexn@telia.com>
Subject: Re: 2.6.13-mm3 [OOPS] vfs, page_owner, full reproductively, badness in vsnprintf
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050912175433.GA8574@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050912024350.60e89eb1.akpm@osdl.org>
	 <6bffcb0e050912044856628995@mail.gmail.com>
	 <20050912175433.GA8574@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/09/05, Alexander Nyberg <alexn@telia.com> wrote:
> 
> Gah, I'm such a fantastic programmer.
> 
> I don't know what mc is up to but the error checking in read_page_owner
> is flawed wrt snprintf which could cause the 'size' argument to snprintf
> to become negative and if so overwrite beyond 'buf'.
> 
> Again, I fail to see how mc causes this to happen, but this fixes it
> by proper error checking.
> 
> Signed-off-by: Alexander Nyberg <alexn@telia.com>

Thanks, patch solved problem.
Here is version, that clean apply on 2.6.13-mm3. Can you review it?

Regards,
Michal Piotrowski

Signed-off-by: Michal K. K. Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-mm-clean/Documentation/dontdiff
linux-mm-clean/fs/proc/proc_misc.c linux-mm/fs/proc/proc_misc.c
--- linux-mm-clean/fs/proc/proc_misc.c	2005-09-12 23:02:10.000000000 +0200
+++ linux-mm/fs/proc/proc_misc.c	2005-09-12 22:52:51.000000000 +0200
@@ -567,6 +567,7 @@ read_page_owner(struct file *file, char 
  	char namebuf[128];
  	unsigned long offset = 0, symsize;
 	int i;
+	ssize_t num_written = 0;
 
  	pfn = min_low_pfn + *ppos;
  	page = pfn_to_page(pfn);
@@ -587,23 +588,41 @@ read_page_owner(struct file *file, char 
  	kbuf = kmalloc(count, GFP_KERNEL);
  	if (!kbuf)
  		return -ENOMEM;
+        ret = snprintf(kbuf, count, "Page allocated via order %d,
mask 0x%x\n",                        page->order, page->gfp_mask);
+        if (ret >= count) {
+                ret = -ENOMEM;
+                goto out;
+        }
+
+        num_written = ret;
 
-	ret = snprintf(kbuf, 1024, "Page allocated via order %d, mask 0x%x\n",
-			page->order, page->gfp_mask);
 
 	for (i = 0; i < 8; i++) {
 		if (!page->trace[i])
 			break;
  		symname = kallsyms_lookup(page->trace[i], &symsize, &offset,
&modname, namebuf);
-		ret += snprintf(kbuf + ret, count - ret, "[0x%lx] %s+%lu\n",
+                ret = snprintf(kbuf + num_written, count -
num_written, "[0x%lx] %s+%lu\n",
  			page->trace[i], namebuf, offset);
+                if (ret >= count - num_written) {
+                        ret = -ENOMEM;
+                        goto out;
+                }
+                num_written += ret;
+
 	}
+        ret = snprintf(kbuf + num_written, count - num_written, "\n");
+        if (ret >= count - num_written) {
+                ret = -ENOMEM;
+                goto out;
+        }
 
-	ret += snprintf(kbuf + ret, count -ret, "\n");
+        num_written += ret;
+        ret = num_written;
 
  	if (copy_to_user(buf, kbuf, ret))
  		ret = -EFAULT;
 
+out:
  	kfree(kbuf);
  	return ret;
 }
