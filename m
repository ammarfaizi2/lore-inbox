Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266654AbSKOTE1>; Fri, 15 Nov 2002 14:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266650AbSKOTE1>; Fri, 15 Nov 2002 14:04:27 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:35213 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266645AbSKOTE0>;
	Fri, 15 Nov 2002 14:04:26 -0500
Subject: Re: Non-blocking lock requests during the grace period
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF5A692563.A6ED6EBB-ON87256C72.0068B38D@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Fri, 15 Nov 2002 11:09:44 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0 [IBM]|November 8, 2002) at
 11/15/2002 12:10:48
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





On second thoughts, I think I wonder if we want to fail F_GETLK while in
the grace period? seems like we won't there it makes sense to hold until
the grace period clears otherwise the client app may think there is
something wrong (note that F_GETLK man page does not provide EAGAIN as
a possible error code).
The case for F_SETLK is different as the result is expected when the lock
is not available due to a previous holder (or, as I want to do it, when the
lock is not available ether by previous holder or grace period).


Juan



|---------+---------------------------->
|         |           Trond Myklebust  |
|         |           <trond.myklebust@|
|         |           fys.uio.no>      |
|         |                            |
|         |           11/15/02 09:35 AM|
|         |           Please respond to|
|         |           trond.myklebust  |
|         |                            |
|---------+---------------------------->
  >-------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                         |
  |       To:       Juan Gomez/Almaden/IBM@IBMUS                                                                            |
  |       cc:       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net                                                 |
  |       Subject:  Re: Non-blocking lock requests during the grace period                                                  |
  |                                                                                                                         |
  |                                                                                                                         |
  >-------------------------------------------------------------------------------------------------------------------------|




     > 2.-I also have this part enclosed in the if(resp->status ==
     > NLM_LCK_DENIED_GRACE_PERIOD) as follows:

     > if(resp->status == NLM_LCK_DENIED_GRACE_PERIOD) {

     >       blah blah...

     > wait_on_grace:
     >                          if ((proc == NLMPROC_LOCK) &&
     >                          !argp->block)
     >                                      return -EAGAIN
     > } else {

     >       ....
     > }

     > This with the intention to be very specific as to when we want
     > the return -EAGAIN to be called.

The above means that you will still block on a F_GETLK query...

In any case, why would we want to return -EAGAIN in one case where
argp->block isn't set, and not in another? If there are cases where we
want to block and where we are not currently setting argp->block (the
only one I can think of might be NLMPROC_UNLOCK), then we should fix
the caller.

Cheers,
  Trond



