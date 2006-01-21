Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWAUB22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWAUB22 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWAUB22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:28:28 -0500
Received: from ns1.siteground.net ([207.218.208.2]:48869 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932381AbWAUB21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:28:27 -0500
Date: Fri, 20 Jan 2006 17:27:09 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, matthew.e.tolentino@intel.com, ak@suse.de,
       shai@scalex86.org
Subject: Re: [bug] __meminit breaks cpu hotplug
Message-ID: <20060121012709.GC3573@localhost.localdomain>
References: <20060121004023.GB3573@localhost.localdomain> <20060120165521.3c71542b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120165521.3c71542b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 04:55:21PM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> > -#define __meminitdata __initdata
> > -#define __memexit __exit
> > -#define __memexitdata	__exitdata
> > +#define __meminit	__cpuinit
> > +#define __meminitdata __cpuinitdata
> > +#define __memexit __cpuexit
> > +#define __memexitdata	__cpuexitdata
> 
> This looks wrong.  The __meminit and __cpuinit definitions we have now are
> OK, aren't they?  Surely the problem is that some functions/variables are
> incorrectly tagged?

I hit the bug on pageset_cpuup_callback, which is obviously __cpuinit, but
has been marked __meminit.  Yeah .. bad patch duh! 

For some reason I thought all other functions marked with __meminit looked 
like __cpuinit candidates....while just pageset_cpuup_callback should be
changed to __cpuinit 


Index: linux-2.6.16-rc1/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc1.orig/mm/page_alloc.c	2006-01-17 14:12:17.000000000 -0800
+++ linux-2.6.16-rc1/mm/page_alloc.c	2006-01-20 17:21:03.000000000 -0800
@@ -1923,7 +1923,7 @@ static inline void free_zone_pagesets(in
 	}
 }
 
-static int __meminit pageset_cpuup_callback(struct notifier_block *nfb,
+static int __cpuinit pageset_cpuup_callback(struct notifier_block *nfb,
 		unsigned long action,
 		void *hcpu)
 {
