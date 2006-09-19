Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWISRlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWISRlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWISRlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:41:16 -0400
Received: from tomts43-srv.bellnexxia.net ([209.226.175.110]:20674 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1030388AbWISRlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:41:14 -0400
Date: Tue, 19 Sep 2006 13:41:12 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Ingo Molnar <mingo@elte.hu>, "Frank Ch. Eigler" <fche@redhat.com>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060919174112.GA26339@Krystal>
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <451008AC.6030006@google.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:33:14 up 27 days, 14:41,  4 users,  load average: 0.18, 0.11, 0.13
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

* Martin J. Bligh (mbligh@google.com) wrote:
> Why don't we just copy the whole damned function somewhere else, and
> make an instrumented copy (as a kernel module)? Then reroute all the
> function calls through it, instead of the original version. OK, it's
> not completely trivial to do, but simpler than kprobes (probably
> doing the switchover atomically is the hard part, but not impossible).
> There's NO overhead when not using, and much lower than probes when
> you are.
> 

I just thought about your idea and I think it can be very powerful. I think it
can be a lot easier with a probe at the beginning of the function than changing
function pointers everywhere. First of all, if we just think about accessing
easily internal variables, we could think of this simple trampoline scheme :

1 - load the instrumented function with modprobe
2 - use kprobe to reroute the first instructions of the original function to the
new one.
3 - _not_ use the special kprobe_ret, simply return at the end of the
instrumented function.

Then, if we want to optimize the speed of this mechanism, we can deploy
djprobes : it would greatly help them to know in advance where the probe is
located. We would have to see if the prologue of a function is a good spot to
put a jump (it does not seem to be the case however) :( .

To stop this tracing behavior, we would just have to remove the kprobe.
Unloading of the instrumented module can be difficult though (we have to be sure
the code will no longer be executed).

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
