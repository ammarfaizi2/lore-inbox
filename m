Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268383AbUIPSN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268383AbUIPSN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268162AbUIPSN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 14:13:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4592 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S268506AbUIPSMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 14:12:39 -0400
Message-ID: <4149D78C.1060906@mvista.com>
Date: Thu, 16 Sep 2004 11:12:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
CC: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: review MPSC driver
References: <20040915150247.37706f7c.rddunlap@osdl.org> <20040915214301.53a68379.randy.dunlap@verizon.net>
In-Reply-To: <20040915214301.53a68379.randy.dunlap@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>| http://www.uwsg.iu.edu/hypermail/linux/kernel/0408.3/1549.html
>
>Hi Mark,
>

Hi Randy.  Thanks for putting time into reviewing and commenting on this.

>1.  Do you realize that a version of the driver is already in the -mm
>patchset?
>

Ahh, no...  Hmm, I guess someone did notice the patch I sent after all.  :)

>2.  + depends on PPC32 && MV64X60
>
>Where is MV64X60 defined?
>

There is a separate patch that provides "core" support for the 
gt/mv64x60 host bridges (which the MPSC is on).  I haven't provided the 
patch yet b/c I keep finding little bugs in it.  For modularity and to 
keep patch sizes smaller, I'm submitting separate patches for the core 
and for the mpsc driver.  I had to draw the line somewhere between the 
driver and the core.  It so happened that this file fell on the other 
side of that line.  So, no, it won't compile until the core patch is 
submitted and accepted.  However, if no one selects that driver--which 
they probably won't since the core support isn't there anyway--no harm 
done.  I sent the mpsc driver patch before the core patch because it was 
more-or-less ready and so I could get the ball rolling WRT getting it 
accepted.

>
>3.  + select SERIAL_CORE
>    + select SERIAL_CORE_CONSOLE
>
>Please don't use "select".  Use "depends on" instead.
>

Already discussed.

>4.  + * Author: Mark A. Greer <mgreer@xxxxxxxxxx>
>
>Put a real email address or remove it.
>

Odd...  It looks like the archive tried to do me a favor and "x-out" my 
domain so I don't get spam (I guess).  The original patch has 
<mgreer@mvista.com>, and that's reflected in the -mm patch and in other 
archives (e.g., http://lkml.org/lkml/2004/8/27/305).  I should have 
pointed you to the lkml.org link instead.

>5.  +#include <asm/mv64x60.h>
>
>Where is this file?  Does this driver build?
>

See comments on 2.

>6.  style:
>+	if (pi->brg_can_tune) {
>+		MPSC_MOD_FIELD_M(pi, brg, BRG_BCR, 1, 25, 0);
>+	}
>Has unneeded braces (in several places).
>

I will fix.

>7.  style:
>+	return;
>+}
>Lots of void functions with "return" that is not needed.
>

Well, I didn't notice anything in Documentation/CodingStyle on this so I 
assumed it was up to me.  If there is a policy on this, I'll remove 
them.  If its up to me, I'd prefer that they be left in--redundant, yes, 
but somehow I like the clarity.

>8.  Why use 'volatile' here?  Have you read the Linus volatile rant?
>
>+static inline void
>+mpsc_sdma_set_tx_ring(struct mpsc_port_info *pi,
>+		      volatile struct mpsc_tx_desc *txre_p)
>+{
>

I have heard about it but I've not actually read it.  I will read it and 
change whatever needs to be.

>
>9.  put in mpsc.h:
>+	static void mpsc_free_ring_mem(struct mpsc_port_info *pi);
>+	static void mpsc_start_rx(struct mpsc_port_info *pi);
>

I didn't put them in mpsc.h because they're never referenced outside of 
mpsc.c.  I will move them unless someone else objects.

>
>10. in the interrupt handler, if rx happened, tx intr not checked.
>Is that intentional?
>
>+	if (mpsc_rx_intr(pi, regs) || mpsc_tx_intr(pi))
>+		rc = IRQ_HANDLED;
>

Good point.  I should have caught that one.

>11. In mpsc_verify_port(), if -EINVAL is ever set, the others
>are wasted checks.
>

Another good point.

>
>12. What's the rationale for having both mpsc_console_init() and
>mpsc_late_console_init() ?
>

I modeled that after the 8250 driver.  I am not intimately familiar with 
all of the char/tty/serial infrastructure so I erred on the safe side 
and did what was done in the 8250 driver.  I will look deeper to see if 
I can find a reason.

>13. register_serial() and unregister_serial():  names are a bit too
>generic -- they sound like serial subsystem functions.
>and why are they exported?  what else uses them?
>

AFAICT, they are standard interfaces for "add-on" files to call into 
"core" files like 8250_pci.c calls 8250.c's register_serial().  Since 
the mpsc doesn't really have any add-on files, I believe that I can get 
rid of them.

>14. mpsc.h:  don't define MIN(), #include <linux/kernel.h> and use
>its min() macro.
>

Yep, already pointed out to me by Russell.  Will be fixed.

>15. Run it thru sparse for warnings.
>  
>

Will do.

BTW, I'm waiting on a minor number (for major 204) from lanana so I 
won't post a new patch until I get that (or I get no response in which 
case, I guess I'm forced to pick one).

Thanks again,

Mark

