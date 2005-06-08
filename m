Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVFHQFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVFHQFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVFHQB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:01:58 -0400
Received: from [195.23.16.24] ([195.23.16.24]:24714 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261336AbVFHP5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:57:05 -0400
Message-ID: <42A7153D.5020608@grupopie.com>
Date: Wed, 08 Jun 2005 16:56:45 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <8116.1118244230@ocs3.ocs.com.au>
In-Reply-To: <8116.1118244230@ocs3.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Wed, 08 Jun 2005 17:04:23 +0200, 
> Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
>>Paulo Marques wrote:
>>
>>>[...]
>>>and disable CONFIG_KALLSYMS_EXTRA_PASS, to see if the problem goes away?
>>
>>Yes, this helps.
>>
>>>It it does go away, then it is the same problem, and I'm working on it...
> 
> Not the same problem.  The significant difference in the maps is :-
> 
> --- .tmp_map1   2005-06-09 01:14:50.303658655 +1000
> +++ .tmp_map2   2005-06-09 01:14:52.829274854 +1000
> @@ -8326,8 +8326,8 @@
>  c02b93b0 T ipv6_skip_exthdr
>  c02b9500 T sha_transform
>  c02b96e0 T sha_init
> -c02b970f T __sched_text_start
>  c02b9710 t __compat_down
> +c02b9710 T __sched_text_start
>  c02b9810 t __compat_down_interruptible
>  c02b9948 T __compat_down_failed
>  c02b9958 T __compat_down_failed_interruptible
> 
> __sched_text_start has moved up by 1 byte between pass 1 and 2.  Text
> addresses are not allowed to move between kallsyms passes, kallsyms
> only adds data, it never touches the text segment.  Paulo's change to
> the working set hides this peculiarity, rather than fixing the real
> cause.  This looks like a toolchain bug, it is moving symbols for no
> good reason.

Actually this is exactly the same problem we've seen in other threads: 
the symbol that marks the beggining of a section gets aligned to a 
different boundary on the second pass. Because it has now the same 
address as the next symbol, it gets sorted in reverse order.

I agree that this is the toolchain's fault, but I think kallsyms could 
be a little more robust and handle this without preventing the kernel 
from building properly.

-- 
Paulo Marques - www.grupopie.com

An expert is a person who has made all the mistakes that can be
made in a very narrow field.
Niels Bohr (1885 - 1962)
