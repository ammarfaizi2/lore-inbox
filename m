Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313104AbSC1IvT>; Thu, 28 Mar 2002 03:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313105AbSC1IvJ>; Thu, 28 Mar 2002 03:51:09 -0500
Received: from web10107.mail.yahoo.com ([216.136.130.57]:40964 "HELO
	web10107.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313104AbSC1Iu7>; Thu, 28 Mar 2002 03:50:59 -0500
Message-ID: <20020328085058.77333.qmail@web10107.mail.yahoo.com>
Date: Thu, 28 Mar 2002 00:50:58 -0800 (PST)
From: Ivan Gurdiev <ivangurdiev@yahoo.com>
Subject: Re: Via-Rhine stalls - transmit errors
To: Urban Widmark <urban@teststation.com>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (sysrq to get stacktraces and run through ksymoops,
or kernel debugger or
>  some deadlock detection thing, if no one gives you
more specific
>  directions search for ikd)

I don't have much experience with traces.
I'd rather mess with the mainstream driver
and try to merge code (read on..)

> You need to follow the instructions on those pages,
there are some
> additional header files for backwards compatibility.
I don't know if it
> compiles under 2.4 but I think the idea is that it
should.

I don't need backwards compatibility.
I have kernel 2.4.19-pre3.
And it doesn't compile.

> I believe the "something wicked" is for an
error/uncommon event that isn't
> handled and so the known events are filtered out.

     if (intr_status & (IntrPCIErr | IntrLinkChange |
IntrMIIChange| IntrStatsMax | IntrTxAbort | 
IntrTxUnderrun))
    via_rhine_error(dev, intr_status);

Which ones aren't handled?
The only one I see is PCI Error....

> If you get a IntrTxAbort
> by itself then a message isn't printed, but if you
get a IntrTxAbort and
> IntrTxDone you get some output (000a).

This is actually a great example of the
'redundancies' I was talking about.
You get both Abort and Done...
Abort handler sends command CmdTxDemand.
"Wicked" message handler excludes Abort
but not Done, so it will: (1) print message,
(2) send CmdTxDemand (once again)

>Possibly those flags are never set without also
setting
> another flag, like IntrRxErr,

Why? Each interrupt should have its own bit
in the bitmask.

>the driver doesn't want to do anything
> special on a "IntrRxNoBuf" error anyway. 

IntrRxEarly is not utilised in this driver
IntrRxWakeUp is used to call rx function
IntrRxNoBuf is used to call rx function
IntrTxAborted is used to call tx function
and NOT used to call error function(??)
while it being used inside the error function
for exclusion from "Wicked" messages.

___________
Ok.. on to other major issues:

I tried merging some code from the linuxfet
driver, and I managed to solve the stall problem
and get some interesting speed results.

I know what I did, but I am not certain
exactly how it helps the problems. My lack
of knowledge regarding the operation
of the hardware is beginning to be frustrating.
Perhaps you could help locate the problem...

The summary:
Tx aborted and Tx Underrun
are handled differently in linuxfet.

The kernel driver
simply increases stats for aborts
and ignores underruns in via_rhine_tx,
and later sends CmdDemandTx for aborts,
and increases threshold for Underrun
in via_rhine_error.

The linuxfet driver uses the following
code to handle both aborts and underruns
inside the interrupt handler
(tx sequence...separated as a function
in kernel driver)
/*----------------------------------------------*/
np->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
                   
writel(virt_to_bus(&np->tx_ring[entry]), ioaddr +
TxRingPtr)
;
/* Turn on Tx On*/
writew(CmdTxOn | np->chip_cmd, dev->base_addr +
ChipCmd);   
/* Stats counted in Tx-done handler, just restart Tx.
*/
writew(CmdTxDemand | np->chip_cmd, dev->base_addr +
ChipCmd)
;
/*----------------------------------------------*/
I am particularly curious about the ownership bits
and the TxRingPtr save... no such thing
in kernel via_rhine_tx...I don't think.

Then the linuxfet driver doesn't do 
anything for abort in the error handler
and increases threshold for underrun.
______________________________________
I moved the code above to the kernel driver
and made it handle aborts and underruns
the same way. I disabled the CmdTxDemand
for aborts in the error handler since it's now
done in the tx function.

This way, I fixed stalls on the Desktop.
However, my laptop was still slow and stalling.
(desktop->laptop transmit, laptop initiates.)

I commented the underrun code in via_rhine_tx
and it fixed all stalls, but speed decreased.

I enabled underrun code in via_rhine_tx
and commented underrun code in via_rhine_error-
same results - decreased speed, no stalls.

I wish I could explain all of this,
but I have little knowledge of hardware operation.
Apparently the handling of aborts is the cause
of stalling. Previously I had logged ownership
bits and stalls always occured when
an ownership bit was set to 0, but transmit 
stopped (result of abort, wrong handling?)
The underrun code has effect on speed
and on transmits initiated from my laptop..
but I am too confused to comment about it.
I am sure this is a horribly ignorant question,
but what exactly is an underrun :)

Thank you for all your help.



__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
