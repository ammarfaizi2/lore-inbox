Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUDKBgk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 21:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUDKBgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 21:36:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:219 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261648AbUDKBgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 21:36:38 -0400
Date: Sat, 10 Apr 2004 18:36:38 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: stern@rowland.harvard.edu, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
       zaitcev@redhat.com
Subject: Re: Patch for usb-storage in 2.4   [linux-usb-devel]
Message-Id: <20040410183638.5b177147.zaitcev@redhat.com>
In-Reply-To: <20040411000957.GA7523@one-eyed-alien.net>
References: <20040409195943.0dac2f5a.zaitcev@redhat.com>
	<20040411000957.GA7523@one-eyed-alien.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Apr 2004 17:09:57 -0700
Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:

> I'm uncertain if your handling of the io_request_lock is right.... but
> getting information on how to handle that has been like pulling teeth, so
> I'm inclined to trust your wide-scale testing on this.

It's not wide-scale, unfortunately, that's why I need more review and
testing of it. Those "Enterprise" people are mostly interested in very
specific things, in particular Bladecenter and JS-20, Dell's OEMed CD-ROMs,
and Lexar memory key which Dell resells. Very likely not all transports
or protocols are tested, for instance UFI. But I think it's right to
call it "intensive" testing.

The main test is to put a CD and keyboard on a hub, and hub on a KVM, then
flip KVM several times quickly from one blade to another. All hell breaks
loose. IIRC, I had four different OOPS and lockup scenarios.

> Was there a reason to add more do-nothing code to host_reset?

Woopsie. I wanted to write it, but understood that if I return right
code from "bus" reset, it should never be called. Sorry about that...
I'll remove that part.

> Is it really safe to remove the irq_urb_sem?

The idea here is to have disconnect and resets locked against each other.
They happen on different threads, unfortunately (khubd and scsi_eh).
Initially I tried various orders, but then I thought, "Why am I making
it hard on myself?! Much better just to merge them". The dev_semaphore now
covers everything irq_urb_sem used to cover, except one path into
usb_stor_allocate_irq from initial probing.

Thanks for looking at it!

-- Pete
