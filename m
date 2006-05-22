Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWEVLZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWEVLZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWEVLZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:25:49 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:37306
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750755AbWEVLZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:25:49 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Valdis.Kletnieks@vt.edu
Subject: Re: 2.6.17-rc4-mm3
Date: Mon, 22 May 2006 13:25:10 +0200
User-Agent: KMail/1.9.1
References: <20060522022709.633a7a7f.akpm@osdl.org> <200605221115.k4MBFq42013901@turing-police.cc.vt.edu>
In-Reply-To: <200605221115.k4MBFq42013901@turing-police.cc.vt.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605221325.10761.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 13:15, you wrote:
> On Mon, 22 May 2006 02:27:09 PDT, Andrew Morton said:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm3/
> 
> Mostly works, am chasing down 3 small things (all 3 were new as of -mm2 - I was
> busy chasing them when -mm3 showed up).
> 
> 1) Something has gone astray in the hardware RNG rework.  /sbin/rngd was
> quite happy dealing with the i810 RNG in my laptop under -rc4-mm1, but under
> -mm2 and -mm3, I get this (from strace /bin/rngd):
> 
> open("/dev/hw_random", O_RDONLY)        = 3
> read(3, "q\252cg", 4)                   = 4
> read(3, 0xbfaf56ac, 4)                  = -1 EAGAIN (Resource temporarily unavai lable)
> 
> It works for some number of reads, but eventually pulls an EAGAIN.  When
> stracing on a console that was slow-to-scroll, it did several dozen before
> failing - so it's apparently a timing thing.  I stuck a debugging printk
> in just before the test that returns EAGAIN, and got this:
> 
> [   68.361000] rng_read data_present=1 i=0 bytes_read=1
> [   68.361000] rng_read data_present=1 i=0 bytes_read=1
> [   68.361000] rng_read data_present=1 i=0 bytes_read=1
> [   68.361000] rng_read data_present=1 i=0 bytes_read=1
> [   68.361000] rng_read data_present=0 i=20 bytes_read=0
> 
> It looks to me line the old code stayed in a while() loop in rng_dev_read
> until it had fulfilled the read request (including possibly multiple
> calls to need_resched() and friends).  The new code will bail on an -EAGAIN
> as soon as the *first* poll fails, rather than waiting until something
> is available - even if it is NOT flagged O_NONBLOCK.

Yeah. That is how it works. I am wondering why userspace doesn't
simply retry, if it receives an EAGAIN.
Should we return ERESTARTSYS or something like that instead?
