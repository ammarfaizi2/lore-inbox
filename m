Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVAaWuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVAaWuR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVAaWuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:50:17 -0500
Received: from mail.joq.us ([67.65.12.105]:49542 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261415AbVAaWtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:49:47 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Alexander Nyberg <alexn@dsv.su.se>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] sched - Implement priority and fifo support for
 SCHED_ISO
References: <41F76746.5050801@kolivas.org> <87acqpjuoy.fsf@sulphur.joq.us>
	<41FE9582.7090003@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Mon, 31 Jan 2005 16:51:29 -0600
In-Reply-To: <41FE9582.7090003@kolivas.org> (Con Kolivas's message of "Tue,
 01 Feb 2005 07:30:58 +1100")
Message-ID: <87651di55a.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Sure enough I found the bug in less than 5 mins, and it would
> definitely cause this terrible behaviour.
>
> A silly bracket transposition error on my part :P

The corrected version works noticeably better, but still nowhere near
as well as SCHED_FIFO.  The first run had a cluster of really bad
xruns.  The second and third were much better, but still with numerous
small xruns.

  http://www.joq.us/jack/benchmarks/sched-iso-fix/

With a compile running in the background it was a complete failure.
Some kind of big xrun storm triggered a collapse on every attempt.

  http://www.joq.us/jack/benchmarks/sched-iso-fix+compile/

The summary statistics are mixed.  The delay_max is noticeably better
than before, but still much worse than SCHED_FIFO.  But, the xruns are
really bad news...

  http://www.joq.us/jack/benchmarks/.SUMMARY


# sched-iso-fix
Delay Maximum . . . . . . . . : 33894   usecs
Delay Maximum . . . . . . . . :   745   usecs
Delay Maximum . . . . . . . . :   341   usecs

# sched-iso
Delay Maximum . . . . . . . . : 21410   usecs
Delay Maximum . . . . . . . . : 36830   usecs
Delay Maximum . . . . . . . . :  4062   usecs

# sched-fifo
Delay Maximum . . . . . . . . :   347   usecs
Delay Maximum . . . . . . . . :   277   usecs
Delay Maximum . . . . . . . . :   246   usecs
Delay Maximum . . . . . . . . :   199   usecs
Delay Maximum . . . . . . . . :   261   usecs
Delay Maximum . . . . . . . . :   305   usecs

# sched-iso-fix+compile
Delay Maximum . . . . . . . . : 14549   usecs
Delay Maximum . . . . . . . . : 38961   usecs
Delay Maximum . . . . . . . . : 26904   usecs

# sched-iso+compile
Delay Maximum . . . . . . . . : 98909   usecs
Delay Maximum . . . . . . . . : 39414   usecs
Delay Maximum . . . . . . . . : 40294   usecs
Delay Maximum . . . . . . . . : 217192   usecs
Delay Maximum . . . . . . . . : 156989   usecs

# sched-fifo+compile
Delay Maximum . . . . . . . . :   285   usecs
Delay Maximum . . . . . . . . :   269   usecs
Delay Maximum . . . . . . . . :   277   usecs
Delay Maximum . . . . . . . . :   569   usecs
Delay Maximum . . . . . . . . :   461   usecs
Delay Maximum . . . . . . . . :   405   usecs
Delay Maximum . . . . . . . . :   286   usecs
Delay Maximum . . . . . . . . :   579   usecs

# sched-iso-fix
XRUN Count  . . . . . . . . . :    26
XRUN Count  . . . . . . . . . :    24
XRUN Count  . . . . . . . . . :    17

# sched-iso
XRUN Count  . . . . . . . . . :    15
XRUN Count  . . . . . . . . . :    17
XRUN Count  . . . . . . . . . :     5

# sched-fifo
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     0

# sched-iso-fix+compile
XRUN Count  . . . . . . . . . :    22
XRUN Count  . . . . . . . . . :    44
XRUN Count  . . . . . . . . . :    39

# sched-iso+compile
XRUN Count  . . . . . . . . . :    44
XRUN Count  . . . . . . . . . :    46
XRUN Count  . . . . . . . . . :    45
XRUN Count  . . . . . . . . . :    27
XRUN Count  . . . . . . . . . :   101

# sched-fifo+compile
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     4
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     0

-- 
  joq
