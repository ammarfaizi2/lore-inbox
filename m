Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbTCEO6d>; Wed, 5 Mar 2003 09:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbTCEO6d>; Wed, 5 Mar 2003 09:58:33 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:14997 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S266868AbTCEO6c>; Wed, 5 Mar 2003 09:58:32 -0500
Message-Id: <200303051508.h25F8gGi006299@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: wa@almesberger.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-reply-to: Your message of "Wed, 05 Mar 2003 06:31:58 PST."
             <20030305.063158.53514369.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 05 Mar 2003 10:08:42 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030305.063158.53514369.davem@redhat.com>,"David S. Miller" writes
:
>If you own both objects, why lock anything?

i believe the original intent was to prevent anyone else from 
appending to either of the lists while the lists are being joined.
while it would be slightly less efficient, should it use the
skb primitives?  this is quite a bit easier to read:

void skb_migrate(struct sk_buff_head *from,struct sk_buff_head *to)
{
	struct sk_buff *skb;
	unsigned long flags;

	local_irq_save(flags);
	spin_lock(&to->lock);
	spin_lock(&from->lock);

	while(skb = __skb_dequeue(from))
		__skb_queue_tail(to, skb);

	spin_unlock(&to->lock);
	spin_unlock(&from->lock);
	local_irq_restore(flags);
}
