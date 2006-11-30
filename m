Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933721AbWK3J6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933721AbWK3J6N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933753AbWK3J6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:58:13 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:19360 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S933721AbWK3J6L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:58:11 -0500
Date: Thu, 30 Nov 2006 10:57:10 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 1/5][AIO] - Rework compat_sys_io_submit
Message-ID: <20061130105710.572d3c6e@frecb000686>
In-Reply-To: <8BA392C6-FCCB-40BD-9CCF-3EF56C3491BD@oracle.com>
References: <20061129112441.745351c9@frecb000686>
	<20061129113212.1e614a61@frecb000686>
	<8BA392C6-FCCB-40BD-9CCF-3EF56C3491BD@oracle.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/11/2006 11:04:18,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/11/2006 11:04:21,
	Serialize complete at 30/11/2006 11:04:21
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 16:47:47 -0800, Zach Brown <zach.brown@oracle.com> wrote:

> On Nov 29, 2006, at 2:32 AM, Sébastien Dugué wrote:
> 
> >                  compat_sys_io_submit() cleanup
> >
> >
> >   Cleanup compat_sys_io_submit by duplicating some of the native  
> > syscall
> > logic in the compat layer and directly calling io_submit_one() instead
> > of fooling the syscall into thinking it is called from a native 64-bit
> > caller.
> >
> >   This is needed for the completion notification patch to avoid having
> > to rewrite each iocb on the caller stack for sys_io_submit() to  
> > find the
> > sigevents.
> 
> You could explicitly mention that this eliminates:
> 
>   - the overhead of copying nr pointers on the userspace caller's stack
> 
>   - the arbitrary PAGE_SIZE/(sizeof(void *)) limit on the number of  
> iocbs that can be submitted
> 
> Those alone make this worth merging.

  Right, will add.

> 
> > +	if (unlikely(!access_ok(VERIFY_READ, iocb, (nr * sizeof(u32)))))
> > +		return -EFAULT;
> 
> I'm glad you got that right :)  I no doubt would have initially  
> hoisted these little checks into a shared helper function and missed  
> that detail of getting the size of the access_ok() right in the  
> compat case.

  Thanks.

> 
> > +	put_ioctx(ctx);
> > +
> > +	return i? i: ret;
> 
> sys_io_getevents() reads:

 uh!     ^^^^^^^^^    you must be meaning sys_io_submit()?

> 
>          put_ioctx(ctx);
>          return i ? i : ret;
> 
> So while this compat_sys_io_submit() logic seems fine and I would be  
> comfortable with it landing as-is, I'd also appreciate it if we  
> didn't introduce differences between the two functions when it seems  
> just as easy to make them the same.  (That chunk is just one  
> example.  There's whitespace, missing unlikely()s, etc).
> 

  OK, will fix.

  Thanks,

  Sébastien.


  
