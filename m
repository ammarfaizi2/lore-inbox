Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131393AbQLFCiS>; Tue, 5 Dec 2000 21:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131394AbQLFCiI>; Tue, 5 Dec 2000 21:38:08 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:6916 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S131393AbQLFCiA>; Tue, 5 Dec 2000 21:38:00 -0500
Date: Wed, 6 Dec 2000 03:07:23 +0100
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org, adilger@turbolinux.com
Subject: fs corruption with invalidate_buffers()
Message-ID: <20001206030723.A1136@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some days ago I saw filesystem corruptions while testing the ext2fs online
resize patches by Andreas Dilger. First I thought that the online resizing
caused the problems, but further investigations didn't support this.

The latest observation shows that the problem is probably neither ext2 nor
lvm related: 

While resizing the filesystem, invalidate_buffers() is called from the
lvm code. (lvm.c, line 2251, in lvm_do_lv_extend_reduce()) 
If I remove this call, the corruption goes away. But this is probably not
the correct fix, as it can cause problems when reducing the lv size.


For reference, some details of the corruption:
	- I reproduced it with kernels between 2.4.0-test9 
	  and 2.4.0-test12-pre5
	- It is easily reproducible immediately after rebooting, but goes
	  away after some uptime (perhaps simply related to the amount of
  	  unused memory)
	- example script follows (attention: absolute device names 
	  like /dev/vg1/test3 hardcoded!)

---------------------------------------------------
#!/bin/bash

umount /dev/vg1/test3
lvremove -f /dev/vg1/test3
lvcreate -n test3 -L 100M vg1
mke2fs -b 1024 /dev/vg1/test3
ext2prepare -v /dev/vg1/test3 50G
mount /dev/vg1/test3 /mnt/test3

( sleep 20; echo resize1; e2fsadm -L+90M /dev/vg1/test3; echo resize1 done ;
 sleep 10; echo resize2; e2fsadm -L+90M /dev/vg1/test3; echo resize2 done ) &
echo copy1
cp -a /mnt/test/linux /mnt/test3/linux
echo copy1 done
echo copy2
cp -a /mnt/test3/linux /mnt/test3/linux2
echo copy2 done
---------------------------------------------------

/mnt/test/linux contains (surprise) a linux source, but I don't think 
the contents are too important :-). The sleep values are tuned in a way that
leads to the following sequence:

copy1, resize1, resize1 done, copy1 done,
copy2, resize2, resize2 done, copy2 done

After that, the first copy is corrupted in memory only (and is ok after
rebooting), and the second copy is corrupted in memory and on disk. The 
corrupted files contain parts of other files or binary stuff that may come
from directory entries.

I guess that invalidate_buffers somehow marks the buffers that contain
the first copy as free, but the second cp still uses them to copy the
files again. I don't understand the source well enough to find out
how it happens.

Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
