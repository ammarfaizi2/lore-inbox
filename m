Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319126AbSIDLAh>; Wed, 4 Sep 2002 07:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319127AbSIDLAh>; Wed, 4 Sep 2002 07:00:37 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:10922 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S319126AbSIDLAg>; Wed, 4 Sep 2002 07:00:36 -0400
Date: Wed, 4 Sep 2002 12:05:04 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Alexander Viro <viro@math.psu.edu>, Xavier Bestel <xavier.bestel@free.fr>,
       david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <200209040902.g84927L29020@oboe.it.uc3m.es>
Message-ID: <Pine.SOL.3.96.1020904114744.27919B-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2002, Peter T. Breuer wrote:
> I suggest that changing FS structure is an operation that is so
> relatively rare  in the projected environment (in which gigabytes of
> /data/ are streaming through every second) that you can make them as
> expensive as you like and nobody will notice. Your frothing at the
> mouth about it isn't going to change that. Moreover, _opening_
> a file is a rare operation too, relative to all that data thruput.

Sorry but this really shows you lack of understanding for how a file
system works. Every time you write a single byte(!!!) to a file, this
involves modifying fs structures. Even if you do writes in 1MiB chunks,
what happens is that all the writes are broken down into buffer head sized
portions for the purposes of mapping them to disk (this is optimized by
the get_blocks interface but still it means that every time get_blocks is
involved you have to do a full lookup of the logical block and map it to
an on disk block). For reading while you are not modifying fs structures
you still need to read and parse them for each get_blocks call.

This in turn means that each call to get_blocks within the direct_IO code
paths will result in a full block lookup in the filesystem driver.

I explained in a previous post how incredibly expensive that is.

So even though you are streaming GiB of /data/ you will end up streaming
TiB of /metadata/ for each GiB of /data/. Is that so difficult to
understand?

Unless you allow the FS to cache the /metadata/ you have already lost all
your performance and you will never be able to stream at the speads you
require.

So far you are completely ignoring my comments. Is that because you see
they are true and cannot come up with a counter argument?

> Anyone ever tell you that you have an insight problem?  You are
> evaluating the sistuation using the wrong objective functions as a
> metric. Don't use your metric, use the one appropriate to the
> situation. Nobody could care less how long it takes to open a file
> or do a mkdir, and even if they did care it would take exactly as long
> as it does on my 486 right now, which doesn't scare the pants off me.

We do care about such things a lot! What you are saying is true in you
extremely specialised scientific application. In normal usage patterns
file creation, etc, are crucially important to be fast. For example file
servers, email servers, etc create/delete huge amounts of files per
second. 

> What we/I want is a simple way to put whatever FS we want on a shared
> remote resource. It doesn't matter if you think it's going to be slow
> in some aspects, it'll be fast enough, because those aspects merely
> have to be correct, not fast.

Well normal users care about fast, sorry. Nobody will agree to making the
generic kernel cater for your specialised application which will be used
on a few systems on the planet when you would penalize 99.99999% of Linux
users with your solution.

The only viable solution which can enter the generic kernel is to
implement what you suggest at the FS level, not the VFS/block layer
levels.

Of course if you intend to maintain your solution outside the kernel as a
patch of some description until the end of time then that's fine. It is
irrelevant what solution you choose and noone will complain as you are not
trying to force it onto anyone else.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

