Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWKBSFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWKBSFN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 13:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWKBSFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 13:05:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:10489 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750836AbWKBSFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 13:05:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=quPZfraMZCzYjDc5OnwV/DmfGJATmVGNp/doVNWawLvVuEbNy784X1/DiMY0jKMU2tJTD2UShcF/KhE0WPo48HMuJWu6e5bPYlV3amgG6jGDtrrIDA7skUC268l6boryqpPdETIhfFtLQ4SM/rZyS/2wNI8tt6L1L+RmyKXJk0k=
Message-ID: <aec7e5c30611021005y2f26319ei1c61963d354a933f@mail.gmail.com>
Date: Fri, 3 Nov 2006 03:05:08 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Mel Gorman" <mel@csn.ul.ie>
Subject: Re: [PATCH] x86_64: setup saved_max_pfn correctly (kdump)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       "Vivek Goyal" <vgoyal@in.ibm.com>, "Andi Kleen" <ak@muc.de>,
       fastboot@lists.osdl.org
In-Reply-To: <Pine.LNX.4.64.0611021604080.14806@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061102131934.24684.93195.sendpatchset@localhost>
	 <Pine.LNX.4.64.0611021604080.14806@skynet.skynet.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

Thanks for your input! Great work with the add_active_range() code.

On 11/3/06, Mel Gorman <mel@csn.ul.ie> wrote:
> Hey Magnus,
>
> I see what you are doing and why. However if you look in
> arch/x86_64/kernel/setup.c, you'll see
>
>          parse_early_param();
>
>          finish_e820_parsing();
>
>          e820_register_active_regions(0, 0, -1UL);
>
> If you just called e820_register_active_regions(0, 0, -1UL) before
> parse_early_param(), would it still fix the problem without having to call
> e820_register_active_regions(0, 0, -1UL) twice?

Well, I guess it is possible to move the
e820_register_active_regions() up, but I'm not sure if that would give
us anything.

We need to call e820_register_active_regions() before e820_end_of_ram,
that's for sure, but the "exactmap" code in parse_memmap_opt() sets
e820.nr_map to 0 after the call to e820_end_of_ram(). Then it adds a
new set of user-supplied ranges to the e820 map which then need to be
registered using e820_register_active_regions().

So yeah, we can move the function up above parse_early_param() but
then we need to insert another call to e820_register_active_regions()
somewhere after all user-supplied ranges have been added.

Another solution could be to rewrite e820_end_of_ram() to instead scan
e820.map[] backwards from e820.nr_map - 1 to locate the last ram page.
But can you do that in two lines of code? =)

Thanks!

/ magnus
