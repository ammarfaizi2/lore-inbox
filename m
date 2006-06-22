Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWFVIPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWFVIPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWFVIPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:15:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51119 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161007AbWFVIPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:15:41 -0400
Message-ID: <449A51A2.4080601@redhat.com>
Date: Thu, 22 Jun 2006 10:15:30 +0200
From: Milan Broz <mbroz@redhat.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] dm: support ioctls on mapped devices
References: <20060621193121.GP4521@agk.surrey.redhat.com> <20060621205206.35ecdbf8.akpm@osdl.org>
In-Reply-To: <20060621205206.35ecdbf8.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 21 Jun 2006 20:31:21 +0100
> Alasdair G Kergon <agk@redhat.com> wrote:
> 
>> From: Milan Broz <mbroz@redhat.com>
>>  
>> Extend the core device-mapper infrastructure to accept arbitrary ioctls
>> on a mapped device provided that it has exactly one target and it is 
>> capable of supporting ioctls.
> 
> I don't understand that.  We're taking an ioctl against a dm device and
> we're passing it through to an underlying device?  Or something else?

Solving this situation: logical volume (say /dev/mapper/lv1) mapped in dm 
to single device (/dev/sda):

If there is need to send ioctl you must know that /dev/mapper/lv1
is mapped to /dev/sda (and use /dev/sda for ioctl).
This is dm work -  so send ioctl to /dev/mapper/lv1 directly
and let dm decide what to do.

This is supported only for single mapping. If there are more than one target
it will return -ENOTTY.

>> [We can't use unlocked_ioctl because we need 'inode': 'file' might be NULL.
>> Is it worth changing this?]
> 
> It _should_ be possible to use unlocked_ioctl() - unlocked_ioctl() would be
> pretty useless if someone was passing it a NULL file*.  More details?

yes, 
(I prefer change block code to not pass NULL and use unlocked_ioctl,
- Alasdair ?)

see

drivers/char/raw.c:
126: return blkdev_ioctl(bdev->bd_inode, *NULL*, command, arg);

and block/ioctl.c: [file = NULL here]
206: if (disk->fops->unlocked_ioctl)
207:	return disk->fops->unlocked_ioctl(*file*, cmd, arg);


-- 
Milan Broz
mbroz@redhat.com



