Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132054AbRC1A0e>; Tue, 27 Mar 2001 19:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132063AbRC1A0Y>; Tue, 27 Mar 2001 19:26:24 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:32781 "EHLO neon-gw.transmeta.com") by vger.kernel.org with ESMTP id <S132054AbRC1A0P>; Tue, 27 Mar 2001 19:26:15 -0500
Date: Tue, 27 Mar 2001 16:24:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>, <tytso@MIT.EDU>
Subject: Re: Larger dev_t
In-Reply-To: <3AC12C12.D86312D7@transmeta.com>
Message-ID: <Pine.LNX.4.31.0103271612370.25282-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Mar 2001, H. Peter Anvin wrote:
>
> They would still have to change, since now we'd have to worry about
> /dev/hd* having changed meanings;

This is why I'd select the SCSI major, which has always had more of a
"random disk" connotation, with fewer people being aware of the fact that
it's specifically IDE.

>			 also, you now cannot create a
> backward-compatible /dev since /dev/hdc is (22,0), etc, in the current
> scheme.  The SCSI scheme is also not acceptable; it has been a
> long-standing problem that it doesn't allow enough partitions per disk.

Note that neither of these are really problematic, for the simple reason
that once you do mapping, the m:n mapping pretty much automatically falls
out of this. It's actually hard to think of a mapping that wouldn't allow
multiple major numbers to be mapped to the same devices (and in different
ways).

For example, it is not hard at all to have a IDE disk show up in three
places: the traditional /dev/hdx place, as /dev/sdx (the SCSI CD-ROM
emulation already ends up doing this, I think) _and_ potentially as a "new
and improved" non-backwards-compatibility place which would be /dev/diskx
and would take advantage of the larger minor number space.

For example, it would probably not be a bad idea to have something
explicitly in "high" major number space that would be something like

	/dev/disk<n>p<m>

where <n> would be the disk number, and <m> would be the partition number,
and just map it to <major=256>, <minor=(n<<8)+m>. Old installers would
still see the device, but couldn't access more than 15/63 partitions (for
SCSI/IDE numbering respectively).

And the thing is, this would not complicate the mapping. The only worry
would be one of virtual aliases, but kdev_t should pretty much take care
of that.

So while we probably eventually want to switch everything over to a new
"disk n"  numbering scheme, but for backwards compatibility reasons the
old numbers won't go away (and knowing how some people work and administer
their sites, they'll stay with us for a _loong_ time and will need to be
supported even with new drivers that don't actually share any code with
"IDE" or "SCSI").

So the IDE/SCSI numbers will have to stay. And they'll have to be
considered "supported", not just "old compatibility stuff that new drivers
don't have to care about". But done right, none of this will be _visible_
to drivers, so it should not add any ugliness. It shouldn't even be
visible to the mapping layer, except as yet another mapping (that just
happens to alias with other mappings).

		Linus

