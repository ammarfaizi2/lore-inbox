Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbULVQOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbULVQOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 11:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbULVQOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 11:14:12 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:49284 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262007AbULVQOF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 11:14:05 -0500
From: David Brownell <david-b@pacbell.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] USB: fix Scheduling while atomic warning when resuming.
Date: Wed, 22 Dec 2004 08:14:17 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
References: <200412220103.iBM13wS0002158@hera.kernel.org> <200412212059.15426.david-b@pacbell.net> <41C905C0.9000705@pobox.com>
In-Reply-To: <41C905C0.9000705@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412220814.17414.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 December 2004 9:27 pm, Jeff Garzik wrote:
> > There's no guarantee that suspend() and resume() methods
> > are only called during system-wide suspend and resume.
> 
> That is precisely the reason why I am concerned.  If it was only during 
> system-wide resume, the impact of the very-long mdelay() would be more 
> difficult to notice.
> 
> You also ignored my question :)

I didn't ignore it; I answered it with a question!  If you had
answered mine, you'd have had the answer to yours ... :)

One way another task can be active during resume is with sysfs:
"echo -n 0 > /sys/devices/.../power/state", after similar selective
suspend of the device.  That's uncommon for now, primarily useful
for unit-testing driver suspend/resume.  Plus, its design is
currently borked; the pm core code doesn't bother to suspend
children of the device first.  But I do expect that selective
suspend/resume should work in Linux; it's not reasonable to design
the pm framework otherwise.

But in any case, while it'd be difficult to notice that mdelay()
in current systems (since selective suspend/resume is still rare)
it'd clearly be wrong to assume that resume() methods don't need
to have mutual exclusion during their critical sections.


> If the PCI layer is calling the resume method for a PCI device while 
> simultaneously calling the suspend method, that's a PCI layer problem.

I never suggested such a scenario.  Though that would be another
case where such critical sections matter, like the remove() method.


> Similarly, If the USB layer is calling into your driver while you are 
> resuming, something is broken and it ain't your locking.

Which gets back to the question I asked you:  if not the lock in
question, what's ensuring that everything behaves right?

As I said originally, I don't much like long udelays, but
at least it's clearly correct in terms of mutual exclusion.
You've not shown any solution that's equivalently correct.

- Dave
