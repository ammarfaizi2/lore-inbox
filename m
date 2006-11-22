Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755921AbWKVOC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921AbWKVOC7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 09:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755923AbWKVOC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 09:02:59 -0500
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:48592 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1755921AbWKVOC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 09:02:58 -0500
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: [OT] Re: bug? VFAT copy problem
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: The Peach <smartart@tiscali.it>, linux-kernel@vger.kernel.org
In-Reply-To: <87mz6kajks.fsf@duaron.myhome.or.jp>
References: <20061120164209.04417252@localhost>
	 <877ixqhvlw.fsf@duaron.myhome.or.jp> <20061120184912.5e1b1cac@localhost>
	 <87mz6kajks.fsf@duaron.myhome.or.jp>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Nov 2006 14:02:55 +0000
Message-Id: <1164204175.10427.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Have vfat a limit of a file size when copy ? 
I tried copy 4.4 Megas to a vfat partition but I  got 
a limit size exceed 

Thanks,
--
Sérgio M. B.

On Wed, 2006-11-22 at 00:46 +0900, OGAWA Hirofumi wrote:
> The Peach <smartart@tiscali.it> writes:
> 
> > On Tue, 21 Nov 2006 02:32:43 +0900
> > OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> >
> >> I couldn't reproduce this for now. Could you tell mount options which
> >> you used? and after mount, "cat /proc/mounts", please.
> >
> > # mount | grep vfat 
> > /dev/sdb1 on /mnt/iomega type vfat (rw,uid=1000,gid=100,codepage=850,iocharset=iso8859-15) 
> >
> > it seems only related to those kind of files, but I don't know how to inspect the "file properties" and why these files behave like this.
> > As you can see and with a strace made on cp, the files _seems_ to be copied with the correct case, whilst it isn't, as seen with "ls". This and other things let me think is a vfat problem.
> 
> Hmm... This may be the dentry cache handling problem of fat.
> 
> Can you try the attached debug patch? And if you comment-in the
> following parts, does this problem fix?
> 
> @@ -787,6 +830,9 @@ static int vfat_rmdir(struct inode *dir,
>  	clear_nlink(inode);
>  	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
>  	fat_detach(inode);
> +	/* need to revalidate for next create */
> +	table = (sbi->options.name_check == 's') ? 3 : 1;
> +//	dentry->d_op = &vfat_dentry_ops[table];
> @@ -811,6 +858,9 @@ static int vfat_unlink(struct inode *dir
>  	clear_nlink(inode);
>  	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
>  	fat_detach(inode);
> +	/* need to revalidate for next create */
> +	table = (sbi->options.name_check == 's') ? 3 : 1;
> +//	dentry->d_op = &vfat_dentry_ops[table];

