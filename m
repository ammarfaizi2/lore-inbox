Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWHHEFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWHHEFc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 00:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWHHEFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 00:05:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46732 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932474AbWHHEFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 00:05:32 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: "Jan Beulich" <jbeulich@novell.com>
cc: anil.s.keshavamurthy@intel.com, "Andrew Morton" <akpm@osdl.org>,
       "Andreas Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: notify_page_fault_chain 
In-reply-to: Your message of "Mon, 07 Aug 2006 14:22:54 +0100."
             <44D75ACE.76E4.0078.0@novell.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Aug 2006 14:05:17 +1000
Message-ID: <8456.1155009917@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" (on Mon, 07 Aug 2006 14:22:54 +0100) wrote:
>All,
>
>I just noticed this addition to i386 and x86-64, conditionalized upon CONFIG_KPROBES. May I ask what the motivation for
>this compatibility breaking change is? Only performance? I consider it already questionable to split out a specific
>fault from the general die notification (previous users of the functionality all of the sudden won't get notifications
>for one of the most crucial faults anymore), but entirely hiding the functionality (unavailable without CONFIG_KPROBES,
>and even with it not getting exported) is really odd.

Running all callbacks on the notify_die chain for every page fault was
causing a significant slowdown on large machines, especially when the
callback chain included heartbeat monitors, kernel debuggers and cross
partition NUMA access routines.

Only kprobes needs to know about page faults, none of the other
callbacks care about page faults.  So the notify_page_fault_chain chain
was added just for kprobes use, and made conditional on CONFIG_KPROBES.
That way only kprobed systems need to suffer the slowdown in page
faulting.

