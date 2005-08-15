Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVHOUyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVHOUyA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVHOUyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:54:00 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:20972 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964958AbVHOUx7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:53:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WdMHtsPUqlR4zvjhZGFeIZOTI0JGEyi17jh/nbUKuvsDc1xeKYCHr8aDbCW3OX4egGA60fQCOyLthnKJqL/Y0h9BhRVh1n/hqz168lcRAnyDidTHzWNLo9ZY4BFB5UPOLNzdQlkGEuHpi7++P9BazuxSAhwLgNsxVbm1i1LY6cA=
Message-ID: <4789af9e050815135347e398fd@mail.gmail.com>
Date: Mon, 15 Aug 2005 14:53:58 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
To: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
Subject: Re: Atyfb questions and issues
Cc: James Simmons <jsimmons@infradead.org>, yhlu <yhlu.kernel@gmail.com>,
       alex.kern@gmx.de, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0508152129490.11750-100000@deadlock.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4789af9e0508151221486d0003@mail.gmail.com>
	 <Pine.LNX.4.44.0508152129490.11750-100000@deadlock.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, Daniël, forgot to CC everyone else on this - please forgive my
resend to you.

On 8/15/05, Daniël Mantione <daniel@deadlock.et.tudelft.nl> wrote:
> I don't know what the purpose of this patch is but it copies the pre-LCD
> version of the code in mach64_ct.c into the xlinit.c code of 2.6. This is
> not the var_to_pll code. This code affects the display fifo and can
> cause wrong image if incorrectly programmed, but has nothing to do with
> initializing the chip.

The purpose of this patch is to get the xlinit working for non-i386
machines, such as the MIPS processor board I'm currently working with.
 It works for me.  The problem is that for non-i386 machines,
init_bios_setup is not called, so some values that the 2.6 code
assumes should be initialized are not.

In the 2.4 kernel I'm using as a reference with the 'xlinit' code
built in, which works on my hardware, the var_to_pll code consists of
3 calls:
- aty_valid_pll_ct
- aty_dsp_gt
- aty_calc_pll_ct

Now, the 2.6 kernel's var_to_pll code is identical, except that it
doesn't call aty_calc_pll_ct any more.  However, the differences don't
stop there.  The 'aty_valid_pll_ct' call in the 2.6 kernel is much
smaller than the 2.4 kernel - apparently it assumes that someone else
will have initialized much of the pll struct.

So to work around this I took these from the 2.4 kernel, renamed them
with 'init_' instead of 'aty_' and put them into xlinit.c, only if
__i386__ isn't defined, and call them explicitly instead of wrapping
them inside a function called 'var_to_pll'.

> The pre-LCD code caused several problems for both i386 and
> non-i386 laptops, and should not be reused. Also, Geert Uytterhoeven
> has said that he developed the pre-LCD by trial and and not by
> design. The post-LCD code is derived from the XFree86 driver, it is
> supposed to work fine if X works.

My patch won't affect non-i386 machines.  Notice the '#ifndef
__i386__' around everything I changed.

This simply fixes the issue that the new 2.6 xlinit code assumes that
you have a bios that will do *something* to your chip before handing
control over to the kernel, which is not always the case.

If you have a fix that is more correct, I'd be happy to test it for you!

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
