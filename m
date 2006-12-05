Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758807AbWLEWL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758807AbWLEWL2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759223AbWLEWL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:11:28 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36892 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758807AbWLEWL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:11:27 -0500
Date: Tue, 5 Dec 2006 23:10:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt 2/3] Make trace_freerunning work
Message-ID: <20061205221046.GB20587@elte.hu>
References: <20061205220257.1AECF3E2420@elvis.elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205220257.1AECF3E2420@elvis.elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:

> Only reorder trace entries once if trace_freerunning is 1. Modify 
> user_trace_stop() not to check report_latency(delta) then. Note that 
> at least MAX_TRACE entries must have been generated between 
> user_trace_start() and user_trace_stop() for a freerunning trace to be 
> reliable.

my thinking behind the freerunning feature is this:

freerunning should behave the same way with regard to latency 
measurement. I.e. report_latency() is still needed, and the kernel will 
thus do a maximum search over all traces triggered via start/stop.

the difference is in the recording of the last-largest-latency:

- with !freerunning, the tracer stops recording after MAX_TRACE entries, 
  i.e. the "head" of the trace is preserved in the trace buffer.

- with freerunning, the tracer never stops, it 'wraps around' after 
  MAX_TRACE entries and starts overwriting the oldest entries. I.e. the  
  "tail" of the trace is preserved in the trace buffer.

depending on the situation, freerunning or !freerunning might be the 
more useful mode.

but there should be no difference in measurement.

could you try to rework this patch with the above functionality in mind? 
(or if you'd like to see new functionality, what would that be - and we 
could/should implement that separately from the existing semantics of 
freerunning and !freerunning)

	Ingo
