Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVCLPKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVCLPKF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 10:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVCLPKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 10:10:04 -0500
Received: from mailfe07.swip.net ([212.247.154.193]:26086 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261935AbVCLPIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:08:13 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Re: Strange memory leak in 2.6.x
From: Alexander Nyberg <alexn@dsv.su.se>
To: Tobias Hennerich <Tobias@Hennerich.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050312133241.A11469@bart.hennerich.de>
References: <20050308133735.A13586@bart.hennerich.de>
	 <20050308173811.0cd767c3.akpm@osdl.org>
	 <20050309102740.D3382@bart.hennerich.de>
	 <20050311183207.A22397@bart.hennerich.de> <1110565420.2501.12.camel@boxen>
	 <20050312133241.A11469@bart.hennerich.de>
Content-Type: text/plain
Date: Sat, 12 Mar 2005 16:08:05 +0100
Message-Id: <1110640085.2376.22.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yikes something isn't right with these backtraces that page_owner is
> > showing. Even without frame pointers it shouldn't be this noisy.
> 
> If you could send me some pointers to documents how to interpret
> this output, i would appreciate it.

The whole output indicates who has allocated whole pages from the page
allocator. It shows us a bit of the call trace of who allocated it. If
we see that someone has allocated abnormally much memory (considering
how much the caller 'should' have allocated) there is a good chance that
that caller is leaking memory.

This is for example good complete trace:
[0xc0148b9a] do_anonymous_page+170
[0xc0148cdb] do_no_page+75
[0xc0149128] handle_mm_fault+264
[0xc0113625] do_page_fault+501
[0xc0104a7b] error_code+43

The next one here is how it looks when it is not so good:
[0xc013962b] find_or_create_page+91
[0xc01596ac] grow_dev_page+44
[0xc015986a] __getblk_slow+170
[0xc0159c26] __getblk+54
[0xf8ac0a57] +1207
[0xf8abfccd] +61
[0xf8ac03c1] +241
[0xf8ac040a] +42


Stupid me, the 0xf8ac040a addresses are vmalloc space (modules). I need
to look into why it doesn't work with vmalloc but in the meantime, could
you please save a copy of /proc/kallsyms from the computer right away so
that I can look up those when the computer locks up (the copy needs to
be from the current run, addresses can change between reboots).


> > And when that kernel is booted, could you directly send me the output
> > of /proc/page_owner (sort or unsorted) so that I can see if something is
> > wrong with the data it's producing (just to be sure).
> 
> See http://download.hennerich.de/page_owner_sorted_20050312_1040.bz2
> 
> > If it works better with CONFIG_FRAME_POINTER, i'm also going to have to
> > ask you to do another one of these runs that you just did.
> 
> The cronjob which generates each 10 minutes a new actual file of 
> page_owner_sorted is still running... and I'm afraid that we will
> run into problems sooner or later again...

Thanks for helping to track this down.

