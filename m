Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAIO2I>; Tue, 9 Jan 2001 09:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbRAIO16>; Tue, 9 Jan 2001 09:27:58 -0500
Received: from zeus.kernel.org ([209.10.41.242]:9683 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129562AbRAIO1s>;
	Tue, 9 Jan 2001 09:27:48 -0500
Date: Tue, 9 Jan 2001 14:25:42 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@caldera.de>, "David S. Miller" <davem@redhat.com>,
        riel@conectiva.com.br, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109142542.G4284@redhat.com>
In-Reply-To: <20010109122810.A3115@caldera.de> <Pine.LNX.4.30.0101091241490.2424-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101091241490.2424-100000@e2>; from mingo@elte.hu on Tue, Jan 09, 2001 at 01:04:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 09, 2001 at 01:04:49PM +0100, Ingo Molnar wrote:
> 
> On Tue, 9 Jan 2001, Christoph Hellwig wrote:
> 
> please study the networking portions of the zerocopy patch and you'll see
> why this is not desirable. An alloc_kiovec()/free_kiovec() is exactly the
> thing we cannot afford in a sendfile() operation. sendfile() is
> lightweight, the setup times of kiovecs are not.
> 
Right.  However, kiobufs can be kept around for as long as you want
and can be reused easily, and even if allocating and freeing them is
more work than you want, populating an existing kiobuf is _very_
cheap.

> another, more theoretical issue is that i think the kernel should not be
> littered with multi-page interfaces, we should keep the one "struct page *
> at a time" interfaces.

Bad bad bad.  We already have SCSI devices optimised for bandwidth
which don't approach decent performance until you are passing them 1MB
IOs, and even in networking the 1.5K packet limit kills us in some
cases and we need an interface capable of generating jumbograms.
Perhaps tcp can merge internal 4K requests, but if you're doing udp
jumbograms (or STP or VIA), you do need an interface which can give
the networking stack more than one page at once.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
