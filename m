Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUI0GG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUI0GG0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 02:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUI0GGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 02:06:25 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:11967 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266136AbUI0GGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 02:06:23 -0400
Date: Mon, 27 Sep 2004 15:08:09 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: acpi-devel@lists.sourceforge.net,
 linux-ia64@vger.kernel.orgRe: [PATCH] Updated patches for PCI IRQ resource
 deallocation support [3/3]
In-reply-to: <Pine.LNX.4.53.0409251730580.2763@musoma.fsmlabs.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartmann <greg@kroah.com>, Len Brown <len.brown@intel.com>,
       tony.luck@intel.com, Andrew Morton <akpm@osdl.org>
Message-id: <4157AE49.7080306@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <2HRhX-6Ad-21@gated-at.bofh.it>
 <Pine.LNX.4.53.0409251436390.2914@musoma.fsmlabs.com>
 <Pine.LNX.4.53.0409251730580.2763@musoma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> On Sat, 25 Sep 2004, Zwane Mwaikambo wrote:
> 
>> Hmm, what happens here if that vector was queued just before the local irq 
>> disable in spin_lock_irqsave(idesc->lock...) ? Then when we unlock we'll 
>> call do_IRQ to handle the irq associated with that vector. I haven't seen 
>> the usage but it appears that iosapic_unregister_intr requires some 
>> serialisation.
> 
> Ignore this, i misread some of the code.
> 
> Thanks Kenji,
> 	Zwane
> 

OK.
BTW, I was able to find a bug thanks to your comment :-)
The following 'spin_lock(&iosapic_lock)' was missing. I'll update
the patch.

	if (unlikely(idesc->action)) {
		iosapic_intr_info[vector].refcnt++;
MISSING =>	spin_unlock(&iosapic_lock);
		spin_unlock_irqrestore(&idesc->lock, flags);
		printk(KERN_WARNING "Cannot unregister GSI. IRQ %u is still in use.\n", irq);
		return;
	}

Thanks,
Kenji Kaneshige


