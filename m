Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269182AbUHZQj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269182AbUHZQj0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269145AbUHZQhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:37:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:42161 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269182AbUHZQfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:35:55 -0400
Date: Thu, 26 Aug 2004 09:35:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@lst.de>
cc: Jamie Lokier <jamie@shareable.org>, Hans Reiser <reiser@namesys.com>,
       Alex Zarochentsev <zam@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826161303.GA4716@lst.de>
Message-ID: <Pine.LNX.4.58.0408260919380.2304@ppc970.osdl.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
 <20040825200859.GA16345@lst.de> <20040825203516.GB4688@backtop.namesys.com>
 <20040825205149.GA17654@lst.de> <412DA2CF.2030204@namesys.com>
 <20040826124119.GA431@lst.de> <20040826134812.GB5733@mail.shareable.org>
 <20040826155744.GA4250@lst.de> <20040826160638.GJ5733@mail.shareable.org>
 <20040826161303.GA4716@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Christoph Hellwig wrote:
>
> > Are you saying that with reiser4, you can open a device or fifo with
> > O_DIRECTORY?
> 
> That's what I thought, but as far as I can follow the code this is not
> actually true.

It should be possible to do, though. There's nothing really different in 
making the "default" (unnamed) fork be a special device or a fifo.

And it would be perfectly ok for O_DIRECTORY to open such a file, as long
as it opens the directory branch, not the special device.

I advocated (long ago) something like this for /dev handling, just because
I think it would make sense to have

	/dev/hda	<- special file
	/dev/hda/part1	<- partition 1 (aka /dev/hda1)

which just seems like a very obvious and intuitive interface to me. Of 
course, we have so much legacy in /dev that there's no real point to doing 
this, but it's still an appealing approach, I think.

But I do take Al's concerns seriously. I like the notion of supporting
"containers", but there are undoubtedly serious issues in the notion. I
don't strictly know exactly _how_ to implement it sanely (I can talk about
using the vfsmnt structure all I like, but the fact is, it's a different
thing from a normal mount, and there may be serious problems indeed
there).

Still, I really do like the idea of merging the notion of file and
directory into one notion of "container". I absolutely _detest_ files with
internal structure that tools have to know about (ie I hate seeing all
those embedded formats that I can't use "grep" on - MIME being one case).
I'd much rather see a "group of files"  and a "file with a grouping of
information".

(Now, flattening that "group of files" is obviously needed for serial 
protocols, so I think MIME/tar/xxxx are fine for _transporting_ data, but 
I'm saying that outside of transport I really prefer a "collection of 
files" approach).

		Linus
