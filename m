Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWBWRjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWBWRjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWBWRjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:39:41 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:65437 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932325AbWBWRjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:39:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=upd16cNjPgEpIIEDXOsWi5UrueStoLH6p4V1ZCBkE+o1/jb7Czu15r6+h+Jhk5U9sNAyBq2TbaQkBaUTu879l1wLLCuPCLvxBeMP7Dg8E9cnps5FT8mLrLQo7HuqQsQa89aMSPru7p82vo5BN8facGCF55ZmYAL+7cI33wxnSKw=
Subject: Re: [PATCH] change b_size to size_t
From: Badari Pulavarty <pbadari@gmail.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       christoph <hch@lst.de>, mcao@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <1140715738.22756.125.camel@dyn9047017100.beaverton.ibm.com>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060222151216.GA22946@lst.de>
	 <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com>
	 <20060222165942.GA25167@lst.de> <20060223014004.GA900@frodo>
	 <20060222175923.784ce5de.akpm@osdl.org>
	 <1140712093.22756.106.camel@dyn9047017100.beaverton.ibm.com>
	 <20060223163204.GA27682@kvack.org>
	 <1140715738.22756.125.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 09:40:55 -0800
Message-Id: <1140716455.22756.131.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 09:28 -0800, Badari Pulavarty wrote:
> On Thu, 2006-02-23 at 11:32 -0500, Benjamin LaHaise wrote:
> > On Thu, Feb 23, 2006 at 08:28:12AM -0800, Badari Pulavarty wrote:
> > > Here is the updated version of the patch, which changes
> > > buffer_head.b_size to size_t to support mapping large
> > > amount of disk blocks (for large IOs).
> > 
> > Your patch doesn't seem to be inline, so I can't quote it.  Several 
> > problems: on 64 bit platforms you introduced 4 bytes of padding into 
> > buffer_head.  atomic_t only takes up 4 byte, while size_t is 8 byte 
> > aligned. 
> 
> 
> Ignore my previous mail.
> 
> How about doing this ? Change b_state to u32 and change b_size
> to "size_t". This way, we don't increase the overall size of
> the structure on 64-bit machines. Isn't it ?

I hate to correct myself again. But this won't work either.
If we do this, we can use bit_spin_lock() helpers any more
to do bh_state manipulation :(

Yes. Bottom line is, we would increase the size of the structure
by 8-bytes on 64-bit machines. I don't see any way out of it.
But this would provide ability to let the filesystems know
that the we are dealing with large (> 4GB) of IOs (may be they
can allocated as much as possible contiguously), even if
we don't really do that big IOs.

Thanks,
Badari

