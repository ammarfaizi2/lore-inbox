Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVIJKt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVIJKt2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 06:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVIJKt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 06:49:28 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:51395 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750744AbVIJKt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 06:49:27 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Scheduler hooks to support separate ia64 MCA/INIT stacks 
In-reply-to: Your message of "Fri, 09 Sep 2005 00:17:44 MST."
             <Pine.LNX.4.61.0509082356390.978@montezuma.fsmlabs.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 10 Sep 2005 20:48:45 +1000
Message-ID: <23761.1126349325@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005 00:17:44 -0700 (PDT), 
Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>On Fri, 9 Sep 2005, Keith Owens wrote:
>
>> The new ia64 MCA/INIT handlers[1] (think of them as super NMI) run on
>> separate stacks.  99% of the changes for these new handlers is ia64
>> only code, however they need a couple of scheduler hooks to support
>> these extra stacks.  The complete patch set will be coming through the
>> ia64 tree, this RFC covers just the scheduler changes, so they do not
>> come as a surprise when the ia64 tree is rolled up.
>> 
>> [1] http://marc.theaimsgroup.com/?l=linux-ia64&m=112537827113545&w=2
>>     and the following patches.
>
>Thanks that gave a lot of background.
>
>> This patch adds two small hooks that can be safely called from MCA/INIT
>> context.  If other architectures want to support NMI on separate stacks
>> then they can also use these functions.
>
>Well x86_64 already does this with NMI being setup as ISTs, the difference 
>is that there we use a register to access current (via PDA/%gs). I might 
>have missed this in the URL you posted, but how come IA64 can't do this 
>via r13?

Because of this possible event sequence: user space -> kernel -> SAL ->
PAL -> physical mode -> MCA/INIT.  When MCA/INIT is delivered in
physical mode, the contents of all registers are undefined.  PAL can
use r13 for its own work, as long as r13 is restored before returning
to the kernel.  MCA/INIT breaks the assumption that r13 is always valid.

