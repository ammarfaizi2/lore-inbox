Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265729AbSKAUMC>; Fri, 1 Nov 2002 15:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265730AbSKAUMC>; Fri, 1 Nov 2002 15:12:02 -0500
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:56391 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S265729AbSKAUL5>; Fri, 1 Nov 2002 15:11:57 -0500
Date: Fri, 1 Nov 2002 12:22:37 -0800 (PST)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Joel Becker <Joel.Becker@oracle.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bill Davidsen <davidsen@tmr.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0211011107470.4673-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211011205330.26575-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Linus Torvalds wrote:
|>Alan isn't worried about the "which sector do I write" kind of thing.  
|>That's the trivial part. Alan is worried about the fact that once you know
|>which sector to write, actually _doing_ so is a really hard thing. You
|>have bounce buffers, you have exceedingly complex drivers that work
|>differently in PIO and DMA modes and are more likely than not the _cause_
|>of a number of problems etc.

[ preamble - this is only a technical discussion, I'm interested
  in feedback on what we can improve upon ]

I agree with you.  We'd prefer to have a better low-level driver
primitive sitting on top of two low-level disk drivers (IDE and
SCSI).  Fundamentally, though, this is difficult to do:

0) There's a lot of early stuff you take risks with, such as the
   partition size (assuming you can probe it), knowing that it
   hasn't changed since boot, and pre-allocating buffers for disk
   I/O operations.  You always take the partition risk no matter
   what.

1) You have to establish that the IDE or SCSI device can be reset
   into an appropriate mode for seek/write mode -- if a DMA operation
   fails to the drive, and you can't reset the drive, you may be stuck.

2) Once the hardware reports back success, it is a matter of how
   you write the blocks.  I once wrote the low-level IDE driver
   below request structures, writing sequentially to the drive,
   and ran into occasional drive lock-ups while writing during
   interrupt crashes.  This was more likely due to my inexperience
   with the IDE driver than anything else.

|>And you have a situation where interrupts are not likely to work well
|>(because you crashed with various locks held), so the regular driver
|>simply isn't likely to work all that well.

This is simply an avoidance of certain code paths.  We saw this
problem earlier in 2.2 using kiobufs and got around it for the
most part by doing our best to avoid the io_request_lock.  That's
why we haven't seen the lock contention problems for 2.5.

|>And you have a situation where there are hundreds of different kinds of 
|>device drivers for the disk.

This is the biggest problem, absolutely.  Our idea moving forward
was to create a _dump() primitive with drivers that allows you to
determine, upon configuration of a disk dump device, whether or
not the low-level driver supported dumping or not.  I suggested this
to Al Viro a long time ago on this list, but it didn't go anywhere.

That way the driver itself knows that it can support a low-level
page-write method.  If it doesn't, you can't use disk dumping to
that device.

I'm willing to re-open this effort.

|>And if you get these things wrong, you're quite likely to stomp on your
|>disk. Hard. You may be tryign to write the swap partition, but if the
|>driver gets confused, you just overwrote all your important data. At which
|>point it doesn't matter if your filesystem is journaling or not, since you
|>just potentially overwrote it.

We haven't seen this before, but it is always a possibility for any
dump scenario.  That's why you some choose netdump instead. :)

|>In other words: it's a huge risk to play with the disk when the system is
|>already known to be unstable. The disk drivers tend to be one of the main
|>issues even when everything else is _stable_, for chrissake!
|>
|>To add insult to injury, you will not be able to actually _test_ any of 
|>the real error paths in real life. Sure, you will be able to test forced 
|>dumps on _your_ hardware, but while that is fine in the AIX model ("we 
|>control the hardware, and charge the user five times what it is worth"), 
|>again that doesn't mean _squat_ in the PC hardware space.

We have actually done a lot of testing with injection of failures
into the middle of VM, network drivers, etc., in conjunction with
disk dumping.  Certainly it doesn't cover all the cases, but nothing
ever will.

|>		Linus

--Matt

