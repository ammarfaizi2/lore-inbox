Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285666AbRLGXdr>; Fri, 7 Dec 2001 18:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285659AbRLGXd2>; Fri, 7 Dec 2001 18:33:28 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:61965 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285661AbRLGXdH>; Fri, 7 Dec 2001 18:33:07 -0500
Message-ID: <3C115196.1D5D87A5@zip.com.au>
Date: Fri, 07 Dec 2001 15:32:38 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Udo A. Steinberg" <reality@delusion.de>
CC: "David C. Hansen" <haveblue@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: release() locking
In-Reply-To: <3C10D83E.81261D74@delusion.de> <3C10FDCF.D8E473A0@zip.com.au> <3C11394D.90101@us.ibm.com> <3C113D78.F324F1B9@delusion.de> <3C113FB1.2000AFF1@zip.com.au> <3C1147F2.4070103@us.ibm.com> <3C114E14.F6DC7937@delusion.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> "David C. Hansen" wrote:
> >
> > Andrew Morton wrote:
> 
> > >Maybe so.  Can you identify the exact kernel version at which
> > >the problem started?
> 
> Yes. I tried the entire 2.5.1-pre series:
> 
> -pre1 and -pre2 are fine.
> -pre3 doesn't compile out of the box and with 3 trivial compile fixes to
>       pc_keyb.c shows the problem.
> 

Hum.  send_data() requires that local interrupts be enabled.

Does this fix it?

--- linux-2.5.1-pre6/drivers/char/pc_keyb.c	Thu Dec  6 20:44:21 2001
+++ 25/drivers/char/pc_keyb.c	Fri Dec  7 15:31:34 2001
@@ -1090,6 +1090,7 @@ static int open_aux(struct inode * inode
 		spin_unlock_irqrestore(&aux_count_lock, flags);
 		return -EBUSY;
 	}
+	spin_unlock_irqrestore(&aux_count_lock, flags);
 	kbd_write_command_w(KBD_CCMD_MOUSE_ENABLE);	/* Enable the
 							   auxiliary port on
 							   controller. */
@@ -1099,7 +1100,6 @@ static int open_aux(struct inode * inode
 	mdelay(2);			/* Ensure we follow the kbc access delay rules.. */
 
 	send_data(KBD_CMD_ENABLE);	/* try to workaround toshiba4030cdt problem */
-	spin_unlock_irqrestore(&aux_count_lock, flags);
 	return 0;
 }
