Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265579AbTF2FuS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 01:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbTF2FuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 01:50:18 -0400
Received: from pop.gmx.net ([213.165.64.20]:59593 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265579AbTF2FuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 01:50:12 -0400
Message-Id: <5.2.0.9.2.20030628175043.00cf1e20@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sun, 29 Jun 2003 08:08:31 +0200
To: Helge Hafting <helgehaf@aitel.hist.no>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: O(1) scheduler & interactivity improvements
Cc: Bill Davidsen <davidsen@tmr.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030628143432.GA7986@hh.idb.hist.no>
References: <5.2.0.9.2.20030628064029.00cfa800@pop.gmx.net>
 <5.2.0.9.2.20030627110106.00cf6068@pop.gmx.net>
 <5.2.0.9.2.20030628064029.00cfa800@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:34 PM 6/28/2003 +0200, Helge Hafting wrote:
>On Sat, Jun 28, 2003 at 07:44:26AM +0200, Mike Galbraith wrote:
>[...]
> >
> > I'm no clean freak, but fiddling with scheduling information all over the
> > place seems like a very bad idea. (before anyone says it, yes, we fiddle
> > with state all over the place;)  I can imagine doing something dirty in
> > driver code for specific cases (kdb/mouse are always interactivity
> > indicators), but not in generic code.
> >
> > Besides, the logical bindings for foo | bar | ... | baz do not exist in 
> the
> > kernel.  The kernel knows and cares only that single entities are using
> > open/read/write/close primitives.
>
>Data is moved from one process to the next, so the logical binding
>exists.  It may exist only for the duration of the write & read
>calls, but that is enough for this purpose.

I don't think it is enough, and regarding logical binding, we're talking 
past each other.

>Info about the data being transferred (address, amount) must exist somewhere,
>or data written to pipes would be lost.  This is updated when
>someone writes into a pipe.  The kernel could, during the write call,
>transfer some interactvity bonus (if any) and store it along with
>the other information about the pipe.

Well, yes, you can make a bucket to attach something to the data.  What are 
you going to attach to the data of irman's two completely independent pipe 
rings that is going to prevent either one or the total of the irman process 
from eating 100% cpu while I'm trying to login?  See what I mean?  When I 
say logical binding, I mean an information bucket that the system can look 
at and determine that process irman has had enough for now, and process 
mikie_logs_is needs a shot of cpu, or process threaded application A vs 
process monolithic application B.

It doesn't really matter that we're talking past each other though.  IMHO, 
the idea of spreading scheduling information around is at best horribly 
ugly, and the idea of a process context is at best horribly 
impractical.  I'd stamp a 0xdeadbeef on both ;-)

>The pipe read call would simply grab any transferred bonus and
>add it to the reader's interactivity bonus.  This should only be
>a few integer operations on either end of the pipe.
>The io boost calculated for disk/device operations surely amounts to some
>code too. It don't mess with every wakeup imaginable, this is specific to
>pipes.

However, I don't think that priority inflation is specific to pipes.

>  > This is why I said I could _imagine_ a
> > process struct... as the container for this missing (it lives in userland)
> > information.
> >
> > Another besides:  it makes zero difference it you add overhead to wakeup
> > time or go to sleep time.  If it's something you do a lot of, adding
> > overhead to it is going to hurt a lot.
> >
>No doubt about that.  Transferring an extra int per pipe read/write
>is overhead, I hope the data part of the transfer typically is much
>bigger than that.

True.

         -Mike 

