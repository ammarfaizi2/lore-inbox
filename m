Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268182AbRHAU6o>; Wed, 1 Aug 2001 16:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268174AbRHAU6f>; Wed, 1 Aug 2001 16:58:35 -0400
Received: from ns.starentnetworks.com ([64.240.141.2]:38823 "HELO
	starentnetworks.com") by vger.kernel.org with SMTP
	id <S268197AbRHAU6X>; Wed, 1 Aug 2001 16:58:23 -0400
Message-ID: <3B686D73.6040602@starentnetworks.com>
Date: Wed, 01 Aug 2001 16:58:27 -0400
From: Brian Ristuccia <bristuccia@starentnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, djohnson@starentnetworks.com
Subject: repeated failed open()'s results in lots of used memory [Was: [Fwd: memory consumption]]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Aug 2001 20:58:27.0156 (UTC) FILETIME=[B5F66940:01C11ACC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've been experiencing a problem where an errant process would run in a 
tight loop trying to create files in a directory where it did not have 
access. While this errant process was running, we'd notice all of the 
available memory shift from buffers/cache (or free) to used and stay 
that way while the process was running. vmstat also reports heavy in/out 
traffic on the swap, but swap consumption does not grow past a few dozen 
megabytes. The memory used by the process itself does not grow.

Note that we increase the default values for certain FS parameters:

echo '16384' >/proc/sys/fs/super-max
echo '32768' >/proc/sys/fs/file-max
echo '65535' > /proc/sys/fs/inode-max

We've created the following test program, which excercises the problem 
on both 2.2.19 and 2.4.7. All of the machines have at least 512mb of 
memory. I'd appreciate any feedback about reproducing the problem and 
potential causes/fixes.

Thanks.

-------- Original Message --------
Subject: memory consumption
Date: Wed, 1 Aug 2001 16:33:18 -0400 (EDT)
From: Dave Johnson <djohnson@starentnetworks.com>
Reply-To: djohnson@starentnetworks.com
To: bristucc@sw.starentnetworks.com



$ mkdir testdir
$ chmod a-w testdir
$ ./open_test testdir/test


strace shows:

open("testdir/test.10001051", O_WRONLY|O_CREAT|O_EXCL, 0666) = -1 EACCES 
(Permission denied)
open("testdir/test.10001052", O_WRONLY|O_CREAT|O_EXCL, 0666) = -1 EACCES 
(Permission denied)
open("testdir/test.10001053", O_WRONLY|O_CREAT|O_EXCL, 0666) = -1 EACCES 
(Permission denied)
open("testdir/test.10001054", O_WRONLY|O_CREAT|O_EXCL, 0666) = -1 EACCES 
(Permission denied)


memory starts getting used until the system begins to swap like crazy....

interestingly.. the filename needs to change, and it wont happen for a
while if you start with 0.


Happens with both 2.4.7 and 2.2.19



-----



#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main (int argc, char *argv[])
{
   int i;
   int fd;
   char name[100];

   if (argc != 2)
     return 1;

   for (i=10000000; i>=0; i++)
     {

       snprintf(name,99,"%s.%d",argv[1],i);

       fd = open(name, O_WRONLY|O_CREAT|O_EXCL, 0666);
       if (fd >= 0) close(fd);

     }

   return 0;
}

--------

-- 
David Johnson                       Starent Networks, Corp.
978-851-1173                        30 International Place
djohnson@starentnetworks.com        Tewksbury, MA 01876


