Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVDYUzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVDYUzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVDYUzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:55:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:64934 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261192AbVDYUy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:54:56 -0400
Date: Mon, 25 Apr 2005 13:54:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: timur.tabi@ammasso.com, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-Id: <20050425135401.65376ce0.akpm@osdl.org>
In-Reply-To: <52is2bvvz5.fsf@topspin.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org>
	<52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org>
	<5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org>
	<52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org>
	<4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org>
	<4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org>
	<426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
>     Timur> With mlock(), we don't need to use get_user_pages() at all.
>      Timur> Arjan tells me the only time an mlocked page can move is
>      Timur> with hot (un)plug of memory, but that isn't supported on
>      Timur> the systems that we support.  We actually prefer mlock()
>      Timur> over get_user_pages(), because if the process dies, the
>      Timur> locks automatically go away too.
> 
>  There actually is another way pages can move, with both
>  get_user_pages() and mlock(): copy-on-write after a fork().  If
>  userspace does a fork(), then all PTEs are marked read-only, and if
>  the original process touches the page after the fork(), a new page
>  will be allocated and mapped at the original virtual address.

Do we care about that?  A straightforward scenario under which this can
happen is:

a) app starts some read I/O in an asynchronous manner
b) app forks
c) child writes to one of the pages which is still under read I/O
d) the read I/O completes
e) the child is left with the old data plus the child's modification instead
   of the new data

which is a very silly application which is giving itself unpredictable
memory contents anyway.

I assume there's a more sensible scenario?
