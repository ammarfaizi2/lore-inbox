Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267358AbUHDRVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267358AbUHDRVt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 13:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUHDRVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 13:21:49 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:8608 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267358AbUHDRU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 13:20:28 -0400
Date: Wed, 4 Aug 2004 18:20:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Bernd Schubert <bernd-schubert@web.de>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.8-rc2-mm2] oops report (crashes on booting)
In-Reply-To: <200408041828.42100.bernd-schubert@web.de>
Message-ID: <Pine.LNX.4.44.0408041808050.30401-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Bernd Schubert wrote:
> 
> we just tried to boot one of our systems using 2.6.8-rc2-mm2,
> unfortunately it oopses after running pivot_root and init:
> 
> (written down manually)
> 
> Debug: sleeping function called from invalid context at 
> include/asm/uaccess.h:471
> 
> in_atomic():1, irqs_disabled():0
> dump_stack
> __might_sleep
> shmem_file_write

It shouldn't be an oops, but it'll certainly be a very disturbing
splurge of messages.  Sorry, I should have caught it sooner.  Please
apply patch below (which not only sidesteps the warnings, but appears
to be the _right_ thing to do, from a look at filemap.c)...

tmpfs must use __copy_from_user_inatomic now, to avoid might_sleep
warning, when knowingly using __copy_from_user with an atomic kmap.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.8-rc2-mm2/mm/shmem.c	2004-08-02 13:03:33.000000000 +0100
+++ linux/mm/shmem.c	2004-08-04 18:05:07.917110256 +0100
@@ -1323,7 +1323,8 @@ shmem_file_write(struct file *file, cons
 			__get_user(dummy, buf + bytes - 1);
 
 			kaddr = kmap_atomic(page, KM_USER0);
-			left = __copy_from_user(kaddr + offset, buf, bytes);
+			left = __copy_from_user_inatomic(kaddr + offset,
+							buf, bytes);
 			kunmap_atomic(kaddr, KM_USER0);
 		}
 		if (left) {

