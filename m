Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVJKUa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVJKUa4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVJKUa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:30:56 -0400
Received: from mail29.messagelabs.com ([140.174.2.227]:47829 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S1751255AbVJKUaz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:30:55 -0400
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-25.tower-29.messagelabs.com!1129062650!23497655!9
X-StarScan-Version: 5.4.15; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to a terminating (PF_EXITING) process.
Date: Tue, 11 Oct 2005 15:33:47 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F36B116@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to a terminating (PF_EXITING) process.
Thread-Index: AcXOnNn+xkqoU4tXQu+01yV8qFSJ+gABGhBA
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Linux Kernel Mail List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Oct 2005 20:33:49.0095 (UTC) FILETIME=[15D13370:01C5CEA3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Okay. I have to take a "work break", but you can check the
> driver and see if the code is interruptible (it must be)
> and if there is something like if(signal_pending(current))
> get_to_hell_out_of_this_loop.... in the time-out loop.

Hi Dick,
I don't believe this is a serial driver problem.

In /usr/src/linux-2.6.13/drivers/serial/serial_core.c ->
uart_wait_until_sent()

You can see that it does this:

while (!port->ops->tx_empty(port)) {
	msleep_interruptible(jiffies_to_msecs(char_time));
	if (signal_pending(current))
		break;
	if (time_after(jiffies, expire))
		break;
	}

Since we know that tx will never be empty because of flow control,
the only way this guy is going to bail, is if it times out,
or if it signal_pending() comes back with something.

signal_pending() never does, no matter how many signals I send it.
(Even sending it multiple kill -9's)

Eventually it times out (after 30 seconds, "setserial closing_wait"),
and then the process goes away.

However, I see the signals climb, when I print out the values of
current->signal->shared_pending.list.next and
current->signal->shared_pending.list.prev

Its like those values and the signal_pending macro aren't in "synch"
Anymore, once the process has gone into the PF_EXITING state.
(It works fine when the process is not in that state)

Thanks!
Scott
