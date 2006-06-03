Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWFCGXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWFCGXf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 02:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWFCGXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 02:23:35 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:17671 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932558AbWFCGXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 02:23:35 -0400
Date: Sat, 3 Jun 2006 08:04:38 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan Van de Ven <arjan@infradead.org>
Subject: Re: [patch] epoll use unlocked wqueue operations ...
Message-ID: <20060603060438.GB30150@w.ods.org>
References: <Pine.LNX.4.64.0606021600001.5402@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606021600001.5402@alien.or.mcafeemobile.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davide,

On Fri, Jun 02, 2006 at 04:28:25PM -0700, Davide Libenzi wrote:
> 
> A few days ago Arjan signaled a lockdep red flag on epoll locks, and 
> precisely between the epoll's device structure lock (->lock) and the wait 
> queue head lock (->lock). Like I explained in another email, and directly 
> to Arjan, this can't happen in reality because of the explicit check at 
> eventpoll.c:592, that does not allow to drop an epoll fd inside the same 
> epoll fd. Since lockdep is working on per-structure locks, it will never 
> be able to know of policies enforced in other parts of the code. It was 
> decided time ago of having the ability to drop epoll fds inside other 
> epoll fds, that triggers a very trick wakeup operations (due to possibly 
> reentrant callback-driven wakeups) handled by the ep_poll_safewake() 
> function.
> While looking again at the code though, I noticed that all the operations 
> done on the epoll's main structure wait queue head (->wq) are already 
> protected by the epoll lock (->lock), so that locked-style functions can 
> be used to manipulate the ->wq member. This makes both a lock-acquire 
> save, and lockdep happy.
> Running totalmess on my dual opteron for a while did not reveal any 
> problem so far:
> 
> http://www.xmailserver.org/totalmess.c

Shouldn't we notice a tiny performance boost by avoiding those useless
locks, or do you consider they are not located in the fast path anyway ?

Regards,
Willy

