Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266844AbTAOSlz>; Wed, 15 Jan 2003 13:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbTAOSlz>; Wed, 15 Jan 2003 13:41:55 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:15326 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S266844AbTAOSly>; Wed, 15 Jan 2003 13:41:54 -0500
Message-ID: <3E25AD42.3090409@google.com>
Date: Wed, 15 Jan 2003 10:49:38 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       andre@linux-ide.org
Subject: [BUG] 2.4.21-pre3 hdparm -X violates IDE locking
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This bug impacts all versions of the kernel that I have looked at 
including 2.4.18 and above.  It probably impacts many other versions as 
well.

hdparm -X issues a drive command ioctl which eventually issue a command 
to the drive bypassing all of the normal locking.  The net effect is 
that a command can be set to the drive when the drive is not ready. 
 Some drives lock up when this happens.

The call chain is

ide_ioctl calls
ide_cmd_ioctl

If the command is a set features to change the communications speed, 
after the command is complete, ide_cmd_ioctl calls

ide_set_xfer_rate

ide_set_xfer_rate then calls drive->speedproc.

Most speedprocs then call ide_config_drive_speed
ide_config_drive_speed issue a set features command. and busy waits on it.

The easiest fix is to probably modify execute_drive_command to update 
drive->current_speed when it issues the appropriate SET FEATURES 
command, and then have ide_config_drive_speed do nothing if speed == 
current_speed.

I did a much bigger modification that handles changing drive speed 
specially and immediately.  I'll make patches for either one, but I 
wanted to get some opinions before I did so.

    Ross


