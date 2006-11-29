Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935553AbWK2NZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935553AbWK2NZO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935555AbWK2NZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:25:14 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:25285 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S935553AbWK2NZL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:25:11 -0500
Date: Wed, 29 Nov 2006 14:25:16 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 4/5][AIO] - AIO completion signal notification
Message-ID: <20061129142516.58eb38df@frecb000686>
In-Reply-To: <20061129113335.GJ6570@devserv.devel.redhat.com>
References: <20061129112441.745351c9@frecb000686>
	<20061129113301.74a66c91@frecb000686>
	<20061129113335.GJ6570@devserv.devel.redhat.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 14:32:21,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 14:32:23,
	Serialize complete at 29/11/2006 14:32:23
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 06:33:35 -0500, Jakub Jelinek <jakub@redhat.com> wrote:

> On Wed, Nov 29, 2006 at 11:33:01AM +0100, S?bastien Dugu? wrote:
> >                       AIO completion signal notification
> > 
> >   The current 2.6 kernel does not support notification of user space via
> > an RT signal upon an asynchronous IO completion. The POSIX specification
> > states that when an AIO request completes, a signal can be delivered to
> > the application as notification.
> > 
> >   This patch adds a struct sigevent *aio_sigeventp to the iocb.
> > The relevant fields (pid, signal number and value) are stored in the kiocb
> > for use when the request completes.
> > 
> >   That sigevent structure is filled by the application as part of the AIO
> > request preparation. Upon request completion, the kernel notifies the
> > application using those sigevent parameters. If SIGEV_NONE has been specified,
> > then the old behaviour is retained and the application must rely on polling
> > the completion queue using io_getevents().
> 
> Well, from what I see applications must rely on polling the completion
> queue using io_getevents() in any case, isn't that the only way how to free
> the kernel resources associated with the AIO request, even if it uses
> SIGEV_SIGNAL or thread notification?

  Well, applications do not need to do any polling on the queue anymore.
io_getevents() needs to be called only once when the signal has been received,
either from a signal handler or from a thread blocking on the signal.

> aio_error/aio_return/aio_suspend
> will still need to io_getevents,

  Right, but only once.

> the only important difference with this
> patch is that a) the polling doesn't need to be asynchronous (i.e. have
> a special thread which just loops doing io_getevents)

  Yes, no more polling loop and I think this makes a big difference.

> b) it doesn't need to care about notification itself.
> 

  Uh! what do you mean here?

  Sébastien.
