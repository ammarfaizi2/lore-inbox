Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbVHIUNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVHIUNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbVHIUNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:13:08 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:4800 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S964909AbVHIUNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:13:06 -0400
Date: Tue, 9 Aug 2005 22:13:00 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Bodo Eggert <7eggert@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: Regression: radeonfb: No synchronisation on CRT with linux-2.6.13-rc5
In-Reply-To: <1123489200.30257.133.camel@gaston>
Message-ID: <Pine.LNX.4.58.0508092140030.2096@be1.lrz>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>  <1123195493.30257.75.camel@gaston>
  <Pine.LNX.4.58.0508051935570.2326@be1.lrz>  <1123401069.30257.102.camel@gaston>
  <3EF2003B-12DF-4EBB-B304-59614AEFAA09@mac.com>  <Pine.LNX.4.58.0508071921540.3495@be1.lrz>
  <1123451289.30257.118.camel@gaston>  <Pine.LNX.4.58.0508080158520.7822@be1.lrz>
 <1123489200.30257.133.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Benjamin Herrenschmidt wrote:
> On Mon, 2005-08-08 at 02:06 +0200, Bodo Eggert wrote:

> > The wrong values are constant across reboots (see my first mail), and I 
> > have a CRT.
> > 
> > Can you tell me where the timing values are read?
> 
> radeon_write_mode() programs the mode. The monitor timing infos are read
> by the various bits of code in radeon_monitor.c
> 
> I'd be curious if you could identify what bit of code is misbehaving

I added preempt_*able around radeon_probe_i2c_connector, and now I get the 
output from below and still no sync. Obviously you shouldn't msleep in 
preempt-disabled code. I'll try voluntary preemption, but that will at 
best hide the error.

Maybe I can mess with the msleep()s like thorndike's cat, but any success 
will be an accident.

Aug  9 20:58:26 be1 __mod_timer+0xb4/0x100
Aug  9 20:58:27 be1  [<c04019b1>] schedule_timeout+0x51/0xa0
Aug  9 20:58:27 be1  [<c011ff60>] process_timeout+0x0/0x10
Aug  9 20:58:27 be1  [<c012031f>] msleep+0x2f/0x40
Aug  9 20:58:27 be1  [<c02a3aca>] radeon_probe_i2c_connector+0xaa/0x320
Aug  9 20:58:27 be1  [<c02a1da2>] radeon_probe_screens+0x482/0x5d0
Aug  9 20:58:27 be1  [<c0298689>] radeonfb_pci_register+0x309/0x570
...
Aug  9 20:58:27 be1 scheduling while atomic: swapper/0x00000001/1
Aug  9 20:58:27 be1  [<c0400ed9>] schedule+0x589/0x640
Aug  9 20:58:27 be1  [<c011f492>] lock_timer_base+0x32/0x70
Aug  9 20:58:27 be1  [<c011f584>] __mod_timer+0xb4/0x100
Aug  9 20:58:27 be1  [<c04019b1>] schedule_timeout+0x51/0xa0
Aug  9 20:58:27 be1  [<c011ff60>] process_timeout+0x0/0x10
Aug  9 20:58:27 be1  [<c012031f>] msleep+0x2f/0x40
Aug  9 20:58:27 be1  [<c02a3aca>] radeon_probe_i2c_connector+0xaa/0x320
Aug  9 20:58:27 be1  [<c02a1da2>] radeon_probe_screens+0x482/0x5d0
Aug  9 20:58:27 be1  [<c0298689>] radeonfb_pci_register+0x309/0x570
Aug  9 20:58:27 be1  [<c0281318>] __pci_device_probe+0x48/0x60



-- 
It is still called paranoia when they really are out to get you.
