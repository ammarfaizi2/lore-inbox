Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268776AbUJPQ2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268776AbUJPQ2q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 12:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268728AbUJPQ2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 12:28:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:153 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268776AbUJPQ2n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 12:28:43 -0400
Date: Sat, 16 Oct 2004 17:28:36 +0100
From: Joel Becker <jlbec@evilplan.org>
To: Avi Kivity <avi@exanet.com>
Cc: Yasushi Saito <ysaito@hpl.hp.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com,
       Janet Morgan <janetmor@us.ibm.com>
Subject: Re: [PATCH 1/2]  aio: add vectored I/O support
Message-ID: <20041016162836.GG17142@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Avi Kivity <avi@exanet.com>, Yasushi Saito <ysaito@hpl.hp.com>,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org,
	suparna@in.ibm.com, Janet Morgan <janetmor@us.ibm.com>
References: <416EDD19.3010200@hpl.hp.com> <20041016031301.GC17142@parcelfarce.linux.theplanet.co.uk> <4170AF35.7030806@exanet.com> <20041016053721.GD17142@parcelfarce.linux.theplanet.co.uk> <4170DF18.50004@exanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4170DF18.50004@exanet.com>
User-Agent: Mutt/1.4.1i
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 10:43:04AM +0200, Avi Kivity wrote:
> Using IO_CMD_READ for a vector entails
> 
> - converting the userspace structure (which might well an iovec) to iocbs

	Why create an iov if you don't need to?

> - merging the iocbs

	I don't see how this is different than merging iovs.  Whether an
I/O range is represented by two segments of an iov or by two iocbs, the
elevator is going to merge them.  If the userspace program had the
knowledge to merge them up front, it should have submitted one larger
segment.

> - generating multiple completions for the merged request

	Fair enough.

> - coalescing the multiple completions in userspace to a single completion

	You generally have to do this anyway.  In fact, it is often far
more efficient and performant to have a pattern of:

	submit 10;
	reap 3; submit 3 more;
	reap 6; submit 6 more;
	repeat until you are done;

than to wait on all 10 before you can submit 10 again.

> error handling is difficult as well. one would expect that a bad sector 
> with multiple iocbs would only fail one of the requests. it seems to be 
> non-trivial to implement this correctly.

	I don't follow this.  If you mean that you want all io from
later segments in an iov to fail if one segment has a bad sector, I
don't know that we can enforce it without running one segment at a
time.  That's terribly slow.
	Again, even if READV is a good idea, we need to fix whatever
inefficiencies io_submit() has.  copying to/from userspace just can't be
that slow.

Joel

-- 

"When choosing between two evils, I always like to try the one
 I've never tried before."
        - Mae West

			http://www.jlbec.org/
			jlbec@evilplan.org
