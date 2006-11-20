Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966186AbWKTQ4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966186AbWKTQ4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966197AbWKTQ4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:56:09 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:38340 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S966198AbWKTQ4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:56:08 -0500
Date: Mon, 20 Nov 2006 17:56:01 +0100
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: avl@logic.at, linux-kernel@vger.kernel.org
Subject: Re: possible bug in ide-disk.c (2.6.18.2 but also older)
Message-ID: <20061120165601.GS6851@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
References: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at> <20061120152505.5d0ba6c5@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120152505.5d0ba6c5@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: Andreas Leitgeb <avl@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 03:25:05PM +0000, Alan wrote:
> On Mon, 20 Nov 2006 15:51:48 +0100
> Andreas Leitgeb <avl@logic.at> wrote:
> > Since I got not even a beep as answer, I'm trying again
> > to get this through to someone who cares:
> Sounds like the Knoppix kernel is built with GPT partition handling and
> your disk has an odd number of sectors ?

While I used Knoppix to determine the age of the bug, it does also
appear with a plain vanilla 2.6.18.2 kernel from www.kernel.org.
The ChangeLog for 2.6.18.3 also doesn't mention ide-disk.

I must admit, I don't know about GPT.  My system's bios
is old enough to not know about EFI, and the partition-scheme
on that harddisk dates back quite a few years, so it's unlikely
to be anything than the good ol' MBR.

The original reported number of sectors was an even number.
After HPA-correction it was an odd number.  I cannot tell
if the original even number wasn't actually "odd" in the
sense of "strange". It was, at least, plausible in so far
as access to the last sector went ok, whereas access to the
hpa-corrected (with addr++) last sector failed.

> > The problem is in  idedisk_read_native_max_address()
> > and equivalently in idedisk_read_native_max_address_ext()
> > in a line like this (near the end):
> >   addr++; /* since the return value is (maxlba - 1), we add 1 */
> > I believe that this is wrong, in so far as it is device-specific.
> Which part of the standard are you referring to here ?

I must also admit that I do know nothing about drive hardware specs.

All I know is, that the current code works for some(most?) disks,
and triggers turning off dma on some other drives and, that changing 
"addr++;" to "addr+=drive->sect0;"  (or removing the line completely)
solved the problem for my particular drive.

I hope that someone who understands the ide-driver better than I do,
would evaluate my proposed solution, and either confirm the bug,
or say that this affects just a few broken drives, and that these
don't justify any fixing of the driver.

I could live with either, and I'm glad when this issue is at least
taken care of.  If this has been discussed already in the past, then
please give me a pointer, since my googling failed to give me anything
but archives of other people complaining about the same problem.

For the while being, I currently patch out the hpa-detection entirely
before compiling a new kernel for that particular machine, until either
the bug is corrected for me (and others with an equal harddisk), or
until I replace my affected 40GB disk with a newer/larger one for
which the "addr++" then again might happen to be the right thing.

Alternatively, a kernel-option to manually disable hpa-checking
would be a good step to solve the problem even for drives like mine.

