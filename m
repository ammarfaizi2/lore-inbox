Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbUCBPCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbUCBPCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:02:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9639 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261665AbUCBPCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:02:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16452.41462.168143.57921@neuro.alephnull.com>
Date: Tue, 2 Mar 2004 10:02:14 -0500
From: Rik Faith <faith@redhat.com>
To: Olaf Kirch <okir@suse.de>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Light-weight Auditing Framework
In-Reply-To: [Rik Faith <faith@redhat.com>] Tue  2 Mar 2004 06:09:09 -0500
References: <16451.25789.72815.763592@neuro.alephnull.com>
	<20040301194501.A9080@infradead.org>
	<16451.40189.997259.379123@neuro.alephnull.com>
	<20040302094438.GA13735@suse.de>
	<16452.27477.406689.897618@neuro.alephnull.com>
X-Key: 7EB57214; 958B 394D AD29 257E 553F  E7C7 9F67 4BE0 7EB5 7214
X-Url: http://www.redhat.com/
X-Mailer: VM 7.17; XEmacs 21.4; Linux 2.4.22-1.2163.nptl (neuro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue  2 Mar 2004 06:09:09 -0500, Rik Faith <faith@redhat.com> wrote:
> On Tue  2 Mar 2004 10:44:38 +0100, Olaf Kirch <okir@suse.de> wrote:
> > A better approach may be to have the kernel write audit records
> > directly to the audit trail; this solves both the record loss issue
> > and improves performance.
> 
> This seems like it would solve several problems.  I'll have to think
> about it more.  (You still have to worry about what happens when the
> drive is too slow for the message rate, how to detect this, and,
> perhaps, how to limit its impact on systems where reliable delivery of
> messages is not absolutely critical.  With netlink, these worries are
> easy to deal with.)

OK, I've thought about this more.  I can appreciate the argument that
writing directly to disk avoids the performance impact of having a
user-space daemon write to disk (e.g., scheduling and, possibly, extra
copies).  However, I do not believe this addresses the fundamental
problem and, because of the nature of the problem, I do not believe the
performance improvement will be observed in all cases.  Let me explain.

CPUs can generate audit records magnitudes of order faster than they can
be written to disk.  Further, the production is non-uniform.  Because
this problem involves a bursty producer and a slow consumer, I view it
as a queuing problem.  Writing directly to disk makes the consumer
marginally faster, but it does not change the fundamental relationships
in the problem -- the consumer is still magnitudes of order slower than
the producer.  This means that, even though the direct-write consumer is
faster, the speed of the whole queue hasn't changed much, if at all.

Further, I am concerned that using direct writes instead of netlink
moves hard problems from one (simple, flexibly) layer to another (more
complex, less flexible) layer.  For example, the file system may have
already made some decisions for you that you could have made differently
if you had access to information about the netlink-managed queue.


