Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265047AbUFGUmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265047AbUFGUmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 16:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUFGUmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 16:42:06 -0400
Received: from [213.146.154.40] ([213.146.154.40]:23511 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265047AbUFGUln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 16:41:43 -0400
Date: Mon, 7 Jun 2004 21:41:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc3
Message-ID: <20040607204142.GA26986@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 12:32:45PM -0700, Linus Torvalds wrote:
> 
> Ok, let's calm down for a while before the final 2.6.7.
> 
> -rc3 does a lot of sparse type cleanup, mainly thanks to Al Viro (but his
> work ended up getting some other people involved too, since the list of
> sparse warnings isn't as daunting any more). Some of that has unearthed 
> real bugs which Al fixed.
> 
> But there are DRM, AGP, cpufreq, sparc64, and input updates there too. See 
> the appended shortlog for more details,

This one here:

diff -Nru a/include/linux/netfilter_arp.h b/include/linux/netfilter_arp.h
--- a/include/linux/netfilter_arp.h     2004-06-07 21:58:09 +02:00
+++ b/include/linux/netfilter_arp.h     2004-06-07 21:58:09 +02:00
@@ -17,4 +17,5 @@
 #define NF_ARP_FORWARD 2
 #define NF_ARP_NUMHOOKS        3

+static DECLARE_MUTEX(arpt_mutex);
 #endif /* __LINUX_ARP_NETFILTER_H */

looks perfectly fucked up.  This way every file including netfilter_arp.h
will get it's own copy of arpt_mutex which certainly doesn't help
synchronization.

But in fact I can only see a single file actually using it, that's
arp_tables.c where it was defined previously.  What's going on here?

