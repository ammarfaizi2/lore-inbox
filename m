Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131493AbQLGXkp>; Thu, 7 Dec 2000 18:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbQLGXkg>; Thu, 7 Dec 2000 18:40:36 -0500
Received: from d06lmsgate.uk.ibm.com ([195.212.29.1]:6573 "EHLO
	d06lmsgate.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S130361AbQLGXkT>; Thu, 7 Dec 2000 18:40:19 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Keith Owens <kaos@ocs.com.au>
cc: Andi Kleen <ak@suse.de>, root@chaos.analogic.com,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Message-ID: <802569AE.007F362C.00@d06mta06.portsmouth.uk.ibm.com>
Date: Thu, 7 Dec 2000 23:08:40 +0000
Subject: Re: Why is double_fault serviced by a trap gate?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Yes, indeed this is the point - we should at least be able to report the
problem even if we can't recover - and we should do that in the standard
kernel. It doesn't seem right to convert a bad problem into an unfathomable
disaster, which is what a trap gate for double-fault does. If you're going
to do that then why bother to set up a trap gate, just leave IDT vector 8
as an invalid descriptor. As is stands, the do_double_fault routine is
otiose.


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


Keith Owens <kaos@ocs.com.au> on 07/12/2000 22:47:42

Please respond to Keith Owens <kaos@ocs.com.au>

To:   Richard J Moore/UK/IBM@IBMGB
cc:   Andi Kleen <ak@suse.de>, root@chaos.analogic.com, "Maciej W. Rozycki"
      <macro@ds2.pg.gda.pl>, linux-kernel@vger.kernel.org
Subject:  Re: Why is double_fault serviced by a trap gate?




On Thu, 7 Dec 2000 21:09:47 +0000,
richardj_moore@uk.ibm.com wrote:
>In summary I'd say the lack of a task gate is at the very least an
>oversight, if not a bug.
>
>If no one else wants to do it I'll see if I can code up the task gates for
>the double-fault and NMI.

If you overflow the kernel stack then you have already scribbled on the
process state at the low end of the kernel stack pages.  The process is
definitely not recoverable but you might not even be able to recover
the machine.  Corrupt p_opptr and friends, thread_group or pidhash and
other processes can be affected when they follow the chains.  However
being able to report the error is a good start, even if you cannot
recover.

If you add task gates, assign enough stack space for debuggers.  kdb
does a lot of work when NMI detects a hung cpu and needs stack space to
do that work.  A good option is to dedicate a set of process entries
for per cpu task gates, say processes 2-NR_CPUS+1 are dedicated to task
gates.




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
