Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132416AbRDUBcI>; Fri, 20 Apr 2001 21:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132421AbRDUBb7>; Fri, 20 Apr 2001 21:31:59 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:44540 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132416AbRDUBbl>; Fri, 20 Apr 2001 21:31:41 -0400
Message-ID: <3AE0E1B5.2C8318A7@uow.edu.au>
Date: Fri, 20 Apr 2001 18:26:13 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Cami <francois.cami@supelec.fr>
CC: Vibol Hou <vhou@khmer.cc>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 
In-Reply-To: <NDBBKKONDOBLNCIOPCGHIEHBGDAA.vhou@khmer.cc> <3ADFA34D.80D8BEE9@supelec.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Cami wrote:
> 
> Vibol Hou wrote:
> ...
>
> > Apr 17 16:10:12 omega kernel: eth0: Too much work in interrupt, status e401.
> 
> I got that one too, PC is ASUS P2B-DS with two PII-350, 384MB RAM,
> 3C905B.

If you were getting this message occasionally, and if increasing the
max_interrupt_work module parm makes it stop, and everything
is always working fine, then it's an OK thing to do.

Question is: why is it happening?  We're failing to get out
of the interrupt loop after 32 loops.  Each loop can reap
up to 16 transmitted packets and 32 received packets.
That's a lot.

My suspicion is that something else in the system is
causing the NIC interrupt routine to get held up for long
periods of time.  It has to be another interrupt.

All reporters of this problem (ie: both of them) were using
aic7xx SCSI.  I wonder if that driver can sometimes spend a
long time in its interrupt routine.  Many times.  Rapidly.

Very odd.

Ah.  SMP.  Perhaps the other CPU is generating the transmit
load, some other interrupt source is slowing down *this*
CPU.

Could you test something for me?  Try *decreasing* the
value of max_interrupt_work.  See if that increases
the frequency of the message.  Then, it if does, try to
correlate the occurence of the message with some other
form of system activity (especially disk I/O).

Thanks.


-
