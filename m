Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSGIQzX>; Tue, 9 Jul 2002 12:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSGIQzW>; Tue, 9 Jul 2002 12:55:22 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:13324 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S315379AbSGIQzV>; Tue, 9 Jul 2002 12:55:21 -0400
Date: Tue, 9 Jul 2002 17:57:54 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Enhanced profiling support (was Re: vm lock contention reduction)
Message-ID: <20020709165754.GA96901@compsoc.man.ac.uk>
References: <20020708113928.GA80073@compsoc.man.ac.uk> <Pine.LNX.4.44.0207081039390.2921-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207081039390.2921-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2002 at 10:52:36AM -0700, Linus Torvalds wrote:

>  - I'd associate each profiling event with a dentry/offset pair, simply
>    because that's the highest-level thing that the kernel knows about and
>    that is "static".

This makes sense, I think.

>  - I'd suggest that the profiler explicitly mark the dentries it wants
>    profiled, so that the kernel can throw away events that we're not
>    interested in. The marking function would return a cookie to user
>    space, and increment the dentry count (along with setting the
>    "profile" flag in the dentry)

For a system-wide profiler, this needs to be /all/ dentries that get
mapped in with executable permissions, or we lose any mappings of shared
libraries we don't know about etc. Essentially, oprofile wants samples
against any dentry that gets mmap()ed with PROT_EXEC, so this marking
would really need to happen at mmap() time. Missing out on any dentry
profiles amounts to data loss in the system profile and has the
potential to mislead.

>  - the "cookie" (which would most easily just be the kernel address of the
>    dentry) would be the thing that we give to user-space (along with
>    offset) on profile read. The user app can turn it back into a filename.
> 
> Whether it is the original "mark this file for profiling" phase that saves
> away the cookie<->filename association, or whether we also have a system
> call for "return the path of this cookie", I don't much care about.
> Details, details.
> 
> Anyway, what would be the preferred interface from user level?

oprofile currently receives eip-pid pairs, along with the necessary
syscall tracing info needed to reconstruct file offsets. The above
scheme removes the dependency on the pid, but this also unfortunately
throws away some useful information.

It is often useful to be able to separate out shared-library samples on
a per-process (and/or per-application) basis. Any really useful profile
buffer facility really needs to preserve this info, but just including
the raw pid isn't going to work when user-space can't reconstruct the
"name" of the pid (where "name" would be something "/bin/bash") because
the process exited in the meantime.

The same goes for kernel samples that happen in process context.

So this might work well in tandem with some global process-tree tracing
scheme, but I don't know what form that might take ...

(Then there are kernel modules, but that's probably best served by
patching modutils)

regards
john
