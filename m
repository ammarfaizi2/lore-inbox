Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264342AbRFDRjp>; Mon, 4 Jun 2001 13:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264295AbRFDRj2>; Mon, 4 Jun 2001 13:39:28 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:50692 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S263851AbRFDRP4>; Mon, 4 Jun 2001 13:15:56 -0400
Date: Mon, 4 Jun 2001 21:08:35 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Tom Vier <tmv5@home.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: [patch] Re: Linux 2.4.5-ac6
Message-ID: <20010604210835.A2907@jurassic.park.msu.ru>
In-Reply-To: <20010601120105.A1356@lightning.swansea.linux.org.uk> <20010601222709.A566@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010601222709.A566@zero>; from tmv5@home.com on Fri, Jun 01, 2001 at 10:27:09PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2001 at 10:27:09PM -0400, Tom Vier wrote:
> > o	Fix mmap cornercase				(Maciej Rozycki)
> 
> when i try running osf/1 netscape on alpha, mmap of libXmu fails. works fine
> on -ac5.

Indeed. Netscape is essentially 32 bit application, so probably
it treats TASK_UNMAPPED_BASE (0x20000000000) as failure.
A tad more respect of specified address fixes that.
Also small fix for endless compile warnings with gcc 3.0 on
alpha (`struct mm_struct' declared inside parameter list).

Ivan.

--- 2.4.5-ac7/mm/mmap.c	Mon Jun  4 14:19:02 2001
+++ linux/mm/mmap.c	Mon Jun  4 19:22:31 2001
@@ -404,10 +404,13 @@ static inline unsigned long arch_get_unm
 
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
-		vma = find_vma(current->mm, addr);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vma->vm_start))
-			return addr;
+		for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
+			if (TASK_SIZE - len < addr)
+				break;
+			if (!vma || addr + len <= vma->vm_start)
+				return addr;
+			addr = vma->vm_end;
+		}
 	}
 	addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 
--- 2.4.5-ac7/include/linux/binfmts.h	Mon Jun  4 14:19:00 2001
+++ linux/include/linux/binfmts.h	Mon Jun  4 20:24:50 2001
@@ -32,6 +32,9 @@ struct linux_binprm{
 	unsigned long loader, exec;
 };
 
+/* Forward declaration */
+struct mm_struct;
+
 /*
  * This structure defines the functions that are used to load the binary formats that
  * linux accepts.
