Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUFGPzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUFGPzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUFGPzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:55:21 -0400
Received: from may.priocom.com ([213.156.65.50]:19165 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S264826AbUFGPxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:53:47 -0400
Subject: Re: [PATCH] 2.6.6 memory allocation checks in SliceBlock()
From: Yury Umanets <torque@ukrpost.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040606110333.57e5b853.rddunlap@osdl.org>
References: <1086538992.2793.94.camel@firefly>
	 <20040606110333.57e5b853.rddunlap@osdl.org>
Content-Type: text/plain
Message-Id: <1086623657.20964.19.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Jun 2004 18:54:17 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-06 at 21:03, Randy.Dunlap wrote:
> On Sun, 06 Jun 2004 19:23:12 +0300 Yury Umanets wrote:
> 
> | Adds memory allocation checks in SliceBlock()
> | 
> |  ./linux-2.6.6-modified/drivers/char/drm/sis_ds.c |    4 ++++
> |  1 files changed, 4 insertions(+)
> | 
> | Signed-off-by: Yury Umanets <torque@ukrpost.net>
> | 
> | diff -rupN ./linux-2.6.6/drivers/char/drm/sis_ds.c
> | ./linux-2.6.6-modified/drivers/char/drm/sis_ds.c
> | --- ./linux-2.6.6/drivers/char/drm/sis_ds.c	Mon May 10 05:33:19 2004
> | +++ ./linux-2.6.6-modified/drivers/char/drm/sis_ds.c	Wed Jun  2 14:19:22
> | 2004
> | @@ -231,6 +231,8 @@ static TMemBlock* SliceBlock(TMemBlock *
> |  	if (startofs > p->ofs) {
> |  		newblock = (TMemBlock*) DRM(calloc)(1, sizeof(TMemBlock),
> |  		    DRM_MEM_DRIVER);
> | +		if (!newblock)
> | +			return NULL;
> |  		newblock->ofs = startofs;
> |  		newblock->size = p->size - (startofs - p->ofs);
> |  		newblock->free = 1;
> | @@ -244,6 +246,8 @@ static TMemBlock* SliceBlock(TMemBlock *
> |  	if (size < p->size) {
> |  		newblock = (TMemBlock*) DRM(calloc)(1, sizeof(TMemBlock),
> |  		    DRM_MEM_DRIVER);
> | +		if (!newblock)
> | +			return NULL;
> |  		newblock->ofs = startofs + size;
> |  		newblock->size = p->size - size;
> |  		newblock->free = 1;
> | 
> | -- 
> 
> These look like the right thing to do, but one caller of
> SliceBlock() has no error handling:
> 
> mmAllocMem():
> 
> 	p = SliceBlock(p,startofs,size,0,mask+1);
> 	p->heap = heap;
> 	return p;
> 
> However, callers of mmAllocMem() do have failure handling.
Hello Randy,

This is fixed version:

 ./linux-2.6.6-modified/drivers/char/drm/sis_ds.c |    6 ++++++
 1 files changed, 6 insertions(+)

Signed-off-by: Yury Umanets <torque@ukrpost.net>

diff -rupN ./linux-2.6.6/drivers/char/drm/sis_ds.c
./linux-2.6.6-modified/drivers/char/drm/sis_ds.c
--- ./linux-2.6.6/drivers/char/drm/sis_ds.c	Mon May 10 05:33:19 2004
+++ ./linux-2.6.6-modified/drivers/char/drm/sis_ds.c	Mon Jun  7 18:41:41
2004
@@ -231,6 +231,8 @@ static TMemBlock* SliceBlock(TMemBlock *
 	if (startofs > p->ofs) {
 		newblock = (TMemBlock*) DRM(calloc)(1, sizeof(TMemBlock),
 		    DRM_MEM_DRIVER);
+		if (!newblock)
+			return NULL;
 		newblock->ofs = startofs;
 		newblock->size = p->size - (startofs - p->ofs);
 		newblock->free = 1;
@@ -244,6 +246,8 @@ static TMemBlock* SliceBlock(TMemBlock *
 	if (size < p->size) {
 		newblock = (TMemBlock*) DRM(calloc)(1, sizeof(TMemBlock),
 		    DRM_MEM_DRIVER);
+		if (!newblock)
+			return NULL;
 		newblock->ofs = startofs + size;
 		newblock->size = p->size - size;
 		newblock->free = 1;
@@ -285,6 +289,8 @@ PMemBlock mmAllocMem( memHeap_t *heap, i
 	if (p == NULL)
 		return NULL;
 	p = SliceBlock(p,startofs,size,0,mask+1);
+	if (!p)
+		return NULL;
 	p->heap = heap;
 	return p;
 }


-- 
umka

