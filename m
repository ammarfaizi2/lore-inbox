Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVHHRny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVHHRny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVHHRny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:43:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61063 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932149AbVHHRnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:43:53 -0400
Date: Mon, 8 Aug 2005 10:42:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: ak@muc.de, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.13-rc5-mm1 doesnt boot on x86_64
Message-Id: <20050808104206.42a51477.akpm@osdl.org>
In-Reply-To: <1123522409.5019.0.camel@mulgrave>
References: <20050808094818.A17579@unix-os.sc.intel.com>
	<20050808171126.GA32092@muc.de>
	<1123522409.5019.0.camel@mulgrave>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> On Mon, 2005-08-08 at 19:11 +0200, Andi Kleen wrote:
> > Looks like a SCSI problem. The machine has an Adaptec SCSI adapter, right?
> 
> The traceback looks pretty meaningless.
> 
> What was happening on the machine before this.  i.e. was it booting up,
> in which case can we have the prior dmesg file; or was the aic79xxx
> driver being removed?
> 

-mm has extra list_head debugging goodies.  I'd be suspecting a list_head
corruption detected somewhere under spi_release_transport().


--- 25/include/linux/list.h~list_del-debug	2005-03-08 11:40:27.000000000 -0800
+++ 25-akpm/include/linux/list.h	2005-03-08 11:40:49.000000000 -0800
@@ -5,7 +5,9 @@
 
 #include <linux/stddef.h>
 #include <linux/prefetch.h>
+#include <linux/kernel.h>
 #include <asm/system.h>
+#include <asm/bug.h>
 
 /*
  * These are non-NULL pointers that will result in page faults
@@ -160,6 +162,8 @@ static inline void __list_del(struct lis
  */
 static inline void list_del(struct list_head *entry)
 {
+	BUG_ON(entry->prev->next != entry);
+	BUG_ON(entry->next->prev != entry);
 	__list_del(entry->prev, entry->next);
 	entry->next = LIST_POISON1;
 	entry->prev = LIST_POISON2;
_

