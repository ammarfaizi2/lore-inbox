Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbVAFGoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVAFGoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 01:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbVAFGnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 01:43:50 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:40346 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262751AbVAFGnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 01:43:15 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9+ keyboard LED problem
Date: Thu, 6 Jan 2005 01:43:13 -0500
User-Agent: KMail/1.6.2
Cc: "Ville Hallik" <ville@linux.ee>, Meelis Roos <mroos@linux.ee>
References: <20050106001203.DAD7E14C47@ondatra.tartu-labor>
In-Reply-To: <20050106001203.DAD7E14C47@ondatra.tartu-labor>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501060143.13428.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 January 2005 07:12 pm, Ville Hallik wrote:
> In article <d120d50005010510543532e0bf@mail.gmail.com> you wrote:
> > On Wed, 5 Jan 2005 20:38:34 +0200 (EET), Meelis Roos <mroos@linux.ee> wrote:
> >> > Seems to work fine here. The led is blinking rapidly but I can type just
> >> > fine and touchpad works as well.
> >> >
> >> > What kind of box do you have? UP/SMP, Preempt?
> >> 
> >> UP, Celeron 900 on i815. Happens on 2 identical computers, one preempt,
> >> one not preempt. PS/2 keyboard and mouse on one, only PS/2 keyboard on
> >> the other (and USB mouse that is probably unimportant).
> >>
> 
> > The big input update went in with 2.6.9-rc2-bk4.Could you try booting
> > -bk3 and -bk4 to verify that those changes are to blame?
> 
> No, this bug appears with 2.6.9-rc2-bk3. I'm afraid that introduction of
> atkbd_schedule_command() & related stuff into atkbd.c is to blame.
> 

Actually it is ACK processing hardening that is very useful at setup stage
but is getting in our way once keyboard is initialized and commands are
intermixed with good data.

Could you please try the patch below? It is just a quick hack, just to prove
the idea. If it works for you I will prepare the proper fix later.

-- 
Dmitry

===== drivers/input/serio/libps2.c 1.2 vs edited =====
--- 1.2/drivers/input/serio/libps2.c	2004-10-20 03:13:08 -05:00
+++ edited/drivers/input/serio/libps2.c	2005-01-06 01:20:11 -05:00
@@ -250,7 +250,7 @@
 			}
 			/* Fall through */
 		default:
-			return 1;
+			return 0;
 	}
 
 	if (!ps2dev->nak && ps2dev->cmdcnt)
