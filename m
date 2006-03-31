Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWCaRQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWCaRQc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWCaRQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:16:32 -0500
Received: from mail.parknet.jp ([210.171.160.80]:44295 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1750729AbWCaRQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:16:31 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andi Kleen <ak@suse.de>
Cc: Jes Sorensen <jes@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] avoid unaligned access when accessing poll stack
References: <yq0sloytyj5.fsf@jaguar.mkp.net>
	<87irpupo3y.fsf@duaron.myhome.or.jp> <200603311853.32870.ak@suse.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 01 Apr 2006 02:16:25 +0900
In-Reply-To: <200603311853.32870.ak@suse.de> (Andi Kleen's message of "Fri, 31 Mar 2006 18:53:32 +0200")
Message-ID: <87ek0ipmae.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Friday 31 March 2006 18:37, OGAWA Hirofumi wrote:
>> Jes Sorensen <jes@sgi.com> writes:
>> 
>> >   	struct poll_list *walk;
>> >  	struct fdtable *fdt;
>> >  	int max_fdset;
>> > -	/* Allocate small arguments on the stack to save memory and be faster */
>> > -	char stack_pps[POLL_STACK_ALLOC];
>> > +	/* Allocate small arguments on the stack to save memory and be 
>> > +	   faster - use long to make sure the buffer is aligned properly
>> > +	   on 64 bit archs to avoid unaligned access */
>> > +	long stack_pps[POLL_STACK_ALLOC/sizeof(long)];
>> >  	struct poll_list *stack_pp = NULL;
>> 
>> struct poll_list stack_pps[POLL_STACK_ALLOC / sizeof(struct poll_list)];
>> 
>> is more readable, and probably gcc align it rightly?
>
> Yes, but it would be wrong

OK. So how about this?

	char stack_pps[POLL_STACK_ALLOC]
        	__attribute__((aligned (sizeof(struct poll_list))));
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
