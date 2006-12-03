Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935858AbWLCLed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935858AbWLCLed (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 06:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935864AbWLCLed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 06:34:33 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:48984 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S935858AbWLCLec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 06:34:32 -0500
Message-ID: <4572B63C.60500@tls.msk.ru>
Date: Sun, 03 Dec 2006 14:34:20 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel NULL pointer deref in pipe() - hotplug in  initramfs
References: <200612030346_MC3-1-D3B9-C8E8@compuserve.com>
In-Reply-To: <200612030346_MC3-1-D3B9-C8E8@compuserve.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <45721258.1070802@tls.msk.ru>
> 
> On Sun, 03 Dec 2006 02:55:04 +0300, Michael Tokarev wrote:
> 
>> When /sbin/hotplug is present in initramfs, and it's a shell
>> script, kernel OOPSes on every hotplug invocation.
> 
> Does this mean that if it's _not_ a shell script everything
> is fine?

It means that if there's no pipe() call, everything is fine.
That is, for a shell script it's just more likely to contain
some pipelines.

[]
>> <0>EFLAGS: 00010282   (2.6.19-c3 #2.6.19.0)
[]
>> <4> <1>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000014
>> (note also the formatting is a bit wrong here -- that <4> prefix in front of <1>BUG..)
> 
> Yeah, that's from the previous oops.  I don't know why bust_spinlocks() leaves
> that hanging space, but it's been that way for a long time.

So can this be fixed, too? ;)

> BTW did you hand-edit the kernel .version file? "(2.6.19-c3 #2.6.19.0)"
> should not print unless you put that 2.6.19.0 there yourself.

Yes I did.  For an rpm- or deb-based kernel, the "build number" is irrelevant
(it's always 1, since both rpm and deb rebuilds everything from scratch).
This #2.6.19.0 comes from the package revision number - I just do
  echo $revision > .version
and remove the part from Makefile which updates the file on every (re)build.
But this isn't relevant for the discussion.

>> Are pipes disallowed in hotplug fired off initramfs?
> 
> AFAICT the pipe filesystem isn't registered yet, so probably not.
> 
>> (Even if they are, kernel probably still should not OOPS like that ;)
> 
> Either (a) pipefs should be registered early, or (b) the call should just
> fail instead of oopsing. Untested patch for (b) below, can you test it?
> (I'm not messing with the init sequence.)
> 
>> The error seems to be harmful however.  That is, hotplug script does not
>> run, but the kernel continues running.
> 
> You mean harmless, right?

Yup.  Oh those foreign languages... :)

> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
> --- 2.6.19.0.2-32.orig/fs/pipe.c
> +++ 2.6.19.0.2-32/fs/pipe.c

Another funny revision number? ;)

> @@ -839,9 +839,11 @@ static struct dentry_operations pipefs_d
>  
>  static struct inode * get_pipe_inode(void)
>  {
> -	struct inode *inode = new_inode(pipe_mnt->mnt_sb);
> +	struct inode *inode = NULL;
>  	struct pipe_inode_info *pipe;
>  
> +	if (pipe_mnt)
> +		inode = new_inode(pipe_mnt->mnt_sb);
>  	if (!inode)
>  		goto fail_inode;

Well, that fixes the OOPs, but I'd do it a in bit more readable way,
and eliminating the gotos too (this is a stylistic change - I see alot
of gotos in kernel for error returns, but here, in such a small function,
gotos looks somewhat funny, esp. when the only statement after the label
is 'return NULL'):

--- linux-2.6.19/fs/pipe.c.orig	2006-11-30 00:57:37.000000000 +0300
+++ linux-2.6.19/fs/pipe.c	2006-12-03 14:27:06.000000000 +0300
@@ -839,15 +839,20 @@ static struct dentry_operations pipefs_d

 static struct inode * get_pipe_inode(void)
 {
-	struct inode *inode = new_inode(pipe_mnt->mnt_sb);
+	struct inode *inode;
 	struct pipe_inode_info *pipe;

+	if (!pipe_mnt)	/* if pipefs isn't mounted (yet) */
+		return NULL;
+	inode = new_inode(pipe_mnt->mnt_sb);
 	if (!inode)
-		goto fail_inode;
+		return NULL;

 	pipe = alloc_pipe_info(inode);
-	if (!pipe)
-		goto fail_iput;
+	if (!pipe) {
+		iput(inode);
+		return NULL;
+	}
 	inode->i_pipe = pipe;

 	pipe->readers = pipe->writers = 1;
@@ -866,12 +871,6 @@ static struct inode * get_pipe_inode(voi
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;

 	return inode;
-
-fail_iput:
-	iput(inode);
-
-fail_inode:
-	return NULL;
 }

 struct file *create_write_pipe(void)


Or like this (without messing up with goto):

--- linux-2.6.19/fs/pipe.c.orig	2006-11-30 00:57:37.000000000 +0300
+++ linux-2.6.19/fs/pipe.c	2006-12-03 14:31:19.000000000 +0300
@@ -839,9 +839,12 @@ static struct dentry_operations pipefs_d

 static struct inode * get_pipe_inode(void)
 {
-	struct inode *inode = new_inode(pipe_mnt->mnt_sb);
+	struct inode *inode;
 	struct pipe_inode_info *pipe;

+	if (!pipe_mnt)	/* in case pipefs isn't mounted (yet) */
+		goto fail_inode;
+	inode = new_inode(pipe_mnt->mnt_sb);
 	if (!inode)
 		goto fail_inode;


In either case, this change not fixes the problem.  As I said, the OOPs is
harmless (yes, not harmful :), so the end effect is the same, just instead
of the OOPs, now the bad stuff is coming from shell complaining about failing
to create pipe.

/mjt
