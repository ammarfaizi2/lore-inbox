Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261779AbTCGVFM>; Fri, 7 Mar 2003 16:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261786AbTCGVFL>; Fri, 7 Mar 2003 16:05:11 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:60093 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261782AbTCGVFH>; Fri, 7 Mar 2003 16:05:07 -0500
Date: Fri, 7 Mar 2003 13:17:32 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Andries.Brouwer@cwi.nl
Cc: patmans@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] scsi_error fix
Message-ID: <20030307211732.GA1148@beaverton.ibm.com>
Mail-Followup-To: Andries.Brouwer@cwi.nl, patmans@us.ibm.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	torvalds@transmeta.com
References: <UTC200303072019.h27KJXX12872.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200303072019.h27KJXX12872.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl [Andries.Brouwer@cwi.nl] wrote:
>     From: Patrick Mansfield <patmans@us.ibm.com>
> 
>     > [Further discussion and things I did not yet investigate:
>     > What was changed to make this fail first in 2.5.63?
>     > Experience shows that we get into a loop when something else
>     > than SUCCESS is returned here. Probably that is a bug elsewhere.
>     > Probably the commands that cause problems should never have been
>     > sent in the first place.]
> 
>     The scsi error handler is also used to retrieve sense data for
>     adapters/drivers that do not auto retrieve it. In such cases, it should
>     not issue any aborts, resets etc.
> 
> Indeed.
> 
>     Your change effectively disables that support - we never hit the code in
>     scsi_eh_get_sense() to request sense. It would be very nice if we could
>     fix (or audit) all the scsi drivers, apply your change and remove
>     scsi_eh_get_sense, but AFAIK that has not and is not happening.
> 
> No. What happened before was that we got into an infinite loop.
> The right action is to read the code, understand why it gets
> into a loop, and fix it. Once that has happened we may decide
> to undo my change. Or we may decide to ask for sense at that very spot.
> 
> Today both James and Mike say that they can reproduce the loop,
> so probably they'll fix that part. If not, I'll have a look again.

Sorry about that Patrick. I had sent some mail last might and thought it
went to the list.

Both James and I can reproduce this problem. I was able to reproduce
using a hack to scsi_debug. 

The loop problem is related to scsi error handling using the common code
of scsi_queue_insert / scsi_requesT_fn . When a command gets started the
scsi_init_cmd_errh function is called which sets retries to 0.

There maybe another issue with the scsi_eh_get_sense function, but I am
still looking at it.

I believe James is still pursuing a solution also.

-andmike
--
Michael Anderson
andmike@us.ibm.com

