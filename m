Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262213AbREZAUD>; Fri, 25 May 2001 20:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262194AbREZATx>; Fri, 25 May 2001 20:19:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37380 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262116AbREZATg>; Fri, 25 May 2001 20:19:36 -0400
Subject: Re: [PATCH] spin[un]locks revision on new cmpci driver (5.64)
To: carlos@techlinux.com.br (Carlos E Gorges)
Date: Sat, 26 May 2001 01:16:29 +0100 (BST)
Cc: cltien@cmedia.com.tw (ChenLi Tien), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-smp@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <01052520370200.01716@shark.techlinux> from "Carlos E Gorges" at May 25, 2001 09:02:06 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153Rkr-0007I4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following patch fixes SMP hangs w/ cmpci v5.64 ( k244-ac17 ).

Let me suggest a different approach

> - -	spin_lock_irqsave(&s->lock, flags);
>  	set_spdifout(s, rate);
> +	spin_lock_irqsave(&s->lock, flags);

Split the various locked versions stuff stuff like set_adc_rate out as
__set_adc_rate which doesnt take the lock, and set_adc_rate which takes the
lock and calls the other one.

That is how several other drivers were done and avoids messy lock/unlocks
some of which in your changes I think introduce races

Ditto for enable_dac as the old code and a newer __enable_dac, as well
I suspect as __set_spdifout (although is that ever called by anyone not
holding the lock ???)

>  		init_timer(&s->midi.timer);
>  		s->midi.timer.expires =3D jiffies+1;
>  		s->midi.timer.data =3D (unsigned long)s;
> +
> +		spin_unlock_irqrestore(&s->lock, flags);
>  		s->midi.timer.function =3D cm_midi_timer;
> +		spin_lock_irqsave(&s->lock, flags);
> +

That one doesnt seem to be needed


