Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTKDQNi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 11:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTKDQNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 11:13:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:60822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262373AbTKDQNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 11:13:37 -0500
Date: Tue, 4 Nov 2003 08:13:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] Dont use cpu_has_pse for WP test branch
In-Reply-To: <Pine.LNX.4.53.0311040155150.20595@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0311040809470.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Nov 2003, Zwane Mwaikambo wrote:
>
> It appears that not all processors which support PSE have the PSE bit set, 
> possibly we should be checking with PSE36 too. But instead i've opted to 
> simply check for 586+

Why?

The reason we test the PSE bit is not that we think it's a good indicator 
of "new enough".  It's because if the PSE bit is set, we will use 4MB 
pages, and the code below that actually _tests_ whether WP works or not 
won't work.

So it doesn't _matter_ that

> Celeron (Mendocino): fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 mmx fxsr
> 
> Opteron 240: fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
> pse36 clflush mmx fxsr sse sse2 syscall mmxext lm 3dnowext 3dnow

do not have PSE, they'll just end up testing dynamically if it works or 
not.

In fact, these days we could remove the test entirely: the only reason it 
exists is because traditionally we didn't have the "fixmap" helpers, so we 
used the page in lowest kernel memory for testing (which did not exist if 
we had PSE, since with PSE the kernel wouldn't use individual pages to map 
itself).

		Linus

