Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130151AbRADHwR>; Thu, 4 Jan 2001 02:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130356AbRADHwH>; Thu, 4 Jan 2001 02:52:07 -0500
Received: from Cantor.suse.de ([194.112.123.193]:43792 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130151AbRADHvw>;
	Thu, 4 Jan 2001 02:51:52 -0500
Date: Thu, 4 Jan 2001 08:51:37 +0100
From: Andi Kleen <ak@suse.de>
To: Asang K Dani <asang@yahoo.com>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: generic_file_write code segment in 2.2.18
Message-ID: <20010104085137.A18532@gruyere.muc.suse.de>
In-Reply-To: <20010104052948.12042.qmail@web2303.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010104052948.12042.qmail@web2303.mail.yahoo.com>; from asang@yahoo.com on Wed, Jan 03, 2001 at 09:29:48PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 09:29:48PM -0800, Asang K Dani wrote:
> hi everyone,
>    I was trying to understand following piece of code in
> 'generic_file_read' (mm/filemap.c) for 2.2.18 kernel. The code
> segment
> is as follows:
> 
> ----------------------------------------------------------------
> 		dest = (char *) page_address(page) + offset;
> 		if (dest != buf) { /* See comment in
>                                       update_vm_cache_cond. */
> 			bytes -= copy_from_user(dest, buf, bytes);
> 			flush_dcache_page(page_address(page));
> 		}
> 		status = -EFAULT;
> 		if (bytes)
> 			status = inode->i_op->updatepage(file, page,                      
>                       offset, bytes, sync);
> 
>  unlock:
> 		/* Mark it unlocked again and drop the page.. */
> 		clear_bit(PG_locked, &page->flags);
> 		wake_up(&page->wait);
> 		page_cache_release(page);
> 
> 		if (status < 0)
> 			break;
> 
> 		written += status;
> 		count -= status;
> 		pos += status;
> 		buf += status;
> ----------------------------------------------------------------
> copy_from_user returns the number of bytes copied from userspace
> to 'dest'. In case it succeeds, 'bytes' will be set to 0 after the
> call. However, 'status' is set to -EFAULT. So wouldn't it break
> out of the while loop (prematurely)?

The code is buggy as far as I can see. copy_from_user doesn't return the 
number of bytes copied, but the number of bytes not copied when an error
occurs (or 0 on success).  


Correct would be:

	
--- linux-work/mm/filemap.c-o	Wed Jan  3 17:37:27 2001
+++ linux-work/mm/filemap.c	Thu Jan  4 08:48:42 2001
@@ -1685,11 +1685,11 @@
 		 */
 		dest = (char *) page_address(page) + offset;
 		if (dest != buf) { /* See comment in update_vm_cache_cond. */
-			bytes -= copy_from_user(dest, buf, bytes);
+			if (copy_from_user(dest, buf, bytes))
+				status = -EFAULT; 
 			flush_dcache_page(page_address(page));
 		}
-		status = -EFAULT;
-		if (bytes)
+		if (!status)
 			status = inode->i_op->updatepage(file, page, offset, bytes, sync);
 
  unlock:



-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
