Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbUCNIQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 03:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263313AbUCNIQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 03:16:28 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:58532 "EHLO smtp02.uc3m.es")
	by vger.kernel.org with ESMTP id S263312AbUCNIQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 03:16:25 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200403140816.i2E8GN221049@oboe.it.uc3m.es>
Subject: removable media support removed in 2.6?
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Sun, 14 Mar 2004 09:16:23 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A quick search in the archives seems to indicate that something is
missing for removable media support. E.g.

  On Sun, 2003-08-31 at 19:17, Andrey Borzenkov wrote:
  > > For 2.5 this doesn't work anymore and whenever you want to mount > a Zip
  > > disk you need to boot Linux together with a Disk inside the Drive, so
  > > during boot it detects the Zip drive + the Disk.
  > 
  > yes devfs was castrated in 2.6 and removable media revalidation has been 
  > removed without providing any suitable replacement.

How does one deal with removable media?

I only ask because I have run out of things to try myself. The problem
I see is how to run an "invalidate_buffers" on a disappeared media.
Everything I've tried (2.6.3), from invalidate_bdev,
__invalidate_device, and so on bla has left the state somehow internally
confused to the point that accesses hang in a down on some semaphire,
even though I don't have a down in my own code.

But I could be confused about something else. Maybe the handling
mechanism has changed?

What I _thought_ one used to have to do was

   1) in any open() on my device, run check_disk_change()

   2) the latter will call my media_changed() function, which should
     return 0 for "it's still there" and 1 for "it's gone".

   3) when we reply "it's back", the kernel calls my media_revalidate()
     function, which should complete any internal driver resets and
     return 0.

None of the above includes any destruction of buffers on my part and
(probably/provably) works ok under 2.4. Yet it all goes horribly
pear-shaped under 2.6 in mysterious (to me) ways.

What's up? What should I be doing? The floppy driver seems to call
__invalidate_device() at various points, but I don't understand the
code much.

Which of the various invalidate functions should I be calling, if any?
What happens about rechecking the partition layout, for example?
Principally, I would just like cache and buffers to go away when the
device disappears.

And there seems to be a "negative cache" too. After getting the device
to error, the same read attempt errors again even when the device is
back. But a few inserts and removals stops the driver even from getting
any more requestts from the kernel. They sit somewhere.

Do I have to run the device request run/wait queue myself?

Clues welcomed. Please cc: me (usual reasons).

Peter

