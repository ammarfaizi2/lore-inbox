Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbTLKQh3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 11:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbTLKQh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 11:37:29 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:36783 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265152AbTLKQh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 11:37:27 -0500
Message-ID: <3FD89D43.7020403@cyberone.com.au>
Date: Fri, 12 Dec 2003 03:37:23 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
References: <3FD81BA4.8070602@cyberone.com.au> <3FD8317B.4060207@cyberone.com.au> <20031211115222.GC8039@holomorphy.com> <3FD86C70.5000408@cyberone.com.au> <20031211132301.GD8039@holomorphy.com> <3FD8715F.9070304@cyberone.com.au> <20031211133207.GE8039@holomorphy.com> <3FD88D93.3000909@cyberone.com.au> <20031211153838.GH8039@holomorphy.com> <3FD89284.2090509@cyberone.com.au> <20031211155611.GI8039@holomorphy.com>
In-Reply-To: <20031211155611.GI8039@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>William Lee Irwin III wrote:
>
>>>There is a spinloop in __up_read(), which is probably it.
>>>
>
>On Fri, Dec 12, 2003 at 02:51:32AM +1100, Nick Piggin wrote:
>
>>Oh I see - in rwsem_wake?
>>
>
>Even before that:
>
>static inline void __up_read(struct rw_semaphore *sem)
>{
>        __s32 tmp = -RWSEM_ACTIVE_READ_BIAS;
>        __asm__ __volatile__(
>                "# beginning __up_read\n\t"
>LOCK_PREFIX     "  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
>                "  js        2f\n\t" /* jump if the lock is being waited upon */
>                "1:\n\t"
>                LOCK_SECTION_START("")
>                "2:\n\t"
>                "  decw      %%dx\n\t" /* do nothing if still outstanding active readers
> */
>                "  jnz       1b\n\t"
>                "  pushl     %%ecx\n\t"
>                "  call      rwsem_wake\n\t"
>                "  popl      %%ecx\n\t"
>                "  jmp       1b\n"
>                LOCK_SECTION_END
>

I think there shouldn't be a loop - remember the lock section.


