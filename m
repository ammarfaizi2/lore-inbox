Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbRE2P0W>; Tue, 29 May 2001 11:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbRE2P0M>; Tue, 29 May 2001 11:26:12 -0400
Received: from proton.llumc.edu ([143.197.200.1]:51912 "EHLO proton.llumc.edu")
	by vger.kernel.org with ESMTP id <S262019AbRE2PZ5>;
	Tue, 29 May 2001 11:25:57 -0400
Reply-To: <baumann@optivus.com>
From: "Michael Baumann" <baumann@optivus.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with minor devices numbers in 2.4.4/68k
Date: Tue, 29 May 2001 08:25:49 -0700
Message-ID: <000201c0e853$a4f4a540$bbc8c58f@mycroftpc.llumc.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully, I don't offend anyone by asking this here, but
I assume (perhaps incorrectly) that this is the place to
go when trying to decipher writing device drivers.
My problem: A device driver for a custom board worked fine
under 2.2.10 - I used the minor number to identify various
channels on the board. In the open() call, I used
MINOR(inode->i_rdev) to decode that information. Now under
2.4.4, this *appears* to be broken - though I am certain it
is my misunderstanding. In checking, every minor device
returns exactly the same i_rdev code.
Anyway, attached are some snippets of code, if someone can point
out where I goofed, I would really appreciate it. I'm in the
process of trying to prove to the PHB that linux is a viable
embedded platform.
Note that at this time, I am not using the devfs, though I did
try and incorporate support. If someone can point me to a good
"how do deal with the changes in 2.4" I'd appreciate that as well.
Anyway in my init_module() routine I register the region, and major/minor
devices:
 if((devfs_register_chrdev(42,"timer", &timer_fops)) < 0)
  {
    printk("Timer: bad doobie, device 42 missing?\n");
    return -EIO;
  }
  else
  {
    int tmrs;

    printk("Timer: Cool,chrdev is regsitered!\n");
    for(tmrs=0;tmrs<8;tmrs++)
    {
      timer_handles[tmrs]=devfs_register(NULL,"timer",DEVFS_FL_DEFAULT,
                                42, tmrs, S_IFCHR |
                                       S_IRUGO | S_IWUSR,&timer_fops,tmrs);
    }

  }


And in my open, I try to decode the minor number:

static
int timer_open(struct inode *inode, struct file *file)
{

  printk("sysclk: open() f_mode=%d, minor = %1d, minor2 %0x\n",
       file->f_mode, MINOR(inode->i_rdev),(inode->i_rdev));

  // we're going to be sneaky here - the minor number
  // stored in the file private data will be used to
  // index the 'interrupt occurred' flag for the poll
  // routine.
  file->private_data = (void *)MINOR(inode->i_rdev);
  usequeue[MINOR(inode->i_rdev)]++;
  MOD_INC_USE_COUNT;
  return 0;
}

But MINOR(inode->i_rdev) always returns 0, no matter which
minor devices I open.
If this doesn't belong here, please direct mail me, as this
has my stymied.

Thank you.

--
Michael Baumann  Optivus Technology Inc.|Loma Linda University Medical
Center
San Bernardino, California. (909)799-8308 |Internet: baumann@llumc.edu


