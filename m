Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWHaQEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWHaQEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWHaQEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:04:33 -0400
Received: from gw.goop.org ([64.81.55.164]:30855 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932353AbWHaQEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:04:32 -0400
Message-ID: <44F7088D.7010700@goop.org>
Date: Thu, 31 Aug 2006 09:04:29 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Ian Campbell <Ian.Campbell@XenSource.com>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 7/8] Implement smp_processor_id() with the PDA.
References: <20060830235201.106319215@goop.org>	 <20060831000515.338336117@goop.org> <1157027758.12949.327.camel@localhost.localdomain>
In-Reply-To: <1157027758.12949.327.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Campbell wrote:
> This doesn't compile for me if CONFIG_SMP=n
>   

Ah, good point.

>           LD      .tmp_vmlinux1
>         arch/i386/kernel/built-in.o: In function `cpu_init':
>         (.init.text+0x1eda): undefined reference to `early_smp_processor_id'
>         arch/i386/kernel/built-in.o: In function `cpu_init':
>         (.init.text+0x1f11): undefined reference to `early_smp_processor_id'
>         
> smp_processor_id() is defined for !SMP in include/linux/smp.h, I don't
> know if it would be appropriate to add early_smp_processor_id() there
> since it seems i386 specific. asm/smp.h isn't included by linux/smp.h
> when !SMP but you could add an explicit include to common.c I suppose.
>   

I'll have a look.

I think my preferred solution would be to get rid of all the early* 
stuff, and try to arrange to have the PDA set up before C code gets 
run.  For the boot CPU, it really could be done statically (I'm not 
quite sure why the boot CPU's GDT is allocated, given that it already 
has a static one; I think this might have been a Xen-related change?).  
The secondary CPUs could have their GDT+PDA completely allocated and 
initialized in advance, making secondary CPU PDA setup just a matter of 
doing lgdt and setting %gs in head.S, even before hitting C code.

    J
