Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVLMQRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVLMQRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVLMQRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:17:09 -0500
Received: from palrel10.hp.com ([156.153.255.245]:60652 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S932159AbVLMQRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:17:08 -0500
Date: Tue, 13 Dec 2005 08:15:57 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: perfctr-devel@lists.sourceforge.net, perfmon@napali.hpl.hp.com
Subject: NMI watchdog logic on X86-64
Message-ID: <20051213161557.GF12669@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In the context of the perfmon2 interface, I am trying to understand
the NMI watchdog logic on X86-64 (I think this is identical on IA-32).

I am looking at the case where the NMI watchdog uses the Local APIC
and the performance counters (AMD or P4). The code of reference
is in 2.6.15.rc5-git1 arch/x86_64/kernel/nmi.c.

It is not clear to me what is going in the case of an SMP machine.

I would like to use reserve_lapic_nmi() and release_lapic_nmi()
from perfmon2 to start/stop the NMI watchdog while we have active
monitoring (i.e., get the performance counters back). The perfctr
subsystem is coded similarly.

The call reserve_lapic_nmi() invokes enable_lapic_nmi_watchdog() which
ends up in setup_apic_nmi_watchdog(). That function is executed only
on the calling processor. In SMP it means one CPU does the NMI watchdog.

In the case of the LAPIC APIC, this means that the call to release_lapic_nmi()
MUST be done on the same CPU as the one used for reserve_lapic_nmi() otherwise
the NMI watchdog setup for the performance counters will not be quiesced.

I would like to make sure that the logic of the code is that ONLY one processor
does the NMI watchdog timer?

In that case, I think it would be good to document or enforce the fact that when
Local APIC is used, calls to reserve and release must be made on the same processor.

Am I missing something here?

-- 
-Stephane
