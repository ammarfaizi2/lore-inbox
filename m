Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVLXUIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVLXUIT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 15:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVLXUIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 15:08:18 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:3736
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750713AbVLXUIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 15:08:18 -0500
Date: Sat, 24 Dec 2005 12:08:25 -0800 (PST)
Message-Id: <20051224.120825.67387399.davem@davemloft.net>
To: torvalds@osdl.org
Cc: michael.bishop@APPIQ.com, linux-kernel@vger.kernel.org, hugh@veritas.com,
       nickpiggin@yahoo.com.au
Subject: Re: More info for DSM w/r/t sunffb on 2.6.15-rc6
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512240029581.14098@g5.osdl.org>
References: <Pine.LNX.4.64.0512231223040.14098@g5.osdl.org>
	<20051223.154509.86780332.davem@davemloft.net>
	<Pine.LNX.4.64.0512240029581.14098@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Sat, 24 Dec 2005 00:32:26 -0800 (PST)

> On Fri, 23 Dec 2005, David S. Miller wrote:
> > +	if (!(vma->vm_flags & VM_SHARED))
> > +		return -EINVAL;
> > +
> 
> Side note - as I explained to Nick the other week, VM_SHARED really means 
> "shared _writable_" mapping, so you're now disallowing a shared read-only 
> open too.
> 
> Which may be fine, of course. Especially if sbusfb always ends up giving a 
> writable pfn-mapping. But I wanted to check that that was what you meant 
> to do.
> 
> To test for MAP_SHARED, either do the is_cow_mapping() thing, or check 
> the VM_MAYSHARE bit.

I did mean to test for MAP_SHARED, thanks for the test.
I've made the check like this:

diff --git a/drivers/video/sbuslib.c b/drivers/video/sbuslib.c
index 646c43f..3a74a63 100644
--- a/drivers/video/sbuslib.c
+++ b/drivers/video/sbuslib.c
@@ -46,6 +46,9 @@ int sbusfb_mmap_helper(struct sbus_mmap_
 	unsigned long off;
 	int i;
                                         
+	if (!(vma->vm_flags & (VM_SHARED | VM_MAYSHARE)))
+		return -EINVAL;
+
 	size = vma->vm_end - vma->vm_start;
 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
 		return -EINVAL;
