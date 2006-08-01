Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWHAQQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWHAQQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 12:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWHAQQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 12:16:34 -0400
Received: from wx-out-0102.google.com ([66.249.82.194]:9646 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750801AbWHAQQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 12:16:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ciYh6eDA5okC04dnVT9wXYtG+iw8h5aHm28OJw5FHhFJ/8lzV26xfky3vS7ywMhZ3a+ZGFiVAYXefOmS/VFs+28Zy4tv2iK2we2VUhRnOgdUDzHY0mOs+etuH8ujzKE5GGfeI653CWDxNiW4MPN+xdDRZKWP8y9jeEDDyytEdVo=
Message-ID: <44CF7E5A.2010903@gmail.com>
Date: Wed, 02 Aug 2006 01:16:26 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
References: <44CC9F7E.8040807@t-online.de>
In-Reply-To: <44CC9F7E.8040807@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> Hi folks,
> 
> I tried to spin down my harddisk using hdparm, but when it is
> supposed to spin up again, then it is blocked for quite some
> time. dmesg says:
> 
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: (BMDMA stat 0x20)
> ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata1: port is slow to respond, please be patient
> ata1: port failed to respond (30 secs)
> ata1: soft resetting port
> ata1.00: configured for UDMA/133
> ata1: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> 
> The disk is a SAMSUNG SP1614C.
> 
> On another machine (with a SAMSUNG SP2504C inside) there is no
> such problem: The disk is back after just a few seconds.

In standby mode, the drive's interface and state machines stay online 
and are supposed to spin up and process the command when it receives 
one.  The above message is printed because an IO command hasn't finished 
in 30 secs meaning that it didn't wake up when it should have.  The 
drive seems to act incorrectly.

> Is there some trick to wake up the disk a little bit faster?

Can you try the following instead of hdparm?

echo 1 > /sys/bus/scsi/devices/1:0:0:0/power/state

It will make libata involved in putting the disk to sleep and waking it 
up, and, when waking, it will kick the drive in the ass by resetting the 
channel.  Please try with the latest -rc kernel.

-- 
tejun
