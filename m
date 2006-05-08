Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWEHVOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWEHVOq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWEHVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 17:14:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2985 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750841AbWEHVOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 17:14:45 -0400
Date: Mon, 8 May 2006 14:17:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: balbir@in.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch 1/8] Setup
Message-Id: <20060508141713.60c9d33e.akpm@osdl.org>
In-Reply-To: <20060502061255.GL13962@in.ibm.com>
References: <20060502061255.GL13962@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <balbir@in.ibm.com> wrote:
>
>  /*
> + * sub = end - start, in normalized form
> + */
> +static inline void timespec_sub(struct timespec *start, struct timespec *end,
> +				struct timespec *sub)
> +{
> +	set_normalized_timespec(sub, end->tv_sec - start->tv_sec,
> +				end->tv_nsec - start->tv_nsec);
> +}

The interface might not be right here.

- I think "lhs" and "rhs" would be better names than "start" and "end". 
  After all, we don't _know_ that the caller is using the two times as a
  start and an end.  The caller might be taking the difference between two
  differences, for example.

- The existing timespec and timeval funtions tend to do return-by-value. 
  So this would become

	static inline struct timespec timespec_sub(struct timespec lhs,
							struct timespec rhs)

  (and given that it's inlined, the added overhead of passing the
  arguments by value will be zero)

- If we don't want to do that then at least let's get the arguments in a
  sane order:

	static inline void timespec_sub(struct timespec *result,
				struct timespec lhs, struct timespec rhs)


