Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270496AbTHJSRQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 14:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270530AbTHJSRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 14:17:16 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:61444 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S270496AbTHJSRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 14:17:13 -0400
Message-ID: <3F368BC4.BEB892E3@SteelEye.com>
Date: Sun, 10 Aug 2003 14:15:32 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Peter T. Breuer" <ptb@it.uc3m.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.22-pre] nbd: fix race conditions
References: <200308101706.h7AH6Hd21642@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:
> 
> In article <iKef.8c1.15@gated-at.bofh.it> you wrote:
> > This patch is similar to one I posted yesterday for 2.6. It fixes the
> > following race conditions in nbd:
> >
> > 1) adds locking and properly orders the code in NBD_CLEAR_SOCK to
> > eliminate races with other code
> 
> This is not so clear as for the 2.6 code.

Sure it is. We have to NULL the socket and file before trying to clear
the queue, otherwise we're racing against do_nbd_request, which is
filling the queue.


> There's no ref_count in the
> 2.4 request struct, so you have no standard way to mark a request as
> in-flight, and hence no standard way to get clr_queue to skip it for the

Correct. This patch does not protect against one particular race that
the 2.6 patch does, namely the one that ref_count protects us from.
There is no ref_count in 2.4, so another workaround would have to be
employed to fix that race...I don't know if it's worth fixing in 2.4 at
this point...it's a very small window, and there's no really clean fix.


> > 2) adds an lo->sock check to nbd_clear_que to eliminate races between
> > do_nbd_request and nbd_clear_que, which resulted in the dequeuing of
> > active requests
> >
> > 3) adds an lo->sock check to NBD_DO_IT to eliminate races with
> > NBD_CLEAR_SOCK, which caused an Oops when "nbd-client -d" was called
> >
> 
> All these are for the same thing - the metadataraces.

No, actually 2), above, fixes one of the races between sending requests
and freeing them. It disallows nbd_clear_que before the socket has been
NULLed.


> > -             file = lo->file;
> > -             if (!file) {
> > -                     spin_unlock(&lo->queue_lock);
> > -                     return -EINVAL;
> > +                     printk(KERN_ERR "nbd: disconnect: some requests are in progress -> please try again.\n");
> > +                     error = -EBUSY;
> >               }
> 
> ... it looks as though if the queue is nonempty, we now still return
> busy. So what you did was remove the test on lo->file. Now we don't
> care about the lo->file state. Why?

We don't care about lo->file since we really just want NBD_CLEAR_SOCK to
cleanup as best it can. There's no harm in running this on a device that
has lo->file NULL anyway, since the device would be inactive at that
point. 

Also, the reordering of the code actually makes it impossible to hit the
"queue not empty" case now. do_nbd_request will not queue a request if
lo->file is NULL.
 

> >       case NBD_CLEAR_QUE:
> > +             down(&lo->tx_lock);
> > +             if (lo->sock) {
> > +                     up(&lo->tx_lock);
> > +                     return 0; /* probably should be error, but that would
> > +                                * break "nbd-client -d", so just return 0 */
> > +             }
> > +             up(&lo->tx_lock);
> 
> You don't clear queue while lo->sock is nonzero. This means that one
> must have cleared socket beforehand.

Yes, clearing the queue while the device is still active is racy, so we
disallow it. 

 
> I don't see any race conditions going away. Except possibly a race
> between set sock and clear sock to set lo->sock. The setting of
> lo->file is also a little more atomic now, and that's OK. But surely
> the race condition you cured in 2.6 was not this at all, but a race
> between clearing the queue and doing the requests?

3 of 4 race conditions that were fixed in the 2.6 patch are fixed here.
As I said above, fixing the 4th is not simple, and may not be worth it
at this point for 2.4.

--
Paul
