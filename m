Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWEJXl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWEJXl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbWEJXl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:41:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49565 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965051AbWEJXl2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:41:28 -0400
Date: Wed, 10 May 2006 16:38:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, pavel@suse.cz
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Message-Id: <20060510163833.586b93ce.akpm@osdl.org>
In-Reply-To: <200605110058.19458.rjw@sisk.pl>
References: <200605021200.37424.rjw@sisk.pl>
	<200605100015.53455.rjw@sisk.pl>
	<20060509152713.36bb94f0.akpm@osdl.org>
	<200605110058.19458.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Wednesday 10 May 2006 00:27, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > Now if the mapped pages that are not mapped by the
> > >  current task are considered, it turns out that they would change only if they
> > >  were reclaimed by try_to_free_pages().  Thus if we take them out of reach
> > >  of try_to_free_pages(), for example by (temporarily) moving them out of their
> > >  respective LRU lists after creating the image, we will be able to include them
> > >  in the image without copying.
> > 
> > I'm a bit curious about how this is true.  There are all sorts of way in
> > which there could be activity against these pages - interrupt-time
> > asynchronous network Tx completion, async interrupt-time direct-io
> > completion, tasklets, schedule_work(), etc, etc.
> 
> AFAIK, many of these things are waited for uninterruptibly, and uninterruptible
> tasks cannot be frozen.

There can be situations where we won't be waiting on this IO at all. 
Network zero-copy transmit, for example.

Or maybe there's some async writeback going on against pagecache - we'll
end up looking at the page's LRU state within interrupt context at IO
completion.  (A sync would prevent this from happening).

One possibly problematic scenario is where task A is doing a direct-IO read
and task B truncates the same file - here, the page will be actually
removed from the LRU and freed in interrupt context.  The direct-IO read
process will be waiting on the IO in D state though.  It it was a
synchronous read - if it was an AIO read then it won't be waiting on the
IO.  Something else might save us here, but it's fragile.

>  Theoretically we may have a problem if there's an
> interruptible task that waits for the completion of an operation that gets
> finished after snapshotting the system.  However that would have to survive the
> syncing of filesystems, freezing of kernel threads, freeing of memory as well
> as suspending and resuming all devices.  [In which case it would be starving
> to death. :-)]

hm.  It's all a bit of a worry.  I don't understand what swsusp is trying
to do here sufficiently well to be able to advise, sorry.  I was rather
surprised to learn that it's presently taking copies of all these pages...
