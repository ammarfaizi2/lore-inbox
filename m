Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbTAVTxq>; Wed, 22 Jan 2003 14:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTAVTxq>; Wed, 22 Jan 2003 14:53:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:30852 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261996AbTAVTxp>;
	Wed, 22 Jan 2003 14:53:45 -0500
Date: Wed, 22 Jan 2003 11:56:41 -0800
From: Andrew Morton <akpm@digeo.com>
To: Kevin Lawton <kevinlawton2001@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please
 consider)
Message-Id: <20030122115641.1be444fa.akpm@digeo.com>
In-Reply-To: <20030122182341.66324.qmail@web80309.mail.yahoo.com>
References: <20030122182341.66324.qmail@web80309.mail.yahoo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2003 20:02:48.0253 (UTC) FILETIME=[3C797ED0:01C2C251]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Lawton <kevinlawton2001@yahoo.com> wrote:
>
> Hello all,
> 
> I'm working on running Linux as a guest OS inside a
> lightweight cut-down plex86 environment.  My goal is to
> run a stock Linux kernel, which can be slimmed down to
> the essentials via kernel configuration, since a guest
> OS doesn't need to drive much hardware.
> 
> For this, there's a few critical but simple diffs to
> macro'ize the use of the PUSHF and POPF instructions,
> due to broken semantics of running stuff using
> PVI (protected mode virtual interrupts).  The rest of
> the stuff I believe can be monitored effectively by
> the VM monitor.
> 
> Would you please consider integrating these diffs before 2.6?
> There's only one new header file, and macro substitution for
> a few cases where these instructions are used.  For a normal
> compile, there are zero logic changes.  Just 1:1 macros.

I'm wondering if this can this be done a lot more simply with assembler
macros.

The below example generates the right code.  It's then just a matter of
getting the redefined pushfl and popfl macros into kernel-wide scope. 
Possibly an explicit `-include' in the makefile system.


asm("
	.macro	popfl
	testl	$(1<<9), 0(%esp)
	jz	69003f
	.byte	0x9d		# popfl
	sti
	jmp	69004f
69003:
	.byte	0x9d		# popfl
	cli
69004:                
	.endm
");

foo()
{
	asm("popfl\n");
}

