Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVE1JIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVE1JIw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 05:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVE1JIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 05:08:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36487 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262512AbVE1JIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 05:08:45 -0400
Date: Sat, 28 May 2005 10:08:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Carsten Otte <cotte@freenet.de>
Cc: suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC/PATCH 2/4] fs/mm: execute in place (3rd version)
Message-ID: <20050528090841.GB19153@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Carsten Otte <cotte@freenet.de>, suparna@in.ibm.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	schwidefsky@de.ibm.com, akpm@osdl.org
References: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com> <1116869420.12153.32.camel@cotte.boeblingen.de.ibm.com> <20050524093029.GA4390@in.ibm.com> <42935DE1.4040301@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42935DE1.4040301@freenet.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 07:01:21PM +0200, Carsten Otte wrote:
> When looking at patch v2, the read split is done in do_generic_mapping_read
> vs do_xip_mapping read. In the write path, the split is at
> generic_file_xip_write,
> generic_file_buffered_write and generic_file_direct_write.
> How about abstracting on that interface? Like make those become address
> space operations.

No, these aren't related to the address_space at all.  Please keep the
abstractions clean or we'll end up with a total mess.

> This way, the filesystems could select the corresponding
> function. No need to distinguish between xip, direct_IO, and classic
> readpage/writepage in the generic code anymore.
> Would this go in the direction you're thinking Suparna? Is it worth a
> try to see
> how it comes out? Opinions anyone?

I don't think this split makes a whole lot of sense either.  The normal
codepath needs to go through a lot of hops to make sure the odd behaviour
of falling back from direct to buffered I/O for some types of requests
works.  That needs intimate knowledge of how the direct and buffered I/O
path works.  Your XIP codepath has the luxury of not having to care for
all this, so you can keep it really simple.
