Return-Path: <linux-kernel-owner+w=401wt.eu-S1761294AbWLHXqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761294AbWLHXqK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 18:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761287AbWLHXqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:46:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52998 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761292AbWLHXqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:46:06 -0500
Date: Fri, 8 Dec 2006 15:45:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zach Brown <zach.brown@oracle.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jeff Dike <jdike@addtoit.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [PATCH RFC] use of activate_mm in fs/aio.c:use_mm()?
Message-Id: <20061208154522.a03bd90b.akpm@osdl.org>
In-Reply-To: <45777002.6050009@goop.org>
References: <45776D54.7030409@goop.org>
	<45777002.6050009@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2006 17:36:02 -0800
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Jeremy Fitzhardinge wrote:
> > I'm wondering if activate_mm() is the right thing to be using in
> > use_mm(); shouldn't this be switch_mm()?
> >
> > On normal x86, they're synonymous, but for the Xen patches I'm adding a
> > hook which assumes that activate_mm is only used the first time a new mm
> > is used after creation (I have another hook for dealing with dup_mm).  I
> > think this use of activate_mm() is the only place where it could be used
> > a second time on an mm.
> >
> > From a quick look at the other architectures I think this is OK (most
> > simply implement one in terms of the other), but some are doing some
> > subtly different stuff between the two.
> >
> > Thanks,
> >     J
> >
> >
> >   
> Er, lets try that again:
> 
> diff -r 455b71ed4525 fs/aio.c
> --- a/fs/aio.c	Wed Dec 06 13:16:42 2006 -0800
> +++ b/fs/aio.c	Wed Dec 06 17:17:43 2006 -0800
> @@ -588,7 +588,7 @@ static void use_mm(struct mm_struct *mm)
>  	 * Note that on UML this *requires* PF_BORROWED_MM to be set, otherwise
>  	 * it won't work. Update it accordingly if you change it here
>  	 */
> -	activate_mm(active_mm, mm);
> +	switch_mm(active_mm, mm, tsk);
>  	task_unlock(tsk);
>  
>  	mmdrop(active_mm);

That to me sounds like a reasonable description of the difference between
activate_mm() and switch_mm().  And the change appears reasonable as well.

But it is a change which the architecture maintainers would need to have a
think about, please.

