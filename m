Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935031AbWK2Leh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935031AbWK2Leh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 06:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935091AbWK2Leh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 06:34:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32134 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935031AbWK2Leg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 06:34:36 -0500
Date: Wed, 29 Nov 2006 06:33:35 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Sebastian Dugue <sebastien.dugue@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 4/5][AIO] - AIO completion signal notification
Message-ID: <20061129113335.GJ6570@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20061129112441.745351c9@frecb000686> <20061129113301.74a66c91@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129113301.74a66c91@frecb000686>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 11:33:01AM +0100, S?bastien Dugu? wrote:
>                       AIO completion signal notification
> 
>   The current 2.6 kernel does not support notification of user space via
> an RT signal upon an asynchronous IO completion. The POSIX specification
> states that when an AIO request completes, a signal can be delivered to
> the application as notification.
> 
>   This patch adds a struct sigevent *aio_sigeventp to the iocb.
> The relevant fields (pid, signal number and value) are stored in the kiocb
> for use when the request completes.
> 
>   That sigevent structure is filled by the application as part of the AIO
> request preparation. Upon request completion, the kernel notifies the
> application using those sigevent parameters. If SIGEV_NONE has been specified,
> then the old behaviour is retained and the application must rely on polling
> the completion queue using io_getevents().

Well, from what I see applications must rely on polling the completion
queue using io_getevents() in any case, isn't that the only way how to free
the kernel resources associated with the AIO request, even if it uses
SIGEV_SIGNAL or thread notification?  aio_error/aio_return/aio_suspend
will still need to io_getevents, the only important difference with this
patch is that a) the polling doesn't need to be asynchronous (i.e. have
a special thread which just loops doing io_getevents)
b) it doesn't need to care about notification itself.

	Jakub
