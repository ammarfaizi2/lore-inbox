Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264487AbRFIUeO>; Sat, 9 Jun 2001 16:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264486AbRFIUeE>; Sat, 9 Jun 2001 16:34:04 -0400
Received: from [32.97.182.102] ([32.97.182.102]:63458 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264485AbRFIUd5>;
	Sat, 9 Jun 2001 16:33:57 -0400
Importance: Normal
Subject: Re: Please test: workaround to help swapoff behaviour
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Derek Glidden <dglidden@illusionary.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Stephen Tweedie <sct@redhat.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF2FF3269C.90D4688C-ON85256A66.006DEAFA@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Sat, 9 Jun 2001 16:32:29 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Build V508_06042001 |June 4, 2001) at
 06/09/2001 04:31:32 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>Bulent,
>
>Could you please check if 2.4.6-pre2+the schedule patch has better
>swapoff behaviour for you?

Marcelo,

It works as expected.  Doesn't lockup the box however swapoff keeps burning
the CPU cycles.  It took 4 1/2 minutes to swapoff about 256MB of swap
content.  Shutdown took just as long.  I was hoping that shutdown would
kill the swapoff process but it doesn't.  It just hangs there.  Shutdown
is the common case.  Therefore, swapoff needs to be optimized for
shutdowns.
You could imagine users frustration waiting for a shutdown when there are
gigabytes in the swap.

So to summarize, schedule patch is better than nothing but falls far short.
I would put it in 2.4.6.  Read on.

----------

The problem is with the try_to_unuse() algorithm which is very inefficient.
I searched the linux-mm archives and Tweedie was on to this. This is what
he wrote:  "it is much cheaper to find a swap entry for a given page than
to find the swap cache page for a given swap entry." And he posted a
patch http://mail.nl.linux.org/linux-mm/2001-03/msg00224.html
His patch is in the Redhat 7.1 kernel 2.4.2-2 and not in 2.4.5.

But in any case I believe the patch will not work as expected.
It seems to me that he is calling the function check_orphaned_swap(page)
in the wrong place.  He is calling the function while scanning the
active_list in refill_inactive_scan().  The problem with that is if you
wait
60 seconds or longer the orphaned swap pages will move from active
to inactive lists. Therefore the function will miss the orphans in inactive
lists.  Any comments?



