Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVFXXMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVFXXMD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 19:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbVFXXJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 19:09:39 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:43995 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S263133AbVFXXIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 19:08:36 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [Fastboot] Re: [-mm patch] i386: enable REGPARM by default
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050624132826.4cdfb63c.akpm@osdl.org>
References: <20050624200916.GJ6656@stusta.de>
	 <20050624132826.4cdfb63c.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 25 Jun 2005 01:08:22 +0200
Message-Id: <1119654502.1868.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre 2005-06-24 klockan 13:28 -0700 skrev Andrew Morton:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > This patch:
> > - removes the dependency of REGPARM on EXPERIMENTAL
> > - let REGPARM default to y
> 
> hm, a compromise.
> 
> One other concern I have with this is that I expect -mregparm will make
> kgdb (and now crashdump) less useful.  When incoming args are on the stack
> you have a good chance of being able to see what their value is by walking
> the stack slots.
> 
> When the incoming args are in registers I'd expect that it would be a lot
> harder (or impossible) to work out their value.
> 
> Have the kdump guys thought about (or encountered) this?

Hmmm. I played a bit with this. Without regparm there is some argument
output although not correct. For example the argument 'ptr' to b_first
should have been 0xbeef. both x=0 and y=299264 are incorrect. Not sure
why, have to look into that.

#0  b_second (pid=1, ptr=0xbeef, x=0, y=299264) at
arch/i386/kernel/process.c:180
#1  0xc0100ce8 in b_first (pid=1, ptr=0x1) at
arch/i386/kernel/process.c:188
-------------- (only the above is interesting)
#2  0xc0100d66 in cpu_idle () at arch/i386/kernel/process.c:221
#3  0xc010027b in rest_init () at init/main.c:393
#4  0xc033e838 in start_kernel () at init/main.c:534
#5  0xc0100199 in is386 () at arch/i386/kernel/head.S:327


Now with regparm. Suprisingly enough only y=0 is now errenous and the
rest are correct (double-checked, have to look into this aswell).

#0  b_second (pid=1, ptr=0xbeef, x=65297, y=0) at
arch/i386/kernel/process.c:180
#1  0xc0100c87 in b_first (pid=1, ptr=0xbeef) at
arch/i386/kernel/process.c:188
-------------- (only the above is interesting)
#2  0xc0100d01 in cpu_idle () at arch/i386/kernel/process.c:221
#3  0xc010026d in rest_init () at init/main.c:393
#4  0xc03247d1 in start_kernel () at init/main.c:534
#5  0xc0100199 in is386 () at arch/i386/kernel/head.S:327

This was at first glance but is interesting.

Adrian, why do we want REGPARM on by default? Performance? I haven't
seen any figures

