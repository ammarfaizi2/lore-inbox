Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280634AbRKJNiJ>; Sat, 10 Nov 2001 08:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280653AbRKJNiA>; Sat, 10 Nov 2001 08:38:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10880 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280634AbRKJNhr>;
	Sat, 10 Nov 2001 08:37:47 -0500
Date: Sat, 10 Nov 2001 05:37:20 -0800 (PST)
Message-Id: <20011110.053720.55510115.davem@redhat.com>
To: mathijs@knoware.nl
Cc: andrea@suse.de, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] fix loop with disabled tasklets
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011110122141.B2C68231A4@brand.mmohlmann.demon.nl>
In-Reply-To: <20011110122141.B2C68231A4@brand.mmohlmann.demon.nl>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mathijs Mohlmann <mathijs@knoware.nl>
   Date: Sat, 10 Nov 2001 13:21:56 +0100
   
   	i'm not sure about the enable_tasklet bit. I think it will prevent
   people from calling tasklet_enable from within an interrupt handler. But then
   again, why do you want to do that? Thanx, velco and
   	
   	Any comments?

I've been looking at this and I sent Andrea+Linus private mail on this
to try and work out a fix.

You can't simply stop enabling the softirq when you hit the "locked
tasklet" condition.  That could deadlock the tasklet.

What really needs to happen is:

1) If tasklet is scheduled, but disabled, simply ignore it
   during tasklet processing.  Do not resignal softirq.
   But do leave it on the pending lists.

2) When tasklet enable brings t->count back to zero and
   tasklet is found to be scheduled, signal a local softirq.

To me, that would be the proper fix.  But I still haven't heard back
from Andrea or Linus yet :-)

Franks a lot,
David S. Miller
davem@redhat.com
