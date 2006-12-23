Return-Path: <linux-kernel-owner+w=401wt.eu-S1753426AbWLWB2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbWLWB2p (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 20:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbWLWB2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 20:28:45 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:33999 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbWLWB2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 20:28:44 -0500
Date: Fri, 22 Dec 2006 17:28:40 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Ian McDonald" <ian.mcdonald@jandi.co.nz>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       sfrench@samba.org, linux-cifs-client@lists.samba.org,
       samba-technical@lists.samba.org, "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [BUG] CIFS won't link
Message-Id: <20061222172840.9bb66cf0.randy.dunlap@oracle.com>
In-Reply-To: <5640c7e00612221721h1463aad2xf01c2785c6febce0@mail.gmail.com>
References: <5640c7e00612221721h1463aad2xf01c2785c6febce0@mail.gmail.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2006 14:21:48 +1300 Ian McDonald wrote:

> In commit fba2591bf4e418b6c3f9f8794c9dd8fe40ae7bd9
> test_clear_page_dirty was removed a couple of days ago.
> 
> Now when I try and build I get this:
> WARNING: "test_clear_page_dirty" [fs/cifs/cifs.ko] undefined!
> 
> This is caused by line 1248 of fs/cifs/file.c
> 			if (PageWriteback(page) ||
> 					!test_clear_page_dirty(page)) {
> 
> This isn't my area of expertise so I'm not providing a fix as I'm sure
> I'll get it wrong!
> 
> My apologies if people have already fixed as I'm not on all the relevant lists.

Linus posted an (untested) patch for this about 10 minutes ago.
Is this something that you can test? (see below)


---
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
-

