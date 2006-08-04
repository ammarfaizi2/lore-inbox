Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWHDFta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWHDFta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbWHDFsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:48:47 -0400
Received: from ns1.suse.de ([195.135.220.2]:22757 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030339AbWHDFpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:45:15 -0400
Date: Thu, 3 Aug 2006 22:40:38 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 20/23] S390: fix futex_atomic_cmpxchg_inatomic
Message-ID: <20060804054038.GU769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="s390-fix-futex_atomic_cmpxchg_inatomic.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
[S390] fix futex_atomic_cmpxchg_inatomic

futex_atomic_cmpxchg_inatomic has the same bug as the other
atomic futex operations: the operation needs to be done in the
user address space, not the kernel address space. Add the missing
sacf 256 & sacf 0.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-s390/futex.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.17.7.orig/include/asm-s390/futex.h
+++ linux-2.6.17.7/include/asm-s390/futex.h
@@ -98,9 +98,10 @@ futex_atomic_cmpxchg_inatomic(int __user
 
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
-	asm volatile("   cs   %1,%4,0(%5)\n"
+	asm volatile("   sacf 256\n"
+		     "   cs   %1,%4,0(%5)\n"
 		     "0: lr   %0,%1\n"
-		     "1:\n"
+		     "1: sacf 0\n"
 #ifndef __s390x__
 		     ".section __ex_table,\"a\"\n"
 		     "   .align 4\n"

--
