Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbUCZEv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 23:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbUCZEv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 23:51:59 -0500
Received: from palrel10.hp.com ([156.153.255.245]:16347 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263932AbUCZEv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 23:51:57 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16483.46826.466847.77987@napali.hpl.hp.com>
Date: Thu, 25 Mar 2004 20:51:54 -0800
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
In-Reply-To: <20040326041926.GG8366@waste.org>
References: <20040325141923.7080c6f0.akpm@osdl.org>
	<20040325224726.GB8366@waste.org>
	<16483.35656.864787.827149@napali.hpl.hp.com>
	<20040325180014.29e40b65.akpm@osdl.org>
	<20040326041926.GG8366@waste.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 25 Mar 2004 22:19:26 -0600, Matt Mackall <mpm@selenic.com> said:

>  struct entropy_store {
> +	/* mostly-read data: */
> +	struct poolinfo poolinfo;
> +	__u32		*pool;
> +
> +	/* read-write data: */
> +	spinlock_t lock ____cacheline_aligned;
>  	unsigned	add_ptr;
>  	int		entropy_count;
>  	int		input_rotate;
> -	struct poolinfo poolinfo;
> -	__u32		*pool;
> -	spinlock_t lock;
>  };

  Matt> Also, I think in general we'd prefer to stick the aligned bit at the
  Matt> front of the structure rather than at the middle, as we'll avoid extra
  Matt> padding. The size of cachelines is getting rather obscene on some
  Matt> modern processors.

Not sharing the cacheline between the mostly-read data and the
read-write data is the _point_ of this change.  If you reverse the
order, the "poolinfo" and "pool" members will also get invalidated
whenever someone updates the write-intensive data.

	--david
