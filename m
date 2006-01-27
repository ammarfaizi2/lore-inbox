Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWA0TbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWA0TbS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWA0TbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:31:18 -0500
Received: from host233.omnispring.com ([69.44.168.233]:4015 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932485AbWA0TbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:31:17 -0500
Message-ID: <43DA74DC.3000702@cfl.rr.com>
Date: Fri, 27 Jan 2006 14:30:36 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14 kernels and above copy_to_user stupidity with IRQ disabled
 check
References: <43DA62CC.8090309@wolfmountaingroup.com>
In-Reply-To: <43DA62CC.8090309@wolfmountaingroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2006 19:31:36.0921 (UTC) FILETIME=[49E1A490:01C62378]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14231.000
X-TM-AS-Result: No--15.000000-5.000000-4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probably because you aren't allowed to call copy_to_user while holding a 
spin lock?  The user pages might be non resident and you can't have a 
page fault with interrupts disabled.  Also you don't want to spend a lot 
of time with interrupts disabled, and copy_to_user can take a fair 
amount of time for large copies. 

Jeff V. Merkey wrote:
>
> Is there a good reason someone set a disabled_irq() check on 2.6.14 
> and above for copy_to_user to barf out
> tons of bogus stack dump messages if the function is called from 
> within a spinlock:
>
> i.e.
>
> spin_lock_irqsave(&regen_lock, regen_flags);
>    v = regen_head;
>    while (v)
>    {
>       if (i >= count)
>          return -EFAULT;
>                                                                                
>
>       err = copy_to_user(&s[i++], v, sizeof(VIRTUAL_SETUP));
>       if (err)
>          return err;
>                                                                                
>
>       v = v->next;
>    }
>    spin_unlock_irqrestore(&regen_lock, regen_flags);
>
> is now busted and worked in kernels up to this point.  The error 
> message is annoying but non-fatal.
>
> Jeff
>

