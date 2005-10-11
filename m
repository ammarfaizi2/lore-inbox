Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVJKSNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVJKSNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 14:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVJKSNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 14:13:50 -0400
Received: from mail29.messagelabs.com ([140.174.2.227]:2995 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S932173AbVJKSNt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 14:13:49 -0400
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-9.tower-29.messagelabs.com!1129054416!26821703!1
X-StarScan-Version: 5.4.15; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to a terminating (PF_EXITING) process.
Date: Tue, 11 Oct 2005 13:16:42 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F36B112@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to a terminating (PF_EXITING) process.
Thread-Index: AcXOj+5MBaNx0lLISrGytHv2s4jdgw==
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Linux Kernel Mail List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Oct 2005 18:16:44.0022 (UTC) FILETIME=[EF4AA960:01C5CE8F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This email will deal with the serial/tty layer of the kernel,
but I don't think its completely isolated to this layer...

I have found a problem with signals not getting delivered to a
Process once it enters into the PF_EXITING state.

Probably the best way to show it, is an example with the built-in
COM port.

1) Don't have anything connected to COM1.
2) stty -ixon -ixoff -ixany crtscts < /dev/ttyS0
3) date > /dev/ttyS0
4) Press ctrl-c.

The process does get this ctrl-c, and starts closing down.

The serial driver gets its "tty close" for ttyS0, as it should,
and goes into a "drain" waiting for the data that is pending
in the UART to be written.

(Which can never be written, because the port is stuck in a
hardware flow control state)

5) Press ctrl-c again... And again, and again, and again.  Nothing.

The process is stuck, and a ps -ef shows that it is in a
zombie state ([date])

Under stock 2.4 kernels, the 2nd and subsequent ctrl-c's would wake
up the serial driver's "wait" with a signal, which in turn would
allow the serial driver to bail out of the forever "drain",
and complete the close.

Now, eventually, the "date" will bail, but only because the serial
driver has a "timeout" set for the wait in its drain routine.
It still never receives the 2nd+ ctrl-c's.

Is this change intentional?
If so, why?

Thanks!
Scott
