Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVAYCk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVAYCk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 21:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVAYCis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 21:38:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:19133 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261759AbVAYCeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 21:34:13 -0500
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks (v. A2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       Paul Mackerras <paulus@samba.org>, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <1106607153.30884.12.camel@cog.beaverton.ibm.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <1106607153.30884.12.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 13:28:54 +1100
Message-Id: <1106620134.15850.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 14:52 -0800, john stultz wrote:
> All,
> 	This patch implements the minimal architecture specific hooks to enable
> the new time of day subsystem code for i386, x86-64, and ppc64. It
> applies on top of my linux-2.6.11-rc1_timeofday-core_A2 patch and with
> this patch applied, you can test the new time of day subsystem. 
> 
> 	Basically it adds the call to timeofday_interrupt_hook() and cuts alot
> of code out of the build via #ifdefs. I know, I know, #ifdefs' are ugly
> and bad, and the final patch will just remove the old code. For now this
> allows us to be flexible and easily switch between the two
> implementations with a single define. Also it makes the patch a bit
> easier to read.

I haven't seen your other patch. Do you mean that with this patch, ppc64
stops using it's own gettimeofday implementation based on the CPU
hardware timebase ?

There are reasons why I plan to keep that. First, our implementation is
very efficient. It allows a timeofday computation without locks or
barriers thanks to carefully hand crafted data dependencies in the
operation. Second, we have an ABI issue here. For historical reasons, we
have this "systemcfg" data structure that can be mmap'ed to userland,
and which contains copy of some of the ppc64 internal time keeping
infos. Some userland stuff use it to implement a fully userland
gettimeofday (again, without barrier nor locks). This is done at least
by IBM's JVM. My still-to-be-merged vDSO patch will also use this for
the userland implementation of gettimeofday syscall itself.

Ben.


