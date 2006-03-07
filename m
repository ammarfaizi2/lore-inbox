Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752475AbWCGCCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbWCGCCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 21:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbWCGCCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:02:45 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:37087 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1752475AbWCGCCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:02:44 -0500
Date: Tue, 7 Mar 2006 04:04:11 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: "David S. Miller" <davem@davemloft.net>, drepper@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
Message-ID: <20060307020411.GA21626@localdomain>
References: <20060306233300.GR20768@kvack.org> <20060306.162444.107249907.davem@davemloft.net> <20060307004237.GT20768@kvack.org> <20060306.165129.62204114.davem@davemloft.net> <20060307013915.GU20768@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307013915.GU20768@kvack.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 08:39:15PM -0500, Benjamin LaHaise wrote:
> On Mon, Mar 06, 2006 at 04:51:29PM -0800, David S. Miller wrote:
> > I think any such VM tricks need serious thought.  It has serious
> > consequences as far as cost especially on SMP.  Evgivny has some data
> > that shows this, and chapter 5 of Networking Algorithmics has a lot of
> > good analysis and paper references on this topic.
> 
> VM tricks do suck, so you just have to use the tricks that nobody else 
> is...  My thinking is to do something like the following: have a structure 
> to reference a set of pages.  When it is first created, it takes a reference 
> on the pages in question, and it is added to the vm_area_struct of the user 
> so that the vm can poke it for freeing when memory pressure occurs.  The 
> sk_buff dataref also has to have a pointer to the pageref added.  Now, the 
> trick to making it useful is as follows:
> 
> 	struct pageref {
> 		atomic_t	free_count;
> 		int		use_count;	/* protected by socket lock */
> 		...
> 		unsigned long	user_address;
> 		unsigned long	length;
> 		struct socket	*sock;		/* backref for VM */
> 		struct page	*pages[];
> 	};
[...]
> 
> It's probably easier to show this tx path with code that gets the details 
> right.

This somehow resembles the scatter-gatter lists already used in some 
subsystems such as the SCSI sg driver. 

BTW you have to make these pages Copy-On-Write before this procedure 
starts because you wouldn't want it to accidently fill the zero page, 
i.e. the VM will have to supply a unique set of pages otherwise it 
messes up.

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
