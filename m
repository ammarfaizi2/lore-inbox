Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030583AbWJ3UEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030583AbWJ3UEp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWJ3UEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:04:44 -0500
Received: from mail.parknet.jp ([210.171.160.80]:44295 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932479AbWJ3UEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:04:43 -0500
X-AuthUser: hirofumi@parknet.jp
To: akpm@osdl.org, sfrench@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] cifs: ->readpages() fixes
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 31 Oct 2006 05:04:39 +0900
Message-ID: <871wopmuy0.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just ignore the remaining pages, and will fix a forgot put_pages_list().

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/cifs/file.c |   23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff -puN fs/cifs/file.c~readpages-fixes-cifs fs/cifs/file.c
--- linux-2.6/fs/cifs/file.c~readpages-fixes-cifs	2006-10-31 04:26:13.000000000 +0900
+++ linux-2.6-hirofumi/fs/cifs/file.c	2006-10-31 04:26:13.000000000 +0900
@@ -1806,13 +1806,6 @@ static int cifs_readpages(struct file *f
 		}
 		if ((rc < 0) || (smb_read_data == NULL)) {
 			cFYI(1, ("Read error in readpages: %d", rc));
-			/* clean up remaing pages off list */
-			while (!list_empty(page_list) && (i < num_pages)) {
-				page = list_entry(page_list->prev, struct page,
-						  lru);
-				list_del(&page->lru);
-				page_cache_release(page);
-			}
 			break;
 		} else if (bytes_read > 0) {
 			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
@@ -1831,13 +1824,7 @@ static int cifs_readpages(struct file *f
 				   this case is ok - if we are at server EOF 
 				   we will hit it on next read */
 
-			/* while (!list_empty(page_list) && (i < num_pages)) {
-					page = list_entry(page_list->prev, 
-							  struct page, list);
-					list_del(&page->list);
-					page_cache_release(page);
-				}
-				break; */
+				/* break; */
 			}
 		} else {
 			cFYI(1, ("No bytes read (%d) at offset %lld . "
@@ -1845,14 +1832,6 @@ static int cifs_readpages(struct file *f
 				 bytes_read, offset));
 			/* BB turn off caching and do new lookup on 
 			   file size at server? */
-			while (!list_empty(page_list) && (i < num_pages)) {
-				page = list_entry(page_list->prev, struct page,
-						  lru);
-				list_del(&page->lru);
-
-				/* BB removeme - replace with zero of page? */
-				page_cache_release(page);
-			}
 			break;
 		}
 		if (smb_read_data) {
_
