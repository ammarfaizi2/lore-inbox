Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267132AbTBVFP1>; Sat, 22 Feb 2003 00:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267653AbTBVFP1>; Sat, 22 Feb 2003 00:15:27 -0500
Received: from ns.suse.de ([213.95.15.193]:34319 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267132AbTBVFP0>;
	Sat, 22 Feb 2003 00:15:26 -0500
To: richard.brunner@amd.com
Cc: prandal@herefordshire.gov.uk, sowadski@umr.edu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 amd speculative caching
References: <99F2150714F93F448942F9A9F112634C013857BF@txexmtae.amd.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 Feb 2003 06:25:33 +0100
In-Reply-To: richard.brunner@amd.com's message of "22 Feb 2003 01:14:46 +0100"
Message-ID: <p73vfzc999u.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

richard.brunner@amd.com writes:

> The best and reliable way to go is by the output of CPUID
> (or cat /proc/cpuinfo)
> 
> if (((family == 6)  && (model >= 6)) || (family == 15)) {
>     printk(KERN_INFO "Advanced speculative caching feature present\n");
>     return 1;
> }
> 
> If your AMD processor meets the above CPUID family and model, then
> you need the patch. The decoder ring from any random
> Product name to CPUID family and model number is not yet available ;-)
> 
When you have such a CPU you either need the old patch or the new patch
for change_page_attr which is in since 2.4.20 and fixes the underlying
bug of linux using conflicting cache attributes. The change_page_attr
solution is much faster because it doesn't prevent the kernel from
using 4MB pages (= less tlb misses) and also of course because it won't
cripple your CPU by disabling hardware prefetch.

However when the change_page_attr() approach is used you need to make
sure that the the agpgart driver that comes with the kernel is used
(which actually calls change_page_attr). Unfortunately it looks like
some versions of the ATI binary 3d driver install their own agpgart driver
and they don't have the change_page_attr() fixes.

So when you use the ATI driver with 2.4.20+ you need to make sure you
don't use their agpgart driver. Better would be to get ATI to fix their
agpgart included or better not ship an own agpgart at all for these
kernels.

Really there isn't much the linux kernel can do about third
party vendors replacing working included drivers with buggy own drivers.

If someone has contacts at ATI it would be good to ask them
to release a new driver with this issue fixed.

-Andi
