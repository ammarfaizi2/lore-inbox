Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbSLTIMf>; Fri, 20 Dec 2002 03:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267746AbSLTIMf>; Fri, 20 Dec 2002 03:12:35 -0500
Received: from gorilla.mchh.siemens.de ([194.138.158.18]:21393 "EHLO
	gorilla.mchh.siemens.de") by vger.kernel.org with ESMTP
	id <S266285AbSLTIMd>; Fri, 20 Dec 2002 03:12:33 -0500
Message-ID: <3E02D29A.8070101@siemens.com>
Date: Fri, 20 Dec 2002 09:19:38 +0100
From: Steffen Rumler <Steffen.Rumler@siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Steffen.Rumler@siemens.com
Subject: cramfs over ramdisk broken ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have tried to use cramfs over a ramdisk.
It seems not working stable.
I have tested this for the 2.4.2 and 2.4.20 kernel,
with the same result:

#  create a file tree
#
$ mkdir x
$ touch x/a
$ touch x/b
$ touch x/c

#  make a cramfs image
#
$ mkcramfs x x.img
Super block: 76 bytes
   a
   b
   c
Directory data: 124 bytes
Everything: 4 kilobytes
warning: gids truncated to 8 bits.  (This may be a security concern.)

#  dump the cramfs image; seems OK
#
$ od -x x.img
0000000 3d45 28cd 0000 0001 0000 0000 0000 0000
0000020 6f43 706d 6572 7373 6465 5220 4d4f 5346
0000040 e779 c669 363f 24cf 0b02 65c2 aef3 7fdb
0000060 6f43 706d 6572 7373 6465 0000 0000 0000
0000100 41ed 0000 0030 4200 04c0 0000 81a4 0000
0000120 0000 4200 0001 0000 0061 0000 81a4 0000
0000140 0000 4200 0001 0000 0062 0000 81a4 0000
0000160 0000 4200 0001 0000 0063 0000 0000 0000
0000200 0000 0000 0000 0000 0000 0000 0000 0000
*
0010000

#  write cramfs image to ramdisc
#
$ dd if=x.img of=/dev/ram15
8+0 records in
8+0 records out

#  check the ramdisc; seems OK
#
$ od -x /dev/ram15 | head
0000000 3d45 28cd 0000 0001 0000 0000 0000 0000
0000020 6f43 706d 6572 7373 6465 5220 4d4f 5346
0000040 e779 c669 363f 24cf 0b02 65c2 aef3 7fdb
0000060 6f43 706d 6572 7373 6465 0000 0000 0000
0000100 41ed 0000 0030 4200 04c0 0000 81a4 0000
0000120 0000 4200 0001 0000 0061 0000 81a4 0000
0000140 0000 4200 0001 0000 0062 0000 81a4 0000
0000160 0000 4200 0001 0000 0063 0000 0000 0000
0000200 0000 0000 0000 0000 0000 0000 0000 0000
*

#  mount it (first try)
#
$ mkdir mnt
$ mount -t cramfs /dev/ram15 mnt
mount: wrong fs type, bad option, bad superblock on /dev/ram15,
        or too many mounted file systems

#  check the ramdisc again; it seems to be demaged :-(
#
$ od -x /dev/ram15 | head
0000000 01fd 0809 0000 0000 8d28 080a 0000 0000
0000020 01fd 0809 0000 0000 8dc8 080a 0000 0000
0000040 01fd 0809 0000 0000 0000 0000 0000 0000
0000060 01fd 0809 0000 0000 e028 0809 0000 0000
0000100 01fd 0809 0000 0000 0000 0000 0000 0000
0000120 01fd 0809 0000 0000 e048 0809 0000 0000
0000140 01fd 0809 0000 0000 8b48 080a 0000 0000
0000160 01fd 0809 0000 0000 0000 0000 0000 0000
0000200 01fd 0809 0000 0000 0063 0064 0000 0000
*

#  write cramfs image to ram disc (second try)
#
$ dd if=x.img of=/dev/ram15
8+0 records in
8+0 records out

#  mount it (second try); it seems now working now !!!
#
$ mount -t cramfs /dev/ram15 mnt
$ ls mnt/
a  b  c


Any idea ?


Steffen

-- 


--------------------------------------------------------------

Steffen Rumler
ICN CP D NT SW 7
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@siemens.com
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------



