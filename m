Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315594AbSENKMO>; Tue, 14 May 2002 06:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315595AbSENKMN>; Tue, 14 May 2002 06:12:13 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:56808 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S315594AbSENKMM>; Tue, 14 May 2002 06:12:12 -0400
Message-ID: <3CE0E306.6171045B@ukaea.org.uk>
Date: Tue, 14 May 2002 11:12:22 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <3CE0DDBE.F9EC80AC@ukaea.org.uk> <3CE0D067.6010302@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> Uz.ytkownik Neil Conway napisa?:
> > The hwgroup was serialized so that in certain cases, it can contain BOTH
> > channels, and thus only one channel is active at a time (e.g. cmd640).
> > With this patch, you are now serializing only channels, not hwgroups
> > (which makes hwgroup totally redundant, yes?), and I can't see which bit
> > of your patch protects the chipsets that need both channels to be
> > serialized.
> >
> > I think I see where you're going with the cleanup (and this isn't
> > unrelated to the conversation about IDE-62) but as it stands, this patch
> > will IMHO totally fsck any machines with dodgy chipsets.
> 
> No it will not, since we act serialized on ide_lock anyway.
> However I have right now per channel (or serialization group)
> lock running right now / modulo locking order problems.

One of us is missing the point (and I'm the newbie so blame me ;-)), so
here goes:

Only the calls from the block layer to the request_fn are serialized by
ide_lock. Not the actual data transfers.  Here's the scenario: 

Firstly, an I/O request is queued by ide_do_request(), and then it
returns.  Let's assume that DMA is now in progress.  Once
ide_do_request() returns, the lock is released by the block layer.  Now
the corruption scenario: another request can come in for the other
channel while our first I/O is in flight, and since the ide_lock isn't
held, and the second channel isn't BUSY, ide_do_request() will be happy
to try and start an I/O on that channel too.  BOOM.

Or is there a dumb mistake in my logic?

Neil
PS: I appreciate that your code is in a transition phase but I think
it's desirable to avoid badly broken 2.5's all the same.
