Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVCPLEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVCPLEK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 06:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVCPLEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 06:04:10 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:34788 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262547AbVCPLEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 06:04:01 -0500
Message-ID: <423821F9.19FD92C8@tv-sign.ru>
Date: Wed, 16 Mar 2005 15:09:29 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Lameter <christoph@lameter.com>, linux-kernel@vger.kernel.org,
       Shai Fultheim <Shai@Scalex86.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] del_timer_sync: proof of concept
References: <4231E959.141F7D85@tv-sign.ru> <Pine.LNX.4.58.0503111254270.25992@server.graphe.net> <42371941.CCBAB134@tv-sign.ru> <20050316090024.GB11582@elte.hu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> > New rules:
> > 	->_base &  1	: is timer pending
> > 	->_base & ~1	: timer's base
>
> how would it look like if we had a separate timer->pending field after
> all? Would it be faster/cleaner?

The only change visible outside kernel/timer.c is:

 static inline int timer_pending(const struct timer_list * timer)
 {
-	return timer->base != NULL;
+	return timer->base & 1;
 }

Currently __get_base() usage in the kernel/time.c suboptimal and
should be cleanuped, I see no other problems with performance.

> (we dont need to keep them small _that_ bad - if there's a good reason
> we should rather add a clean new field than to encode two fields into
> one field and complicate the code.)

I think that separate timer->pending field will require more changes,
because we can't read/write base+pending atomically.

int del_timer()
{
again:
	if (!timer->pending)	// not strictly necessary, but it is
		return 0;	// nice to avoid locking
	base = timer->base;
	if (!base)
		return 0;

	spin_lock(base->lock);

	if (!timer->pending) {
		spin_unlock();
		goto again;
	}
	if (timer->base != base) {
		spin_unlock();
		goto again;
	}
	....	
}

Note also, that we have to audit every timer->base usage anyway,
because currently it mix base and pending.

But may be you are right, the encoding of a bit in a pointer is
indeed weird.

Oleg.
