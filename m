Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUFFSIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUFFSIB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 14:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUFFSIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 14:08:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:48345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262547AbUFFSH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 14:07:58 -0400
Date: Sun, 6 Jun 2004 11:03:33 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Yury Umanets <torque@ukrpost.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.6 memory allocation checks in SliceBlock()
Message-Id: <20040606110333.57e5b853.rddunlap@osdl.org>
In-Reply-To: <1086538992.2793.94.camel@firefly>
References: <1086538992.2793.94.camel@firefly>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Jun 2004 19:23:12 +0300 Yury Umanets wrote:

| Adds memory allocation checks in SliceBlock()
| 
|  ./linux-2.6.6-modified/drivers/char/drm/sis_ds.c |    4 ++++
|  1 files changed, 4 insertions(+)
| 
| Signed-off-by: Yury Umanets <torque@ukrpost.net>
| 
| diff -rupN ./linux-2.6.6/drivers/char/drm/sis_ds.c
| ./linux-2.6.6-modified/drivers/char/drm/sis_ds.c
| --- ./linux-2.6.6/drivers/char/drm/sis_ds.c	Mon May 10 05:33:19 2004
| +++ ./linux-2.6.6-modified/drivers/char/drm/sis_ds.c	Wed Jun  2 14:19:22
| 2004
| @@ -231,6 +231,8 @@ static TMemBlock* SliceBlock(TMemBlock *
|  	if (startofs > p->ofs) {
|  		newblock = (TMemBlock*) DRM(calloc)(1, sizeof(TMemBlock),
|  		    DRM_MEM_DRIVER);
| +		if (!newblock)
| +			return NULL;
|  		newblock->ofs = startofs;
|  		newblock->size = p->size - (startofs - p->ofs);
|  		newblock->free = 1;
| @@ -244,6 +246,8 @@ static TMemBlock* SliceBlock(TMemBlock *
|  	if (size < p->size) {
|  		newblock = (TMemBlock*) DRM(calloc)(1, sizeof(TMemBlock),
|  		    DRM_MEM_DRIVER);
| +		if (!newblock)
| +			return NULL;
|  		newblock->ofs = startofs + size;
|  		newblock->size = p->size - size;
|  		newblock->free = 1;
| 
| -- 

These look like the right thing to do, but one caller of
SliceBlock() has no error handling:

mmAllocMem():

	p = SliceBlock(p,startofs,size,0,mask+1);
	p->heap = heap;
	return p;

However, callers of mmAllocMem() do have failure handling.

--
~Randy
