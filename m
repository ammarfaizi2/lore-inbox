Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbSKOSly>; Fri, 15 Nov 2002 13:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266480AbSKOSly>; Fri, 15 Nov 2002 13:41:54 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:61432 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266464AbSKOSlw>; Fri, 15 Nov 2002 13:41:52 -0500
Subject: Re: Non-blocking lock requests during the grace period
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OFFF0C4F23.C5AA44D6-ON87256C72.0066E60D@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Fri, 15 Nov 2002 10:48:49 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0 [IBM]|November 8, 2002) at
 11/15/2002 11:49:53
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Guess you are right. I was just worried that this code does not become
active for any other case than the one we were trying to fix.
We should also return when called from test as it should be non-blocking.
Then we do have the problem with UNLOCKs so we
have two choices: either fix the caller or just check for either lock or
test and block. I rather the last one.


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



