Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264482AbUFRWtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbUFRWtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUFRWsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:48:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33427 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264482AbUFRWpu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:45:50 -0400
Message-ID: <40D37090.20909@pobox.com>
Date: Fri, 18 Jun 2004 18:45:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, Robert.Picco@hp.com
Subject: Re: [PATCH] HPET driver
References: <200406181616.i5IGGECd003812@hera.kernel.org>	<40D35740.8070206@pobox.com> <20040618145531.015fbc12.akpm@osdl.org>
In-Reply-To: <20040618145531.015fbc12.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>>	[PATCH] HPET driver
>>>	
>>
>>Was this posted on lkml, or simply snuck in?
> 
> 
> Was posted on lkml, was fairly widely reviewed, had comments from hch and
> others, had several fixes from myself and from Robert and a long discussion
> wrt the readq() implementation.

I'm surprised it was reviewed, but I apologize for my harsh words in any 
case.


> wrt the readq() implementation: I reverted the generic implementation based
> on concerns raised on lkml by Eric Biederman.  As a generic readq/writeq
> implementation seems to be a new R&D project I decided to leave the
> implementation private to the HPET driver until someone takes all of this
> on.

All the readq/writeq users at the moment don't give a crap about atomicity.


> wrt the hpets list locking: yeah, I noticed that, mentioned it to Robert
> wrt the request_irq() bug: yipes.  Robert, please fix.
> wrt the new miscdev minor: yes, devices.txt should be updated.  When the

And:

1) a merge issue, we shouldn't be merging new procfs stuff

2) build breaks if CONFIG_ACPI is not set, but this driver is selected

3) shared interrupt causes very incorrect behavior, look at the last few 
lines of hpet_interrupt().

4) return EINVAL in open(2) if FMODE_WRITE isn't set.  Yes, vfs_write() 
will return EINVAL if you actually attempt to write(2), but other areas 
of the kernel check FMODE_WRITE.  I consider this a security bug, if the 
driver does not support writing, but does not prevent FMODE_WRITE from 
being set.  I do not know for sure, but I strongly suspect you can use 
this to cause incorrect behavior _somewhere_.

5) use of "__set_current_state" _and_ "current->state ="

6) race:
	spin-lock
	set HPET_IE
	spin-unlock

	doh!  we shouldn't have set HPET_IE

	spin-lock
	clear HPET_IE
	spin-unlock

