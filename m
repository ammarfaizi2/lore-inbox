Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751978AbWFLNu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbWFLNu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 09:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbWFLNu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 09:50:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:28473 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751978AbWFLNu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 09:50:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oei06/bT/uX+b0gbXkm16SOFUOiVztaCTeO7HCOX0C/szZ/ARhknvvdgVtOZ4Q4ppislDy4sbunvGSp4LTjMTHX3UPsl7I1h1gLWNOx3UZVMNK39li/ATeYBrmp1+ZR0EWb6+OlPazPYvcnHCzHd8qWpVnT61qfxszWgLcaJqcU=
Message-ID: <6bffcb0e0606120650l7116ac17vc3a0379194b56315@mail.gmail.com>
Date: Mon, 12 Jun 2006 15:50:28 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.16-rc6-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060612110537.GA11358@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	 <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com>
	 <20060610092412.66dd109f.akpm@osdl.org>
	 <Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0606100951340.7174@schroedinger.engr.sgi.com>
	 <20060610100318.8900f849.akpm@osdl.org>
	 <Pine.LNX.4.64.0606101102380.7421@schroedinger.engr.sgi.com>
	 <6bffcb0e0606101114u37c8b642u5c9cc8dd566cba7c@mail.gmail.com>
	 <Pine.LNX.4.64.0606101118410.7535@schroedinger.engr.sgi.com>
	 <20060612110537.GA11358@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 12/06/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Christoph Lameter <clameter@sgi.com> wrote:
>
> > Sorry that patch was still against mm1. Here is a fixed up version
> > that applies cleanly against mm2:
>
> i have applied both patches you sent in this thread but it still
> triggers tons of messages:
>
>  printk: 104 messages suppressed.
>  BUG: using smp_processor_id() in preemptible [00000001] code: distccd/9263
>  caller is __handle_mm_fault+0x58/0xd70
>   [<c0105d6f>] show_trace+0xd/0x10
>   [<c0105d89>] dump_stack+0x17/0x1a
>   [<c0585ab4>] debug_smp_processor_id+0x88/0xa0
>   [<c016eb63>] __handle_mm_fault+0x58/0xd70
>   [<c110ff1c>] do_page_fault+0x2e5/0x672
>   [<c0104a69>] error_code+0x39/0x40
>   [<c110eade>] __kprobes_text_start+0x6/0x14
>
> trying to fix it i realized that i'd have to touch tons of
> architectures, which all duplicate this piece of code:
>
> /* Use these for per-cpu local_t variables: on some archs they are
>  * much more efficient than these naive implementations.  Note they take
>  * a variable, not an address.
>  */
> #define cpu_local_read(v)       local_read(&__get_cpu_var(v))
> #define cpu_local_set(v, i)     local_set(&__get_cpu_var(v), (i))
> #define cpu_local_inc(v)        local_inc(&__get_cpu_var(v))
> #define cpu_local_dec(v)        local_dec(&__get_cpu_var(v))
> #define cpu_local_add(i, v)     local_add((i), &__get_cpu_var(v))
> #define cpu_local_sub(i, v)     local_sub((i), &__get_cpu_var(v))
>
> #define __cpu_local_inc(v)      cpu_local_inc(v)
> #define __cpu_local_dec(v)      cpu_local_dec(v)
> #define __cpu_local_add(i, v)   cpu_local_add((i), (v))
> #define __cpu_local_sub(i, v)   cpu_local_sub((i), (v))
>
> that code must all be consolidated into a header in asm-generic, so that
> the per-arch file only implements _truly_ per-arch logic.

I just tried your latest  lockdep-combo-2.6.17-rc6-mm2 patch, and I
get many warnings

WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/sound/core/snd-pcm.ko
needs unknown symbol down_write
WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/sound/core/snd-pcm.ko
needs unknown symbol up_write
WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/sound/core/snd-pcm.ko
needs unknown symbol down_read
WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/sound/core/snd-pcm.ko
needs unknown symbol up_read
WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/sound/core/oss/snd-mixer-oss.ko
needs unknown symbol down_read
WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/sound/core/oss/snd-mixer-oss.ko
needs unknown symbol up_read
WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/sound/core/seq/snd-seq.ko
needs unknown symbol down_write

>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
