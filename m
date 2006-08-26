Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422943AbWHZRot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422943AbWHZRot (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422945AbWHZRms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:42:48 -0400
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:38528 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1422968AbWHZRmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:42:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=XPA+U1DmONZEkaW0BjFuyiutWnNuDAlOEv9IGsI96zxseBvwn4+v0P+RRAbq/3VVy14p4BI6u9LHFfjXwlAND6hAPKwGh8TLbU0+aF1aUN5ZuAU+tfNwfZeUFfanZEkgy4KudUMYk7iW0amcW/A9y20ucPRTii9H/A0oH5wTpiI=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH RFP-V4 08/13] RFP prot support: support private vma for MAP_POPULATE
Date: Sat, 26 Aug 2006 19:42:36 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <20060826174236.14790.79303.stgit@memento.home.lan>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Fix mmap(MAP_POPULATE | MAP_PRIVATE). We don't need the VMA to be shared if we
don't rearrange pages around. And it's trivial to do.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 mm/fremap.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/fremap.c b/mm/fremap.c
index e62dc15..b1db410 100644
--- a/mm/fremap.c
+++ b/mm/fremap.c
@@ -191,9 +191,6 @@ retry:
 	if (!vma)
 		goto out_unlock;
 
-	if (!(vma->vm_flags & VM_SHARED))
-		goto out_unlock;
-
 	if (!vma->vm_ops || !vma->vm_ops->populate)
 		goto out_unlock;
 
@@ -218,6 +215,8 @@ retry:
 		/* Must set VM_NONLINEAR before any pages are populated. */
 		if (pgoff != linear_page_index(vma, start) &&
 		    !(vma->vm_flags & VM_NONLINEAR)) {
+			if (!(vma->vm_flags & VM_SHARED))
+				goto out_unlock;
 			if (!has_write_lock) {
 				up_read(&mm->mmap_sem);
 				down_write(&mm->mmap_sem);
@@ -236,6 +235,8 @@ retry:
 
 		if (pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot) &&
 				!(vma->vm_flags & VM_MANYPROTS)) {
+			if (!(vma->vm_flags & VM_SHARED))
+				goto out_unlock;
 			if (!has_write_lock) {
 				up_read(&mm->mmap_sem);
 				down_write(&mm->mmap_sem);
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
