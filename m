Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWAISYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWAISYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWAISYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:24:12 -0500
Received: from gold.veritas.com ([143.127.12.110]:49340 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964914AbWAISYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:24:10 -0500
Date: Mon, 9 Jan 2006 18:24:21 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
In-Reply-To: <9a8748490601091001y74fba5q2cd7e08a324701c3@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0601091819160.14800@goblin.wat.veritas.com>
References: <20060107052221.61d0b600.akpm@osdl.org> 
 <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com> 
 <9a8748490601090947i524d5f73uf5ccd06d8c693cae@mail.gmail.com> 
 <20060109175748.GD25102@redhat.com> <9a8748490601091001y74fba5q2cd7e08a324701c3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jan 2006 18:24:10.0056 (UTC) FILETIME=[E2538C80:01C61549]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Jesper Juhl wrote:
> On 1/9/06, Dave Jones <davej@redhat.com> wrote:
> > On Mon, Jan 09, 2006 at 06:47:01PM +0100, Jesper Juhl wrote:
> >
> >  > Here's what bad_page printed for me :
> >  >
> >  > Bad page state in process 'kded'
> >  > [<c0103e77>] dump_stack+0x17/0x20
> >  > [<c0148999>] bad_page+0x69/0x160
> >
> > Odd, there should be more state between the 'Bad page'
> > and the backtrace.
> >
> >     printk(KERN_EMERG "Bad page state in process '%s'\n"
> >                 "page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
> >                 "Trying to fix it up, but a reboot is needed\n"
> >
> > Did you aggressively trim that, or did it for some
> > reason not get printed ?
> >
> 
> I did not trim that.
> 
> All I did was add
> 
>  printk(KERN_EMERG "we hit bad page, looping forever\n");
>  while (1) {
>     mdelay(1000);
>  }
> 
> to the end of bad_page()

I'm afraid someone has recently "tidied up" bad_page, and missed out
the most interesting KERN_EMERG of all.  No promises that this will
actually help us more than the backtrace you've sent, but please give
it another go with patch below applied.  Andrew, please pass along...


Restore KERN_EMERG to each line printed by bad_page.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.15-mm2/mm/page_alloc.c	2006-01-07 14:05:58.000000000 +0000
+++ linux/mm/page_alloc.c	2006-01-09 18:13:00.000000000 +0000
@@ -137,9 +137,9 @@ static inline int bad_range(struct zone 
 static void bad_page(struct page *page)
 {
 	printk(KERN_EMERG "Bad page state in process '%s'\n"
-		"page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
-		"Trying to fix it up, but a reboot is needed\n"
-		"Backtrace:\n",
+		KERN_EMERG "page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
+		KERN_EMERG "Trying to fix it up, but a reboot is needed\n"
+		KERN_EMERG "Backtrace:\n",
 		current->comm, page, (int)(2*sizeof(unsigned long)),
 		(unsigned long)page->flags, page->mapping,
 		page_mapcount(page), page_count(page));
