Return-Path: <linux-kernel-owner+w=401wt.eu-S932431AbXAIV1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbXAIV1K (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbXAIV1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:27:10 -0500
Received: from mis011.exch011.intermedia.net ([64.78.21.10]:38344 "EHLO
	mis011.exch011.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932431AbXAIV1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:27:09 -0500
Message-ID: <45A40898.4040307@qumranet.com>
Date: Tue, 09 Jan 2007 23:26:48 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] guest crash on 2.6.20-rc4
References: <ada4pr1mqz2.fsf@cisco.com>
In-Reply-To: <ada4pr1mqz2.fsf@cisco.com>
Content-Type: multipart/mixed;
 boundary="------------020502030200070109080303"
X-OriginalArrivalTime: 09 Jan 2007 21:27:01.0235 (UTC) FILETIME=[E66F5C30:01C73434]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020502030200070109080303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Roland Dreier wrote:
> I'm running a 64-bit Fedora 6 install as a guest on a host running
> 2.6.20-rc4 with the kvm-10 userspace release.  The CPU is a Xeon 5160
> and I have 6 GB of RAM.  The guest is given 512 MB of memory.  I left
> the guest idle overnight, and the makewhatis cron job seems to have
> triggered this:
>
>     Unable to handle kernel paging request at ffff81000ba04000 RIP:
>      [<ffffffff8025f402>] clear_page+0x16/0x44
>   

I've managed to reproduce a bug with similar characteristics: a write 
fault into a present, writable kernel page.  The attached patch should 
fix it.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


--------------020502030200070109080303
Content-Type: text/x-patch;
 name="spurious-page-fault.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spurious-page-fault.patch"

Index: b/drivers/kvm/paging_tmpl.h
===================================================================
--- a/drivers/kvm/paging_tmpl.h	(revision 4270)
+++ b/drivers/kvm/paging_tmpl.h	(working copy)
@@ -274,7 +274,7 @@
 	struct kvm_mmu_page *page;
 
 	if (is_writeble_pte(*shadow_ent))
-		return 0;
+		return 1;
 
 	writable_shadow = *shadow_ent & PT_SHADOW_WRITABLE_MASK;
 	if (user) {

--------------020502030200070109080303--
