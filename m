Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276761AbRJCRvo>; Wed, 3 Oct 2001 13:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276807AbRJCRve>; Wed, 3 Oct 2001 13:51:34 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:50952 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S276785AbRJCRvU>; Wed, 3 Oct 2001 13:51:20 -0400
Message-ID: <3BBB5005.65B1FCF5@zip.com.au>
Date: Wed, 03 Oct 2001 10:51:01 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ragnar =?iso-8859-1?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
CC: Dave Jones <davej@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?
In-Reply-To: <Pine.LNX.4.33L.0110030938130.4835-100000@imladris.rielhome.conectiva> <Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de>,
		<Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de>; from davej@suse.de on Wed, Oct 03, 2001 at 02:54:17PM +0200 <20011003150145.D8709@vestdata.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ragnar Kjørstad wrote:
> 
> On Wed, Oct 03, 2001 at 02:54:17PM +0200, Dave Jones wrote:
> > Alan mentioned this was something to do with the IBM hard disk
> > having strange write-cache properties that confuse ext3.
> > I'm not sure if this has been fixed or not yet, but its enough
> > to make me think twice about trying it on the vaio for a while.
> 
> If a disk is doing write-back caching, it's likely to break all
> journaling filesystem and anything else that relies on write ordering.

In theory, disk write caching can defeat ext3's ordering requirements.

However I have never observed this in practice, nor have I seen
any report of it happening.

Think about it: ext3 writes a chunk of blocks, waits on them,
then writes a single commit block and waits on that.  The "chunk"
of blocks are very probably contiguous on disk.  The commit block
will most probably be at the very next LBA afer the "chunk".

The only way in which the drive can cause corruption is for it to write the
commit block before the "chunk", and for you to lose power [*] within
that time window.  Unless some serious block remapping has occurred
at the physical level, I really can't see any reason why the disk
should choose to flush those blocks in the wrong order.  Nor do I see why
the disk should leave a large time window between flushing the commit
block and then flushing the "chunk".

So....  I wouldn't be too fussed about it, personally.  




[*] I think it has to be a power outage - a kernel crash won't be
enough - the disk should still flush its write cache.  I'm not sure
if hitting the front-panel reset button would prevent a disk from
flushing its cache?

-
