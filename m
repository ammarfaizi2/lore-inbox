Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267014AbSKVJAc>; Fri, 22 Nov 2002 04:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267016AbSKVJAc>; Fri, 22 Nov 2002 04:00:32 -0500
Received: from 205-158-62-68.outblaze.com ([205.158.62.68]:33031 "HELO
	spf0.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S267014AbSKVJAc>; Fri, 22 Nov 2002 04:00:32 -0500
Message-ID: <20021122085441.2127.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au, torvalds@transmeta.com, davem@redhat.com
Date: Fri, 22 Nov 2002 03:54:41 -0500
Subject: calling schedule() from interupt context
X-Originating-Ip: 64.175.39.70
X-Originating-Server: ws3-5.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was running a script to find which functions call schedule() and I across something 
strange.  

In drivers/net/tokenring/3c359.c xl_interrupt() calls schedule().
The path from xl_interupt to schedule is:
xl_rx ==> netif_rx ==> 
kfree_skb ==> __kfree_skb ==> 
secpath_put ==> __secpath_destroy ==> 
xfrm_state_put ==> __xfrm_state_destroy ==> xfrm_put_type ==> 
module_put ==> put_cpu ==> preempt_schedule ==> schedule

The problem is that xl_interrupt is the interrupt handler for the 3c359 driver and
I did not think it was legal to call shedule() from interrupt context.

The second thing is that module_put() has a line that looks like it's decrementing
the module reference count (Is it supposed to do that?):
176                  local_dec(&module->ref[cpu].count);

The third thing I was wondering is:  xl_interupt is holding a 
spin_lock(&xl_priv->xl_lock).   I know that you're not supposed to call shedule()
while holding a spin lock, but is it ok to call preempt_schedule()?

thanks,
dan carpenter

-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

One click access to the Top Search Engines
http://www.exactsearchbar.com/mailcom

