Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293075AbSCBRik>; Sat, 2 Mar 2002 12:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293230AbSCBRib>; Sat, 2 Mar 2002 12:38:31 -0500
Received: from host-049.towebs.com ([200.49.75.49]:37393 "EHLO
	global1.toservers.com") by vger.kernel.org with ESMTP
	id <S293075AbSCBRiU>; Sat, 2 Mar 2002 12:38:20 -0500
Message-ID: <3C810DB4.7020606@laotraesquina.com.ar>
Date: Sat, 02 Mar 2002 14:36:52 -0300
From: Pablo Alcaraz <pabloa@laotraesquina.com.ar>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: es-ar, en-us
MIME-Version: 1.0
To: James D Strandboge <jstrand1@rochester.rr.com>
CC: LINUX-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: ext3 and undeletion
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD063077D8@loisexc2.loislaw.com> <20020227210026.GA18660@rochester.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James D Strandboge wrote:

>On Tue, Feb 26, 2002 at 11:48:49AM -0600 or thereabouts, Rose, Billy wrote:
>
>It seems to me the undelete could be in the kernel, and could be
>beneficial.
>
>Rather than modifying all the different filesystems, or libc, we could
>modify the VFS unlink function in the kernel.  It would therefore work
>with all filesystems working under VFS, and all programs regardless of
>whether it is linked against the latest libc or using LD_PRELOAD.
>
>There are obviously some issues that would have to be resolved with the
>algorithm, but as far as versioning I think that is the role of backups.
>This should be more along the lines of 'whoops I deleted /etc/fstab.
>Let me go get it out of /.undelete'.  Simply put, if the file is already
>in there, just overwrite it.  Though, it wouldn't be too hard to tack a
>.1 on the end of the old file I suppose.
>
>Also, if the files are just moved to the .undelete directory (and by
>moved, I mean a hard link to .undelete, followed by a remove of the
>original), disk usage as reported by df and du would still show it
>as there.  I don't think that is a very big deal.  I simple solution
>would just be to have a cron job empty out older files.  It should be the
>sysadmin's job on how to manage the .undelete directory, not the kernel's
>(IMO).  Of course, a configurable daemon to monitor the directory could
>be implemented, but this especially seems like a userspace problem.
>
>Undeleting is the harder of these.  User's should be able to undelete a
>file IMO.  Either an suid binary has to be created to list the contents
>of the .undelete directory based on the user running it, or they can go
>into the directory and get what they need.  Rather than having a world
>write /tmp like directory, it could be chmod 1755 with root ownership.
>That way users could browse the directory and cp out what they wanted,
>but they can't write to it and overwrite files and do symlink attacks,
>etc.  This is a security issue in terms of privacy though, depending on
>the user's umask.  The former (an suid binary) is probably better, but
>the latter is the easier to implement.
>
>Please comment.
>
>James Strandboge
>




My 2ctvs.

An example:
We have a file server with these fs mounted in /mnt

/
+-mnt
|   +-fs1
|   |  +-dir1
|   |  |  +--rw-r--r--    1 root     root          121 dic 13 19:47 
file1.txt
|   |  |  +--rw-r--r--    1 paul     sales      232121 dic 13 19:47 
file2.txt
|   |  +-dir2
|   |  |  +--rw-r--r--    1 root     root        72534 dic 14 20:27 
file1.txt
|   |  |  +--rw-r--r--    1 mary     sales        9493 dic 14 20:27 
file2.txt
|   +-fs2
|   |  +-dir1
|   |  |  +--rw-r--r--    1 root     root         2312 dic 13 19:55 
other1.txt
|   |  |  +--rw-r--r--    1 root     root          232 dic 13 19:55 
other2.txt
|   |  +-dir2
|   |     +--rw-r--r--    1 root     root         2534 dic 14 20:34 
file1.txt
|   |     +--rw-r--r--    1 root     root          493 dic 14 20:54 
file2.txt
|
.



Then, UserA delete /mnt/fs1/dir1/file2.txt and UserB delete 
/mnt/fs1/dir2/file2.txt and create a new one. The state of the file 
server will be:

+-mnt
|   +-fs1
|   |  +-dir1
|   |  |  +--rw-r--r--    1 root     root          121 dic 13 19:47 
file1.txt
|   |  +-dir2
|   |  |  +--rw-r--r--    1 root     root        72534 dic 14 20:27 
file1.txt
|   |  |  +--rw-r--r--    1 UserB    sales        9493 Mar 02 12:22 
file2.txt
|   |  +-.undelete
|   |     +--rw-r--r--    1 paul     sales      232121 dic 13 19:47 
+2001-12-13 19:47:23+dir1+file2.txt
|   |     +--rw-r--r--    1 mary     sales        9493 dic 14 20:27 
+2001-12-14 20:27:44+dir2+file2.txt
|   +-fs2
|   |  +-dir1
|   |  |  +--rw-r--r--    1 root     root         2312 dic 13 19:55 
other1.txt
|   |  |  +--rw-r--r--    1 root     root          232 dic 13 19:55 
other2.txt
|   |  +-dir2
|   |     +--rw-r--r--    1 root     root         2534 dic 14 20:34 
file1.txt
|   |     +--rw-r--r--    1 root     root          493 dic 14 20:54 
file2.txt
|
.


I mean:

When a user delete a file, the old version would be moved to .undelete 
directory and renamed:

yyyy-MM-dd hh:mm:ss+directory+from+became+filename.ext

and there would be a '.undelete' directory inside each mounted fs (with 
undelete option in /etc/fstab?).

In this way we can undelete erased files AND complete directory erases.
The date/time attr of the files in 'undelete' directory could be set the 
delete time.

The rwx attr do not change



Another filename version could be:

yyyy-MM-dd 
hh:mm:ss+owner_user+owner_group+rwxrwxrwx+directory+from+became+filename.ext

The date/time attr of the files in 'undelete' directory would have the 
delete time AND the uid/gid would have the uid/gid of the user that 
delete the files, so he/she will have rights to undelete it.

The rwx attr changes to 440 I think...



If the fs does not support long names, then we could to move and rename 
it as file1.txt.1, file1.txt2, etc...


A undelete utility that complete the picture would be usefull.


Sorry my English. ;-)


Pablo


