Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWGHU3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWGHU3M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWGHU3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:29:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39109 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030342AbWGHU3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:29:11 -0400
Date: Sat, 8 Jul 2006 13:28:56 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, mtosatti@redhat.com
Subject: Re: Bug with USB proc_bulk in 2.4 kernel and possibly bug in
 proc_ioctl in 2.6
Message-Id: <20060708132856.41644999.zaitcev@redhat.com>
In-Reply-To: <mailman.1152332281.24203.linux-kernel2news@redhat.com>
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 17:24:56 -0700, Benjamin Cherian <benjamin.cherian.kernel@gmail.com> wrote:

> I believe that there is a bug in the proc_bulk function in drivers/usb/devio.c 
> in the current 2.4 kernel. In the 2.4.28 proc_ioctl was changed so that the 
> device would be locked before proc_bulk was called (See line 1275 of 
> devio.c). In 2.4.27, no locking occurred. However, this leads to problems if 
> one thread is continuously attempting to read and another one needs to write 
> because the write thread can never access the device. []

The decision to cripple the devio in this way was conscious. The problem
scenario with 2.4.27 and earlier was how many devices would fail if
a control and other transfer were submitted simultaneously. In other
words, when desktop components (e.g. HAL) rescanned /proc/bus/usb/devices,
some other devices would throw errors. The most notorious example
would be TEAC CD-210PU, because of how widespread and popular it is.

In other words, I crippled your application for the sake of a bunch
of users of other devices. You have to realize though, that your
concerns weren't voiced in the time and it was widely believed that
user-mode drivers did not submit several URBs at once (primarily
because the queueing in HCDs of 2.4 was a suspect).

> I would have submitted a patch, but it seems like the locking/unlocking 
> mechanism is different in 2.4 and 2.6 and I wasn't sure if I would break 
> other stuff.

If you do send a patch, you need to account for the serialization
somehow. The linux-usb-devel people considered a few ideas, such
as per-device blacklists and locking flags, backport of string caching
from 2.6 (to alleviate the most common case of /proc/usb/usb/devices).

But it seems to me that the best approach would be if you made
a special case for bulk+bulk and locked out control transfers somehow.

Another option is to look at an in-kernel driver architecture for
your device. What is it, anyway?

-- Pete
