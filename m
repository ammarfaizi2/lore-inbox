Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266598AbUF3Jh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbUF3Jh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 05:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266600AbUF3Jh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 05:37:59 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:18718 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP id S266598AbUF3Jhw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 05:37:52 -0400
Date: Wed, 30 Jun 2004 11:37:44 +0200 (CEST)
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
Subject: Re: hwscan hangs on USB2 disk - SCSI_IOCTL_SEND_COMMAND - SOLVED
To: garloff@suse.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040629094557.GR4732@tpkurt.garloff.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20040630093747.287D9AD3@etpmod.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt,

I tried both 0x26 and 0x24, but the problem persists. Guess I bought
crappy hardware (again). For now, I've removed the offending ioctl, and 
everything sort of works.

Thanks,
Bart

On 29 Jun, Kurt Garloff wrote:
> Hi Bart,
> 
> On Tue, Jun 29, 2004 at 11:37:36AM +0200, Bart Hartgers wrote:
>> The problem is that both hwscan and usb-storage get stuck in the 'D"
>> state until I unplug the harddisk.
>> 
>> A strace of hwscan shows:
>> 
>> 21141 open("/dev/sda", O_RDONLY|O_NONBLOCK) = 3
>> 21141 ioctl(3, 0x301, 0xbfffeba0)       = 0
>> 21141 ioctl(3, BLKSSZGET, 0xbfffeb9c)   = 0
>> 21141 ioctl(3, 0x80041272, 0xbfffeb90)  = 0
>> 21141 ioctl(3, FIBMAP, 0xbfffec40)      = 0  <--- hwscan gets stuck
>> here
>> 
>> The last ioctl corresponds to this bit of code in
>> hwinfo-8.38/src/hd/block.c:
>> 
>> #ifndef SCSI_IOCTL_SEND_COMMAND
>> #define SCSI_IOCTL_SEND_COMMAND 1
>> #endif
>> 
>> ...
>> 
>>       memset(scsi_cmd_buf, 0, sizeof scsi_cmd_buf);
>>       // ###### FIXME: smaller!
>>       *((unsigned *) (scsi_cmd_buf + 4)) = sizeof scsi_cmd_buf - 0x100;
>>       scsi_cmd_buf[8 + 0] = 0x12;
>>       scsi_cmd_buf[8 + 1] = 0x01;
>>       scsi_cmd_buf[8 + 2] = 0x80;
>>       scsi_cmd_buf[8 + 4] = 0xff;
>> 
>>       k = ioctl(fd, SCSI_IOCTL_SEND_COMMAND, scsi_cmd_buf);
>> 
>> So it appears that the driver hangs because of a SCSI command. Is
>> this kernel bug, and if so, where do I fix it?
> 
> To me it looks like a bug in the USB stick.
> It probably locks up when you ask for VPD page 0x80 (serial number)
> of the device with INQUIRY. 
> Some shitty USB devices lock up when you ask for more than 36 bytes
> with INQUIRY. See code in scsi_scan.c and the BLIST_INQUIRY_36 and
> _58 flags.
> Your device may even do so when you don't ask for standard INQUIRY 
> data but for EVPD page 0x80 :-(
> 
> Does it work if you send the INQUIRY with 36 bytes allocation length?
> scsi_cmd_buf[8 + 4] = 0x26;

