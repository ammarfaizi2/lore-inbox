Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278149AbRJWSCZ>; Tue, 23 Oct 2001 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278151AbRJWSCP>; Tue, 23 Oct 2001 14:02:15 -0400
Received: from colorfullife.com ([216.156.138.34]:14091 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S278149AbRJWSCF>;
	Tue, 23 Oct 2001 14:02:05 -0400
Message-ID: <002601c15bec$ea4ed950$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1011023124944.14694A-100000@chaos.analogic.com>
Subject: Re: Behavior of poll() within a module
Date: Tue, 23 Oct 2001 20:02:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Richard B. Johnson" <root@chaos.analogic.com>
> 
> In this module, there isn't any read() or write() event that can
> clear the poll mask. Instead, the sole purpose of poll is to tell
> the user-mode caller that there is new status available as a result
> of an interrupt. This is a module that controls a motor. It runs
> <forever> on its own. It gets new parameters via an ioctl(). It
> reports exceptions (like overload conditions) using the poll
> mechanism.
> 
> The caller reads the cached status via an ioctl(). Any caller sleeping
> in poll must be awakened as a result of the interrupt event. Any caller
> can read the cached status at any time. If this was allowed to
> clear the poll mask, only one caller would be awakened. 
>
Ugh.
->poll must never change any state. The kernel is free to call poll
multiple times (common are once, twice and three times).

Can you use a per-filp pollmask?
* remove poll_active
* remove poll_mask
* add event counters for every possible event.
    poll_count_POLLIN, poll_count_POLLOUT, etc.
* interrupt handler increases the counter.
* ioctl() copies the value of the counters into
    filp->private_data->event_handled_POLL{IN,OUT}
* poll sets the pollmask if
    filp->private_data->event_seen != info->poll_count

If filps (file descriptors) are shared between apps, then I have no
idea how to fix your design.

--
    Manfred

