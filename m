Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbVKWIcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbVKWIcW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 03:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbVKWIcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 03:32:22 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:60576 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030356AbVKWIcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 03:32:04 -0500
Date: Wed, 23 Nov 2005 09:32:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: "lkml, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rt13 / minimum gcc  version
Message-ID: <20051123083203.GA32386@elte.hu>
References: <4383A790.1090208@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4383A790.1090208@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Darren Hart <dvhltc@us.ibm.com> wrote:

> rt13 makes use of the gcc extension:
> 	int __builtin_types_compatible_p (type1, type2)
> which from what I can tell was first introduced to gcc in version 3.1.1
> 	http://gcc.gnu.org/onlinedocs/gcc-3.1.1/gcc/Other-Builtins.html
> 
> In any case, I am unable to compile rt13 with gcc-2.95.  I have tried 
> various -std args as well, but the compiler dies on 
> __builtin_types_compatible_p.
> 
> 1) Is it acceptable to require >= gcc-3.1.1 to compile a Linux kernel?
> 
> 2) Would a patch/work-around for gcc-2.95 compatibility be accepted if 
> I provide one?  (assuming it is a sane implementation of course :-)

sure, i'll accept any sane patch. (quirky ones are OK too, as long as 
the effects are localized into an include file or so.)

but the type comparison feature is really essential to PREEMPT_RT. So 
unless gcc 2.95 has a comparable feature, i doubt it's doable.  

background: PREEMPT_RT relies on being able to implement build-time, 
"lock type dependent" function calls. I.e. 'down()' done on a semaphore 
will be built with a different function call than down() done on a 
compat semaphore. Or spin_lock() done on a raw spinlock leads to a 
different function call than spin_lock() done on a 'normal' spinlock.  
This solution implements a feature in C that is normally only found in 
object-oriented languages. It is an essential trick, as it reduces the 
size and impact of the -rt tree very significantly.

A completely type-unsafe (i.e. void * APIs with some runtime checking) 
solution is not acceptable - nor are separate per-type API namespaces.  
(such as compat_down(), etc.)

	Ingo
