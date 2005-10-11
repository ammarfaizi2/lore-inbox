Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVJKSaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVJKSaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 14:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVJKSaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 14:30:20 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:1299 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932261AbVJKSaT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 14:30:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F36B112@mtk-sms-mail01.digi.com>
References: <335DD0B75189FB428E5C32680089FB9F36B112@mtk-sms-mail01.digi.com>
X-OriginalArrivalTime: 11 Oct 2005 18:30:17.0022 (UTC) FILETIME=[D3E09DE0:01C5CE91]
Content-class: urn:content-classes:message
Subject: Re: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to a terminating (PF_EXITING) process.
Date: Tue, 11 Oct 2005 14:30:16 -0400
Message-ID: <Pine.LNX.4.61.0510111424230.10195@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to a terminating (PF_EXITING) process.
Thread-Index: AcXOkdPnYkKrXGNORnaqIldhn07K9w==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: "Linux Kernel Mail List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Oct 2005, Kilau, Scott wrote:

> Hi everyone,
>
> This email will deal with the serial/tty layer of the kernel,
> but I don't think its completely isolated to this layer...
>
> I have found a problem with signals not getting delivered to a
> Process once it enters into the PF_EXITING state.
>
> Probably the best way to show it, is an example with the built-in
> COM port.
>
> 1) Don't have anything connected to COM1.
> 2) stty -ixon -ixoff -ixany crtscts < /dev/ttyS0
> 3) date > /dev/ttyS0
> 4) Press ctrl-c.
>
> The process does get this ctrl-c, and starts closing down.
>
> The serial driver gets its "tty close" for ttyS0, as it should,
> and goes into a "drain" waiting for the data that is pending
> in the UART to be written.
>
> (Which can never be written, because the port is stuck in a
> hardware flow control state)
>
> 5) Press ctrl-c again... And again, and again, and again.  Nothing.
>
> The process is stuck, and a ps -ef shows that it is in a
> zombie state ([date])
>
> Under stock 2.4 kernels, the 2nd and subsequent ctrl-c's would wake
> up the serial driver's "wait" with a signal, which in turn would
> allow the serial driver to bail out of the forever "drain",
> and complete the close.
>
> Now, eventually, the "date" will bail, but only because the serial
> driver has a "timeout" set for the wait in its drain routine.
> It still never receives the 2nd+ ctrl-c's.
>
> Is this change intentional?
> If so, why?
>
> Thanks!
> Scott

Once a process in in the 'Z' state it should not receive any
signals. Its signal handlers are already gone. It's just a
snippit of sys_exit code that remains. If the process truly
is in the 'Z' state, its input/output/error file-descriptors
should have already been closed so the time-out from the
shutdown should have already happened.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.44 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
