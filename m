Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTJAX3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 19:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbTJAX3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 19:29:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:32931 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262787AbTJAX3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 19:29:33 -0400
Date: Wed, 1 Oct 2003 16:29:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Minutes from 10/1 LSE Call
Message-Id: <20031001162916.5fc2241b.akpm@osdl.org>
In-Reply-To: <37940000.1065035945@w-hlinder>
References: <37940000.1065035945@w-hlinder>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder <hannal@us.ibm.com> wrote:
>
> In mainline, once block size is over 32k our throuput actually drops off.
> It levels off around 128k but at a greater cpu utilization.
> Dont really understand why that is. 

Probably thrashing the CPU's L1 cache.

> In mm tree, maintains throughput for all block size but the cpu utilzation
> keeps going up to do the same throughput.  Readprofile shows the extra time 
> is being spent in copy_to_user (in mm tree). Backing out readahead patch 
> reduces cpu by 10% for all block sizes but still shows the spike. So that
> isnt the main problem.

If you have a loop like:

	char *buf;

	for (lots) {
		read(fd, buf, size);
	}


the optimum value of `size' is small: as little as 8k.  Once `size' gets
close to half the size of the L1 cache you end up pushing the memory at
`buf' out of CPU cache all the time.

