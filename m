Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTBPX0E>; Sun, 16 Feb 2003 18:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbTBPX0E>; Sun, 16 Feb 2003 18:26:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4877 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263039AbTBPX0C>; Sun, 16 Feb 2003 18:26:02 -0500
Date: Sun, 16 Feb 2003 15:32:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Fw: 2.5.61 oops running SDET
In-Reply-To: <63040000.1045436929@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302161519450.3917-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Feb 2003, Martin J. Bligh wrote:
> 
> So what does protect sighand? tasklist_lock?

Yup. At least right now. And we do tend to hold tasklist_lock in most
cases simply by virtue of having to get it anyway in order to search for 
the process. 

>				It doesn't seem to
> as people do things like:
> 
> spin_unlock_irq(&current->sighand->siglock);
> 
> all the time ... so is it just protected by good faith and the direction
> of the wind?

Agreed.  That, and the fact that most of the time the stuff _is_ there:  
obviously any time the process looks at its own signals it will always be
there.

So we have two cases:
 - "normal" signal sending which holds tasklist_lock to find the target.
 - signals to the process itself, which is usually safe, since we know 
   we're there (the exception would be if/when taking a fault in the exit
   path, but even that might be ok since signals are torn down not by exit
   itself but by "release_task")

So the signal path may actually be ok.

		Linus

