Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWGHJde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWGHJde (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 05:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWGHJdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 05:33:33 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:37892 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932114AbWGHJdd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 05:33:33 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <jamagallon@ono.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [patch] spinlocks: remove 'volatile'
Date: Sat, 8 Jul 2006 02:33:24 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEJMNAAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060708003749.053d8875@werewolf.auna.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 08 Jul 2006 02:28:45 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 08 Jul 2006 02:28:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This is _totally_ incorrect. Your "lock" functions are broken, because 
> > they do not introduce syncronization points or locked bus operations. 
 
> But why should I do that ? I write C, a high level language, and I don't
> mind about buses or whatever. I just have to know that a 32 bit store is
> atomic in a 32bit arch. There is a nice high level and portable language
> feature to say 'reload this variable here'. And it lets the 
> compiler do its
> optimization work as it best can asuming it has to reload that variable.
> Instead, you prefer to lock all the bus for that.
> Kernel developers spent a full release to get rid of
> the 'big kernel lock'. Perhaps there is another release needed to get
> rid of the 'big memory barrier'.

	Wow, no. Not even close.

	If you need a full memory barrier because you want general lock/mutex semantics, then you need it and can't avoid it. If you just need atomic 32-bit operations, and you know that the platform has them, just use them directly with inline assembly.

	The proof that 'volatile' does not solve the problem is:

volatile int i;
i=i+1;

	Is this an atomic operation or not? Just because the platform has an atomic operation that will do this, does 'volatile' guarantee that I get it?

	If you are programming in a high-level language and need the atomicity guarantees that particular assembly instructions are known to give you, then you *must* specify those instructions. The 'volatile' keyword has *never* guaranteed atomicity even where such atomicity is possible.

	So both parts of your argument is wrong. The alternative to 'volatile' is not invalidating memory, we only invalidate memory when those are the specific semantics we need. And volatile is neither necessary nor sufficient to get atomicity when that is possible on the platform.

	You are actively advocating for coding practices that are known (from years of painful experience) to be disastrous.

> BTW, I really don't mind if a given architecnture has to lock the bus or
> say a prayer to Budha to reload a variable. I want it to be reloaded at
> every (or a certain, in case of a (volatile)mtx cast) usage. The compiler
> is the responsible of knowing what to do. What if nextgen P4 Xeon do not
> need a bus lock ? Will you rewrite the kernel ?

	What if the nextgen P4 Xeon needs something else in addition to what's needed to get the guaranteed semantics of 'volatile' (which are just signals and longjmp on a single CPU). Suppose it required something very expensive when accesses might occur on another CPU that wasn't needed for any of the defined uses of 'volatile'. Why would gcc provide that and slow down all the programs that use 'volatile' correctly?

	The whole problem with your use of 'volatile' that it's in the 'just happens to work' category. It just happens to work because what's needed for signals and longjmp is also what's needed for SMP. If something extre were needed for SMP that wasn't needed for the defined uses of 'volatile', you'd be screwed. That's why 'volatile' does *not* put in memory barriers by default, even though they're arguably needed if 'volatile' were supposed to prevent reordering of operations (which for locks is what we need!).

	DS


