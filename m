Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVKPRtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVKPRtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVKPRtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:49:15 -0500
Received: from silver.veritas.com ([143.127.12.111]:22120 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030286AbVKPRtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:49:14 -0500
Date: Wed, 16 Nov 2005 17:47:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>
cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Junichi Uekawa <dancer@netfort.gr.jp>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Michael Krufky <mkrufky@m1k.net>,
       linux-kernel@vger.kernel.org, debian-amd64@lists.debian.org
Subject: Re: [x86_64] 2.6.14-git13 mplayer fails with "v4l2: ioctl queue
 buffer failed: Bad address" (2 Nov 2005, 11 Nov 2005)
In-Reply-To: <1132145454.12638.8.camel@t94>
Message-ID: <Pine.LNX.4.61.0511161735260.11170@goblin.wat.veritas.com>
References: <87fyqeicge.dancerj%dancer@netfort.gr.jp> 
 <87wtjg5gh2.dancerj%dancer@netfort.gr.jp> <4373D087.5050908@linuxtv.org> 
 <87psp859sd.dancerj%dancer@netfort.gr.jp> <43740F06.6030504@m1k.net> 
 <87y83vl780.dancerj%dancer@netfort.gr.jp>  <87ek5nb9ec.dancerj%dancer@netfort.gr.jp>
  <Pine.LNX.4.61.0511111355080.16161@goblin.wat.veritas.com> 
 <1131834172.8368.6.camel@localhost.localdomain>  <20051113025417.GN5706@mea-ext.zmailer.org>
 <1132145454.12638.8.camel@t94>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Nov 2005 17:49:14.0479 (UTC) FILETIME=[0EF55FF0:01C5EAD6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2005, Nickolay V. Shmyrev wrote:
> 
> It's sad, but I still don't understand the way it should be fixed.
> Removal of VM_RESERVED is certainly not a solution, since we don't going
> to swap mmaped pages and VM_RESERVED is used in other drivers (for
> example, some sound drivers)

Early in this thread (last Friday) I said that I was working on
the fix for this and some other PageReserved removal problems.

I suggested then:
Though if you're curious and impatient, you could try just editing
the " | VM_RESERVED" out of mm/memory.c get_user_pages.

Does that not work for you?  It's not the full solution to all the
issues, but I'd expect it to be enough to get you going.  If it does
not work for you, then I need to understand why not in a hurry:
please let me know either way.

I'm at last getting near with my patches, hope to post later tonight
(but everything always takes me longer than I expect).

> So, we need to find the problem itself. After looking at the code I've
> found that the x86_64 dependency of that problem lies in the check in
> memory.c:get_user_pages
> 
> if (vma && in_gate_area (task, start))
> 
> x86_64 defines it's own arch-dependant function in_gate_area which fails
> in our case.

Why would you expect "in_gate_area" to pass in your case?  I'd be very
surprised if the user pages you're trying to get are in the gate area.
I doubt that has anything to do with it: please try what I suggested.

Hugh

> Can someone trace that code and find why do we fail and
> fail only on x86_64. It would be nice if someone could point me to
> get_user_pages documentation, why it's so differently behaves for 64 bit
> arch.
> 
> Also it seems that I had traces of video-buf module with debug enabled
> on 64 bit, but lost them. Can someone just enable debug option to video-
> buf module and collect those traces.
