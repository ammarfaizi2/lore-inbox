Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbWF2Ge4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWF2Ge4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 02:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWF2Ge4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 02:34:56 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:56533 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932664AbWF2Gez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 02:34:55 -0400
Date: Thu, 29 Jun 2006 02:34:53 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Greg Bledsoe <greg.bledsoe@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: pmap, smap, process memory utilization
In-Reply-To: <dba10b900606280855g6d415441y92c46ca83c74a469@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0606290220220.19156@gandalf.stny.rr.com>
References: <dba10b900606271140o64b60c97kecb8177f801ff9f4@mail.gmail.com> 
 <Pine.LNX.4.58.0606280511320.32286@gandalf.stny.rr.com>
 <dba10b900606280855g6d415441y92c46ca83c74a469@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Jun 2006, Greg Bledsoe wrote:

>
> Thank you.  This information is extremely difficult to find without
> digging into kernel code, which I certainly wish I had time to do, but
> don't, and particulars of how many aspects of memory management happen
> seems to be nonexistant.  I would like to document this aspect, at
> least, as well as I am able and post somewhere to add to the worlds'
> global knowledge pool on this subject, and prevent the lkml from
> getting bugged about this anymore.

The problem you will find with any document of this kind is that the
kernel is constantly changing.  Who's going to keep the document up
to date?

>
> This leads me to the question though, of how the kernel keeps track of
> this information overall to report accurately via free and vmstat.

free reads /proc/meminfo which your can see how this is done from
linux-2.6.17/fs/proc/proc_misc.c: meminfo_read_proc

vmstat gets its info from /proc/stat and you can see how that is done
from linux-2.6.17/fs/proc/proc_misc.c: show_stat

> Does it just keep an overall count on the fly as memory is allocated?

Yes and this is not process specific, but low level from any allocation.

> And, getting ahead of myself, if that can be done, is it just
> considered too expensive to keep a similar acount for each proccess?

What do you really want to know?  A process is abstract.  It's memory
can be physical, shared, a file or in swap. Its memory may not even be
allocated until it actually tries to use it.  So what exactly do you
need?

I'm bringing this up because too many managers want this information
and they don't know why.  Why do they want to know how much memory a
process is using?  Is it to see if it has a memory leak?  Is it just
to know how much it uses? If that is the case, then the virtual map
from /proc/PID/maps should be a good way to know.  It shows the shared
libraries, so you can take that into account.  And all the other memory
it maps has the potential to be real.  Otherwise, why would it map it?

Chances are, a process  wont use all the memory shown in maps, but
if you are afraid of running out of memory, then take the conservative
approach and give that answer.

> That seems to be what I am hearing in previous lkml discussions.
>
> Also, since it seems virtually impossible to get this data on a
> per-process basis, does smap suffer from these same difficulties, as
> it seems to calculate this information when asked, and not keep it
> from process start time.

I don't know anything about smap.

-- Steve

