Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135750AbREBSxt>; Wed, 2 May 2001 14:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135725AbREBSxk>; Wed, 2 May 2001 14:53:40 -0400
Received: from enst.enst.fr ([137.194.2.16]:52406 "HELO enst.enst.fr")
	by vger.kernel.org with SMTP id <S135760AbREBSx0>;
	Wed, 2 May 2001 14:53:26 -0400
Date: Wed, 02 May 2001 20:52:36 +0200
From: Fabrice Gautier <gautier@email.enst.fr>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: serial console problems with 2.4.4
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <m1elu7pv0e.fsf@frodo.biederman.org>
In-Reply-To: <20010502130958.38BB.GAUTIER@email.enst.fr> <m1elu7pv0e.fsf@frodo.biederman.org>
Message-Id: <20010502201026.CB69.GAUTIER@email.enst.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02 May 2001 10:37:21 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Fabrice Gautier <gautier@email.enst.fr> writes:
> > So this this probably a sulogin/mingetty problem. They should set the
> > CREAD flag in your tty c_cflag.
> > 
> > the patch for busybox repalced the line
> > 	tty.c_cflag |= HUPCL|CLOCAL
> > by
> > 	tty.c_cflag |= CREAD|HUPCL|CLOCAL
> > 	
> > Hope this help.
> 
> This part is correct.  
> 
> However the kernel sets CREAD by default.  

Are your sure? Wasn't this the behaviour for 2.4.2  but changed in 2.4.3

> sysvinit (and possibly other inits) clears CREAD.

In my case I was using busybox as init. So there is no sysinit or any other
init called before this line.


> I wish I knew where the breakage actually occured.

Just look at this diff on serial.c between 2.4.2 and 2.4.3:

--- serial.c	Sat Apr 21 17:22:53 2001
+++ ../../../linux-2.4.2/drivers/char/serial.c	Sat Feb 17 01:02:36 2001
@@ -1764,8 +1765,8 @@
 	/*
 	 * !!! ignore all characters if CREAD is not set
 	 */
-//	if ((cflag & CREAD) == 0)
-//		info->ignore_status_mask |= UART_LSR_DR;
+	if ((cflag & CREAD) == 0)
+		info->ignore_status_mask |= UART_LSR_DR;
 	save_flags(flags); cli();
 	if (uart_config[info->state->type].flags & UART_STARTECH) {
 		serial_outp(info, UART_LCR, 0xBF);


-- 
Fabrice Gautier <gautier@email.enstfr>

