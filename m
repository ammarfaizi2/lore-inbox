Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310176AbSCETk1>; Tue, 5 Mar 2002 14:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310174AbSCETkU>; Tue, 5 Mar 2002 14:40:20 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:29663 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S310172AbSCETkJ>; Tue, 5 Mar 2002 14:40:09 -0500
Message-Id: <5.1.0.14.2.20020305112314.01c3cea8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 05 Mar 2002 11:39:59 -0800
To: jt@hpl.hp.com
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: PPP feature request (Tx queue len + close)
Cc: Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020305102835.B847@bougret.hpl.hp.com>
In-Reply-To: <5.1.0.14.2.20020305095825.01b61fd8@mail1.qualcomm.com>
 <15492.21937.402798.688693@argo.ozlabs.ibm.com>
 <20020304144200.A32397@bougret.hpl.hp.com>
 <15492.13788.572953.6546@argo.ozlabs.ibm.com>
 <20020304191947.A32730@bougret.hpl.hp.com>
 <15492.21937.402798.688693@argo.ozlabs.ibm.com>
 <20020305094535.A792@bougret.hpl.hp.com>
 <5.1.0.14.2.20020305095825.01b61fd8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > You _will_ drop it, if txqueue is full. TCP will back off and re-transmit
> > but this will not allow TCP window to grow and you TCP performance will
> > be pretty bad.
>
>         Ok, I didn't look at the network code, so I have to take your
>word for it. I would have assumed that the logical thing would be to
>flow control within the network stack (like it's done in IrDA), but it
>seem that I was wrong.
I looked at the code again and tried to trace TCP xmit path. Seems like it 
should not
back off because it does check return status of the dev_queue_xmit (send 
packet to the driver).
But it does not seem to retry either. Looks like it's just waits for an ack 
from the other side which
effectively makes your window equal to 1 segment. In any case small PPP 
queue won't make any
good for you.

> > I totally agree with Paul. Just decrease buffering below PPP.
>
>         If what you say is true, I should *increase* the buffering
>below PPP to make sure that packet don't get dropped above PPP.
I was under assumption that you know for sure that buffering is bad for you :)

>         Think about it : for TCP, it doesn't matter if buffers are
>above or below PPP, what matter is only how many there are. TCP can't
>make the difference between buffers at the PPP and at IrDA level.
>         Actually, it's probably better to keep the buffers as low as
>possible in the stack, because less processing remain to be done on
>them before beeing transmitted.
All this depends on what you want to achieve. If you're looking for max TCP
performance. I'd recommend to use tcptrace and see what actually is going on.
May be your RTT is to high and you need bigger windows or may be there is
something else.

Max

