Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbWH3APW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbWH3APW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 20:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbWH3APW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 20:15:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965188AbWH3APV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 20:15:21 -0400
Date: Tue, 29 Aug 2006 17:14:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: kmannth@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       efalk@google.com
Subject: Re: [BUG] 2.6.18-rc4-mm3 x86_64-mm-spin-irqs-enabled causes
 problems
Message-Id: <20060829171453.3921337e.akpm@osdl.org>
In-Reply-To: <1156895977.5654.17.camel@keithlap>
References: <1156895977.5654.17.camel@keithlap>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 16:59:36 -0700
keith mannthey <kmannth@us.ibm.com> wrote:

>   I moved to mm2 to mm3 and had trouble booting again with my hardware.
> In -mm3 the kernel boots but about the time init starts the whole box
> just stops doing anything.  Sysrq works and I dumped the tasks but
> nothing look too far out of place.  
> 
> I did a bisection of -mm3 and found x86_64-mm-spin-irqs-enabled.patch to
> be the cause. 

Yes, Hugh was hitting that today and the following has emerged...

From: Andrew Morton <akpm@osdl.org>

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/asm-x86_64/spinlock.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN include/asm-x86_64/spinlock.h~x86_64-mm-spin-irqs-enabled-fix include/asm-x86_64/spinlock.h
--- a/include/asm-x86_64/spinlock.h~x86_64-mm-spin-irqs-enabled-fix
+++ a/include/asm-x86_64/spinlock.h
@@ -51,7 +51,7 @@ static inline void __raw_spin_lock_flags
 {
 	asm volatile(
 		"\n1:\t"
-		LOCK_PREFIX "; decb %0\n\t"
+		LOCK_PREFIX "; decl %0\n\t"
 		"js 2f\n\t"
 		LOCK_SECTION_START("")
 		"2:\t"
@@ -60,7 +60,7 @@ static inline void __raw_spin_lock_flags
 		"sti\n\t"
 		"3:\t"
 		"rep;nop\n\t"
-		"cmpb $0, %0\n\t"
+		"cmpl $0, %0\n\t"
 		"jle 3b\n\t"
 		"cli\n\t"
 		"jmp 1b\n"
_

