Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSIOHfZ>; Sun, 15 Sep 2002 03:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSIOHfZ>; Sun, 15 Sep 2002 03:35:25 -0400
Received: from web40514.mail.yahoo.com ([66.218.78.131]:59483 "HELO
	web40514.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317947AbSIOHfW>; Sun, 15 Sep 2002 03:35:22 -0400
Message-ID: <20020915074013.87184.qmail@web40514.mail.yahoo.com>
Date: Sun, 15 Sep 2002 00:40:13 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: Possible bug and question about ide_notify_reboot in 2.4.19
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10209141548370.6925-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Andre Hedrick <andre@linux-ide.org> wrote:
> > > You said you can make a patch, please do so and apply it to your tree.
> > > Now, if you want the option, submit the patch for review.  For two or
> > > three days there has been no patch to test.
> > Still testing locally. I also want to fix the code so that the flush is
> > done before the standby.
> 
> Wait, how did the order go south?
>
I don't know how, but I know it happened somewhere between 2.4.18 and 2.4.19. 
This is a snippet of code from the ide_notify_reboot() function in ide.c in 
2.4.19 vanilla:
4024                 for (unit = 0; unit < MAX_DRIVES; ++unit) {
4025                         drive = &hwif->drives[unit];
4026                         if (!drive->present)
4027                                 continue;
4028 
4029                         /* set the drive to standby */
4030                         printk("%s ", drive->name);
4031                         if (event != SYS_RESTART)
4032                                 if (drive->driver != NULL && DRIVER(drive)->standby(drive))
4033                                 continue;
4034 
4035                         if (drive->driver != NULL && DRIVER(drive)->cleanup(drive))
4036                                 continue;
4037                 }

Notice that we are calling standby(), then cleanup(): standby() puts the disk
to sleep, but cleanup flushes the cache.

Here is the code for standby() from ide_disk.c in 2.4.19 vanilla:
1235 static int do_idedisk_standby (ide_drive_t *drive) // put disk to sleep.
1236 {
1237         struct hd_drive_task_hdr taskfile;
1238         struct hd_drive_hob_hdr hobfile;
1239         memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
1240         memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
1241         taskfile.command        = WIN_STANDBYNOW1;
1242         return ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
1243 }

Now here's the cleanup() function:
1420 static int idedisk_cleanup (ide_drive_t *drive)
1421 {
1422         if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
1423                 if (do_idedisk_flushcache(drive)) 
1424                         printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
1425                                 drive->name);
1426         return ide_unregister_subdriver(drive);
1427 }

--------------------------------------------------------------------------

Looking at this snippet of the the first snippet
4031                         if (event != SYS_RESTART)
4032                                 if (drive->driver != NULL && DRIVER(drive)->standby(drive))
4033                                 continue;
4034 
4035                         if (drive->driver != NULL && DRIVER(drive)->cleanup(drive))
4036                                 continue;
I also see another potential bug (actually, the original bug I posted about):
standby() returns 0 on success, and non-zero on failure. By this logic, if
standby() fails then cleanup() won't get called.




__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
