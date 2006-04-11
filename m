Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWDKNAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWDKNAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 09:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWDKNAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 09:00:31 -0400
Received: from pproxy.gmail.com ([64.233.166.179]:61937 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750811AbWDKNAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 09:00:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Lke5vMO9LbjXxnnCVlAwB9GR2vC1ugfjB+mFTeZ7b46zVsubB67sSoAInq7bGw3cUwZiHmbkEHrEMprr3TP9h8Gk100/0DqcV7MlWwJOL27a0082fnbvcGkBiQj1PvEGc+YgfD5kQ/O/P1TaZXV2vh7o1LlUBrOwZkWEL8TYLDE=
Date: Tue, 11 Apr 2006 21:00:24 +0800
From: lepton <ytht.net@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] asm-i386/atomic.h: local_irq_save should be used instead of local_irq_disable
Message-ID: <20060411130024.GA3364@gsy2.lepton.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
	When I read the kernel codes, I think this perhaps be a little
	bug, What do you think about this?

	See the following patch (against 2.6.16.3)

Signed-off-by: Lepton Wu <ytht.net@gmail.com>

diff -pru linux-2.6-curr.orig/include/asm-i386/atomic.h linux-2.6-curr.lepton/include/asm-i386/atomic.h
--- linux-2.6-curr.orig/include/asm-i386/atomic.h	2006-04-06 09:21:53.000000000 +0800
+++ linux-2.6-curr.lepton/include/asm-i386/atomic.h	2006-04-11 20:47:39.000000000 +0800
@@ -189,6 +189,7 @@ static __inline__ int atomic_add_return(
 {
 	int __i;
 #ifdef CONFIG_M386
+	unsigned long flags;
 	if(unlikely(boot_cpu_data.x86==3))
 		goto no_xadd;
 #endif
@@ -202,10 +203,10 @@ static __inline__ int atomic_add_return(
 
 #ifdef CONFIG_M386
 no_xadd: /* Legacy 386 processor */
-	local_irq_disable();
+	local_irq_save(flags);
 	__i = atomic_read(v);
 	atomic_set(v, i + __i);
-	local_irq_enable();
+	local_irq_restore(flags);
 	return i + __i;
 #endif
 }
