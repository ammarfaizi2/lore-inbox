Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWKBS2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWKBS2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 13:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWKBS2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 13:28:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:43467 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751325AbWKBS2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 13:28:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JxGi/I8tfjbCNa9R1BHG3P8SWffRos3Q2+xW7SU4X1MNsYt3COBu/xmZmBuU5ZypoLEG3eJeEvM5SpsIfjjuysWWz4yRAOb/NYwueOZZeOOrR6N/1UEvKtvT1xMkOxzfuEQJ+vMkJ+q62Zs86txGdo3f1FKObGFa+Ir7He0ghbs=
Message-ID: <aec7e5c30611021028y30545781tee646d2718877694@mail.gmail.com>
Date: Fri, 3 Nov 2006 03:28:51 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: vgoyal@in.ibm.com
Subject: Re: [PATCH] x86_64: setup saved_max_pfn correctly (kdump)
Cc: "Mel Gorman" <mel@csn.ul.ie>, "Magnus Damm" <magnus@valinux.co.jp>,
       linux-kernel@vger.kernel.org, "Andi Kleen" <ak@muc.de>,
       fastboot@lists.osdl.org
In-Reply-To: <20061102182011.GE8074@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061102131934.24684.93195.sendpatchset@localhost>
	 <Pine.LNX.4.64.0611021604080.14806@skynet.skynet.ie>
	 <aec7e5c30611021005y2f26319ei1c61963d354a933f@mail.gmail.com>
	 <20061102182011.GE8074@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> On Fri, Nov 03, 2006 at 03:05:08AM +0900, Magnus Damm wrote:
> > Hi Mel,
> >
> > Thanks for your input! Great work with the add_active_range() code.
> >
> > On 11/3/06, Mel Gorman <mel@csn.ul.ie> wrote:
> > >Hey Magnus,
> > >
> > >I see what you are doing and why. However if you look in
> > >arch/x86_64/kernel/setup.c, you'll see
> > >
> > >         parse_early_param();
> > >
> > >         finish_e820_parsing();
> > >
> > >         e820_register_active_regions(0, 0, -1UL);
> > >
> > >If you just called e820_register_active_regions(0, 0, -1UL) before
> > >parse_early_param(), would it still fix the problem without having to call
> > >e820_register_active_regions(0, 0, -1UL) twice?
> >
> > Well, I guess it is possible to move the
> > e820_register_active_regions() up, but I'm not sure if that would give
> > us anything.
> >
> > We need to call e820_register_active_regions() before e820_end_of_ram,
> > that's for sure, but the "exactmap" code in parse_memmap_opt() sets
> > e820.nr_map to 0 after the call to e820_end_of_ram(). Then it adds a
> > new set of user-supplied ranges to the e820 map which then need to be
> > registered using e820_register_active_regions().
> >
> > So yeah, we can move the function up above parse_early_param() but
> > then we need to insert another call to e820_register_active_regions()
> > somewhere after all user-supplied ranges have been added.
> >
> > Another solution could be to rewrite e820_end_of_ram() to instead scan
> > e820.map[] backwards from e820.nr_map - 1 to locate the last ram page.
> > But can you do that in two lines of code? =)
> >
>
> Is there are reason that why e820_end_of_ram() should be looking at active
> regions instead of dicrectly probing e820 memory map? If no, then modifying
> e820_end_of_ram() wil save us extra calls.

No special reason. I was just happy that I was able to solve the
problem by using two lines of new kernel functions. =) Also, the code
is not timing critical at all so I see no reason to write up something
else when we already have a working solution.

Feel free to hack up with a better patch and I'll test and report
before end of next week.

Thanks!

/ magnus
