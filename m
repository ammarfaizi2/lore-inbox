Return-Path: <linux-kernel-owner+w=401wt.eu-S1753302AbWLWA0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbWLWA0S (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 19:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322AbWLWA0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 19:26:18 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53912 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302AbWLWA0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 19:26:17 -0500
Date: Fri, 22 Dec 2006 16:25:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
cc: Thomas Meyer <thomas@m3y3r.de>, Steve French <sfrench@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: WARNING: "test_clear_page_dirty" [fs/cifs/cifs.ko] undefined!
In-Reply-To: <20061222223034.b29aeb5f.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.64.0612221615430.3671@woody.osdl.org>
References: <458BEB9D.8030709@m3y3r.de> <20061222223034.b29aeb5f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Dec 2006, Jean Delvare wrote:
> 
> The approach seems quite broken to me, the users should have been fixed
> _before_ removing the function, so as to avoid compilation failures.
> These are a pain for testers, and break git bisect too. Grmbl.

This needed to be fixed, and quite frankly, things don't get fixed nearly 
as quickly if you don't just break them first. And there really were just 
two filesystems that got broken, cifs being one of them.

I just can't test it.

> Now that it's done... Steve, can you please take a look and provide a
> patch so that cifs builds again?

CIFS _should_ be using "clear_page_dirty_for_io()" in that place, and that 
will fix the build. However, the reason I didn't just do that myself is 
that I can't test the end result, and for the life of me, I can't see 
where CIFS does the "end_page_writeback()" that it needs to do at IO 
completion time.

And the thing that confuses me about that, is that if CIFS doesn't do 
"end_page_writeback()", then it was already broken before - because when 
the VM calls "->writepage()" the clear_page_dirty_for_io() will have been 
done by the VM, and it needs that "end_page_writeback()" so that the 
system can know when the IO is done.

I _suspect_ that those "unlock_page()" calls should be accompanied by a 
"end_page_writeback()" call, and that the proper patch MAY look something 
like the appended, but I worry about having missed something really 
subtle. Maybe there's a end_page_writeback() somewhere else.

And if there isn't, I wonder if shared mappings have _ever_ worked on 
CIFS? And if so, how? That writeback bit thing isn't new per se.

So this may or may not fix it. If you can test it (_including_ with some 
dirty shared mmap-on-mmap action, please - just call me kinky), I'll 
commit it. But I need somebody who actually uses this to test it.

		Linus

---
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 0f05cab..4f0472d 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1245,7 +1245,7 @@ retry:
 				wait_on_page_writeback(page);
 
 			if (PageWriteback(page) ||
-					!test_clear_page_dirty(page)) {
+					!clear_page_dirty_for_io(page)) {
 				unlock_page(page);
 				break;
 			}
@@ -1253,6 +1253,7 @@ retry:
 			if (page_offset(page) >= mapping->host->i_size) {
 				done = 1;
 				unlock_page(page);
+				end_page_writeback(page);
 				break;
 			}
 
@@ -1316,6 +1317,7 @@ retry:
 					SetPageError(page);
 				kunmap(page);
 				unlock_page(page);
+				end_page_writeback(page);
 				page_cache_release(page);
 			}
 			if ((wbc->nr_to_write -= n_iov) <= 0)
@@ -1356,7 +1358,8 @@ static int cifs_writepage(struct page* page, struct writeback_control *wbc)
 	rc = cifs_partialpagewrite(page, 0, PAGE_CACHE_SIZE);
 	SetPageUptodate(page); /* BB add check for error and Clearuptodate? */
 	unlock_page(page);
-	page_cache_release(page);	
+	end_page_writeback(page);
+	page_cache_release(page);
 	FreeXid(xid);
 	return rc;
 }
