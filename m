Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSG2AVG>; Sun, 28 Jul 2002 20:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSG2AVG>; Sun, 28 Jul 2002 20:21:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13329 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317468AbSG2AVD>;
	Sun, 28 Jul 2002 20:21:03 -0400
Message-ID: <3D448D38.D156C249@zip.com.au>
Date: Sun, 28 Jul 2002 17:32:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
References: <3D439E10.67A839A5@zip.com.au> <Pine.LNX.4.44.0207281649560.9427-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 28 Jul 2002, Andrew Morton wrote:
> >
> > There are some situations where a page's final release is performed by
> > put_page().  Such as in access_process_vm().  This tends to go BUG()
> > because the page is on the LRU.
> 
> This is wrong.
> 
> If that happens, then you should just make access_process_vm() use
> "page_cache_release()". That's what you basically make "__free_pages_ok()"
> do, but since you still have to add the BUG_ON() check to make clear that
> it is illegal to do this from an interrupt context, it's much better to
> just do this check statically.
> 

OK.  This means that put_page() against userspace-mapped pages
is to be avoided.

Did an audit.  What on earth is drivers/scsi/sg.c:sg_rb_correct4mmap()
doing?

Also skb_release_data(), ___pskb_trim() and __pskb_pull_tail().  Can these
ever perform the final release against a page which is on the LRU? In
interrupt context?

tcp_sendmsg() is doing put_page() too.  I _think_ it's OK because
the page is mapped into the calling process and because of the
way in which shrink_cache() looks at page->count.  Not sure.



 fs/binfmt_elf.c |    3 ++-
 fs/smbfs/file.c |    8 ++++----
 kernel/ptrace.c |    3 ++-
 3 files changed, 8 insertions(+), 6 deletions(-)

--- 2.5.29/fs/binfmt_elf.c~put_page	Sun Jul 28 17:17:23 2002
+++ 2.5.29-akpm/fs/binfmt_elf.c	Sun Jul 28 17:31:33 2002
@@ -33,6 +33,7 @@
 #include <linux/smp_lock.h>
 #include <linux/compiler.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 
 #include <asm/uaccess.h>
 #include <asm/param.h>
@@ -1249,7 +1250,7 @@ static int elf_core_dump(long signr, str
 					flush_page_to_ram(page);
 					kunmap(page);
 				}
-				put_page(page);
+				page_cache_release(page);
 			}
 		}
 	}
--- 2.5.29/fs/smbfs/file.c~put_page	Sun Jul 28 17:19:08 2002
+++ 2.5.29-akpm/fs/smbfs/file.c	Sun Jul 28 17:19:40 2002
@@ -105,9 +105,9 @@ smb_readpage(struct file *file, struct p
 	int		error;
 	struct dentry  *dentry = file->f_dentry;
 
-	get_page(page);
+	page_cache_get(page);
 	error = smb_readpage_sync(dentry, page);
-	put_page(page);
+	page_cache_release(page);
 	return error;
 }
 
@@ -194,11 +194,11 @@ smb_writepage(struct page *page)
 	if (page->index >= end_index+1 || !offset)
 		return -EIO;
 do_it:
-	get_page(page);
+	page_cache_get(page);
 	err = smb_writepage_sync(inode, page, 0, offset);
 	SetPageUptodate(page);
 	unlock_page(page);
-	put_page(page);
+	page_cache_release(page);
 	return err;
 }
 
--- 2.5.29/kernel/ptrace.c~put_page	Sun Jul 28 17:20:04 2002
+++ 2.5.29-akpm/kernel/ptrace.c	Sun Jul 28 17:26:13 2002
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 
 #include <asm/pgtable.h>
@@ -156,7 +157,7 @@ int access_process_vm(struct task_struct
 			flush_page_to_ram(page);
 		}
 		kunmap(page);
-		put_page(page);
+		page_cache_release(page);
 		len -= bytes;
 		buf += bytes;
 		addr += bytes;

.
