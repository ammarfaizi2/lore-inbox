Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTIDCyF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbTIDCxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:53:39 -0400
Received: from smtp03.web.de ([217.72.192.158]:32536 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S264619AbTIDCwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:52:19 -0400
From: "Mehmet Ceyran" <mceyran@web.de>
To: "'Mike Fedyk'" <mfedyk@matchmail.com>
Cc: <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>
Subject: AW: drivers/sound/i810_audio.c bug and patch
Date: Thu, 4 Sep 2003 04:55:06 +0200
Message-ID: <000201c3728f$f55c42e0$0100a8c0@server1>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20030904014327.GK16361@matchmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

>> Well, why not? The loop will only go through it's body 100 times if 
>> the hardware is actually not available or corrupt and even in this 
>> case the whole block won't take much time. It works for me and it 
>> should work for all the other people using this driver too:
> Why busy wait especially when you can sleep 1ms each time and poll
less?

Well, I can tell you why I chose "busy wait" (kind of brainstorming):

- Why did the originator of the driver made the loop with 10 turns,
which is "busy wait" in your definition too?

- Imagine you have workers and you give them a job that's supposed to be
finished in six minutes. But these workers actually need seven minutes,
which you don't know. If that job is urgent, would you rather look if
it's done yet every 60 minutes or every six minutes? In the first case
(that's your model), you would get your positive result in one hour, in
the second case (my model), you'd get it in 12 minutes.

- Seeing the constant of HZ/20 in "schedule_timeout(HZ/20);" gives me
the feeling that this value is taken from some specification. Perhaps
it's from a i810 datasheet (I will look at that later because it's very
late now), but my fix is for SiS 7012 which could have slightly
different characteristics. In this case, by doing my "busy wait", you
don't modify the existing code which will initialize the chip in less
than or equal to 10 turns.

- When the driver is loaded at boot time I think it's the only piece of
code which is running at that moment, I don't think there are any other
threads working during driver init. If it's loaded as a module, the one
who loads it waits for its results anyway. It's almost impossible that
doing this "busy wait" will affect a running system with many
concurrently running processes at a high system load _noticeably_. It
will instead come to a result faster if the hardware is available (see
point 1).

Best Regards,
Mehmet

