Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWFSK1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWFSK1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 06:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWFSK1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 06:27:43 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:40899 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932366AbWFSK1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 06:27:42 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Date: Mon, 19 Jun 2006 20:27:29 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <9huc9217opa7sd26q5it13nvos9f9gg2in@4ax.com>
References: <20060616181419.GA15734@dmt> <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com> <20060618133718.GA2467@dmt> <ksib9210010mt9r3gjevi3dhlp4biqf59k@4ax.com> <20060618223736.GA4965@1wt.eu> <dmlb92lmehf2jufjuk8emmh63afqfmg5et@4ax.com> <20060619040152.GB2678@1wt.eu> <fvbc92higiliou420n3ctjfecdl5leb49o@4ax.com> <20060619080651.GA3273@1wt.eu> <p9qc92t26fu29ib2opsg4l82lju7qmldm9@4ax.com> <20060619092426.GC3472@1wt.eu>
In-Reply-To: <20060619092426.GC3472@1wt.eu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 11:24:26 +0200, Willy Tarreau <w@1wt.eu> wrote:

>On Mon, Jun 19, 2006 at 07:12:22PM +1000, Grant Coady wrote:
>> On Mon, 19 Jun 2006 10:06:51 +0200, Willy Tarreau <w@1wt.eu> wrote:
>> 
>> >Hi Grant,
>> >
>> >OK, it does *really* crash in vfs_unlink(), during the double_up on
>> >dentry->inode-i_zombie (dentry->inode = NULL).
>> >
>> >I suggest the following fix, I hope that it is correct and is not subject
>> >to any race condition :
>> >
>> >--- ./fs/namei.c.orig	2006-06-19 09:39:52.000000000 +0200
>> >+++ ./fs/namei.c	2006-06-19 09:51:09.000000000 +0200
>> >@@ -1478,12 +1478,14 @@
>> > int vfs_unlink(struct inode *dir, struct dentry *dentry)
>> > {
>> > 	int error;
>> >+	struct inode *inode;
>> > 
>> > 	error = may_delete(dir, dentry, 0);
>> > 	if (error)
>> > 		return error;
>> > 
>> >-	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
>> >+	inode = dentry->d_inode;
>> >+	double_down(&dir->i_zombie, &inode->i_zombie);
>> > 	error = -EPERM;
>> > 	if (dir->i_op && dir->i_op->unlink) {
>> > 		DQUOT_INIT(dir);
>> >@@ -1495,7 +1497,7 @@
>> > 			unlock_kernel();
>> > 		}
>> > 	}
>> >-	double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);
>> >+	double_up(&dir->i_zombie, &inode->i_zombie);
>> > 	if (!error) {
>> > 		d_delete(dentry);
>> > 		inode_dir_notify(dir, DN_DELETE);
>> >
>> >I think it will *not* oops anymore with this fix, but I'd like someone to
>> >review it to ensure that it is valid.
>> 
>> Strangely, the /etc/lilo.conf~ is as expected on a different box, 
>> 500MHz Celeron (Coppermine) + PATA HDD okay, whereas the Sempron 
>> SktA 2600+ with SATA HDD has something munch a couple chars off 
>> a filename during whatever vim does to make its backup file.
>
>I would not suspect the hardware. Instead, you should strace vim when it
>write the file :
>
>  # strace -s 1000 -o /tmp/vim.trace vim /etc/lilo.conf
>
>Grep for "lilo.co" in it, I'm fairly sure that you will find "lilo.co~".

stat64("/etc/lilo.conf", {st_mode=S_IFREG|0644, st_size=778, ...}) = 0
stat64("/etc/lilo.conf", {st_mode=S_IFREG|0644, st_size=778, ...}) = 0
stat64("/etc/lilo.conf", {st_mode=S_IFREG|0644, st_size=778, ...}) = 0
access("/etc/lilo.conf", W_OK)          = 0
open("/etc/lilo.conf", O_RDONLY)        = 3

## munch a char:
stat64("/etc/lilo_con.swp", 0xbfffee8c) = -1 ENOENT (No such file or directory)
lstat64("/etc/lilo_con.swp", 0xbfffef0c) = -1 ENOENT (No such file or directory)
lstat64("/etc/lilo_con.swp", 0xbffff38c) = -1 ENOENT (No such file or directory)
open("/etc/lilo_con.swp", O_RDWR|O_CREAT|O_EXCL, 0600) = 4

##munch another:
write(1, "\"/etc/lilo.conf\"", 16)      = 16
stat64("/etc/lilo.conf", {st_mode=S_IFREG|0644, st_size=778, ...}) = 0
access("/etc/lilo.conf", W_OK)          = 0
lstat64("/etc/lilo.conf", {st_mode=S_IFREG|0644, st_size=778, ...}) = 0
lstat64("/etc/lilo.conf", {st_mode=S_IFREG|0644, st_size=778, ...}) = 0
stat64("/etc/lilo.conf", {st_mode=S_IFREG|0644, st_size=778, ...}) = 0
unlink("/etc/lilo.co~")                 = 0
rename("/etc/lilo.conf", "/etc/lilo.co~") = 0

<http://bugsplatter.mine.nu/test/boxen/sempro/2.4.xx/vim.trace.gz>

If you want the whole trace (168k -> 26k gzipped). 

Cheers,
Grant.
