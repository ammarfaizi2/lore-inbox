Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUGQC3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUGQC3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 22:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUGQC3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 22:29:05 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:64964 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S266684AbUGQC3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 22:29:01 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Chris Wright <chrisw@osdl.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
Subject: Re: [RFC] Lock free fd lookup 
In-reply-to: Your message of "Fri, 16 Jul 2004 18:19:36 MST."
             <20040717011936.GK3411@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Jul 2004 12:28:54 +1000
Message-ID: <3671.1090031334@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2004 18:19:36 -0700, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>On Sat, Jul 17, 2004 at 10:55:59AM +1000, Keith Owens wrote:
>> The beauty of these lockfree algorithms on large structures is that
>> nothing ever stalls indefinitely.  If the underlying SMP cache hardware
>> is fair, everything running a lockfree list will make progress.  These
>> algorithms do not suffer from reader vs. writer starvation.
>
>That's a large assumption. NUMA hardware typically violates it.

True, which is why I mentioned it.  However I suspect that you read
something into that paragraph which was not intended.

Just reading the lockfree list and the structures on the list does not
suffer from any NUMA problems, because reading does not perform any
global updates at all.  The SMP starvation problem only kicks in when
multiple concurrent updates are being done.  Even with multiple
writers, one of the writers is guaranteed to succeed every time, so
over time all the write operations will proceed, subject to fair access
to exclusive cache lines.

Lockfree reads with Moir's algorithms require extra memory bandwidth.
In the absence of updates, all the cache lines end up in shared state.
That reduces to local memory bandwidth for the (hopefully) common case
of lots of readers and few writers.  Lockfree code is nicely suited to
the same class of problem that RCU addresses, but without the reader
vs. writer starvation problems.

Writer vs. writer starvation on NUMA is a lot harder.  I don't know of
any algorithm that handles lists with lots of concurrent updates and
also scales well on large cpus, unless the underlying hardware is fair
in its handling of exclusive cache lines.

