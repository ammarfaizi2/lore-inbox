Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUIUNPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUIUNPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 09:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267669AbUIUNPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 09:15:41 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:51865 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267668AbUIUNPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 09:15:38 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/3] New input patches
Date: Tue, 21 Sep 2004 08:15:34 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200409162358.27678.dtor_core@ameritech.net> <20040921121040.GA1603@ucw.cz>
In-Reply-To: <20040921121040.GA1603@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409210815.34509.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 September 2004 07:10 am, Vojtech Pavlik wrote:
> On Thu, Sep 16, 2004 at 11:58:27PM -0500, Dmitry Torokhov wrote:
> >           I think that command processing is now race free - instead of using
> >           bit operations on flags the ps2_command and ps2_send_byte simply
> >           take serio->lock (via serio_pause/continue_rx). Since serio->lock
> >           is also taken by interrupt handler anyway it gives us desired
> >           serialization. As wakeup routines take a spinlock as well and
> >           spinlock is guaranteed to be a barrier we should not miss wake up
> >           events either.
> 
> I hope the wait_event* functions also use memory barriers properly, but
> they probably must, otherwise they won't be useful, because there we're
> accessing the flags variable without a lock.

prepare_to_wait does spin_lock/spin_unlock on when adding a task to a wait queue
and (I hope someone corrects me if I'm wrong) spin lock/unlock are guaranteed to
be memory barriers.

> -       input_event(&atkbd->dev, EV_MSC, MSC_RAW, code);
> +       if (atkbd->softraw)
> +               input_event(&atkbd->dev, EV_MSC, MSC_RAW, code);
> 
> ... we definitely want the RAW codes to be sent when we're not in
> softraw mode, because that's when they're passed through keyboard.c to
> the console.
> 
> So the condition needs to be inverted. However, it's not necessary at
> all, since the input layer will not pass the RAW events when the MSC_RAW
> bit is not set.

I see, my bad. I will drop that bit.

Thanks for the comments!

-- 
Dmitry
