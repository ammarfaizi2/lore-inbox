Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269997AbRHJTvv>; Fri, 10 Aug 2001 15:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270001AbRHJTvp>; Fri, 10 Aug 2001 15:51:45 -0400
Received: from stine.vestdata.no ([195.204.68.10]:55528 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S269999AbRHJTv2>; Fri, 10 Aug 2001 15:51:28 -0400
Date: Fri, 10 Aug 2001 21:51:36 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Ben LaHaise <bcrl@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010810215136.C16864@vestdata.no>
In-Reply-To: <20010703065312.J4841@vestdata.no> <Pine.LNX.4.33.0107032211120.30968-100000@toomuch.toronto.redhat.com> <20010726041821.C19238@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: =?iso-8859-1?Q?=3C20010726041821=2EC19238=40vestdata=2Eno=3E=3B_from_Rag?=
 =?iso-8859-1?Q?nar_Kj=F8rstad_on_Thu=2C_Jul_26=2C_2001_at_04:18:21AM_+02?=
 =?iso-8859-1?Q?00?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2001 at 04:18:21AM +0200, Ragnar Kjørstad wrote:
> On Tue, Jul 03, 2001 at 10:19:36PM -0400, Ben LaHaise wrote:
> > Here's the [completely untested] generic scsi fixup, but I'm told that
> > some controllers will break with it.  Give it a whirl and let me know how
> > many pieces you're left holding. =)  Please note that msdos partitions do
> > *not* work on devices larger than 2TB, so you'll have to use the scsi disk
> > directly.  This patch applies on top of v2.4.6-pre8-largeblock4.diff.
> 
> I just trid this, but when I can't load the md modules becuase of
> missing symbols for __divdi3 and __umoddi3. 

I compiled md and lvm into the kernel rather than modules and got a
little futher:

* raid 0 over 4*600GB devices:
  * made filesystem
  * tried reading of the end of the device (dd skip=xx)
  all tests successful

* >1TB devices over scsi.
  * /proc/partitions report incorrect sizes
    [root@K2 /root]# cat /proc/partitions 
    major minor  #blocks  name
       8     0   17921835 sda
       8     1      56196 sda1
       8     2          1 sda2
       8     5   13076878 sda5
       8     6     530113 sda6
       8    16 9223372035816620928 sdb
       8    32 9223372035975108096 sdc
  * mkreiserfs fails: "mkreiserfs: can not create filesystem on that
    small device (0 blocks)."
  * mkfs.xfs fails: "warning - cannot set blocksize on block device
    /dev/sdb: Invalid argument"
  I assume both mkreiserfs and mkfs.xfs use ioctl to get the size
  of the device, and that ioctl uses an unsigned int? How is 
  userspace supposed to get the devicesize of >2GB devices with
  your code?
  * mkfs.ext2 makes the machine panic after a while.
    Unfortenately I don't have the panic message anymore, and at the
    moment I don't have the hardware to redo the test.
  * fdisk bails out with 'Unable to read /dev/sdb'
    Strace shows:
    open("/dev/sdb", O_RDWR)                = 3
    uname({sys="Linux", node="K2.torque.com", ...}) = 0
    ioctl(3, 0x1268, 0xbffff8f4)            = 0
    fstat64(3, {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 16), ...}) = 0
    ioctl(3, BLKGETSIZE, 0xbffff924)        = 0
    ioctl(3, HDIO_GETGEO, 0xbffff918)       = 0
    read(3, "", 512)                        = 0



-- 
Ragnar Kjorstad
Big Storage
