Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWGHAZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWGHAZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWGHAZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:25:05 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:32223 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932440AbWGHAZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:25:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=R3QDV/oxm/HiJHaFRNnz7RuAJvHC5GBsJ9zSiBBtBiHFU6k2QORfU+axAGaSQ74qoCL6YR6Dw+rLhR/+GgJDkF6Z3/bKlGp4yd2QO4jOwc7pQXnKIoaRyyOlbcMOKVrsNuEt5+VK4GWu1zdIuKDYKLjzOxQdl5rswUYFLMgIyC0=
From: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bug with USB proc_bulk in 2.4 kernel and possibly bug in proc_ioctl in 2.6
Date: Fri, 7 Jul 2006 17:24:56 -0700
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200607071724.57216.benjamin.cherian.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that there is a bug in the proc_bulk function in drivers/usb/devio.c 
in the current 2.4 kernel. In the 2.4.28 proc_ioctl was changed so that the 
device would be locked before proc_bulk was called (See line 1275 of 
devio.c). In 2.4.27, no locking occurred. However, this leads to problems if 
one thread is continuously attempting to read and another one needs to write 
because the write thread can never access the device. The code has changed a 
little since 2.4.28, but the device is still locked before proc_bulk is 
called.

In the 2.6 kernel,the device is locked before proc_bulk, or any other USB 
operation for that matter, is called (see line 1419 in 
drivers/usb/core/devio.c); however, the device is unlocked in proc_bulk 
before usb_bulk_msg is called, and is locked after usb_bulk_msg is completed. 
(See lines 716-718 & 746-748 of v2.6 devio.c)

Additionally, in 2.4.32 one of the comments says that for some ioctls, the 
device does not need to be locked because they don't touch the device (e.g. 
USBDEVFS_REAPURB or USBDEVFS_GETDRIVER, see 2.4.32 for more). However, in 2.6 
the device is locked for all ioctls. Shouldn't this be changed?

I would have submitted a patch, but it seems like the locking/unlocking 
mechanism is different in 2.4 and 2.6 and I wasn't sure if I would break 
other stuff.



Thanks,

Ben
