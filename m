Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262189AbSIZFTN>; Thu, 26 Sep 2002 01:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSIZFTN>; Thu, 26 Sep 2002 01:19:13 -0400
Received: from packet.digeo.com ([12.110.80.53]:36825 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262189AbSIZFTM>;
	Thu, 26 Sep 2002 01:19:12 -0400
Message-ID: <3D929A06.8D8C8AE0@digeo.com>
Date: Wed, 25 Sep 2002 22:24:22 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] prepare_to_wait/finish_wait sleep/wakeup API
References: <20020925.213427.116352583.davem@redhat.com> <Pine.LNX.4.44.0209252211280.1203-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 05:24:22.0548 (UTC) FILETIME=[F8AEA540:01C2651C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 25 Sep 2002, David S. Miller wrote:
> >
> > Ok, so if the condition retest fails at wakeup (someone got to the
> > event before us), it's ok because we add ourselves back to the wait
> > queue first, mark ourselves as sleeping, _then_ retest.
> 
> Right. The looping case (if somebody else was first) is slowed down
> marginally, but the common case is sped up and needs one less time through
> the waitqueue lock.
> 

Most of the gain I saw in Badari's profiles (dd to 60 disks) was
in fact in __wake_up.  60 tasks parked on a waitqueue, waiting
for memory to come clean, wakeups being delivered to them faster
than they can wake up and get off the queue.

Yeah, my code is bust ;)  The heavy __wake_up cost in there seems
to be specific to the profusion chipset, which is two quads joined
by wet string, but the principle still applies.

I expect a decent win would come from using this technique in
select/poll, but that code relies on the remains-on-the-waitqueue
semantics, and would need some fiddling.
