Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757335AbWKWKTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757335AbWKWKTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757336AbWKWKTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:19:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757335AbWKWKTH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:19:07 -0500
Date: Thu, 23 Nov 2006 02:14:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?U+liYXN0aWVuIER1Z3Xp?= <sebastien.dugue@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 3/4][AIO] - AIO completion signal notification
Message-Id: <20061123021437.684d7c63.akpm@osdl.org>
In-Reply-To: <20061123104755.68561c66@frecb000686>
References: <20061120151700.4a4f9407@frecb000686>
	<20061120152252.7e5a4229@frecb000686>
	<20061121170228.4412b572.akpm@osdl.org>
	<20061123092805.1408b0c6@frecb000686>
	<20061123004053.76114a75.akpm@osdl.org>
	<20061123104755.68561c66@frecb000686>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 10:47:55 +0100
Sébastien Dugué <sebastien.dugue@bull.net> wrote:

> On Thu, 23 Nov 2006 00:40:53 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Thu, 23 Nov 2006 09:28:05 +0100
> > Sébastien Dugué <sebastien.dugue@bull.net> wrote:
> > 
> > > > > +	target = good_sigevent(&event);
> > > > > +
> > > > > +	if (unlikely(!target || (target->flags & PF_EXITING)))
> > > > > +		goto out_unlock;
> > > > > +
> > > > > +	
> > > > > +
> > > > > +	if (notify->notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID)) {
> > > > > +		/*
> > > > > +		 * This reference will be dropped in really_put_req() when
> > > > > +		 * we're done with the request.
> > > > > +		 */
> > > > > +		get_task_struct(target);
> > > > > +	}
> > > > 
> > > > It worries me that this function can save away a task_struct* without
> > > > having taken a reference against it.
> > > > 
> > > 
> > >   OK. Does moving 'notify->target = target;' after the get_task_struct() will
> > > do, or am I missing something more subtle?
> > 
> > Well it's your code - you tell me ;)
> > 
> > It is unsafe (and rather pointless) to be saving the address of some structure
> > which can be freed at any time.
> 
>   Sorry, I expressed myself quite badly. What I wanted to know is whether you
> are worried with the task been freed between saving its pointer and getting a
> ref on it (which is trivial to fix) or you are thinking of something deeper.
> 

Look:

> +	notify->target = target;
> +
> +	if (notify->notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID)) {
> +		/*
> +		 * This reference will be dropped in really_put_req() when
> +		 * we're done with the request.
> +		 */
> +		get_task_struct(target);

If that test fails, we've saved a pointer to the task_struct without having
taken a refreence on it.

