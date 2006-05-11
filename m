Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWEKNPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWEKNPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 09:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWEKNPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 09:15:50 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:18117 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751687AbWEKNPu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 09:15:50 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Date: Thu, 11 May 2006 15:15:48 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, pavel@suse.cz
References: <200605021200.37424.rjw@sisk.pl> <200605110058.19458.rjw@sisk.pl> <20060510163833.586b93ce.akpm@osdl.org>
In-Reply-To: <20060510163833.586b93ce.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605111515.49487.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 May 2006 01:38, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > On Wednesday 10 May 2006 00:27, Andrew Morton wrote:
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > >
> > > > Now if the mapped pages that are not mapped by the
> > > >  current task are considered, it turns out that they would change only if they
> > > >  were reclaimed by try_to_free_pages().  Thus if we take them out of reach
> > > >  of try_to_free_pages(), for example by (temporarily) moving them out of their
> > > >  respective LRU lists after creating the image, we will be able to include them
> > > >  in the image without copying.
> > > 
> > > I'm a bit curious about how this is true.  There are all sorts of way in
> > > which there could be activity against these pages - interrupt-time
> > > asynchronous network Tx completion, async interrupt-time direct-io
> > > completion, tasklets, schedule_work(), etc, etc.
> > 
> > AFAIK, many of these things are waited for uninterruptibly, and uninterruptible
> > tasks cannot be frozen.
> 
> There can be situations where we won't be waiting on this IO at all. 
> Network zero-copy transmit, for example.
> 
> Or maybe there's some async writeback going on against pagecache - we'll
> end up looking at the page's LRU state within interrupt context at IO
> completion.  (A sync would prevent this from happening).
> 
> One possibly problematic scenario is where task A is doing a direct-IO read
> and task B truncates the same file - here, the page will be actually
> removed from the LRU and freed in interrupt context.  The direct-IO read
> process will be waiting on the IO in D state though.  It it was a
> synchronous read - if it was an AIO read then it won't be waiting on the
> IO.  Something else might save us here, but it's fragile.

Yes, that's one situation to be considered in detail (which I evidently failed
to do :-().

I think the problem is whether any modification agains these pages can
be triggered from interrupt context _after_ we have snapshotted the system and
resumed devices (in order to write the image).

> >  Theoretically we may have a problem if there's an
> > interruptible task that waits for the completion of an operation that gets
> > finished after snapshotting the system.  However that would have to survive the
> > syncing of filesystems, freezing of kernel threads, freeing of memory as well
> > as suspending and resuming all devices.  [In which case it would be starving
> > to death. :-)]
> 
> hm.  It's all a bit of a worry.  I don't understand what swsusp is trying
> to do here sufficiently well to be able to advise, sorry.  I was rather
> surprised to learn that it's presently taking copies of all these pages...

Well, I'm trying to avoid copying every single page in the system in the
process of creating the snapshot image.  The idea behind the patch was
to select a susbset of pages that could be safely included in the image
without copying and such that we could identify them easily.  [The LRU
pages obviously come to mind here.]

Greetings,
Rafael
