Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbUJYVZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbUJYVZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUJYVW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:22:29 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:39026 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262180AbUJYVDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:03:47 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/1] dm: fix printk errors about whether %lu/%Lu is right for sector_t - revised
Date: Mon, 25 Oct 2004 22:55:08 +0200
User-Agent: KMail/1.6.1
Cc: agk@redhat.com, neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
References: <20041021224554.402233F37@zion.localdomain> <20041022025340.058837f7.akpm@osdl.org>
In-Reply-To: <20041022025340.058837f7.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410252255.08217.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 October 2004 11:53, Andrew Morton wrote:
> blaisorblade_spam@yahoo.it wrote:
> > The Device Manager code barfs when sector_t is 64bit wide (i.e. an u64)
> > and CONFIG_LBD is off. This happens on printk(), resulting in wrong
> > memory accesses, but also on sscanf(), resulting in overflows (because it
> > uses %lu for a long long in this case). And region_t, chunk_t are
> > typedefs for sector_t, so we have warnings for these, too.

> This patch caused the x86_64 build to puke: "Not allowed to define
> CONFIG_LBD on this architecture" or some such.

Yes, there is an #error directive for this.

Who would ever need to use CONFIG_LBD when sector_t is already 64-bit? So this 
is flagged as an error (feel free to remove that, if you know a good reason).

In fact, this is your fault, given both the 2.6.9 kernel and the 2.6.10-rc1 
one:

config LBD
        bool "Support for Large Block Devices"
        depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH
        help
          Say Y here if you want to attach large (bigger than 2TB) discs to
          your machine, or if you want to have a raid or loopback device
          bigger than 2TB.  Otherwise say N.

So if you define LBD on a x86_64 kernel, you get to keep the pieces.

A make oldconfig would probably help - don't you think so?

> I'd much prefer that you simply remove SECTOR_FORMAT completely.

Impossible - doing a scanf and then copying the value is much uglier. I just 
add 5 lines of code to avoid the problem, while removing the silly 
HAVE_SECTOR_T trick and moving the CONFIG_LBD handling to arch-independent 
code.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
