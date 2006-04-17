Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWDQHwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWDQHwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 03:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWDQHwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 03:52:12 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:64453 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750720AbWDQHwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 03:52:11 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Robin Holt <holt@sgi.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Dean Nelson <dcn@sgi.com>
Subject: Re: Is notify_die being overloaded? 
In-reply-to: Your message of "Sat, 15 Apr 2006 05:43:56 EST."
             <20060415104355.GA7156@lnx-holt.americas.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Apr 2006 17:52:10 +1000
Message-ID: <2059.1145260330@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt (on Sat, 15 Apr 2006 05:43:56 -0500) wrote:
>On Sat, Apr 15, 2006 at 04:19:55PM +1000, Keith Owens wrote:
>> Robin Holt (on Thu, 13 Apr 2006 14:46:44 -0500) wrote:
>> >notify_die seems to be called to indicate the machine is going down as
>> >well as there are trapped events for the process.
>...
>> The only real problem is the page fault handler event.  All the other
>...
>> 
>> kprobes should be using its own notify chain to trap page faults, and
>> the handler for that chain should be optimized away when
>> CONFIG_KPROBES=n or there are no active probes.
>
>I realize the page fault handler is the only performance critical event,
>but don't all the debugging events _REALLY_ deserve a seperate call chain?
>They are _completely_ seperate and isolated events.  One is a minor event
>which a small number of other userland processes are concerned with.
>The other is indicating the machine is about stop running and is only
>relevant to critical system infrastructure.

Unfortunately the ebents are ambiguous.  On IA64 BUG() maps to break 0,
but break 0 is also used for debugging[*].  Which makes it awkward to
differentiate between a kernel error and a debug event, we have to
first ask the debuggers if the event if for them then, if the debuggers
do not want the event, drop into the die_if_kernel event.

[*] It does not help that IA64 break.b <n> does not store the value of
    <n> in cr.iim.  All break.b values look like break.b 0.  There used
    to be code in traps.c to detect this and extract the value of
    break.b, but a kprobes patch removed that code.

