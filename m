Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbQKVMFd>; Wed, 22 Nov 2000 07:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131545AbQKVMFN>; Wed, 22 Nov 2000 07:05:13 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:54172 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129682AbQKVMFG>; Wed, 22 Nov 2000 07:05:06 -0500
Message-ID: <3A1BAF5F.4649594B@uow.edu.au>
Date: Wed, 22 Nov 2000 22:34:55 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Johannes Erdfelt <johannes@erdfelt.com>,
        Oleg Drokin <green@ixcelerator.com>, linux-kernel@vger.kernel.org
Subject: Re: hardcoded HZ in hub.c
In-Reply-To: <3A1BAC59.B0F124AF@uow.edu.au>,
		<3A1BAC59.B0F124AF@uow.edu.au>  <20001121142616.L7764@sventech.com>, <20001121142616.L7764@sventech.com> <20001121095626.F3431@valinux.com> <Pine.LNX.4.30.0011211912490.22252-100000@imladris.demon.co.uk> <4627.974890115@redhat.com> <9719.974892360@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> andrewm@uow.edu.au said:
> >  Nothing which sleeps for very long - mainly serial drivers which
> > queue a call to tty_hangup(), which immediately queues _another_
> > tq_scheduler call to do_tty_hangup (Why?  Heaven knows).
> 
> Not so much worried about that. More about how sensitive they would be to
> something _else_ causing the eventd thread to sleep for 'multiple seconds'
> before getting round to doing what they asked.

Ah.  No, I don't think it would be polite to cause TTY hangup processing
to be deferred for this long.  I'd suggest that the policy be "scheduled
tasks can't sleep".  I guess kmalloc(GFP_KERNEL) is acceptable because
the system is already running like a dog if this sleeps.

> I really don't want to have to start using multiple eventd threads before
> 2.5, if at all. So I don't want to add the USB hub stuff unless the other
> queued tasks will be happy with that.

Some of these requirements could also be satisfied with a combination of
a timer_list and a tq_struct.  When the timer fires, feed the tq_struct
into schedule_task.

Easy, except for the problem of killing the damn things off reliably.  That
would require a bit of infrastructure.  But it's the right thing for
netdriver media polling functions, for example.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
