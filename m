Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292234AbSBYVC1>; Mon, 25 Feb 2002 16:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292272AbSBYVCS>; Mon, 25 Feb 2002 16:02:18 -0500
Received: from unthought.net ([212.97.129.24]:10685 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S292234AbSBYVCC>;
	Mon, 25 Feb 2002 16:02:02 -0500
Date: Mon, 25 Feb 2002 22:02:01 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Manohar Pradhan <mpml@isp.primuseurope.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re[2]: Urgent SCSI I/O Error
Message-ID: <20020225220200.D28035@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Manohar Pradhan <mpml@isp.primuseurope.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <194779754037.20020225190953@isp.primuseurope.com> <20020225210239.H24109@unthought.net> <154785420535.20020225204419@isp.primuseurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <154785420535.20020225204419@isp.primuseurope.com>; from mpml@isp.primuseurope.com on Mon, Feb 25, 2002 at 08:44:19PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 08:44:19PM +0000, Manohar Pradhan wrote:
> Hi All,
> 
> If the Hard Drive is died, means I will need to replace. I have backup
> for the Data in that /www partition.
> 
> Means when I replace new HDD, I will have to partition/format using
> fdisk /sda ?
> 
> >From my partition info,
> 
> /dev/sdb6               917072    732972    137516  84% /
> /dev/sda1                18820      5811     12037  33% /boot
> /dev/sda6              2218336    462492   1643156  22% /www
> /dev/sda5              5297560    418936   4609520   8% /home
> /dev/sda7              1210440    711516    437436  62% /software
> /dev/sdb1              5550188     50896   5217356   1% /usr
> /dev/sdb5              2016016     28572   1885032   1% /var
> 
> 
> My problematic HDD is /sda so if I replace this HDD, how can I boot as
> boot images are in /sda1 /boot partition. How can I copy this boot
> images to somewhere and make it work and what will be the process?

Plug in the new drive as well as the old one.

I assume the new drive will be /dev/sdc.  And I assume you are running
RedHat 6.2 with LILO.

If you statically set the IDs on your disks, just make sure that the
new disk has a higher ID than the two others, then it will be /dev/sdc.

> 
> I know if I reboot and replace the HDD, it will give problem while
> booting, any Idea to struggle with this?

# Create partitions on the new disk
sfdisk -d /dev/sda | sfdisk /dev/sdc

# Create filesystems
mke2fs /dev/sdc1
mke2fs /dev/sdc5
mke2fs /dev/sdc6
mke2fs /dev/sdc7

# Mount new filesystems
mkdir /mnt/boot
mount /dev/sdc1 /mnt/boot
mkdir /mnt/home
mount /dev/sdc5 /mnt/home
mkdir /mnt/www
mount /dev/sdc6 /mnt/www
mkdir /mnt/software
mount /dev/sdc7 /mnt/software

# Copy the boot filesystem
umask 0
tar cf - /boot | tar xCfp /mnt -

# Now, edit /etc/lilo.conf so that it
# contains something like:
boot=/dev/sdc
disk=0x80
map=/mnt/boot/map
# The boot and map lines are to be replaced, the
# disk line is to be inserted.

# Make the disk bootable - if this command
# complains, then I've overlooked something.
# Mail me back with the error message
lilo

# Now copy the other filesystems.  Note, these
# copy commands may fail horribly when you run
# into the bad blocks !!!  Don't worry, you have
# a backup...
tar cf - /home | tar xCfp /mnt -
tar cf - /www | tar xCfp /mnt -
tar cf - /software | tar xCfp /mnt -

# Now, your box may have died during the copying, 
# or it may still be more or less alive.  We
# don't care, it's time to lose the old drive.
# Now, power down, and unplug /dev/sda
# Move /dev/sdc so that it will be recognized as
# /dev/sda on boot.

 That should be it !  (in theory at least)

You probably want to change back your lilo.conf, and
check the files you (possibly) copied from the broken
disk.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
