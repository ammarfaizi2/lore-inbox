Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVBVUlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVBVUlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 15:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVBVUlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 15:41:32 -0500
Received: from ida.rowland.org ([192.131.102.52]:23300 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261234AbVBVUl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 15:41:28 -0500
Date: Tue, 22 Feb 2005 15:41:25 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Parag Warudkar <kernel-stuff@comcast.net>
cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6: USB Storage hangs machine on bootup for
 ~2 minutes
In-Reply-To: <200502221344.58420.kernel-stuff@comcast.net>
Message-ID: <Pine.LNX.4.44L0.0502221525200.6861-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005, Parag Warudkar wrote:

> > You said that the system hangs during bootup.  Where in the log does that
> > hang occur?  The log itself looks perfectly normal.  The Maxtor drive is
> > scanned, the partitions detected, and then apparently one or two
> > partitions are mounted.  There's no indication of any problem.
> 
> I have tracked down the reason for this hang  - it seems that kudzu gets stuck 
> in D state on usb_device_read - Below SysRQ+T from 2.6.11-rc4 - always 
> reproducible.
> 
> kudzu         D 00000000ffffffff     0  4424   4472                     
> (NOTLB)
> ffff81002bebfd98 0000000000000086 ffff81002c538150 ffff81002f21d00e
>        000000078847ce40 ffff81002b5977c0 000000000000fd38 ffffffff803defc0
>        ffff81002bebfd88 ffffffff80219b32
> Call Trace:
> <ffffffff80219b32>{_atomic_dec_and_lock+290} <ffffffff80383835>{__down+421}
>        <ffffffff80133e30>{default_wake_function+0} 
> <ffffffff803868ae>{__down_failed+53}
>        <ffffffff802db9f1>{.text.lock.usb+5} 
> <ffffffff802edb35>{usb_device_read+229}
>        <ffffffff801998d1>{vfs_read+225} <ffffffff80199bd0>{sys_read+80}
>        <ffffffff8010ed1e>{system_call+126}
> 
> Thereafter, if I try to mount the USB drive, even mount gets stuck.

usb_device_read acquires a couple of locks, one for the USB bus list and 
one for the root hub of the bus it's looking at.  I don't know which one 
occurs at offset 229 on your system -- maybe you can tell.  Oddly enough, 
neither of those locks is for a USB device like the Maxtor drive.  So it's 
not at all clear why plugging in the drive should mess up kudzu.  Or why 
the blockage should clear up after a couple of minutes.

Perhaps we can find out by looking at other entries in the stack trace.  
Of particular interest are the khubd, usb-storage, and scsi_eh processes.

Alan Stern

