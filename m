Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269863AbUJSVgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269863AbUJSVgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269773AbUJSVbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:31:21 -0400
Received: from gprs214-24.eurotel.cz ([160.218.214.24]:3456 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267301AbUJSVLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:11:32 -0400
Date: Tue, 19 Oct 2004 23:11:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       penguinppc-team@lists.penguinppc.org
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041019211114.GC1142@elf.ucw.cz>
References: <416E6ADC.3007.294DF20D@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416E6ADC.3007.294DF20D@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am writing this email to guage the interest in having code contributed 
> to the main stream Linux kernel that would support the user of a generic, 
> full featured VESA framebuffer driver that works on any CPU architecture 
> along with a generic Video card BOOT or POST mechanism.

BTW, does this look like right way to POST VGA BIOS from real mode? It
is what we currently use... and it works on some machines...

        movw    $0xb800, %ax
        movw    %ax,%fs
        movw    $0x0e00 + 'L', %fs:(0x10)

        cli
        cld

        # setup data segment
        movw    %cs, %ax
        movw    %ax, %ds                                        # Make ds:0 point to wakeup_start
        movw    %ax, %ss
        mov     $(wakeup_stack - wakeup_code), %sp              # Private stack is needed for ASUS board
        movw    $0x0e00 + 'S', %fs:(0x12)

        pushl   $0                                              # Kill any dangerous flags
        popfl

        movl    real_magic - wakeup_code, %eax
        cmpl    $0x12345678, %eax
        jne     bogus_real_magic

        testl   $1, video_flags - wakeup_code
        jz      1f
        lcall   $0xc000,$3
        movw    %cs, %ax
        movw    %ax, %ds                                        # Bios might have played with that
        movw    %ax, %ss
1:

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
