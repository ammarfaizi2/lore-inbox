Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278709AbRKALfK>; Thu, 1 Nov 2001 06:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278713AbRKALfB>; Thu, 1 Nov 2001 06:35:01 -0500
Received: from toad.com ([140.174.2.1]:32260 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S278709AbRKALeq>;
	Thu, 1 Nov 2001 06:34:46 -0500
Message-ID: <3BE13327.C9150EBF@mandrakesoft.com>
Date: Thu, 01 Nov 2001 06:33:59 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrey Savochkin <saw@saw.sw.com.sg>
CC: Johan <jo_ni@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: Still having problems with eepro100
In-Reply-To: <20011030123927.74e26501.jo_ni@telia.com> <20011101141506.B27180@castle.nmd.msu.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin wrote:
> 
> On Tue, Oct 30, 2001 at 12:39:27PM +0100, Johan wrote:
> >
> > Hello,
> > Does anyone except me still having problems with the eepro100 drivers ?
> >
> > The network connection stalls and I'll get this message:
> >
> > eepro100: wait_for_cmd_done timeout!
> 
> Try to add `udelay(1);' inside the loop in wait_for_cmd_done().
> It helped to some people with same problems.

In 2.4 that's already there:

> static inline void wait_for_cmd_done(long cmd_ioaddr)
> {
>         int wait = 1000;
>         do  udelay(1) ;
>         while(inb(cmd_ioaddr) && --wait >= 0);
> #ifndef final_version
>         if (wait < 0)
>                 printk(KERN_ALERT "eepro100: wait_for_cmd_done timeout!\n");
> #endif
> }

In contrast, here is what Becker's current version looks like.  It looks
like Becker just added a hack to continue waiting.

Things to try:
(a) add a rmb() after the udelay
(b) the Becker version


> /* How to wait for the command unit to accept a command.
>    Typically this takes 0 ticks. */
> 
> static inline void wait_for_cmd_done(long cmd_ioaddr)
> {
>         int wait = 0;
>         do
>                 if (inb(cmd_ioaddr) == 0) return;
>         while(++wait <= 100);
>         do
>                 if (inb(cmd_ioaddr) == 0) break;
>         while(++wait <= 10000);
>         printk(KERN_ERR "Command %4.4x was not immediately accepted, %d ticks!\n
> ",
>                    inb(cmd_ioaddr), wait);
> }


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
