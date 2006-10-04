Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030539AbWJDBPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbWJDBPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 21:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbWJDBPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 21:15:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35502 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030539AbWJDBPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 21:15:18 -0400
Date: Tue, 3 Oct 2006 18:14:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: tim.c.chen@linux.intel.com
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       leonid.i.ananiev@intel.com
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Message-Id: <20061003181452.778291fb.akpm@osdl.org>
In-Reply-To: <1159920569.8035.71.camel@localhost.localdomain>
References: <1159916644.8035.35.camel@localhost.localdomain>
	<20061003170705.6a75f4dd.akpm@osdl.org>
	<1159920569.8035.71.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2006 17:09:29 -0700
Tim Chen <tim.c.chen@linux.intel.com> wrote:

> On Tue, 2006-10-03 at 17:07 -0700, Andrew Morton wrote:
> 
> > 
> > Perhaps the `static int __warn_once' is getting put in the same cacheline
> > as some frequently-modified thing.   Perhaps try marking that as __read_mostly?
> > 
> 
> I've tried marking static int __warn_once as __read_mostly.  However, it
> did not help with reducing the cache miss :(
> 
> So I would suggest reversing the "Let WARN_ON/WARN_ON_ONCE return the
> condition" patch.  It has just been added 3 days ago so reversing it
> should not be a problem.
> 

Not yet, please.  This is presently a mystery, and we need to work out
what's going on.

First up, is it due to WARN_ON, or WARN_ON_ONCE?  Please try reverting each
one separately.

Let's look at WARN_ON.

Before:

#define WARN_ON(condition) do { \
	if (unlikely((condition)!=0)) { \
		printk("BUG: warning at %s:%d/%s()\n", __FILE__, __LINE__, __FUNCTION__); \
		dump_stack(); \
	} \
} while (0)

After:

#define WARN_ON(condition) ({						\
	typeof(condition) __ret_warn_on = (condition);			\
	if (unlikely(__ret_warn_on)) {					\
		printk("BUG: warning at %s:%d/%s()\n", __FILE__,	\
			__LINE__, __FUNCTION__);			\
		dump_stack();						\
	}								\
	unlikely(__ret_warn_on);					\
})

There's no difference, except we return the temporary. 


And WARN_ON_ONCE.

Before:

#define WARN_ON_ONCE(condition)				\
({							\
	static int __warn_once = 1;			\
	int __ret = 0;					\
							\
	if (unlikely((condition) && __warn_once)) {	\
		__warn_once = 0;			\
		WARN_ON(1);				\
		__ret = 1;				\
	}						\
	__ret;						\
})

After:

#define WARN_ON_ONCE(condition)	({			\
	static int __warn_once = 1;			\
	typeof(condition) __ret_warn_once = (condition);\
							\
	if (likely(__warn_once))			\
		if (WARN_ON(__ret_warn_once)) 		\
			__warn_once = 0;		\
	unlikely(__ret_warn_once);			\
})

There are changes here: in the old code we'll avoid reading the static
variable.  In the new code we'll read the static variable, but we'll avoid
evaluating the condition.

Why would that make a measurable difference?

Do you know which WARN_ON (or is it WARN_ON_ONCE?) callsite is causing a
problem?
