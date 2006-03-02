Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWCBERT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWCBERT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWCBERT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:17:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17357 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751125AbWCBERS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:17:18 -0500
Date: Wed, 1 Mar 2006 23:10:31 -0500
From: Dave Jones <davej@redhat.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Andi Kleen <ak@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [patch 18/39] [PATCH] sys_mbind sanity checking
Message-ID: <20060302041031.GF19755@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
	stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Andi Kleen <ak@suse.de>,
	Greg Kroah-Hartman <gregkh@suse.de>
References: <20060227223200.865548000@sorel.sous-sol.org> <20060227223350.609924000@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227223350.609924000@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 02:32:18PM -0800, Chris Wright wrote:
 > -stable review patch.  If anyone has any objections, please let us know.
 > ------------------
 > 
 > Make sure maxnodes is safe size before calculating nlongs in
 > get_nodes().
 > 
 > Signed-off-by: Chris Wright <chrisw@sous-sol.org>
 > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
 > [chrisw: fix units, pointed out by Andi]
 > Cc: Andi Kleen <ak@suse.de>
 > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
 > ---
 > 
 >  mm/mempolicy.c |    2 ++
 >  1 files changed, 2 insertions(+)
 > 
 > --- linux-2.6.15.4.orig/mm/mempolicy.c
 > +++ linux-2.6.15.4/mm/mempolicy.c
 > @@ -524,6 +524,8 @@ static int get_nodes(nodemask_t *nodes, 
 >  	nodes_clear(*nodes);
 >  	if (maxnode == 0 || !nmask)
 >  		return 0;
 > +	if (maxnode > PAGE_SIZE*BITS_PER_BYTE)
 > +		return -EINVAL;
 >  
 >  	nlongs = BITS_TO_LONGS(maxnode);
 >  	if ((maxnode % BITS_PER_LONG) == 0)

Gar..

mm/mempolicy.c: In function 'get_nodes':
mm/mempolicy.c:527: error: 'BITS_PER_BYTE' undeclared (first use in this function)
mm/mempolicy.c:527: error: (Each undeclared identifier is reported only once
mm/mempolicy.c:527: error: for each function it appears in.)

About to retry a build with the below patch which should do the trick.
(How did this *ever* build?)

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15/include/linux/types.h~	2006-03-01 23:05:24.000000000 -0500
+++ linux-2.6.15/include/linux/types.h	2006-03-01 23:05:57.000000000 -0500
@@ -8,6 +8,7 @@
 	(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
+#define BITS_PER_BYTE 8
 #endif
 
 #include <linux/posix_types.h>
