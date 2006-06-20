Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWFTQLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWFTQLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWFTQLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:11:38 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:5866 "EHLO osa.unixfolk.com")
	by vger.kernel.org with ESMTP id S1751384AbWFTQLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:11:37 -0400
Date: Tue, 20 Jun 2006 09:11:36 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, ccb@acm.org, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
 and NMI)
In-Reply-To: <20060619233947.94f7e644.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0606200906340.26762@osa.unixfolk.com>
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no>
 <fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no> <Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com>
 <20060619233947.94f7e644.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006, Andrew Morton wrote:
| > We'll see very long delays when 8 MPI processes exit "simultaneously", and sometimes
| > get NMI, sometimes system hangs, and sometimes just hung up for many seconds (and
| > often in that state, doing sysrq-P or sysrq-T will make things happy again).
| > 
| 
| OK.  I assume these processes have done a mmap(MAP_SHARED) of a lot of
| memory?

Yep.  Some shared with kernel modules, some of device address space.

| > A typical trace looks like this (on an fc4 2.6.16 kernel):
| 
| fc4?  You seem to have an RH-FCx which doesn't enable
| CONFIG_DEBUG_SPINLOCK.  Or maybe we didn't have all that debug code in
| 2.6.16.  Doesn't matter, really.

Intended to be more or less stock fc4 but with CONFIG_PCI_MSI=y and
2.6.17-based patch so the 8131 MSI quirk isn't enabled.

>From the config file:
	CONFIG_DEBUG_SPINLOCK=y
	CONFIG_DEBUG_SPINLOCK_SLEEP=y

| With a -stable backport.  I suspect this is triggerable on demand.

So far we've only got the one test case, but it's quite reliable.
We hit one of the 3 cases (long > 60 seconds) "hangs" at exit,
NMI, or dead system hang, every time we run the test case (well,
perhaps 1 out of 20 times everything is "just fine", probably
something perturbs it enough to let one or more processes get
through the critical section ahead of the whole gang).

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
