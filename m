Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264381AbUD2Mke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264381AbUD2Mke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbUD2Mke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:40:34 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:438 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264367AbUD2MkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:40:25 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: locking in psmouse
Date: Thu, 29 Apr 2004 07:40:17 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
References: <20040428213040.GA954@elf.ucw.cz> <200404282347.47411.dtor_core@ameritech.net> <20040429095830.GD390@elf.ucw.cz>
In-Reply-To: <20040429095830.GD390@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404290740.18182.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Thursday 29 April 2004 04:58 am, Pavel Machek wrote:
> Hi!
> 
> > > psmouse-base.c does not have any locking. For example psmouse_command
> > > could race with data coming from the mouse, resulting in problem. This
> > > should fix it.
> > 
> > Although I am not arguing that locking might be needed in psmouse module I
> > am somewhat confused how it will help in case of data stream coming from the
> > mouse... If mouse sent a byte before the kernel issue a command then it will
> > be delivered by KBC controller and will be processed by the interrupt handler,
> > probably messing up detection process. That's why as soon as we decide that
> > the device behind PS/2 port is some kind of mouse we disable the stream mode.
> 
> Does that mean that mouse can not talk while we are sending commands
> to it? That would help a bit.
> 

Yes, check psmouse_probe. As soon as PSMOUSE_CMD_RESET_DIS acknowledged mouse
should cease sending motion data. That still leaves possibility of screwing up
detection if you are moving mouse while psmouse doing PSMOUSE_CMD_GETID.
But I don't think we can do much about it as we'd like to know that the device
is some kind of a mouse before we start messing with it.

> Anyway, locking still seems to be needed: 
> 
>         while (psmouse->cmdcnt && timeout--) {
> 
>                 if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_RESET_BAT &&
>                                 timeout > 100000) /* do not run in a endless loop */
>                         timeout = 100000; /* 1 sec */
> 
>                 if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_GETID &&
>                     psmouse->cmdbuf[1] != 0xab && psmouse->cmdbuf[1] != 0xac) {
>                         psmouse->cmdcnt = 0;
>                         break;
>                 }
> 
>                 spin_unlock_irq(&psmouse_lock);
>                 udelay(1);
>                 spin_lock_irq(&psmouse_lock);
>         }
> 
> racing with
> 
>         if (psmouse->cmdcnt) {
>                 psmouse->cmdbuf[--psmouse->cmdcnt] = data;
>                 goto out;
>         }
> 
> now... if each runs on different CPU, it can be possible that
> psmouse->cmdcnt is seen as 1 but data are not yet in
> psmouse->cmdbuf... Locking seems neccessary here.

I see.. but this particular case can be resolved but rearranging the code to
write command response first and then decrementing the counter... and putting
a barrier? Or just make cmdcnt atomic... spin_lock_irq feels heavier than
absolutely necessary.

-- 
Dmitry
