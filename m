Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264048AbUD2J6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbUD2J6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 05:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUD2J6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 05:58:43 -0400
Received: from gprs214-162.eurotel.cz ([160.218.214.162]:15232 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264048AbUD2J6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 05:58:41 -0400
Date: Thu, 29 Apr 2004 11:58:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: locking in psmouse
Message-ID: <20040429095830.GD390@elf.ucw.cz>
References: <20040428213040.GA954@elf.ucw.cz> <200404282347.47411.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404282347.47411.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > psmouse-base.c does not have any locking. For example psmouse_command
> > could race with data coming from the mouse, resulting in problem. This
> > should fix it.
> 
> Although I am not arguing that locking might be needed in psmouse module I
> am somewhat confused how it will help in case of data stream coming from the
> mouse... If mouse sent a byte before the kernel issue a command then it will
> be delivered by KBC controller and will be processed by the interrupt handler,
> probably messing up detection process. That's why as soon as we decide that
> the device behind PS/2 port is some kind of mouse we disable the stream mode.

Does that mean that mouse can not talk while we are sending commands
to it? That would help a bit.

Anyway, locking still seems to be needed: 

        while (psmouse->cmdcnt && timeout--) {

                if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_RESET_BAT &&
                                timeout > 100000) /* do not run in a endless loop */
                        timeout = 100000; /* 1 sec */

                if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_GETID &&
                    psmouse->cmdbuf[1] != 0xab && psmouse->cmdbuf[1] != 0xac) {
                        psmouse->cmdcnt = 0;
                        break;
                }

                spin_unlock_irq(&psmouse_lock);
                udelay(1);
                spin_lock_irq(&psmouse_lock);
        }

racing with

        if (psmouse->cmdcnt) {
                psmouse->cmdbuf[--psmouse->cmdcnt] = data;
                goto out;
        }

now... if each runs on different CPU, it can be possible that
psmouse->cmdcnt is seen as 1 but data are not yet in
psmouse->cmdbuf... Locking seems neccessary here.
							Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
