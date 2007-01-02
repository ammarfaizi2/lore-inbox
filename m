Return-Path: <linux-kernel-owner+w=401wt.eu-S1753098AbXABLBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbXABLBz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbXABLBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:01:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43036 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbXABLBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:01:54 -0500
Date: Tue, 2 Jan 2007 11:01:36 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch] remove redundant iov segment check
Message-ID: <20070102110136.GA20640@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zach Brown <zach.brown@oracle.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <000001c717c0$f82b5ea0$2589030a@amr.corp.intel.com> <28F99581-3A2A-45BD-8F00-B554313E2C26@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28F99581-3A2A-45BD-8F00-B554313E2C26@oracle.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if it wouldn't be better to make this change as part of a  
> larger change that moves towards an explicit iovec container struct  
> rather than bare 'struct iov *' and 'nr_segs' arguments.  The struct  
> could have a flag that expressed whether the elements had been  
> checked.  A helper could be called by the upper and lower code paths  
> which does the checking, marks the flag, and avoids checking again if  
> the flag is set.
> 
> We've wanted an explicit struct in the past to avoid the multiple  
> walks of iovecs that various paths do for their own reasons.  The  
> iovec walk that is checking for length wrapping could also be  
> building a bitmap of length alignment that O_DIRECT could be using to  
> test 512B alignment without having to walk the iovec again.

I suspect it should be rather trivial to get this started.  As a first
step we simply add a

struct iodesc {
	int nr_segs;
	struct iovec ioc[]
};

And then we can add fields where nessecary.  First a full_length one
to avoid the loops to calculate thw whole I/O size, then flags for
the alignment check, etc..  
