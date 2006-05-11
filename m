Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWEKMLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWEKMLK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 08:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWEKMLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 08:11:10 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:40132 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751273AbWEKMLI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 08:11:08 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Date: Thu, 11 May 2006 14:10:50 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
References: <200605021200.37424.rjw@sisk.pl> <200605110058.19458.rjw@sisk.pl> <20060511113519.GB27638@elf.ucw.cz>
In-Reply-To: <20060511113519.GB27638@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605111410.51952.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 May 2006 13:35, Pavel Machek wrote:
> On Čt 11-05-06 00:58:18, Rafael J. Wysocki wrote:
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
> > AFAIK, many of these things are waited for uninterruptibly, and
> > uninterruptible
> 
> Well, "many of these things" makes me nervous.
> 
> > tasks cannot be frozen.  Theoretically we may have a problem if there's an
> > interruptible task that waits for the completion of an operation that gets
> > finished after snapshotting the system.  
> 
> I'd prefer not to have even theoretical problems. If we don't _know_
> why patch is safe, I'd prefer not to have it.

OK (still I think I'll be able to provide some more precise arguments for it,
but I'll need some more time).

> Needing bdev freezing is bad sign, too.

Well, acutually we should understand why it helps I think, which makes it
interesting anyway, because in theory even without the patch we may be
vulnerable to a leftover "completion" that causes data to be written to a
storage.

> We are talking 10% speedup here (on low-mem-machines, IIRC), but whole
> design has just got way more complex. Previous snapshot was really
> atomic, and apart from NMI, it was "independend" from the rest of the
> system.
> 
> New design depends on bdev freezing (depending on XFS details we do
> not understand), and depends on all the other parts of kernel using
> uninteruptible (when we know that networking sleeps interruptibly).
> 
> Too much uncertainity for 10% speedup, I'm afraid. Yes, it was really
> clever to get this fundamental change down to few hundred lines,

:-)

> but design complexity remains. Could we drop that patch?

Yes, Andrew please drop it.

[Nonetheless I'd appreciate it if someone could suggest a specific failing
scenario to me.]

Greetings,
Rafael
