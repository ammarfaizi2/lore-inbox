Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWDRAXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWDRAXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 20:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWDRAXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 20:23:54 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:6341 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751380AbWDRAXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 20:23:53 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Robin Holt <holt@sgi.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Dean Nelson <dcn@sgi.com>
Subject: Re: Is notify_die being overloaded? 
In-reply-to: Your message of "Mon, 17 Apr 2006 06:25:52 EST."
             <20060417112552.GB4929@lnx-holt.americas.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Apr 2006 10:23:52 +1000
Message-ID: <9758.1145319832@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt (on Mon, 17 Apr 2006 06:25:52 -0500) wrote:
>On Mon, Apr 17, 2006 at 05:51:44AM -0500, Robin Holt wrote:
>> On Mon, Apr 17, 2006 at 05:52:10PM +1000, Keith Owens wrote:
>> > Robin Holt (on Sat, 15 Apr 2006 05:43:56 -0500) wrote:
>...
>> > Unfortunately the ebents are ambiguous.  On IA64 BUG() maps to break 0,
>> > but break 0 is also used for debugging[*].  Which makes it awkward to
>> > differentiate between a kernel error and a debug event, we have to
>> > first ask the debuggers if the event if for them then, if the debuggers
>> > do not want the event, drop into the die_if_kernel event.
>> 
>> I think this still would argue for a notify_debugger() sort of callout
>> which would read something like:
>
>I finally think I understand your point.  You are saying that kdb would
>have to register for the notify_debugger() chain and would therefore
>get in the way of handle_page_fault().  What about changing notify_die()
>callout in handle_page_fault() into a notify_page_fault().  That actually
>feels a lot better now that you got me to think about it.

I thought that is what I said in my original response, "kprobes should
be using its own notify chain to trap page faults, and the handler for
that chain should be optimized away when CONFIG_KPROBES=n or there are
no active probes".

Even the overhead of calling into a notify_page_fault() routine just to
do nothing adds a measurable overhead to the page fault handler
(according to Jack Steiner).  Since kprobes is the only code that needs
a callback on a page fault, it is up to kprobes to minimize the impact
of that callback on the normal processing.

