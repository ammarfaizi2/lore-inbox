Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263415AbUEKTXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUEKTXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUEKTXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:23:22 -0400
Received: from fmr04.intel.com ([143.183.121.6]:9627 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263415AbUEKTXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:23:20 -0400
Message-Id: <200405111923.i4BJN6F17770@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>,
       "Geoff Gustafson" <geoff@linux.jf.intel.com>
Cc: <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [RFC] [PATCH] Performance of del_timer_sync
Date: Tue, 11 May 2004 12:23:08 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQ3i9OpGio0MNfNQH27TZnXpmFRlQAAGyBQ
In-Reply-To: <20040511121126.73f5fdeb.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Andrew Morton wrote on Tuesday, May 11, 2004 12:11 PM
> > > Geoff Gustafson <geoff@linux.jf.intel.com> wrote:
> > >>
> > >> I started this patch based on profiling an enterprise database
> > >>  application on a 32p IA64 NUMA machine, where del_timer_sync was
> > >>  one of the top few functions taking CPU time in the kernel.
> > >
> > > Do you know where it's being called from?
> >
> > OK, the main sources were:
> >
> > sys_semtimedop() -> schedule_timeout()
> >
> > sys_io_getevents() -> read_events() -> clear_timeout()
> >
>
> OK, thanks.  schedule_timeout()!  Ow.
>
> Ingo, why is this not sufficient?
>
>
> diff -puN kernel/timer.c~a kernel/timer.c
> --- 25/kernel/timer.c~a	2004-05-11 12:10:28.695557600 -0700
> +++ 25-akpm/kernel/timer.c	2004-05-11 12:10:42.820410296 -0700
> @@ -331,6 +331,8 @@ int del_timer_sync(struct timer_list *ti
>
>  del_again:
>  	ret += del_timer(timer);
> +	if (!ret)
> +		return 0;
>
>  	for_each_cpu(i) {
>  		base = &per_cpu(tvec_bases, i);


Hehe ... , first thing we tried :-). But has problem that if timeout
function is running while del_timer_sync() is called, it returns
without waiting.

- Ken


