Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265148AbRGJJs7>; Tue, 10 Jul 2001 05:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbRGJJsv>; Tue, 10 Jul 2001 05:48:51 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:63756 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S265148AbRGJJsb>; Tue, 10 Jul 2001 05:48:31 -0400
Message-ID: <3B4ACF6B.5F194E54@stud.uni-saarland.de>
Date: Tue, 10 Jul 2001 09:48:27 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>, linux-kernel@vger.kernel.org,
        manfred@colorfullife.com, manfred@colorfullife.com
Subject: Re: [PATCH]  sym53c8xx timer rework
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  /*
> -**     Stop the ncr_timeout process
> -**     Set release_stage to 1 and wait that ncr_timeout() set it to 2.
> +**     Stop the ncr_timeout process - lock it to ensure no timer is running
> +**     on a different CPU, or anything
>  */
> -       np->release_stage = 1;
> -       for (i = 50 ; i && np->release_stage != 2 ; i--) MDELAY (100);
> -       if (np->release_stage != 2)
> -               printk("%s: the timer seems to be already stopped\n",
> -                       ncr_name(np));
> -       else np->release_stage = 2;
> +       NCR_LOCK_NCB(np, flags);
> +       del_timer(&np->timer);
> +       NCR_UNLOCK_NCB(np, flags);

I'm only reading the diff, but this change looks wrong.
The simplest solution is del_timer_sync() instead of
LOCK;del_timer;UNLOCK.

Why do you acqurie the NCB spinlock? the _timeout function runs without
it.

--	
	Manfred
