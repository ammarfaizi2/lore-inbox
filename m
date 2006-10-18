Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWJRGFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWJRGFI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 02:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWJRGFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 02:05:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49096 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964777AbWJRGFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 02:05:04 -0400
Date: Wed, 18 Oct 2006 07:05:00 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC] typechecking for get_unaligned/put_unaligned
Message-ID: <20061018060500.GI29920@ftp.linux.org.uk>
References: <20061017005025.GF29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <20061018054242.GA21266@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018054242.GA21266@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 01:42:42AM -0400, Dave Jones wrote:
> On Tue, Oct 17, 2006 at 05:37:26AM +0100, Al Viro wrote:
> 
>  > There are several #includes with very high impact; the worst happens
>  > to be module.h -> sched.h
> 
> I gave up fighting to get that fixed a year and a half ago..
> http://lkml.org/lkml/2005/1/26/11
> 
> rediffing trees with lots of include file juggling gets boring real fast.

I don't see a lot of files touched by that one...
 arch/i386/kernel/alternative.c            |    1 +
 arch/i386/kernel/cpu/mcheck/therm_throt.c |    1 +
 drivers/base/cpu.c                        |    1 +
 drivers/hwmon/abituguru.c                 |    1 +
 drivers/leds/ledtrig-ide-disk.c           |    1 +
 drivers/leds/ledtrig-timer.c              |    1 +
 drivers/scsi/scsi_transport_sas.c         |    1 +
 drivers/w1/slaves/w1_therm.c              |    1 +
 include/asm-x86_64/elf.h                  |    1 -
 include/linux/acct.h                      |    1 +
 include/linux/module.h                    |    3 ++-
 include/linux/phy.h                       |    2 ++
 include/scsi/libiscsi.h                   |    2 ++
 kernel/latency.c                          |    1 +
 kernel/module.c                           |    2 +-
is hardly a lot.

That's the point, actually - apparently we have several high-impact includes
that are easy to sever and that are really worth being severed.  The part
that was not aproiri obvious:
	* there are clusters of headers around certain dependency
counts.
	* such clusters tend to have leaders - header that pulls the
rest and even though other headers are apparently independently included,
all such includes end up being hidden by includes of the leader.
	* gaps between the clusters are pretty large.
	* dependency graph *on* *clusters* is worth being studied; includes
of cluster leader from cluster around slightly smaller dependency count
are prime targets for severing.

That is the new part here.  Not just "dependency graph is a mess and ought
to be cleaned up" - _that_ is neither new nor particulary useful...
