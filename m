Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbUKEN6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbUKEN6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 08:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbUKEN6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 08:58:31 -0500
Received: from cantor.suse.de ([195.135.220.2]:24770 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262684AbUKEN6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 08:58:11 -0500
Date: Fri, 5 Nov 2004 14:53:43 +0100
From: Andi Kleen <ak@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Fix for vmalloc problem was Re: 2.6.10-rc1-mm3
Message-ID: <20041105135343.GH8349@wotan.suse.de>
References: <20041105001328.3ba97e08.akpm@osdl.org.suse.lists.linux.kernel> <418B5C70.7090206@kolivas.org.suse.lists.linux.kernel> <p73sm7o7br3.fsf@verdi.suse.de> <418B6F18.9090404@kolivas.org> <20041105131232.GA1030@wotan.suse.de> <418B8047.5050902@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418B8047.5050902@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 12:29:43AM +1100, Con Kolivas wrote:
> Andi Kleen wrote:
> >On Fri, Nov 05, 2004 at 11:16:24PM +1100, Con Kolivas wrote:
> >
> >>Andi Kleen wrote:
> >>
> >>>Con Kolivas <kernel@kolivas.org> writes:
> >>>
> >>>
> >>>
> >>>>It's life Jim but not as we know it...
> >>>>
> >>>>
> >>>>This happened during modprobe of alsa modules. Keyboard still alive,
> >>>>everything else dead; not even sysrq would do anything, netconsole had
> >>>>no output, luckily this made it to syslog:
> >>>
> >>>
> >>>I just tested modprobing of alsa (snd_intel8x0) and it works for me.
> >>>Also vmalloc must work at least to some point.
> >>>
> >>>Can you confirm it's really caused by 4level by reverting all the 
> >>>4level-* patches from broken out? 
> >>
> >>I dont recall blaming 4level. When I get a chance I'll try.
> >
> >
> >This patch should fix it. Can you please test? Thanks.
> >
> >-Andi
> >
> >Fix silly typo in mm/vmalloc.c and some minor cleanups.
> 
> Boots fine now thanks.

It broke x86-64 unfortunately. This version should be better and is
simpler. Andrew, if you applied the previous version please replace
with this one.

-Andi

Fix vmalloc overflow with 4levels.

Signed-off-by: Andi Kleen <ak@suse.de>


diff -up linux-2.6.10rc1-mm3/mm/vmalloc.c-o linux-2.6.10rc1-mm3/mm/vmalloc.c
--- linux-2.6.10rc1-mm3/mm/vmalloc.c-o	2004-11-05 11:42:00.000000000 +0100
+++ linux-2.6.10rc1-mm3/mm/vmalloc.c	2004-11-05 14:49:25.000000000 +0100
@@ -213,7 +213,7 @@ int map_vm_area(struct vm_struct *area, 
 			err = -ENOMEM;
 			break;
 		}
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
+		next = (address + PML4_SIZE) & PML4_MASK;
 		if (next < address || next > end)
 			next = end;
 		if (map_area_pgd(pgd, address, next, prot, pages)) {


