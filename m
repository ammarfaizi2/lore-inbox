Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWCSFJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWCSFJP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 00:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWCSFJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 00:09:15 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17639 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751405AbWCSFJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 00:09:14 -0500
Date: Sat, 18 Mar 2006 21:08:40 -0800
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, kernel-stuff@comcast.net, linux-kernel@vger.kernel.org,
       alex-kernel@digriz.org.uk, jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Message-Id: <20060318210840.e7156b6b.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
	<Pine.LNX.4.64.0603181321310.3826@g5.osdl.org>
	<20060318165302.62851448.akpm@osdl.org>
	<Pine.LNX.4.64.0603181827530.3826@g5.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If find_first_bit and find_next_bit suck so bad, then why just fix
their use in the for_each_cpu_mask().  How about the other uses?

Such as the other 50 odd places in the kernel that call them directly,
such as:

	$ grep ' = find_[a-z]*_bit' lib/bitmap.c
	    rbot = cur = find_first_bit(maskp, nmaskbits);
		    cur = find_next_bit(maskp, nmaskbits, cur+1);
	    i = find_first_bit(buf, bits);
		    i = find_next_bit(buf, bits, i + 1);
		    for (i = find_first_bit(buf, bits);
			 i = find_next_bit(buf, bits, i + 1))
	    for (oldbit = find_first_bit(src, bits);
		 oldbit = find_next_bit(src, bits, oldbit + 1)) {

Perhaps the common interface to these find_*_bit routines should be out
of line, with perhaps just a couple of key calls from the scheduler
using the inline form.

And if we fix the cpu loop to the API Linus suggests, we should do the
same with the node loops, such as used in:

	$ grep for_each.*_node mm/slab.c
		    for_each_node(i) {
	    for_each_node(i)
	    for_each_online_node(i) {
		    for_each_online_node(node) {
	    for_each_online_node(node) {
			    for_each_online_node(node) {
	    for_each_online_node(node) {
	    for_each_online_node(i) {
	    for_each_online_node(i) {
	    for_each_online_node(node) {
	    for_each_online_node(node) {
	    for_each_online_node(node) {
	    for_each_online_node(node) {

And for those of us with too many CPUs, how about something like
(totally untested and probably totally bogus):

	#if NR_CPUS <= BITS_IN_LONG
	 ... as per Linus, shifting a mask right ...
	#else
	#define for_each_cpu_mask(cpu, mask)
		{ for (cpu = 0; cpu < NR_CPUS; cpu++) {
			if (!(test_bit(cpu, mask))
				continue;
	#endif

	#define end_for_each_cpu_mask	} }	

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
