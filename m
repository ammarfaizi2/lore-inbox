Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263548AbTEMWnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbTEMWm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:42:26 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:1271 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263548AbTEMWlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:41:44 -0400
Date: Tue, 13 May 2003 15:50:04 -0700
From: Andrew Morton <akpm@digeo.com>
To: trond.myklebust@fys.uio.no
Cc: dmccr@us.ibm.com, davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-Id: <20030513155004.294142af.akpm@digeo.com>
In-Reply-To: <16065.8979.48898.341246@charged.uio.no>
References: <20030512155417.67a9fdec.akpm@digeo.com>
	<20030512155511.21fb1652.akpm@digeo.com>
	<shswugvjcy9.fsf@charged.uio.no>
	<20030513135756.GA676@suse.de>
	<16065.3159.768256.81302@charged.uio.no>
	<20030513152228.GA4388@suse.de>
	<16065.4109.129542.777460@charged.uio.no>
	<20030513154741.GA4511@suse.de>
	<16065.5911.55131.430734@charged.uio.no>
	<20030513160948.GA6594@suse.de>
	<16065.7415.189762.803068@charged.uio.no>
	<79170000.1052844307@baldur.austin.ibm.com>
	<16065.8979.48898.341246@charged.uio.no>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 22:54:25.0653 (UTC) FILETIME=[9A0E4A50:01C319A2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> The dirty pages are failing to be written out because
> they've been swapped out. We then try to do an RPC call to the server
> to get it to truncate the file on its side.
> Meanwhile one or more of the swapped out pages are faulted in, and
> attempted written out. -> race...

These are file-backed pages: they don't get swapped out.  The VM will write
them out with ->writepage(), and will reclaim them when they are clean.

A filemap_fdatawait() will do the right thing with these pages: it'll wait
on them.

There is a weird race in there wrt ongoing pagefaults in the truncated
region, but they require two processes - one faulting, the other
truncating.  fsx-linux doesn't do that.

I'd need to see some more details on the code flow, including pointers to
the relevant code in the NFS client to understand this one please.

