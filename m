Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVHCDvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVHCDvQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 23:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVHCDvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 23:51:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29837 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262010AbVHCDvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 23:51:14 -0400
Date: Wed, 3 Aug 2005 11:56:18 +0800
From: David Teigland <teigland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050803035618.GB9812@redhat.com>
References: <20050802071828.GA11217@redhat.com> <1122968724.3247.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122968724.3247.22.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 09:45:24AM +0200, Arjan van de Ven wrote:

> * The on disk structures are defined in terms of uint32_t and friends,
> which are NOT endian neutral. Why are they not le32/be32 and thus
> endian-defined? Did you run bitwise-sparse on GFS yet ?

GFS has had proper endian handling for many years, it's still correct as
far as we've been able to test.  I ran bitwise-sparse yesterday and didn't
find anything alarming.

> * None of your on disk structures are packet. Are you sure?

Quite, particular attention has been paid to aligning the structure
fields, you'll find "pad" fields throughout.  We'll write a quick test to
verify that packing doesn't change anything.

> +#define gfs2_16_to_cpu be16_to_cpu
> +#define gfs2_32_to_cpu be32_to_cpu
> +#define gfs2_64_to_cpu be64_to_cpu
> 
> why this pointless abstracting?

#ifdef GFS2_ENDIAN_BIG

#define gfs2_16_to_cpu be16_to_cpu
#define gfs2_32_to_cpu be32_to_cpu
#define gfs2_64_to_cpu be64_to_cpu

#define cpu_to_gfs2_16 cpu_to_be16
#define cpu_to_gfs2_32 cpu_to_be32
#define cpu_to_gfs2_64 cpu_to_be64

#else /* GFS2_ENDIAN_BIG */

#define gfs2_16_to_cpu le16_to_cpu
#define gfs2_32_to_cpu le32_to_cpu
#define gfs2_64_to_cpu le64_to_cpu

#define cpu_to_gfs2_16 cpu_to_le16
#define cpu_to_gfs2_32 cpu_to_le32
#define cpu_to_gfs2_64 cpu_to_le64

#endif /* GFS2_ENDIAN_BIG */

The point is you can define GFS2_ENDIAN_BIG to compile gfs to be BE
on-disk instead of LE which is another useful way to verify endian
correctness.

You should be able to use gfs in mixed architecture and mixed endian
clusters.  We don't have a mixed endian cluster to test, though.

> * +static const uint32_t crc_32_tab[] = .....
> why do you duplicate this? The kernel has a perfectly good set of generic
> crc32 tables/functions just fine

We'll try them, they'll probably do fine.

> * Why use your own journalling layer and not say ... jbd ?

Here's an analysis of three approaches to cluster-fs journaling and their
pros/cons (including using jbd):  http://tinyurl.com/7sbqq

> * +	while (!kthread_should_stop()) {
> +		gfs2_scand_internal(sdp);
> +
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(gfs2_tune_get(sdp, gt_scand_secs) * HZ);
> +	}
> 
> you probably really want to check for signals if you do interruptible sleeps

I don't know why we'd be interested in signals here.

> * why not use msleep() and friends instead of schedule_timeout(), you're
> not using the complex variants anyway

When unmounting we really appreciate waking up more often than the
timeout, otherwise the unmount sits and waits for the longest daemon's
msleep to complete.  I converted this to msleep recently but it was too
painful and had to go back.

We'll get to your other comments, thanks.
Dave

