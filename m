Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278521AbRJPE2G>; Tue, 16 Oct 2001 00:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278522AbRJPE15>; Tue, 16 Oct 2001 00:27:57 -0400
Received: from zok.sgi.com ([204.94.215.101]:12451 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S278521AbRJPE1s>;
	Tue, 16 Oct 2001 00:27:48 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.13-pre3 arm/i386/mips/mips64/s390/s390x/sh die() deadlock 
In-Reply-To: Your message of "Tue, 16 Oct 2001 12:58:21 +1000."
             <18966.1003201101@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Oct 2001 14:27:55 +1000
Message-ID: <19892.1003206475@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001 12:58:21 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>On Mon, 15 Oct 2001 19:36:02 -0700 (PDT), 
>Linus Torvalds <torvalds@transmeta.com> wrote:
>>I much prefer a dead machine with a partially visible oops over a oops
>>where the original oops has scrolled away due to recursive faults.
>
>IMHO it is unrealistic to expect that all code inside die() will never
>fail.  Any unexpected kernel corruption could cause the register or
>backtrace dump to fail.  The patch gets the best of both worlds.  It
>protects against recursive errors and against concurrent calls to
>die().

Previous message sent too soon.

The patch makes two attempts at dumping registers, one for the original
oops and one if die() fails, then it gives up.  The second attempt is
useful for diagnosing why die() is failing, without that data it is
difficult to fix die() itself.

I was aiming to improve error handling in the rare case that die()
failed so we could get better diagnostics in the long term, by fixing
the problems that make die() fail.  If you think that this would scroll
away useful data then we can compromise.

	if (++die_lock_owner_depth < 2+(CONFIG_DIAGNOSE_RECURSIVE_DIE+0)) {

CONFIG_DIAGNOSE_RECURSIVE_DIE
  If this variable is selected then the kernel will attempt to provide
  extra diagnostics in the rare cases when the kernel die() routine
  itself dies.  This may cause useful information from the first
  failure to be lost.  Unless you want to diagnose the die() and
  show_regs() code in the kernel, say N here.

Acceptable?

