Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422689AbWHEBBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbWHEBBd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 21:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWHEBBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 21:01:33 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:35302 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422689AbWHEBBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 21:01:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RDHjp/oN8kP4xiP6jqPOcpWH+OxQ1DZr0ZPLNTa2cgHwYCLh6W/2xU+6QlpFu30hU1fw6SG+A7TOYq7SO4IYIDP3n6tps75bNOb0Di5c9/LYASSnjXEZPr6y4HbyDVw/GGDtfAgFSAsrhrWEpqfeBJFXVGTdQ9AP0DqYoZ0iTlo=
From: Mulyadi Santosa <mulyadi.santosa@gmail.com>
Reply-To: mulyadi.santosa@gmail.com
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] accounting per process swapped out pages
Date: Sat, 5 Aug 2006 08:00:16 +0700
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200608041351.52695.mulyadi.santosa@gmail.com> <Pine.LNX.4.64.0608041616330.10681@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0608041616330.10681@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608050800.16584.mulyadi.santosa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ...

> To be honest, I don't think there's much interest in this particular
> VmSwp statistic; and if there's little interest in it, we'd rather
> not spend the time and space on collecting it.  But I could be wrong:
> let's see who speaks up for it.

I got the same impression too, but I do think this statistic is 
important if someone wants to know which program suffers most when 
(heavy) swapping happens. Some programs like "top" would also get 
benefit since  its "swapped" accounting is just based on virtual-rss, 
which is wrong (just showing parts that haven't been brought to RAM)

> You waste space in every vm_area_struct for your swapped_out count,
> then /proc/<pid>/status has to loop over the vmas adding them up.
> Much better to make it an mm_counter like anon_rss, then you only
> use space in mm_struct, and don't have to add them up at the end,
> and avoid dirtying (vma) cachelines unnecessarily, and (in some
> cases) avoid the atomic operations.

Let's see if I can adapt this idea. Actually, in the first place, I was 
thinking this way but sometimes it is easier to get pointer to 
vm_area_struct rather than to mm_struct. I'll take a deeper look...

Avoiding atomic operation is also my another primary target....

> While you've caught the main places where you'd need to adjust
> swapped_out, you've missed a couple (maybe I've missed more):
> copy_pte_range (fork) needs to increment the count, zap_pte_range
> (munmap or truncate or exit) needs to decrement it.  Check wherever
> anon_rss is adjusted, some not all would need swapped_out adjusted.

Yes, I use anon_rss a the "guidance" on where I probably put the 
swapped_out accounting and decide whether it  actually has anything to 
do with swapping or not. Hmmmm, looks like I still miss a lot...

> Oh, you are doing something in zap_pte_range, but I'm sorry to say
> what you do there is nonsense: the number you're subtracting has
> nothing to do with the number of swapped out pages.

:( OK, re-checking...

> And you probably wouldn't want that printk in your final patch!

Perfect closing, i forgot to clean that printk(). Thanks for reminding 
me...

Refined patch will follow ASAP..

regards,

Mulyadi

