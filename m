Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311403AbSCMWTu>; Wed, 13 Mar 2002 17:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311404AbSCMWTh>; Wed, 13 Mar 2002 17:19:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5384 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311403AbSCMWTX>; Wed, 13 Mar 2002 17:19:23 -0500
Subject: Re: your mail
To: rlievin@free.fr (=?ISO-8859-1?Q?Romain_Li=E9vin?=)
Date: Wed, 13 Mar 2002 22:35:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Kernel List)
In-Reply-To: <1016051318.3c8fb67699ae8@imp.free.fr> from "=?ISO-8859-1?Q?Romain_Li=E9vin?=" at Mar 13, 2002 09:28:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lHKt-0007dn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Deal with CONFIG_MODVERSIONS
> + */
> +#if 0 /* Pb with MODVERSIONS */
> +#if CONFIG_MODVERSIONS==1
> +#define MODVERSIONS
> +#include <linux/modversions.h>
> +#endif
> +#endif

[modversions.h is magically included by the kernel for you when its in 
 kernel if you haven't worked that one out yet]

> +#define PP_NO 3
> +struct tipar_struct  table[PP_NO];
static ?

> +               for(i=0; i < delay; i++) {
> +                       inbyte(minor);
> +               }
> +               schedule();

Oh random tip

		  if(current->need_resched)
			schedule();

will just give up the CPU when you are out of time

> +       if(table[minor].opened)
> +               return -EBUSY;
> +       table[minor].opened++;

Think about open/close at the same moment or SMP - the watchdog drivers all
had this problem and now do

	unsigned long opened = 0;

	if(test_and_set_bit(0, &opened))
		return -EBUSY;

	clear_bit(0, &opened)

[this generates atomic operations so is always safe]

> +       if(!table[minor].opened)
> +               return -EFAULT;

	BUG() may be better - it can't happen so BUG() will get a backtrace
and actually get it reported 8)

> +static long long tipar_lseek(struct file * file, long long offset, int origin)
> +{
> +       return -ESPIPE;
> +}

Can go (you now use no_llseek)


Basically except for the open/close one I'm now just picking holes. 
For the device major/minors see http://www.lanana.org.



