Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSKCP5z>; Sun, 3 Nov 2002 10:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262107AbSKCP5y>; Sun, 3 Nov 2002 10:57:54 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:20109 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262089AbSKCP5x>; Sun, 3 Nov 2002 10:57:53 -0500
Subject: Re: swsusp: don't eat ide disks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: benh@kernel.crashing.org
Cc: Alan Cox <alan@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021103145735.14872@smtp.wanadoo.fr>
References: <200211022006.gA2K6XW08545@devserv.devel.redhat.com> 
	<20021103145735.14872@smtp.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 16:25:33 +0000
Message-Id: <1036340733.29642.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 14:57, benh@kernel.crashing.org wrote:
> Hrm... I don't think so Alan. The PM ordering is bus driven,
> so actual bus binding of the disk is it's controller, not
> the request queue which is the functional binding. It's up to
> the disk driver to shut down processing of the request queue.

That requires code in every driver. Duplicated, hard to write, likely to
be racey code. Thats bad.

The bigger picture really should be

ACPI etc	"I want to suspend to disk"

PM layer
		Suspend the non I/O tasks (btw reminds me - eh tasks and
			all workqueues may be I/O tasks at times)
		Complete all the block I/O queues
		Throw out the pages we can evict
		Write suspend image
		
		Jump to PM layer "power off" logic

If you do it that way up then no drivers need to be hacked about.

Alan

