Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUENF4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUENF4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 01:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbUENF4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 01:56:44 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:357 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264297AbUENF4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 01:56:41 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2 : Hitting Num Lock kills keyboard
Date: Fri, 14 May 2004 00:32:52 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, eric.valette@free.fr,
       Vojtech Pavlik <vojtech@suse.cz>
References: <40A3C951.9000501@free.fr> <40A3EB84.8020405@free.fr> <200405131745.08973.dtor_core@ameritech.net>
In-Reply-To: <200405131745.08973.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405140032.52636.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 May 2004 05:45 pm, Dmitry Torokhov wrote:
> On Thursday 13 May 2004 04:41 pm, Eric Valette wrote:
> > Andrew Morton wrote:
> > > Eric Valette <eric.valette@free.fr> wrote:
> > > 
> > >>Eric Valette wrote:
> > >>
> > >>>Andrew,
> > >>>
> > >>>I tested 2.6.6-mm2 this afternoon and twice I totally lost my keyboard. 
> > >>
> > >>Well, I can reproduce it at will : I just need to hit the numlock key 
> > >>and keyboard is frozen.
> > > 
> > > 
> > > Could you please do
> > > 
> > > 	patch -p1 -R -i bk-input.patch
> > 
> > Yes it fixes it. Thanks for the quick answer and sorry for the delay...
> > 
> > In the thread, other have reported the same problem with the Caps Lock 
> > key. Both keys have at least three things in common :
> > 	1) They do no echo any character,
> > 	2) They modify the interpretation of the next key pressed (change a 
> > keyboard status),
> > 	3) They light up a led on the keyboard,
> 	^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> atkbd tries to switch leds but one tasklet can not interrupt another so
> it deadlocks...
> 
> You need to revert just the patch below, not entire bk-input
> 

Guys,

I need some guidance. The issue can be resolved in several ways but I am not
sure which one is better:

- just revert the patch and continue doing everything in IRQ context;
- move IRQ/tasklet split higher, into atkbd and psmouse-base respectively.
  Every device would have it's own ring buffer, tasklet will be fired off
  for incoming data only (i.e. ACKs and command response will be processed
  right there in IRQ context);
- move drivers/char/keyboard.c from tasklet to schedule_work. Need also
  take care of others who are using keyboard_tasklet (qtronix, scan_keyb,
  ec3104_keyb);
- have atkbd use schedule_work to do LED and repeat rate setting.

What would you suggest?

-- 
Dmitry
