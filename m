Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315847AbSEMFuK>; Mon, 13 May 2002 01:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315849AbSEMFuJ>; Mon, 13 May 2002 01:50:09 -0400
Received: from [4.3.237.190] ([4.3.237.190]:38528 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id <S315847AbSEMFuJ>;
	Mon, 13 May 2002 01:50:09 -0400
Message-ID: <3CDF5409.9040809@alumni.caltech.edu>
Date: Sun, 12 May 2002 22:50:01 -0700
From: Matthew Derer <matthew@alumni.caltech.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.18: aic7xxx soft reboot broken
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded to a 2.4.18 kernel on a machine with an Adaptec 
2940AU SCSI controller.  Since the upgrade, soft reboots don't work; the 
machine appears to shut down normally, but during the subsequent boot 
the SCSI BIOS reports a timeout on an inquiry command and is unable to 
find any drives on the bus.  A hard power cycle is required to restore 
the card to a state in which it can find the drives.

Problem seems to be that the reboot notifier for the new aic7xxx driver 
is registered in aic7xxx_setup, which only gets called when there are 
module or kernel command-line params for aic7xxx.  Without reboot 
notification and cleanup, the card is left in a bad state at shutdown, 
and BIOS does not appear to clean it up during boot.

I think other people have run into the same problem:

http://groups.google.com/groups?selm=20010811.180158.1012502954.2309%40omit.nonsense.bigfoot.com

Workaround is obvious, just feed the module any param to get the 
notification registered, like aic7xxx=verbose, then soft reboots work 
just fine.  Fix would be to register the notifier whether there are 
params or not.  Also wouldn't hurt to check for SYS_POWER_OFF as well as 
SYS_HALT and SYS_DOWN when handling the notify, SYS_POWER_OFF can result 
in a halt without actually powering off on some machines.

Matthew

