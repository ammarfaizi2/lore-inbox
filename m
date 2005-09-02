Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVIBLid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVIBLid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 07:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVIBLid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 07:38:33 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:52819 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751141AbVIBLic convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 07:38:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CYQMXMPLnSTEExQ41lRRfGLVDQVsXhdAqeT9mTmxYD1ze6zyIcaxzCZhS3gjP4Y9NzAwaKqFCkbon2TACKHjnq+f9Gx8uciFDvHSlbOTWByGlKUPWRd0SFLvTPQ61RNSnxdZIRLt3cN6LHP0ftgGf56My2e1jkk5lAO+9v80kfI=
Message-ID: <e8ac1af10509020438c71133d@mail.gmail.com>
Date: Fri, 2 Sep 2005 17:08:26 +0530
From: Tushar Adeshara <adesharatushar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Potential concurrency bug in ide-disk.c ?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The way file ide-disk.c handles usage count, it seems to me that its
concurrency bug.
In open method and release, it uses code as follows


static int idedisk_open(struct inode *inode, struct file *filp)
{
	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
	drive->usage++;
	if (drive->removable && drive->usage == 1) {
		ide_task_t args;
		memset(&args, 0, sizeof(ide_task_t));
		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
		args.command_type = IDE_DRIVE_TASK_NO_DATA;
		args.handler	  = &task_no_data_intr;
		check_disk_change(inode->i_bdev);
		/*
		 * Ignore the return code from door_lock,
		 * since the open() has already succeeded,
		 * and the door_lock is irrelevant at this point.
		 */
		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
			drive->doorlocking = 0;
	}
	return 0;
}


Here, if drive->usage=0 initially and two process concurrently executes 
drive->usage++, then drive->usage will become 2.  Both of them will
think that drive is already initialized. Something similar can happen
in case of release.
                      I think a semaphore need to be added in
ide_drive_t structure and method should be modified as

static int idedisk_open(struct inode *inode, struct file *filp)
{
	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
        if(down_interruptible(&drive->sem)){
                    /*error handling code*/
        } 
	drive->usage++;
	if (drive->removable && drive->usage == 1) {
		ide_task_t args;
		memset(&args, 0, sizeof(ide_task_t));
		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
		args.command_type = IDE_DRIVE_TASK_NO_DATA;
		args.handler	  = &task_no_data_intr;
		check_disk_change(inode->i_bdev);
		/*
		 * Ignore the return code from door_lock,
		 * since the open() has already succeeded,
		 * and the door_lock is irrelevant at this point.
		 */
		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
			drive->doorlocking = 0;
	}
         up(&drive->sem);
	return 0;
}
Similar modifications are also required in release.

Please let me know if there is anything wrong in above code. Also let
me know to whom I should offer patches for this.

-- 
Regards,
Tushar
--------------------
It's not a problem, it's an opportunity for improvement. Lets improve.
