Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKXNJl>; Fri, 24 Nov 2000 08:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129145AbQKXNJW>; Fri, 24 Nov 2000 08:09:22 -0500
Received: from [204.177.156.37] ([204.177.156.37]:711 "EHLO
        bacchus-int.veritas.com") by vger.kernel.org with ESMTP
        id <S129091AbQKXNJS>; Fri, 24 Nov 2000 08:09:18 -0500
Date: Fri, 24 Nov 2000 18:08:15 +0530 (IST)
From: V Ganesh <ganesh@veritas.com>
Message-Id: <200011241238.SAA14757@vxindia.veritas.com>
To: linux-kernel@vger.kernel.org
Subject: [bug] set_pgdir can skip mm's
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

set_pgdir() needs to modify all active mm's to include the new entry.
what it really does is 
        for_each_task(p) {
                if (!p->mm)
                        continue;
                *pgd_offset(p->mm,address) = entry;
        }

however, there could be a lazy-tlb thread on another cpu whose active_mm
belongs to a process which is dead and gone, and hence won't be covered by the
above code. if this thread then accesses an address covered by this entry, it
would fault.
ideally, we ought to loop through a list of all mm's rather than processes.
but since we don't have such a list, an easier solution is to use p->active_mm
rather than p->mm. this can cause multiple updates of the same pgd, but
the number of such unnecessary extra updates is bound by the number of CPUs.

ganesh
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
