Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317301AbSGDA5h>; Wed, 3 Jul 2002 20:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317303AbSGDA5h>; Wed, 3 Jul 2002 20:57:37 -0400
Received: from [24.114.147.133] ([24.114.147.133]:15748 "EHLO starship")
	by vger.kernel.org with ESMTP id <S317301AbSGDA5g>;
	Wed, 3 Jul 2002 20:57:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: pmenage@ensim.com
Subject: Re: simple handling of module removals Re: [OKS] Module removal
Date: Thu, 4 Jul 2002 02:59:09 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17PuV9-0006iy-00@pmenage-dt.ensim.com>
In-Reply-To: <E17PuV9-0006iy-00@pmenage-dt.ensim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Puxv-0000UW-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 July 2002 02:29, pmenage@ensim.com wrote:
> In article <0C01A29FBAE24448A792F5C68F5EA47D2B0A8A@nasdaq.ms.ensim.com>,
> you write:
> >
> >Is it just the mod_dec_use_count; return/unload race we're worried about? 
> >>I'm not clear on why this is hard.  I'd think it would be sufficient just to 
> >walk all runnable processes to ensure none has an execution address inside
> >the module.  For smp, an ipi would pick up the current process on each cpu.
> >
> >At this point the use count must be zero and the module deregistered, so
> >all we're interested in is that every process that dec'ed the module's use
> >count has succeeded in executing its way out of the module.  If not, we try
> >again later, or if we're impatient, also bump any processes still inside the
> >module to the front of the run queue.
> >
> >I'm sure I must have missed something.
> 
> Identifying the valid execution address in a stack traceback isn't
> possible on many architectures (in particular, i386 without debugging
> support enabled) so this wouldn't work if one of the functions had
> called into a function outside the module.

I'm only thinking about the current execution address, and am only
concerned with the handful of instructions between the dec and the
ret.  But I did miss something all right: I'd assumed we somehow
magically wrap all exported functions in inc/dec, which on closer
inspection, isn't the case.

> On the other hand, if it was made a rule that any code in a module that
> might theoretically be running without reference counts wasn't allowed
> to call out of the module (or maybe was allowed to call out to a very
> specific small set of library functions that were known to the module
> system), then something like this might work.

That seems like a reasonable rule to make.  This, along with the
execution address inspection, would give us a way of declaring
certain modules 'remove clean'.  Module removal is just too nice a
feature to give up on so easily.

What else did I miss?

-- 
Daniel
