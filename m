Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283006AbRLORz4>; Sat, 15 Dec 2001 12:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282941AbRLORzr>; Sat, 15 Dec 2001 12:55:47 -0500
Received: from zeus.kernel.org ([204.152.189.113]:14818 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S282907AbRLORzg>;
	Sat, 15 Dec 2001 12:55:36 -0500
Date: Sat, 15 Dec 2001 18:50:10 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: <mingo@elte.hu>
Cc: bcrl@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] mempool-2.5.1-D2
Message-Id: <20011215185010.74837327.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0112150653310.22818-100000@localhost.localdomain>
In-Reply-To: <20011214172728.B26535@redhat.com>
	<Pine.LNX.4.33.0112150653310.22818-100000@localhost.localdomain>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001 07:41:12 +0100 (CET)
Ingo Molnar <mingo@elte.hu> wrote:

>  - mempool_alloc(), if called from a process context, never fails. This
>    simplifies lowlevel IO code (which often must not fail) visibly.

Uh, do you trust your own word? This already sounds like an upcoming deadlock
to me _now_. I saw a lot of try-and-error during the last month regarding
exactly this point. There have been VM-days where allocs didn't really fail
(set with right flags), but didn't come back either. And exactly this was the
reason why the stuff was _broken_. Obviously no process can wait a indefinitely
long time to get its alloc fulfilled. And there are conditions under heavy load
where this cannot be met, and you will see complete stall.

In fact I pretty much agree to Ben's thesis that the current allocator has a
problem. I would not call it broken, but it cannot present the ad-hoc answer to
one (_the_) important question: what is the correct cache page to drop _now_
when resources get low and I have to successfully return an allocation?
This is _the_ central issue that must be solved in a VM with such a tremendous
page caching going on like we have now. And really important is the fact the
answer must be presentable ad-hoc. If you have to loop around, wait for I/O or
whatever, then the basic design is already sub-optimal. 
Looking at your mempool-ideas one cannot fight the impression that you try to
"patch" around a deficiency of the current code. This cannot be the right thing
to do.

Regards,
Stephan


