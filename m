Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275621AbRJNP7J>; Sun, 14 Oct 2001 11:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275675AbRJNP7A>; Sun, 14 Oct 2001 11:59:00 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:16018 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S275621AbRJNP6o>; Sun, 14 Oct 2001 11:58:44 -0400
Date: Sun, 14 Oct 2001 18:59:08 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: mount --bind and -o [re: nosuid/noexec/nodev handling]
Message-ID: <20011014185908.P1074@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-09-12 17:30:22 you wrote:
>
> nosuid, noexec and nodev are made vfsmount flags (instead of
> superblock ones).  Places that used to check them switched to checking
> vfsmount->mnt_flags.  get_filesystem_info() updated, ditto for
> do_add_mount() and do_remount(). 
>
> As the result, these flags are per-mountpoint now.  E.g. we can turn them
> on and off for arbitrary subtree:
> 
> mount --bind /home/luser /home/luser
> mount -o remount,noexec /home/luser
> 
> will turn noexec on for subtree at /hom/luser without affecting the rest
> /of home.  Other obvious applications is mounting a filesystem nosuid for
> chroot jail and normally outside of it, yodda, yodda.
> 
> Patch is completely straightforward.  Works here and it had been in ac for
> -a month (i.e. since 2.4.8-ac2).  Please, apply.

Ummh, is there a reason for this behaviour?

$ mount --bind -o noexec /bin /home/sftp/bin
$ mount 
(...)
/bin on /home/sftp/bin type none (rw,noexec,bind)
$ cd /home/sftp/bin
$ ./uname -a
Linux babbage 2.4.10-ac10 #4 SMP Wed Oct 10 11:39:11 EEST 2001 i686 unknown
$ mount -o remount,noexec /home/sftp/bin
$ mount 
(...)
/bin on /home/sftp/bin type none (rw,noexec,bind)
$ ./uname -a
zsh: permission denied: ./uname

That seems like a bug to me. At very least, mount shouldn't report noexec if
the mount point isn't. Or am I missing something?

Further:

$ mount --bind -o ro /bin /home/sftp/bin 
$ mount -o remount,ro,nosuid /home/sftp/bin 
$ mount: /home/sftp/bin is busy      
$ mount
(...)
/bin on /home/sftp/bin type none (ro,bind)
$ cd /home/sftp/bin
$ touch asdakhsdhdh
$ ls asdakhsdhdh
asdakhsdhdh

So I suppose ro (umask, some others as well) is not supported for --bind
mounted mount points? Would it be possible to have mount to report error if
non-functional -o options are passed to it?

And btw, thanks. --bind is a damn cool feature to have.


-- v --

v@iki.fi
