Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWH3Ssq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWH3Ssq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 14:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWH3Ssq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 14:48:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:33470 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751274AbWH3Ssp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 14:48:45 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,189,1154934000"; 
   d="scan'208"; a="117965771:sNHT396441563"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
Date: Wed, 30 Aug 2006 11:40:16 -0700
Message-ID: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
Thread-Index: AcbLrrrdW9xhwaVRSaanAHKQX2WlGAAs9vBA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Adam Belay" <abelay@novell.com>, "Brown, Len" <len.brown@intel.com>
Cc: "ACPI ML" <linux-acpi@vger.kernel.org>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>,
       "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "Arjan van de Ven" <arjan@linux.intel.com>
X-OriginalArrivalTime: 30 Aug 2006 18:40:18.0263 (UTC) FILETIME=[BDABF670:01C6CC63]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Adam Belay
>Sent: Tuesday, August 29, 2006 1:51 PM
>To: Brown, Len
>Cc: ACPI ML; Linux Kernel ML; Dominik Brodowski; Arjan van de Ven
>Subject: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
>
>Hi All,
>
>This patch improves the ACPI c-state selection algorithm.  It also
>includes a major cleanup and simplification of the processor idle code.
>
>The new implementation considers the full menu of available c-states.
>Just as the previous implementation, decisions are primarily based on
>the residency time of the last c-state entry.  This is generally an
>effective metric because it allows for detection of interrupt activity.
>However, the new algorithm differs in that it does not promote 
>or demote
>through the c-states in succession.  Rather, it immediately jumps to
>whatever c-state has the best expected power consumption advantage for
>the predicted residency time (i.e. the previously measured residency).
>If the residency time is too short during a deep c-state 
>entry, then the
>cost of entering the state outweighs any power consumption advantage.
>Similarly, if a shallow c-state is entered and resident for an
>excessively long duration, then a potential opportunity to save more
>power is missed.
>
>The changes in this patch allow the ACPI idle processor mechanism to
>react more quickly to sudden bursts of activity because it can jump
>directly to whatever c-state is appropriate.  However, because of the
>"menu" nature of c-state selection, the code works best when ACPI
>implementations expose all of the c-states supported by hardware.
>
>The bus master activity mechanism has undergone similar improvements.
>During capability detection, the deepest c-state that allows bus master
>activity is determined.  BM_STS is then polled each time the ACPI code
>prepares to enter a c-state.  If bus master activity is detected, then
>the previously mentioned bus master capable c-state becomes the deepest
>c-state allowed for that quantum.  In contrast, the old implementation
>would permit bus master activity to cause a promotion from one C3-type
>state to the next shallower C3-type state, imposing 
>unnecessary latency.
>As a further optimization, BM_STS is cleared each time
>acpi_processor_idle() is entered.  This prevents any stale bus master
>status from affecting c-state policy, as it may have occurred long ago
>during scheduled work.
>
>Finally, it's worth mentioning that the bulk of c-state policy
>calculations have been moved to take place before c-states are entered.
>This should further reduce exit latency when returning from a c-state.
>
>This algorithm has not yet been carefully benchmarked (e.g. bltk or
>power meters).  However, I can say with some confidence that it saves a
>small amount more power during an idle workload and a larger 
>amount more
>power during typical user-input oriented workloads such as word
>processing.
>
>I would really appreciate any comments, suggestions, or testing.
>

Nice changes. Will test and let you know how it goes.

While we are at cleaning up the code, I think it will be much better to 
move out C-state policy out of this acpi code altogether. We should have

just a generic interface, where any low level driver (acpi) can 
register/unregister a idle routine with latency, power and other 
characteristics (BM_STS). That way the policy can be generic and 
out of ACPI code. We had a patch earlier that does something like this
here:
http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg00129.html
http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg00130.html
But, that did not go anywhere at that time. Probably we can do some 
cleanup like that, along with this patch....

Thanks,
Venki
