Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131468AbQKVMAx>; Wed, 22 Nov 2000 07:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131637AbQKVMAo>; Wed, 22 Nov 2000 07:00:44 -0500
Received: from 62-6-233-24.btconnect.com ([62.6.233.24]:37381 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131468AbQKVMA2>;
	Wed, 22 Nov 2000 07:00:28 -0500
Date: Wed, 22 Nov 2000 11:32:17 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: vfree() question.
Message-ID: <Pine.LNX.4.21.0011221127540.9662-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In vfree() shouldn't we be dropping vmlist_lock spinlock as soon as we
unlinked the item from the vmlist? I.e. before we free the actual pages
and the vm_struct itself. Or, perhaps it should be done _after_
vmfree_area_pages() but definitely before kfree(tmp) since tmp is no
longer visible outside the function. (My only doubt whether
vmfree_area_pages() should be inside the lock is because those pages may
otherwise be reused for the next vmalloc request).

(actually I put that spinlock in vfree and get_vm_area so at the time it
seemed "obviously correct" but now I am having thoughts that it can still
be optimized more).

Regards,
Tigran

PS. To be specific, here is the patch I had in mind:

--- linux/mm/vmalloc.c	Mon Nov 20 11:56:14 2000
+++ work/mm/vmalloc.c	Wed Nov 22 11:25:29 2000
@@ -214,9 +214,9 @@
 	for (p = &vmlist ; (tmp = *p) ; p = &tmp->next) {
 		if (tmp->addr == addr) {
 			*p = tmp->next;
+			write_unlock(&vmlist_lock);
 			vmfree_area_pages(VMALLOC_VMADDR(tmp->addr), tmp->size);
 			kfree(tmp);
-			write_unlock(&vmlist_lock);
 			return;
 		}
 	}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
