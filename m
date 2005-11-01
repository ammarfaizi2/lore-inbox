Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbVKBAJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbVKBAJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbVKBAJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:09:16 -0500
Received: from [67.137.28.189] ([67.137.28.189]:59522 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S1751464AbVKBAJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:09:16 -0500
Message-ID: <4367F06B.2050209@utah-nac.org>
Date: Tue, 01 Nov 2005 15:47:07 -0700
From: "Jeff V. Merkey" <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9 VFS Issues
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have noticed one change from 2.4 to 2.6 which although esoteric, is 
bothersome.  Did the dache assign static inode identities to
the "." and ".." directories for 2.6 differnt than the behavior in 2.4?  
I notice that the root of ext based filesystems is now always "2"
for the root (although readdir commands pass "0" during passes through 
the readdir function calls into the VFS).  I have noticed that
the user space libs always fix "2" as the value of the inode for the 
root directory.  I am having trouble getting the . and .. entries to show
up under 2.6, although, they seem to work just fine when you type cd .. 
and cd ., etc.

I am using my DSFS file system and I am generating inode numbers 
dynamically for captured data, but I am seeing problems with readdir calls
from a program I wrote called "dir.c" (ATTACHED) I am using to debug.  
Anyone know what changed in 2.6.9 and later
kernels that is causing this, and is there some assummption I need to 
make?  I also have noted that the . and .. entries are no longer
passed (or at least do not appear to be getting passed) through to the 
VFS layer from the dcache.  The DSFS works just fine but this
issue is somewhat bothersome and I would like to know what is wrong here 
as it may be exposing some other problem in the VFS
(apart from wetware issues).

Here's what dir.c outputs from user space for ext3 FS's:

. type-4 len-16 ino-00000002 off-0000000C
.. type-4 len-16 ino-00000002 off-00000018
lost+found type-4 len-24 ino-0000000B off-0000002C
grub type-4 len-16 ino-00000FC1 off-00000038
initrd-2.6.5-1.358.img type-8 len-40 ino-0000001D off-00000058
bzImage type-8 len-24 ino-00000010 off-00000078
boot.b type-8 len-24 ino-00000011 off-00000088
chain.b type-8 len-24 ino-0000000E off-00000098
os2_d.b type-8 len-24 ino-0000000F off-000000A8
vmlinuz-2.6.9 type-8 len-32 ino-00000012 off-00000150
kernel.h type-8 len-24 ino-00000019 off-000001FC
System.map-2.6.5-1.358 type-8 len-40 ino-0000000C off-0000021C
config-2.6.5-1.358 type-8 len-32 ino-0000000D off-00000238
vmlinuz-2.6.5-1.358 type-8 len-32 ino-0000001C off-00000400



Here's what dir.c outputs from user space for DSFS (I assign inode 
numbers dynamically, however, the data files are fixed in the FS 
beneath).  The . and .. entries are always missing.

stats type-4 len-24 ino-00008001 off-00000003
slots type-4 len-24 ino-00008002 off-00000004
slice type-4 len-24 ino-00008003 off-00000005
merge type-4 len-24 ino-00008004 off-00000006
create type-4 len-24 ino-00008005 off-00000007
1-lo type-8 len-16 ino-10000005 off-0000000B
5-eth0 type-8 len-24 ino-10000009 off-00000027
1-lo-slice type-8 len-24 ino-20000025 off-0000002B
5-eth0-slice type-8 len-24 ino-20000029 off-00000046



Here's the dir.c source code I wrote to test this:

#include <unistd.h>
#include <dirent.h>

int main(int argc, char *argv[])
{
     register struct dirent *entry;
     DIR *local_dir;

         if (argc < 2)
         {
               printf("USAGE:  dir <directory>\n");
               return 1;
         }

         if ((local_dir = opendir(argv[1])) == NULL)
             return 1;

         while ((entry = readdir(local_dir)) != NULL)
        {
             printf("%s type-%d len-%d ino-%08X off-%08X\n",
                    entry->d_name,      
                   (int)entry->d_type,     
                   (int)entry->d_reclen,     
                   (unsigned)entry->d_ino,     
                   (unsigned)entry->d_off);
         }
         closedir(local_dir);

         return 0;
}

Any ideas?

Jeff
