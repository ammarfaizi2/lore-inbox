Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbRCHUdI>; Thu, 8 Mar 2001 15:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRCHUc7>; Thu, 8 Mar 2001 15:32:59 -0500
Received: from mail-blue.research.att.com ([135.207.30.102]:22026 "HELO
	mail-blue.research.att.com") by vger.kernel.org with SMTP
	id <S129667AbRCHUcw>; Thu, 8 Mar 2001 15:32:52 -0500
Message-ID: <3AA7EC55.E0020B8E@research.att.com>
Date: Thu, 08 Mar 2001 15:32:21 -0500
From: Leon Bottou <leonb@research.att.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; IRIX 6.5 IP32)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Subtle NFS/VFS/GLIBC interaction bug
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary: 
  Sometimes files are missing when listing a directory.


The following runs on linux-2.4.2 on with glibc-2.2.2  (x86)
The relevant directory is NFS mounted (nfsvers=2)

----------------------- junk.c
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <dirent.h>
#include <errno.h>

int 
main(int argc, char **argv)
{
  struct DIRENT *ent = 0;
  DIR *dir = opendir(argv[1]);
  while ((ent = READDIR(dir)))
    puts(ent->d_name);
  closedir(dir);
}
--------------------------

Let's compare the 32 and 64 bit versions:

% gcc -D_GNU_SOURCE -DDIRENT=dirent -DREADDIR=readdir -o junk32 junk.c
% junk32 .kde/share/mimelnk/
.
..
audio   
video
application

% gcc -D_GNU_SOURCE -DDIRENT=dirent64 -DREADDIR=readdir64 -o junk64
junk.c
% junk64 .kde/share/mimelnk/                                      
.
..
audio
video
application
image	  <--------- This file was missing!

----------------------------

In glibc-2.2.2, both readdir and readdir64 use 
syscall __NR_getdents64. Here is a capture of what 
__NR_getdents64 returns:

  0x62, 0xce, 0xbe, 0x02, 0x00, 0x00, 0x00, 0x00, // d_ino
  0x2e, 0x17, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // d_off
  0x18, 0x00, 0x00, /* . */                       // d_reclen d_type
                    0x2e, 0x00, 0x00, 0x00, 0x00, // d_name

  0xe0, 0x05, 0xce, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0xe9, 0x34, 0xb9, 0x1e, 0x00, 0x00, 0x00, 0x00,
  0x18, 0x00, 0x00, /* .. */
                    0x2e, 0x2e, 0x00, 0x00, 0x00,
  
  0x1d, 0xd0, 0x69, 0x03, 0x00, 0x00, 0x00, 0x00, 
  0xe8, 0x32, 0x39, 0x6d, 0x00, 0x00, 0x00, 0x00, 
  0x20, 0x00, 0x00, /* audio */
                    0x61, 0x75, 0x64, 0x69, 0x6f,
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 

  0xfe, 0xcf, 0x69, 0x03, 0x00, 0x00, 0x00, 0x00, 
  0x88, 0xc8, 0x43, 0x6e, 0x00, 0x00, 0x00, 0x00, 
  0x20, 0x00, 0x00, /* video */
                    0x76, 0x69, 0x64, 0x65, 0x6f, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 

  0xc5, 0x62, 0xe5, 0x02, 0x00, 0x00, 0x00, 0x00, 
  0xe3, 0x73, 0xb8, 0x9d, 0xff, 0xff, 0xff, 0xff, 
  0x20, 0x00, 0x00, /* application */
                    0x61, 0x70, 0x70, 0x6c, 0x69, 
  0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x00, 0x00, 

  0xa8, 0xa1, 0x87, 0x03, 0x00, 0x00, 0x00, 0x00, 
  0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00,  // last d_ino
  0x20, 0x00, 0x00, /* image */
                    0x69, 0x6d, 0x61, 0x67, 0x65, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 


Note the strange numbers in the d_off fields.
These are in fact cookies used internally by nfs.
Under nfs2, these are 32 bit unsigned number, 
sign extended to 64 bits.

The last cookie has not been properly sign extended.  
The glibc-2.2.2 source code for readdir uses __NR_getdents64 
and converts the result into 32 bit dirents.  
But it sees that the last d_ino cannot fit in an off_t
and it simply bails out.

There is already a problem in the making since 
nfs3 cookies are 64 bits long.  But things should
work with nfs2.  

Everything happens in fact in linux/fs/readdir.c.
The dirent64 buffers are build using a function
of type filldir_t.  This functions takes
an off_t offset and writes it into the d_ino.
To be 64 bit clean, this function should 
take a loff_t.

Nevertheless, it happens that the last offset is
directly filled by function sys_getdents64 using 
file->f_pos which is a signed loff_t.  
It is set somewhere in linux/fs/nfs/dir.c from an 
unsigned 64 bit cookie variable containing 0xffffffff,
that is to say the unsigned 32 bit cookie used to 
indicate the end of the directory.
That explains the value of the last d_off field.


I can fix the problem using the following hack:

--- readdir.c.orig      Thu Mar  8 15:21:09 2001
+++ readdir.c   Thu Mar  8 15:21:39 2001
@@ -315,7 +315,7 @@
        lastdirent = buf.previous;
        if (lastdirent) {
                struct linux_dirent64 d;
-               d.d_off = file->f_pos;
+               d.d_off = (off_t)file->f_pos;
                copy_to_user(&lastdirent->d_off, &d.d_off,
sizeof(d.d_off));
                error = count - buf.count;
        }

That is acceptable as long as filldir_t 
does not handle 64bits offsets anyway. 

But it won't last.



Hope this helps.

- Leon Bottou
  <leonb@research.att.com>
