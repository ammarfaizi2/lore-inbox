Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262217AbSJFWCB>; Sun, 6 Oct 2002 18:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262221AbSJFWCB>; Sun, 6 Oct 2002 18:02:01 -0400
Received: from packet.digeo.com ([12.110.80.53]:29849 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262217AbSJFWCA>;
	Sun, 6 Oct 2002 18:02:00 -0400
Message-ID: <3DA0B422.C23B23D4@digeo.com>
Date: Sun, 06 Oct 2002 15:07:30 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: 2.5.40-mm2
References: <3DA0854E.CF9080D7@digeo.com> <3DA0A144.8070301@us.ibm.com> <3DA0B151.6EF8C8D9@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2002 22:07:31.0932 (UTC) FILETIME=[C47B49C0:01C26D84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ...
>  int del_timer_sync(timer_t *timer)
>  {
> -       tvec_base_t *base = tvec_bases;
>         int i, ret;
> 
>         ret = del_timer(timer);
> 
>         for (i = 0; i < NR_CPUS; i++) {
> +               tvec_base_t *base;
> +
>                 if (!cpu_online(i))
>                         continue;
> +               base = tvec_bases + i;
>                 if (base->running_timer == timer) {
> -                       while (base->running_timer == timer) {
> +                       while (base->running_timer == timer)
>                                 cpu_relax();
> -                               preempt_disable();
> -                               preempt_enable();
> -                       }
>                         break;
>                 }
>                 base++;

Oh, OK.  There's a base++ hidden at the end there :(

So the code as-is will work OK if all your online CPUs are
adjacent, starting at CPU0.  It is incorrect if you have
gaps in your online map.
