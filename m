Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269249AbUHZRib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269249AbUHZRib (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269227AbUHZReN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:34:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:56283 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269269AbUHZR37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:29:59 -0400
Date: Thu, 26 Aug 2004 10:29:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       Alex Zarochentsev <zam@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826172029.GP5733@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0408261021250.2304@ppc970.osdl.org>
References: <20040825200859.GA16345@lst.de> <20040825203516.GB4688@backtop.namesys.com>
 <20040825205149.GA17654@lst.de> <412DA2CF.2030204@namesys.com>
 <20040826124119.GA431@lst.de> <20040826134812.GB5733@mail.shareable.org>
 <20040826155744.GA4250@lst.de> <20040826160638.GJ5733@mail.shareable.org>
 <20040826161303.GA4716@lst.de> <Pine.LNX.4.58.0408260919380.2304@ppc970.osdl.org>
 <20040826172029.GP5733@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Jamie Lokier wrote:
>
>     run_setuid_program
> 
>         -> calls pwd
>            pwd opens("."), (".."), ("../..") etc.

Ehh.. Not only does pwd not do that..

(hint: there's a getcwd() system call)

>         -> the setuid program thus ends up opening a device or fifo,
>            when it does pwd's path walk.  Yes it could use the getcwd
>            syscall, but some programs do their own path walk.

.. but even if it did that, it should use O_DIRECTORY when it did so. If 
it doesn't, it's broken.

So no, it would _not_ open the device or fifo when it did so.

The fact is, anything that expects to open a directory should already be 
opening it with O_DIRECTORY.

That said, ".." and "." are special already inside the kernel, and it 
migth be worth making them automatically imply O_DIRECTORY, since nothing 
else makes sense anyway. That would fix the case where somebody uses ".." 
_without_ using O_DIRECTORY. 

> It also fits the container idea very well:
> 
>         /dev/hda/part1/ <- the filesystem inside partition 1

I don't think you can do that. The kernel has no idea how to mount the
filesystem.

If it's already mounted somewhere else, that's a different issue.  
Although it might be mounted in several places (as a bind mount) with
different writability, I guess, so even then it might be "interesting".

		Linus
