Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263135AbSK0QED>; Wed, 27 Nov 2002 11:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSK0QED>; Wed, 27 Nov 2002 11:04:03 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:36808 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S263135AbSK0QEB>; Wed, 27 Nov 2002 11:04:01 -0500
Date: Wed, 27 Nov 2002 17:10:17 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] page walker bugfix (was: 2.5.49-mm2)
Message-ID: <20021127171017.H5263@nightmaster.csn.tu-chemnitz.de>
References: <3DE48C4A.98979F0C@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3DE48C4A.98979F0C@digeo.com>; from akpm@digeo.com on Wed, Nov 27, 2002 at 01:11:38AM -0800
X-Spam-Score: -3.9 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18H4mV-0006jN-00*TTIRUt684hk*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrew,
hi list readers,

On Wed, Nov 27, 2002 at 01:11:38AM -0800, Andrew Morton wrote:
> .. Some code from Ingo Oeser to start using the expanded and cleaned up
>   user pagetable walker code.  This affects the st and sg drivers; I'm
>   not sure of the testing status of this?

The testing status is: None, but it compiles.

The sg-driver maintainer has already said he does some testing
and the author of the previous code in st.c was positive about
using these features. That's why I've choosen these as my "victims".

I also found a locking bug in walk_user_pages() in case of OOM or
SIGBUS. Fixed by the attached patch.

The attached patch also exports some functions to enable modular
builds for testing.

And it also deletes the redundant check of the pfn_valid(), which
is done in follow_page() already.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth

--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="page-walk-api-2.5.49-mm2-bugfix.patch"

diff -Naur linux-2.5.49-mm2/mm/page_walk.c linux-2.5.49-mm2-ioe/mm/page_walk.c
--- linux-2.5.49-mm2/mm/page_walk.c	Wed Nov 27 14:48:33 2002
+++ linux-2.5.49-mm2-ioe/mm/page_walk.c	Wed Nov 27 17:05:35 2002
@@ -116,6 +116,7 @@
 	struct vm_area_struct *vma = pw->vma;
 	int write = pw->vm_flags & (VM_MAYWRITE|VM_WRITE);
 
+	/* follow_page also does all the checking of ptes for us. */
 	while (!(page= follow_page(vma->vm_mm, pw->virt, write))) {
 		int fault;
 
@@ -138,16 +139,7 @@
 		}
 		spin_lock(&vma->vm_mm->page_table_lock);
 	}
-	/* 
-	 * Given a physical address, is there a useful struct page pointing to
-	 * it?  This may become more complex in the future if we start dealing
-	 * with IO-aperture pages for direct-IO.
-	 */
-	if (pfn_valid(page_to_pfn(page)))
-		return page;
-
-	spin_unlock(&vma->vm_mm->page_table_lock);
-	return ERR_PTR(-EFAULT);
+	return page;
 }
 
 /* Setup page walking for the simple and common case. 
@@ -291,7 +283,7 @@
  			pw->page = single_page_walk(pw);
 			if (IS_ERR(pw->page)) {
 				ret = PTR_ERR(pw->page);
-				break;
+				goto out_unlocked;
 			}
 			ret = pw->walker(pw->data);
 			
@@ -304,7 +296,8 @@
  		} while (pw->virt < vma->vm_end);
 		spin_unlock(&pw->mm->page_table_lock);
 	} while (ret == 0);
-
+	
+out_unlocked:
 	/* cleanup after errors */
 	if (ret < 0 && pw->cleaner)
 		pw->cleaner(pw->data);
@@ -393,3 +386,12 @@
 EXPORT_SYMBOL(get_user_pages);
 EXPORT_SYMBOL(get_one_user_page);
 EXPORT_SYMBOL_GPL(walk_user_pages);
+EXPORT_SYMBOL_GPL(setup_simple_page_walk);
+EXPORT_SYMBOL_GPL(setup_sgl_page_walk);
+EXPORT_SYMBOL_GPL(fixup_sgl_walk);
+EXPORT_SYMBOL_GPL(gup_add_pages);
+EXPORT_SYMBOL_GPL(gup_cleanup_pages);
+EXPORT_SYMBOL_GPL(gup_cleanup_pages_kfree);
+EXPORT_SYMBOL_GPL(gup_add_sgls);
+EXPORT_SYMBOL_GPL(gup_cleanup_sgls);
+EXPORT_SYMBOL_GPL(gup_cleanup_sgls_kfree);

--WBsA/oQW3eTA3LlM--
