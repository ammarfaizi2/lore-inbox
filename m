Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbUCDI7f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 03:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbUCDI7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 03:59:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9927 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261565AbUCDI7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 03:59:34 -0500
Date: Thu, 4 Mar 2004 03:57:36 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Ulrich Drepper <drepper@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
Message-ID: <20040304085735.GN31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com> <1078359137.10076.193.camel@cog.beaverton.ibm.com> <1078359191.10076.195.camel@cog.beaverton.ibm.com> <1078359248.10076.197.camel@cog.beaverton.ibm.com> <20040304005542.GZ4922@dualathlon.random> <40469194.5080506@redhat.com> <20040304024739.GA4922@dualathlon.random> <1078368889.10076.255.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078368889.10076.255.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 06:54:49PM -0800, john stultz wrote:
> On Wed, 2004-03-03 at 18:47, Andrea Arcangeli wrote:
> > And sysenter is at a fixed address in 2.6 x86 too (it doesn't even
> > change between different kernel compiles).
> 
> Actually, the 4G patch pushes vsysenter down a page, and glibc seems to
> handle this properly.

But the 4G/4G patch relinks the vDSO to the address it uses, this is no
big problem for glibc which of course doesn't use hardcoded address but
reads AT_SYSINFO{,_EHDR} values kernel passes to it.

But the fixed vDSO location is a problem, exploits certainly appreciate
a fixed address at which they with high probability can enter the kernel.

Ingo Molnar recently wrote a patch to randomize the vDSO address on
IA-32.  Unfortunately it revealed some bugs in glibc where ld.so did not
handle properly vDSOs linked to one address, but mmaped to a different one
(which is a must if kernel wants to share one vDSO page for each process).
So now the problem is if kernel randomizes vDSO, it will not even boot
with glibcs >= 2003-04-22 and <= 2004-02-27.  There are 2 possible solutions
for this IMHO:
1) tell users of the glibc's which don't handle this they must upgrade glibc
first before booting a newer kernel and add kernel cmdline option to turn
vDSO off, so that a user can turn it off, upgrade glibc and then on next
boot use vDSO again
2) start using a different AT_SYSINFO_* value (just one is enough,
ATM AT_SYSINFO is ((ElfNN_Ehdr *)AT_SYSINFO_EHDR)->e_entry), stop using
the old 2 values.  This would mean old glibcs will stop using vDSO, but hey,
it is just an optimization.  Upgrading glibc would use vDSO again.

	Jakub
