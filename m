Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbUACTA6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 14:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUACTA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 14:00:58 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:54406 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263723AbUACTAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 14:00:55 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 3 Jan 2004 11:00:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <Pine.LNX.4.44.0401021919240.825-100000@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.44.0401031021280.1678-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jan 2004, Davide Libenzi wrote:

> On Sat, 3 Jan 2004, Rusty Russell wrote:
> 
> > In message <Pine.LNX.4.44.0401020856150.2278-100000@bigblue.dev.mdolabs.com> you write:
> > > Rusty, you still have to use global static data when there is no need.
> > 
> > And you're still putting obscure crap in the task struct when there's
> > no need.  Honestly, I'd be ashamed to post such a patch.
> 
> Ashamed !? Take a look at your original patch and then define shame. You 
> had a communication mechanism that whilst being a private 1<->1 
> communication among two tasks, relied on a single global message 
> strucure, lock and mutex. Honestly I do not like myself to add stuff 
> inside a strcture for one-time use. Not because of adding 12 bytes to the 
> struct, that are laughable. But because it is used by a small piece of 
> code w/out a re-use ability for other things.

Rusty, I took a better look at the patch and I think we can have 
per-kthread stuff w/out littering the task_struct and by making the thing 
more robust. We keep a global list_head protected by a global spinlock. We 
define a structure that contain all the per-kthread stuff we need 
(including a task_struct* to the kthread itself). When a kthread starts it 
will add itself to the list, and when it will die it will remove itself 
from the list. The start/stop functions will lookup the list (or hash, 
depending on how much stuff you want to drop in) with the target 
task_struct*, and if the lookup fails, it means the task already quit 
(another task already did kthread_stop() ??, natural death ????). This is 
too bad, but at least there won't be deadlock (or crash) beacause of this. 
This because currently we keep the kthread task_struct* lingering around 
w/out a method that willl inform us if the task goes away for some reason 
(so that we can avoid signaling it and waiting for some interaction). The 
list/hash will be able to tell us this. What do you think?




- Davide



