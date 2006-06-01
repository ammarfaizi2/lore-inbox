Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWFAIpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWFAIpl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 04:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWFAIpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 04:45:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33426 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750777AbWFAIpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 04:45:40 -0400
Subject: deadlock in epoll (found by lockdep)
From: Arjan van de Ven <arjan@infradead.org>
To: davidel@xmailserver.org, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu
Content-Type: text/plain
Date: Thu, 01 Jun 2006 10:45:37 +0200
Message-Id: <1149151538.3115.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in ep_poll() (fs/eventpoll.c) the code does

       write_lock_irqsave(&ep->lock, flags);

        res = 0;
        if (list_empty(&ep->rdllist)) {
                /*
                 * We don't have any available event to return to the caller.
                 * We need to sleep here, and we will be wake up by
                 * ep_poll_callback() when events will become available.
                 */
                init_waitqueue_entry(&wait, current);
                add_wait_queue(&ep->wq, &wait);

eg we first take ep->lock and then call add_wait_queue which takes 
         spin_lock_irqsave(&q->lock, flags);
for obvious reasons.
this would mean that ep->lock would be the outer lock, and q->lock the
inner lock.


HOWEVER, __wake_up does this:
void fastcall __wake_up(wait_queue_head_t *q, unsigned int mode,
                        int nr_exclusive, void *key)
{
        unsigned long flags;

        spin_lock_irqsave(&q->lock, flags);
        __wake_up_common(q, mode, nr_exclusive, 0, key);
        spin_unlock_irqrestore(&q->lock, flags);
}

where __wake_up_common calls into ep_poll_callback, which in term does
        write_lock_irqsave(&ep->lock, flags);
as one of the first things.

... which implies that q->lock is the outer lock, and ep->lock is the
inner lock.... 

can you explain which order is right, and if/why this is not an AB-BA
deadlock??

Greetings,
   Arjan van de Ven

