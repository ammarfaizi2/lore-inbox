Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273085AbRIIW3F>; Sun, 9 Sep 2001 18:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273083AbRIIW2z>; Sun, 9 Sep 2001 18:28:55 -0400
Received: from smtp-server2.cfl.rr.com ([65.32.2.69]:29138 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S273081AbRIIW2m>; Sun, 9 Sep 2001 18:28:42 -0400
Message-Id: <200109092229.f89MT3M07627@smtp-server2.tampabay.rr.com>
Content-Type: text/plain; charset=US-ASCII
From: Phillip Susi <psusi@cfl.rr.com>
Reply-To: psusi@cfl.rr.com
To: linux-kernel@vger.kernel.org
Subject: New SCSI subsystem in 2.4, and scsi idle patch
Date: Sun, 9 Sep 2001 18:21:13 +0000
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get my 2.4.9 system to spin down my scsi disk(s) when idle.  
Aparently, this is supported on IDE disks, but not SCSI.  I found an old 
patch to add support for this to the 2.0.34 kernel, and have been trying to 
use it as a guide to fixing the 2.4.9 kernel.  It seems that major changes 
have been done to the scsi layer, so I'm a little confused.  Any help is 
appreciated.  Here is my current status:

It looks like the code path I need to modify is in 
drivers/scsi/sd.c:rw_intr().  It looks to me that this function is called 
when the HBA completes an SRB and it decides if it was an error or not, and 
completes it correctly.  I think I need to check for the NOT_READY sense 
status here, and if it is found, try to spin up the disk.  

Now for my questions:  

1) In the old patch, if the spin up failed, it calls 
end_scsi_request, and then requeue_sd_request.  I'm not sure why it tries to 
requeue a failed request, but the it seems that neither of these functions 
exist in the 2.4 kernel.  What should I use instead?

2) If the spin up worked, the old code called requeue_sd_request, I assume to 
send down the original read/write request to the disk now that it is on.  
Once again, what should I use instead of requeue_sd_request to do this?  
There is a comment still in the 2.4 code describing this function, but the 
function itself is not there.  

3) The old code called scsi_do_cmd to send down a START_STOP SRB to the drive 
when it decides it should spin the drive back up.  This function is also no 
longer there, so what should I use to send down the START_STOP SRB?  

P.S.  I'd like to use a user mode daemon to detect disk idle, and issue the 
existing ioctl code to spin the disk down, and rely on the kernel to spin it 
back up as needed.  Isn't there somewhere in /proc that keeps IO counters on 
the disk I can monitor?  Also, is there a way I could ask the kernel to not 
flush dirty pages to disk unless it gets a whole lot of them so the disk 
won't be spun up all the time just to write a few KB?

-- 
--> Phill Susi
