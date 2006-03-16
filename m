Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbWCPA6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbWCPA6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 19:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWCPA6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 19:58:48 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:60889 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S932637AbWCPA6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 19:58:47 -0500
Message-ID: <4418B843.3050800@namesys.com>
Date: Wed, 15 Mar 2006 16:58:43 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Andreas_Sch=E4fer?= <gentryx@gmx.de>
CC: reiserfs-list@namesys.com, Nate Diller <ndiller@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: 4k at a time only works well for an OS that does less per iteration
 than Linux does
References: <3aa654a40603140241s5d8a7430j6bf29a5ef7dd1bf5@mail.gmail.com> <1142336718.7415.55.camel@tribesman.namesys.com> <194f62550603140732j6ef10757j@mail.gmail.com> <4417BEC4.6060506@namesys.com> <20060315085745.GA21609@wintermute> <44185CEC.3010103@namesys.com> <20060315192730.GA11927@wintermute>
In-Reply-To: <20060315192730.GA11927@wintermute>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To sum up for akpm what was said previously in this thread:

Linux needs to take the lesson learned from bios about how going up and
down through various software layers once per 4k is too expensive, and
generalize it to where in general, in all of the layers, we are
operating many pages at a time.  It would be nice for code simplicity if
the same struct, with perhaps some optional attachments to it, was used
the whole trip (rather than pagevecs in once place and bios in another). 

For kernel newbies on lkml let me summarize it as for every trip made
through these layers, a whole lot more than 4k of code gets traversed,
all of it seeming to have some legitimate purpose;-), so only handling
4k per trip is more expensive than you might guess.

Now, for the question that was raised:

Andreas Schäfer wrote:

>On 10:29 Wed 15 Mar     , Hans Reiser wrote:
>  
>
>>Tell the mosix guys we would be willing to cooperate with them regarding
>>their problem.
>>    
>>
>
>If it was that easy... The problem for openMosix is that most devices
>fetch data in 4k blocks via copy_from_user(). For migrated processes,
>openMosix intercepts these calls and forwards them to the node which
>currently hosts the process. This forwarding yields a high latency
>penalty.
>
>Obviously there are two ways to get rid of this problem: 
>
>* modify _every_ Linux device driver to use a
>  _a_lot_more_than_4k_at_a_time_ approach or
>  
>
I suspect that if the code benefitted more than mosix in its
implementation, and I think it would, then akpm might not be opposed to
the one above provided someone wrote it.  There is a rumor he already
understands this is a problem.  Maybe he can comment on the rumor.;-)

>* implement a second "read ahead" buffer which fetches large blocks via
>  the network in the background and answers calls to copy_from_user()
>  directly from the local buffer
>
>In my _very_ humble opinion the first approach would be much nicer,
>but after you guys had so many trouble with just your filesystem, I
>don't see that one coming, not at all.
>
>So I think the long term strategy for oM will the second, double
>buffering approach. At least I couldn't think of any other realistic,
>feasible way.
>
>BTW: how are you guys planning to solve this 4k issue? Will you revert
>to small blocks 
>
not sure what that means.  You mean surrender?  Not yet.;-)  First we
fix our code so that reiser4 really does what I am arguing it needs to
do, then we will argue it is the right approach.

>or will you "pretend" to perform 4k transfers and
>assemble those in the background to, again, process large chunks at
>once? 
>
Oh is that ugly....  no.  Dynamically sized pagevecs (I call them
pagezams) are better.

We will process things in large chunks all the way down to the io layer,
and then wait for Nate or others to fix the io layer someday.

>If yes, wouldn't this seriously increase CPU usage due to
>(most likely) unnecessary data duplication?
>
>Regards
>-Andreas
>
>
>  
>

