Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWCZVQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWCZVQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWCZVQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:16:09 -0500
Received: from smop.co.uk ([81.5.177.201]:42915 "EHLO hades.smop.co.uk")
	by vger.kernel.org with ESMTP id S1751488AbWCZVQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:16:08 -0500
Date: Sun, 26 Mar 2006 22:15:14 +0100
To: Kernel ML <linux-kernel@vger.kernel.org>
Subject: 2.6.16-mm1 leaks in dvb playback
Message-ID: <20060326211514.GA19287@wyvern.smop.co.uk>
Reply-To: adrian@smop.co.uk
Mail-Followup-To: Kernel ML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
From: Adrian Bridgett <adrian@smop.co.uk>
X-smop.co.uk-MailScanner: Found to be clean
X-smop.co.uk-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.949,
	required 5, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.45,
	BAYES_00 -2.60)
X-smop.co.uk-MailScanner-From: adrian@smop.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had this problem for a little while (probably since 2.6.14/15
era) but I've only recently spent some time to figure out what's been
going wrong.

There is a patch in the -mm series which causes leaks in both
sock_inode_cache and dentry_cache for me during DVB playback (thanks
to slabtop). 

2.6.16 is fine (no leakage), 2.6.16-mm1 has this problem (~ 2MB/s in
each cache).

I'm using dvbstream and sending the output to /dev/null,  dvb modules
loaded are dvb_usb_vp7045, dvb_usb, dvb_core, dvb_pll.  It's an EHCI USB
device running on a Dell D600 latitude.

turning on some debugging and looking at /proc/slab_allocators and
/proc/page_owners shows that the most prevalent page owners are:

(5363 out of 5631)
Page allocated via order 0, mask 0xd0
[0xc0161079] poison_obj+41
[0xc0162355] cache_alloc_refill+981
[0xc0161889] cache_alloc_debugcheck_after+169
[0xc01d5169] vsnprintf+857
[0xc0247eec] lock_sock+204
[0xc0244999] sock_alloc_inode+25
[0xc0161f73] kmem_cache_alloc+131
[0xc027a4b4] inet_csk_accept+436

(1989 out of 2734)
Page allocated via order 0, mask 0xd0
[0xc0162355] cache_alloc_refill+981
[0xc0161079] poison_obj+41
[0xc0161079] poison_obj+41
[0xc01d5169] vsnprintf+857
[0xc0182341] d_alloc+33
[0xc0161f73] kmem_cache_alloc+131
[0xc0182341] d_alloc+33
[0xc02461e0] sock_attach_fd+96

I don't normally read LKML so best to Cc me in case I forget :-)  

Many thanks,

Adrian
