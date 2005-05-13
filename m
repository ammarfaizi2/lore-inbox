Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVEML25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVEML25 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 07:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVEML25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 07:28:57 -0400
Received: from smtpout.mac.com ([17.250.248.44]:21244 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261430AbVEML0X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 07:26:23 -0400
In-Reply-To: <20050513080137.GA9255@wohnheim.fh-wedel.de>
References: <20050509183135.GB27743@mary> <20050512121842.GA20388@wohnheim.fh-wedel.de> <20050512164413.GA14099@mary> <2F200E69-465D-46ED-9D3A-5ED5C9FEAC9A@mac.com> <20050513080137.GA9255@wohnheim.fh-wedel.de>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <7E4FD3AB-54F6-43D5-9340-ECEEA2E55C0B@mac.com>
Cc: Markus Klotzbuecher <mk@creamnet.de>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
Date: Fri, 13 May 2005 07:26:14 -0400
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 13, 2005, at 04:01:37, Jörn Engel wrote:
> Doesn't even have to be interruptable.

Well, I wrote in my first mail:

> On Thu, 12 May 2005 23:18:36 -0400, Kyle Moffett wrote:
>> 1) This system should be a first-class VFS element, IE: -o union  
>> should
>> work on all filesystems, regardless of feature support.

I'd like to have -o union work not just on ext2/3.  It could  
potentially be
very _slow_ on other filesystems, until they get nonresident file  
support,
but it would definitely need to be an interruptible page copy in that  
case.

> Your trick, if I understand it correctly, is to copy data up on a  
> block
> level, not on a file level.

Precisely.

>> That way, if I later unmounted the unioned ext3 fs and remounted it
>> elsewhere without the underlying storage, I would be able to  
>> access the
>> parts of the directory structure and files that are resident, and the
>> rest would fail with a new error code ENONRESIDENT or similar.
>
> ENONRESIDENT bugs me somehow.  I guess EIO would be quite sufficient.

Hmm.  Ideally a program like tar would be able to determine which  
pages of
a file are resident in memory and only store those.  How does this  
currently
work for sparse files?

> Maybe you also want a new incompatible fs flag, just to make sure old
> kernels without proper understanding don't mess up the fs.

Definitely.  You'd only need to set this if there were any  
nonresident files,
however, and those would probably only be created if you union  
mounted with
"-o nonres" or similar.

>> If they deleted /dev/hdb1, but still wanted whatever changes they had
>> made on /dev/hdb2, they could always get at them by remounting / 
>> dev/hdb2
>> somewhere _without_ "-o union", and use a modified tar to package  
>> up the
>> resident portions of files the same way it does for sparse files.
>> Naturally there would need to be a way to mark a sparse file's empty
>> spaces as nonresident if so desired when untarring.
>
> That's the old well-known (to some people) union-mount behaviour.

I'm just describing the whole idea in totality, so that everybody can  
get an
idea of what's going on.

> Really, your idea of a block (page, whatever) level granularity for
> copying data is nice.

I liked the idea of the existing linux sparse file support, so I  
based it off
that.

> It solves the biggest concern I had left for union mount.  Actually
> implementing it, though, depends on quite a bit of infrastructure  
> that just
> doesn't exist yet.  Still, a very interesting idea.

For ext2/ext3, the sparse-file-support _does_ exist, so the only  
major parts
that need to be added are:
     o An extra ext2/ext3 flag that indicates nonresidence (For both  
sparse
       files, normal files, and directories).
     o VFS-level support for the union operation with hooks to let each
       filesystem do something special.





Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



