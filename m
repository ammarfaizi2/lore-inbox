Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269076AbRHBTrs>; Thu, 2 Aug 2001 15:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269082AbRHBTri>; Thu, 2 Aug 2001 15:47:38 -0400
Received: from ntt-connection.daiwausa.com ([210.175.188.3]:28109 "EHLO
	ead42.ead.dsa.com") by vger.kernel.org with ESMTP
	id <S269076AbRHBTrc>; Thu, 2 Aug 2001 15:47:32 -0400
Date: Thu, 2 Aug 2001 15:47:18 -0400
From: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010802154718.A16494@ead45>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010801170230.B7053@redhat.com> <20010802110341.B17927@emma1.emma.line.org> <01080219261601.00440@starship> <20010802193750.B12425@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010802193750.B12425@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Thu, Aug 02, 2001 at 07:37:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 07:37:50PM +0200, Matthias Andree wrote:
> The other thing is, that Linux is the only known system that does
> asynchronous rename/link/unlink/symlink -- people have claimed it might
> not be the only one, but failed to name systems.
> 
> So we need to assume that Linux is the only system that does
> asynchronous rename/link/unlink/symlink, however a directory fsync() is
> believed to be rather expensive.
> 
> Still, some people object to a dirsync mount option. But this has been
> the actual reason for the thread - MTA authors are refusing to pamper
> Linux and use chattr +S instead which gives unnecessary (premature) sync
> operations on write() - but MTAs know how to fsync().

Let's inject a little reality into this discussion.  Filesystems are used
for something other than running MTA's written by stubborn "purists".

Solaris: Dell 600 MHz PIII 128MB RAM, largely quiescent:
         Solaris 8 mu4, UFS with logging

Linux:   VA Linux 800 MHZ PIII, 128MB RAM, largely quiescent
         RedHat Linux 7.1 w/ kernel-2.4.6-2.4 (2.4.6-ac5 + ext3-0.9.3).

660MB XFree86-4.1 build tree, cache primed with du -s in each case.

Here's something that we developers probably all do frequently: copy a
tree using hard links, so that we can patch it.

[solaris] find . | wc     
   33027   33027 1251671
[solaris] time find . -depth | cpio -pdul ../foo
0 blocks
 363.46s real    0.84s user   10.13s system 

Plain ext2:

[linux]# time find . -depth | cpio -pdul ../foo
0 blocks

real    0m3.823s user    0m0.240s sys     0m3.570s

Mounted ext3, ordered data mode.

[linux] time find . -depth | cpio -pdul ../foo
0 blocks

real    0m5.106s user    0m0.200s sys     0m3.700s

Mounted ext3, -o sync:

[root@ead51 bar]# time find . -depth | cpio -pdul ../foo
0 blocks

real    1m28.483s user    0m0.470s sys     0m4.410s 

=====================================================

Solaris8 UFS:   363.5 seconds
ext2:             3.8 seconds
ext3:             5.1 seconds
ext3 -o sync:    88.5 seconds

Got it?

Obviously, the last is the result of the poor interaction
of ext3+sync in 0.9.3, but Andrew Morton has already fixed that.
I will try again with 0.9.5 when I have a chance to upgrade that
machine.

I have no idea where BSD falls, but the basic point stands:  unused
features should not penalize other applications.  Andrew Morton has
figured out how to do this efficiently with ext3, and many kudos to him
for doing the work.  Absent that, why should I have to go get a cup of
coffee every time I want to patch a tree, just so some MTA can make
naive assumptions?

Regards,

   Bill Rugolsky
