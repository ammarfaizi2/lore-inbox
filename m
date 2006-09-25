Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWIYRFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWIYRFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWIYRFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:05:45 -0400
Received: from [212.227.126.187] ([212.227.126.187]:3791 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751269AbWIYRFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:05:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Aubrey <aubreylee@gmail.com>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Mon, 25 Sep 2006 19:05:21 +0200
User-Agent: KMail/1.9.4
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com> <200609251126.17494.arnd@arndb.de> <6d6a94c50609250839y7365e20ale6910e36b0ec9976@mail.gmail.com>
In-Reply-To: <6d6a94c50609250839y7365e20ale6910e36b0ec9976@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609251905.22224.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 September 2006 17:39, Aubrey wrote:
> 1) Timer interrupt will call do_irq(), then return_from_int().
> 
> 2) return_from_int() will check if there is interrupt pending or
> signal pending, if so, it will call schedule_and_signal_from_int().
> 
> 3) schedule_and_signal_from_int() will jump to resume_userspace()
> 
> 4) resume_userspace() will call _schedule to run the user task.

I have a little trouble reading your assembly code, but your
return_from_int() function should normally not call
schedule_and_signal_from_int() when the interrupt happened
in kernel context (like in the idle function):

+	/* if not return to user mode, get out */
+	p2.l = lo(IPEND);
+	p2.h = hi(IPEND);
+	r0 = [p2];
+	r1 = 0x17(Z);
+	r2 = ~r1;
+	r2.h = 0;
+	r0 = r2 & r0;
+	r1 = 1;
+	r1 = r0 - r1;
+	r2 = r0 & r1;
+	cc = r2 == 0;
+	if !cc jump 2f;

This looks a lot like you user_mode() function, so you jump
over schedule_and_signal_from_int() here.

What you described would be a preemptive kernel
(CONFIG_PREEMPT), but you clearly don't have that enabled.

	Arnd <><
