Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVBJIUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVBJIUj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 03:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVBJIUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 03:20:36 -0500
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:24232 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S262042AbVBJIUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 03:20:25 -0500
Message-ID: <420B196C.2030202@ru.mvista.com>
Date: Thu, 10 Feb 2005 11:21:00 +0300
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>,
       Sven Dietrich <sdietrich@mvista.com>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Preempt Real-time for ARM
References: <1107628604.5065.54.camel@dhcp153.mvista.com> <1107948492.17747.31.camel@tglx.tec.linutronix.de> <20050209113140.GB13274@elte.hu> <20050209125044.A6312@flint.arm.linux.org.uk> <1107970869.10177.12.camel@dhcp153.mvista.com> <20050209194401.A8810@flint.arm.linux.org.uk>
In-Reply-To: <20050209194401.A8810@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Feb 09, 2005 at 09:41:10AM -0800, Daniel Walker wrote:
> 
>>	All I want to do is integrate the common IRQ threading code. To do that
>>I need things , from Russell, like per descriptor locks .. And I need
>>things , from Ingo, like pulling out the IRQ threading code..
> 
> 
> I've said why per-IRQ locks are incorrect for the non-RT cases on ARM,
> but unfortunately just repeating the reasons why it's wrong isn't
> getting me anywhere either.  So shrug, all I can to is explain why
> it's wrong, and if people choose not to listen there's nothing more
> I can do.

Lets summarize your main arguments from two threads - 
"irq_controller_lock" and this one:
(sorry, I summarized since I somehow accidently lost traack of 
"irq_controller_lock" thread and want to be sure I haven't missed anything)

1) if we drop ide_controller_lock we need to add per-chip lock due to 
read-modify-write issue

true

2) per-descriptor lock will not bring gains since
    a) SMP - almost nonexistent at the moment

As Daniel said - why not look to the future - did anybody expect 3 month 
  ago RT enchancement for Linux?! progress is too quick - and again from 
the perspective of SMP - irq_controller_lock is defective.

    b) lots of contention on request_irq/free_irq - rare
seems true
    c) multiple devices on the same interrupt line - rare
seems true

But in a whole it's not so unambiguously what outweighs - b)&c) against 
contra a)

3) per chip lock in combination with per descriptor lock
   a) decreases peformance

why not to lock per-chip lock only for chips indeed require this (i.e. 
with read/modify/write/) and drop the locking otherwise?!

   b) (quoatition):
      "Yes, and then audit that no one uses different irqchip structures
       covering the same register (consider a read-modify-write mask
       register where some IRQs are edge and others are level riggered.)"

such a register and a chip have ono-to-one relationship, do they? chip 
lock is something connected to _the_ chip. The above situation is 
definitly up to a developer and his own _fault_.

4) ARM IRQs are already "threaded"

As you said:  can we _please_ get the terminology right? As Nicolas 
pointed you were talking about completely different "threaded".


		Eugeny

