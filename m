Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbUB0TMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbUB0TMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 14:12:51 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:53728 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262977AbUB0TL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 14:11:28 -0500
Date: Sat, 28 Feb 2004 03:11:18 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Chris Friesen" <cfriesen@nortelnetworks.com>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: Why no interrupt priorities?
Cc: "Helge Hafting" <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <F760B14C9561B941B89469F59BA3A8470255F02D@orsmsx401.jf.intel.com> <403F894C.1050808@nortelnetworks.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr31l84wi4evsfm@smtp.pacific.net.th>
In-Reply-To: <403F894C.1050808@nortelnetworks.com>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 13:15:40 -0500, Chris Friesen <cfriesen@nortelnetworks.com> wrote:

> Grover, Andrew wrote:
>
>> If a device later in the handler chain is also interrupting, then the
>> interrupt will immediately trigger again. The irq line will remain
>> asserted until nobody is asserting it.
>
> I thought I saw examples of edge-triggered shared interrupts earlier in
> the thread.  Doesn't that give the reason for this behaviour?

To make it more clear

                 /---active--~--\
IRQa	---------/                \-------------------------

                                 /-------------------------
IRQb  ----------------------~--/

                  /----------~--\/\/-----------------------
IRQBUS ---------/

Program  ....Main.....|.ISR...........|.Main............
Flow Edge trig                          Interrupt _dead_

Program  ....Main.....|.ISR...........|.Main.|ISR.....
Flow Level trig

When IRQBUS is level triggered, ISR is reeentered fairly quickly
(within one instruction) after IRET (depends on CPU).

The only way to "fix" edge-trig shared IRQ's is to

a) perform blind extra poll of the _entire_ chain until _no_ devices
    were serviced
b) Check IRQBUS and poll _entire_ chain when active.

And I find it mind boggling that IRQ's other than Timer and RTC are
edge triggered which also explains the troubles with sharing IRQ's.

It would be better to just program them level.

I good rule is:

An IRQ should be edge triggered when the ISR has no influence on the
state of the IRQ line. This is usually the case with periodic signals
such as timer outputs or strobes by rotary encoders and the like.

All other IRQs - in particular those "reset" by a software generated
events such as reading or writing a register - should be level triggered.

Regards
Michael
