Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317173AbSEXPBw>; Fri, 24 May 2002 11:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317174AbSEXPBv>; Fri, 24 May 2002 11:01:51 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:37818 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317173AbSEXPBt>; Fri, 24 May 2002 11:01:49 -0400
Date: Fri, 24 May 2002 10:01:33 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>, <akpm@zip.com.au>
Subject: Re: [PATCH] XBUG(comment) BUG enhancement
In-Reply-To: <E17B7Z0-0003cP-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0205240944010.9499-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2002, Rusty Russell wrote:

> D: Introduces XBUG(comment) and XBUG_ON(comment) macros to PPC and
> D: i386.  XBUG prints out module (usually same as objfile without the
> D: .o) and the comment.
> D: 
> D: It also changes every BUG() in the headers files to XBUG(), so that
> D: the headers don't include absolute filenames, which allows the
> D: kernel compile to use ccache much better.

Just to mention an alternative (I think BUG() is actually designed to be 
easy to put in without bothering about writing some explanatory text), I 
think the main reason why this is introduced is ccache.

For people who don't know it, ccache(.samba.org) is a program which will 
cache the results from previous compiles and just copy the object file 
when command line and preprocessed input stayed the same. It immensely 
speeds up compiles when you're compiling the same tree twice with only 
minor changes, and it's particularly useful for people having multiple 
trees around, which only differ in patches they're working on. (As people 
who're using bk tend to do, for example)

Well, the last point is actually the issue this is all about. Since 
the BUG()'s in the headers will put the full path into the preprocessed 
file, ccache will have lots of cache misses, only due to this changed 
string.

There's basically two ways around this:
o Remove the __FILE__ in BUG() in headers, which Rusty's patch
  does
o Make sure that the __FILE__ does not contain absolute paths.

I have a patch which does the later, it replaces

	-I/home/kai/kernel/v2.5/linux-2.5.make-work/include
with
	-I../../include

(with the right number of '../')

With that patch you'd get
	
	"BUG in ../../include/linux/foo.h:234"

Now, I can't claim that's all that nice, but I think the previous full 
path was ugly, too (and we're talking about BUG() here, anyway).

I should mention that there's also another possibility, which actually 
looks nicer, but is a bit harder to implement:

Call gcc from $(TOPDIR), so it's always "-Iinclude", and you get

	"BUG in include/linux/foo.h:234".

That, BTW, has also the advantage of getting 
	
	"BUG in fs/hfs/inode.c:123"

instead of the current

	"BUG in inode.c:123"

Actually, I would think the last approach is the cleanest, so if there's 
interest in it, I can code it up.

--Kai


