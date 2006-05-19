Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWESRpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWESRpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWESRpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:45:41 -0400
Received: from lea.cs.unibo.it ([130.136.1.101]:11242 "EHLO lea.cs.unibo.it")
	by vger.kernel.org with ESMTP id S1751043AbWESRpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:45:41 -0400
Date: Fri, 19 May 2006 19:45:34 +0200
To: Ulrich Drepper <drepper@gmail.com>, Andi Kleen <ak@suse.de>,
       osd@cs.unibo.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
Message-ID: <20060519174534.GA22346@cs.unibo.it>
References: <20060518155337.GA17498@cs.unibo.it> <20060518155848.GC17498@cs.unibo.it> <p73sln72im3.fsf@bragg.suse.de> <20060518211321.GC6806@cs.unibo.it> <a36005b50605181923k285b4d50y30d6b43baede95ca@mail.gmail.com> <20060519090726.GA11789@cs.unibo.it> <20060519130952.GA1242@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519130952.GA1242@nevyn.them.org>
User-Agent: Mutt/1.5.6+20040907i
From: renzo@cs.unibo.it (Renzo Davoli)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 09:09:52AM -0400, Daniel Jacobowitz wrote:
> On Fri, May 19, 2006 at 11:07:26AM +0200, Renzo Davoli wrote:
> > On Thu, May 18, 2006 at 07:23:13PM -0700, Ulrich Drepper wrote:
> > > On 5/18/06, Renzo Davoli <renzo@cs.unibo.it> wrote:
> > > >e.g. To virtualize a write you'd have to call PTRACE_PEEKDATA for each
> > > >word of the buffer, very many hundreds cycles lost.
> > > 
> > > No, this is not how programs should do it.  Just open /proc/PID/mem
> > > and use pread() with an offset corresponding to the address.  Now,
> > > repeat your timings using this technique.
> > 
> > That would be faster to access the memory but:
> > - the manager has to keep one open file per controlled process
> 
> No, it doesn't.  It can open it as needed.  It can even maintain a
> cache of open mem files.
> 
> GDB's been opening it as needed for years.  It works very well and is
> drastically faster than PTRACE_PEEKDATA.
> 
Over all I could speed up just half of the calls because I cannot write
in /proc/<pid>/mem !
You are proposing a solution which speeds up writes but not reads.

(from fs/proc/base.c)
#define mem_write NULL

#ifndef mem_write
/* This is a security hazard */
static ssize_t mem_write(struct file * file, const char * buf,
       size_t count, loff_t *ppos)
....
#endif

My proposals should not add any threats which is not already in 
PTRACE_POKEDATA. Now, either the threat do currently exist and my
proposed patch makes is exploitable in a faster way, or it did not
exist and it still does not exist.
PTRACE_MULTI just executes several ptrace requests in a single call.

Other projects would benefit from a similar patch:
see: www.cs.wisc.edu/condor/doc/parrot-agm2003.pdf 
http://www.cse.nd.edu/~dthain/papers/ibox-sc05.pdf
They had the very same problem.

	renzo
