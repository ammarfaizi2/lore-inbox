Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311461AbSCNBIL>; Wed, 13 Mar 2002 20:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311463AbSCNBIC>; Wed, 13 Mar 2002 20:08:02 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:42421 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311462AbSCNBHw>; Wed, 13 Mar 2002 20:07:52 -0500
Message-ID: <3C8FF7C7.5CA133B0@us.ibm.com>
Date: Wed, 13 Mar 2002 17:07:19 -0800
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: ecki-news2002-02@lina.inka.de, kessler@us.ibm.com
Subject: Re: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bernd wrote...
> Of course it is only useful if it is not another framework because this will
> lead to kernel clutter. So do we want to replace netlink and printk?

I checked and there are nearly 41,000 calls to printk in the 2.5.6 
kernel.  Getting every maintainer to change to event logging's write
functions
would be impossible.  Instead we want to provide enhanced logging
features 
for new and updated device drivers and other kernel code--more of a
"slow 
migration over time" approach.  We provided the feature that creates
POSIX
event records from printks so that System Admins, field service,
developers
testing and debugging their code (just to name a few) could still take
advantage of the new tools provided with the user lib (too numerous to
mention, 
but see the spec on the website) for handling printk messages. 

Of course, even with better tools there may still be those who only want
to see
printks in /var/log/messages.  It has even been suggested that events in
the 
event log which did not originate with printk should also be written to
/var/log/messages, for this very reason. 

Another way to "replace" printk is not to replace the function itself,
but
instead combine printk's ring buffer with the event logging buffer, but
still
the end-user would see events in the event log and/or messages in
/var/log/messages.  A proposal like that at this point in time would
probably
be too radical, but is certainly a possibility.

I am sorry, I am not really familiar with netlink.  Please explain why
you 
think netlink could be (or perhaps should be) replaced with event
logging ?      

> Well, depending on the type of events one can even think about a "halt" like
> it is required for audit trail overflow.

I think the point you are making is that there are certain events that
you
never under any circumstances want to miss or discard because of their 
importance.  printk does not address this nor does it report the fact
that
messages in the ring buffer have even been overwritten.  Event logging
is a little better, but it does not prevent the loss of events either.

One scheme we have thought of is to add dynamic event buffer allocation,
so
that if the static event buffer overflows additional dynamic buffering
will
activate until the logging daemon can read-out the events.  Another 
possibility is the "selective" discarding of lower severity events when
the
event buffer reaches a high-water mark.

> What would be nice is a policy for each type of event:
>
> - overwrite old/new/halt
> - rate limit
> - buffer size

>From the beginning our design appoach has been to "write everything"
into the
kernel buffer (or at least try) and apply policies, screening,
filtering, 
etc. only in user-space for both performance reasons and to reduce the 
complexity of the code in the kernel.  Given the relatively low
occurance
of events overruning the buffer; or, evlogd logging daemon not running
and
draining them out, the "per-event type"  policy you seem to be
suggesting 
*I think* would add more complexity than dynamically allocating more
buffer
space when needed.  Please elaborate if you disagree.    

Regards,
Larry Kessler
http://evlog.sourceforge.net/
