Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268690AbTGIXiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268749AbTGIXfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:35:37 -0400
Received: from air-2.osdl.org ([65.172.181.6]:61829 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268745AbTGIXfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:35:12 -0400
Subject: Re: [PATCH libaio] add timeout to io_queue_run and remove
	io_queue_wait
From: Daniel McNeil <daniel@osdl.org>
To: John Myers <jgmyers@netscape.com>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F0C97C0.2060408@netscape.com>
References: <1057712224.11509.35.camel@dell_ss5.pdx.osdl.net> 
	<3F0C97C0.2060408@netscape.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Jul 2003 16:49:41 -0700
Message-Id: <1057794581.10851.66.camel@dell_ss5.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-09 at 15:31, John Myers wrote:
> Daniel McNeil wrote:
> 
> >Thoughts?
> >  
> >
> I don't think io_queue_run() is particularly worthwhile.  Applications 
> are much better off coding that loop themselves, so they can control 
> such things as how many events they ask for in a call to io_getevents() 
> and how they handle process shutdown.  Besides, io_queue_run()'s 
> handling of EINTR isn't particularly good.
> 
> io_queue_run() is basically for legacy apps.  Your patch changes its 
> signature, which breaks its only use.
> 

If any application is using io_queue_run()/io_queue_wait(), it is
wasting a bunch of cpu time because io_queue_wait() is never waiting.
So, yes, this would break any existing application which is using
the currently broken io_queue_wait().  Is there any "legacy" app using
this?  How long have the interfaces been around?

If io_queue_run()/io_queue_wait() isn't worthwhile, then it should be
removed.  If having a callback interface is worthwhile, I vote for
fixing it.  So the choices are:

1. patch kernel to get io_queue_wait() to actually wait. (see my earlier
   patch).

2. Change the libaio callback interfaces so that it blocks without
   patching the kernel.  (This patch does that).

3. remove io_queue_run()/io_queue_wait() if they are not worthwhile.

I agree that the io_getevents() is sufficient, but it doesn't hurt
having the callback interface (if it actually worked correctly).

Daniel

