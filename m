Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSGCXzh>; Wed, 3 Jul 2002 19:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317282AbSGCXzg>; Wed, 3 Jul 2002 19:55:36 -0400
Received: from [24.114.147.133] ([24.114.147.133]:50307 "EHLO starship")
	by vger.kernel.org with ESMTP id <S317277AbSGCXze>;
	Wed, 3 Jul 2002 19:55:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Pavel Machek <pavel@ucw.cz>,
       "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
Date: Thu, 4 Jul 2002 01:46:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020702123718.A4711@redhat.com> <Pine.LNX.3.95.1020702075957.24872A-100000@chaos.analogic.com> <20020703034809.GI474@elf.ucw.cz>
In-Reply-To: <20020703034809.GI474@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17PtqU-0000RJ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 July 2002 05:48, Pavel Machek wrote:
> Hi!
> 
> Okay. So we want modules and want them unload. And we want it bugfree.
> 
> So... then its okay if module unload is *slow*, right?
> 
> I believe you can just freeze_processes(), unload module [now its
> safe, you *know* noone is using that module, because all processes are
> in your refrigerator], thaw_processes().
> 
> That's going to take *lot* of time, but should be very simple and very
> effective.

Hi Pavel,

Is it just the mod_dec_use_count; return/unload race we're worried about?  
I'm not clear on why this is hard.  I'd think it would be sufficient just to 
walk all runnable processes to ensure none has an execution address inside the
module.  For smp, an ipi would pick up the current process on each cpu.

At this point the use count must be zero and the module deregistered, so all 
we're interested in is that every process that dec'ed the module's use count 
has succeeded in executing its way out of the module.  If not, we try again 
later, or if we're impatient, also bump any processes still inside the module 
to the front of the run queue.

I'm sure I must have missed something.

-- 
Daniel
