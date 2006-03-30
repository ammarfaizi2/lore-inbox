Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWC3W6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWC3W6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 17:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWC3W6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 17:58:42 -0500
Received: from smop.co.uk ([81.5.177.201]:19921 "EHLO hades.smop.co.uk")
	by vger.kernel.org with ESMTP id S1750781AbWC3W6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 17:58:41 -0500
Date: Thu, 30 Mar 2006 23:58:30 +0100
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.16-mm1 leaks in dvb playback (found)
Message-ID: <20060330225830.GA24009@smop.co.uk>
Reply-To: adrian@smop.co.uk
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Andi Kleen <ak@muc.de>
References: <20060326211514.GA19287@wyvern.smop.co.uk> <20060327172356.7d4923d2.akpm@osdl.org> <20060328070220.GA29429@smop.co.uk> <20060327231630.76e97b83.akpm@osdl.org> <20060329233712.GA21810@smop.co.uk> <20060329160648.59395d67.akpm@osdl.org> <20060330004518.GA23404@smop.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330004518.GA23404@smop.co.uk>
User-Agent: Mutt/1.5.11+cvs20060126
From: Adrian Bridgett <adrian@smop.co.uk>
X-smop.co.uk-MailScanner: Found to be clean
X-smop.co.uk-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.673,
	required 5, autolearn=not spam, AWL -0.07, BAYES_00 -2.60,
	NO_RELAYS -0.00)
X-smop.co.uk-MailScanner-From: adrian@smop.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What I thought was just one patch was actually two and it was the
other patch causing the problem - "Do not lose accepted socket when
-ENFILE/-EMFILE".

Most of the patch seems to be just a restructuring - I guess that
leaves the sys_accept changes that are leaking the memory. 

I've no idea how the code is supposed to work, so large rocks of salt
required :-)  The code now does a sock_alloc_fd, and the error cases
now do a "put_filp" and "put_unused_fd" if the alloc succeeded.
However in the normal case, nothing gets freed (I guess that's the
memory leak).  OTOH the description of the patch is:

 "Try to allocate the struct file and an unused file
 descriptor before we try to pull a newly accepted
 socket out of the protocol layer."

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=39d8c1b6fbaeb8d6adec4a8c08365cc9eaca6ae4

Cheers,

Adrian
