Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264037AbSJ3GUy>; Wed, 30 Oct 2002 01:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264146AbSJ3GUy>; Wed, 30 Oct 2002 01:20:54 -0500
Received: from packet.digeo.com ([12.110.80.53]:36535 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264037AbSJ3GUw>;
	Wed, 30 Oct 2002 01:20:52 -0500
Message-ID: <3DBF7BBD.795AFC0E@digeo.com>
Date: Tue, 29 Oct 2002 22:27:09 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       Matt Reppert <arashi@arashi.yi.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: poll-related "scheduling while atomic", 2.5.44-mm6
References: <20021029223856.21280.qmail@linuxmail.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2002 06:27:09.0980 (UTC) FILETIME=[604AA5C0:01C27FDD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> 
> >> So my guess is somewhere between -mm5 and -mm6 we
> >> screwed up the atomicity count.
> >Mine too.  I'll check it out, thanks.
> 
> The same here as well
> 

This'll fix it up.  Whoever invented cut-n-paste has a lot to
answer for.


--- 25/mm/swap.c~preempt-count-fix	Tue Oct 29 22:19:54 2002
+++ 25-akpm/mm/swap.c	Tue Oct 29 22:20:16 2002
@@ -90,11 +90,12 @@ void lru_cache_add_active(struct page *p
 
 void lru_add_drain(void)
 {
-	struct pagevec *pvec = &per_cpu(lru_add_pvecs, get_cpu());
+	int cpu = get_cpu();
+	struct pagevec *pvec = &per_cpu(lru_add_pvecs, cpu);
 
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
-	pvec = &per_cpu(lru_add_active_pvecs, get_cpu());
+	pvec = &per_cpu(lru_add_active_pvecs, cpu);
 	if (pagevec_count(pvec))
 		__pagevec_lru_add_active(pvec);
 	put_cpu();

.

I had a crash while testing SMP+preempt btw.  Nasty one - took a
pagefault from userspace but do_page_fault() decided that the
fault was in-kernel or something.  It fell all the way through
to die() and, well, died.  I saw the same happen some months ago.
