Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261626AbSIXJnG>; Tue, 24 Sep 2002 05:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSIXJnG>; Tue, 24 Sep 2002 05:43:06 -0400
Received: from angband.namesys.com ([212.16.7.85]:5769 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261626AbSIXJnD>; Tue, 24 Sep 2002 05:43:03 -0400
Date: Tue, 24 Sep 2002 13:48:16 +0400
From: Oleg Drokin <green@namesys.com>
To: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org,
       Hans Reiser <reiser@namesys.com>
Subject: Re: ReiserFS buglet
Message-ID: <20020924134816.A23185@namesys.com>
References: <20020924072455.GE2442@unthought.net> <20020924132110.A22362@namesys.com> <20020924092720.GF2442@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020924092720.GF2442@unthought.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Sep 24, 2002 at 11:27:20AM +0200, Jakob Oestergaard wrote:
> > > I would suggest replacing the '!=' with a '<' in the while loop and
> > > adding a sanity check afterwards.
> > What if overheated CPU will cause a bitflip exactly after such checks?
> > You cannot protect against broken hardware. Such problems should be
> > fixed by fsck.
> Disk errors are common. Software can also flip that bit.

Not only disk errors are common, but also CPU/memory/chipset/wiring errors are.

> > > As I see it, the ReiserFS journal has the same problems as jbd wrt. to
> > > atomicity of write operations of indexes.  Please see my recent mail
> > > about the jbd problems.
> > journal header in reiserfs only occupies first 20 bytes of the block,
> > since this fells within 1st 512 bytes hardware sector, it will be written
> > atomically, I presume.
> You presume wrong.

Oh, I missed your original email, thanks for noticing me.

> I posted to LKML about a month ago with some questions regarding exactly
> this issue.  I had a disk that worked on 128 byte atomic writes - a
> standard IDE disk.

Hm. This is still much larger than 20 bytes we use.

> The conclusion was something like "we know jack about the disk's
> internal logic" so we need consistency measures instead of relying on
> anything from the disk.

Actually we submit data to disk in 512 byte chunks (4k blocksize case),
and disk should not write any data before it receives all of it and
checks the integrity (hm, this is only true for UDMA, though.)
Still I do not see why any sane disk would start to write a sector before fully
receiving new sector's content (thinking of disk drives of course, solid state
stuff should take its own measures in this direction too).
This is even more insane than ACKing data and putting it in not battery
backed cache to be lost on power loss (Yes, I know this is a common
practice now. At least there is a way either to turn such feature off
or to flush a cache on demand).

Thanks for bringing our attention to such issues, though changing disk format
is our of questions for reiser3 now, some kind of verifying single instance
on-disk structures may/will be incorporated in reiser4.

Bye,
    Oleg
