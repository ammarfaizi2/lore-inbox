Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSLJQYA>; Tue, 10 Dec 2002 11:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbSLJQYA>; Tue, 10 Dec 2002 11:24:00 -0500
Received: from irongate.swansea.linux.org.uk ([194.168.151.19]:11968 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262859AbSLJQX6>; Tue, 10 Dec 2002 11:23:58 -0500
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@suse.de>
Cc: Antonino Daplas <adaplas@pol.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210172320.A4586@suse.de>
References: <1039522886.1041.17.camel@localhost.localdomain>
	<20021210131143.GA26361@suse.de>
	<1039538881.2025.2.camel@localhost.localdomain>
	<20021210140301.GC26361@suse.de>
	<1039547210.1071.26.camel@localhost.localdomain> 
	<20021210172320.A4586@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 17:06:17 +0000
Message-Id: <1039539977.14251.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 16:23, Dave Jones wrote:
> That's really quite icky. Even putting an..
> 
> #ifdef CONFIG_FRAMEBUFFER_I810
>     dev = pci_find_blah..
>     agp_intel_init(dev);
> #endif
> 
> before console_init() call in init/main.c seems cleaner than that imo,
> (and this is still quite gross).

Given how fragile the AGP code can be I would much rather we had the AGP
continue to initialize late. If the AGP init function is something like


int agp_required(void)
{
	static int agp_inited = 0;

	if(!agp_inited)
	{
		agp_inited = 1;
		agp_do_real_init();
	}
}

module_init(agp_required);


Then the i810 fb driver can do

	agp_required();

and force the order change only if necessary.

