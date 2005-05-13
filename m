Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVEMDSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVEMDSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 23:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVEMDSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 23:18:51 -0400
Received: from smtpout.mac.com ([17.250.248.84]:65217 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262224AbVEMDSq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 23:18:46 -0400
In-Reply-To: <20050512164413.GA14099@mary>
References: <20050509183135.GB27743@mary> <20050512121842.GA20388@wohnheim.fh-wedel.de> <20050512164413.GA14099@mary>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <2F200E69-465D-46ED-9D3A-5ED5C9FEAC9A@mac.com>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
Date: Thu, 12 May 2005 23:18:36 -0400
To: Markus Klotzbuecher <mk@creamnet.de>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 12, 2005, at 12:44:13, Markus Klotzbuecher wrote:
> Hi Joern,
>
> On Thu, May 12, 2005 at 02:18:42PM +0200, Jörn Engel wrote:
>> Just out of curiosity: how do you perform the copy-up operation?
>> In-kernel copies of large files are a huge problem and for union- 
>> mount
>> purposes, I'm clueless about how to fix things.
>>
>
> Basically I open the source and the target file on the lower file
> systems for reading and writing respectively, then read and write page
> sized chunks of data until all has been copied. Obviously not ideal
> for large files, but I had no better idea so far.

I've been thinking about a "-o union" mount option for a while now, and
I had a couple ideas on this topic.

1) This system should be a first-class VFS element, IE: -o union should
work on all filesystems, regardless of feature support. (As long as you
can read/write from/to the unioned fs and read from the underlying fs)

2) When forced to copy data, the copy should be done in the context of
whatever process is doing the "write" operation, and be interruptible,
etc.  The end result is that if you union an nfs mount over another one,
it will just seem like a write to a big file takes a _really_ long time
to complete.

3) ext2/3 should get an extra flag for files and directories that
indicates nonresidence.  This would be used by the VFS union layer to
map existence/nonexistence to the unioned filesystem (If it's ext2/3).
That way, if I later unmounted the unioned ext3 fs and remounted it
elsewhere without the underlying storage, I would be able to access the
parts of the directory structure and files that are resident, and the
rest would fail with a new error code ENONRESIDENT or similar.

For example, if I have two ext3 filesystems on /dev/hdb1 and /dev/hdb2,
then I could do this:

mount -t ext3 -o ro /dev/hdb1 /mnt
mount -t ext3 -o rw,union /dev/hdb2 /mnt

The on-disk structures might look like this:

/dev/hdb1:
     foo/
         bar => blocks(1-4)
         baz => blocks(1-8)
     oof/
         xuuq => blocks(1-2)

/dev/hdb2:
     foo/
         bar => sparse,nonresident,blocks(2,4)
         baz => sparse,nonresident,blocks(1-4,9-12)
         quux => blocks(1-32)
     oof/ => nonresident
     mumble/
         grumble => blocks(1-4)

The resultant view to the user:

/mnt
     foo/
         bar => blocks(1-4)
         baz => blocks(1-12)
         quux => blocks(1-32)
     oof/
         xuuq => blocks(1-2)
     mumble/
         grumble => blocks(1-4)

If they deleted /dev/hdb1, but still wanted whatever changes they had
made on /dev/hdb2, they could always get at them by remounting /dev/hdb2
somewhere _without_ "-o union", and use a modified tar to package up the
resident portions of files the same way it does for sparse files.
Naturally there would need to be a way to mark a sparse file's empty
spaces as nonresident if so desired when untarring.


Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



