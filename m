Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267193AbSLaHw4>; Tue, 31 Dec 2002 02:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267199AbSLaHwz>; Tue, 31 Dec 2002 02:52:55 -0500
Received: from ip68-101-124-193.oc.oc.cox.net ([68.101.124.193]:52353 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S267193AbSLaHwy>; Tue, 31 Dec 2002 02:52:54 -0500
Date: Tue, 31 Dec 2002 00:01:17 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org, mnalis-umsdos@voyager.hr
Subject: [BUG] 2.2.24-rc2/2.4.18/2.4.20 UMSDOS hardlink OOPS
Message-ID: <20021231080117.GB2323@ip68-4-86-174.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, a description of a 100% reproducible (at least for me) test case
(do not do this on any disk whose data you value):

1. Make sure your (IDE in my case) has a FAT (FAT32 in my case)
partition.

2. Unzip zipslack.zip from Slackware 8.1 (I used the copy from disc 4 of
the boxed set, but it's also available from the Slackware FTP mirrors).
After you do this step, there should be a \LINUX directory on your FAT
partition. BTW, the problem happens whether I unzip it with Linux
(SuperRescue 2.1.2) or with Windows XP (Service Pack 1).

3. Boot into the ZipSlack installation using either a 2.2.24-rc2 or
2.4.20 kernel. (Or, perhaps more easily, use one of Slackware 8.1's
2.4.18 kernels.)

4. Obtain the glibc package from the "L" package set (I think the
filename is "slackware/l/glibc-2.2.5-i386-2.tgz" from your Slackware 8.1
FTP mirror, your Slackware CD burned from downloaded ISO file, or disc 1
from your Slackware boxed set), and install it. In my case, this means
inserting disc 1, mounting it on /mnt/cdrom, and "installpkg
/mnt/cdrom/slackware/l/glibc-2.2.5-i386-2.tgz".

5. Wait a few moments. The kernel will oops (unable to dereference NULL
pointer) when extracting one of the glibc timezone files, and tar will
segfault.

This problem does not happen if I use kernel 2.0.40-rc6 instead of
2.2.24-rc2, 2.4.18, or 2.4.20.

I'll post .config files, decoded oopses, output of strace of tar before
it crashes, or stuff like that upon request (i.e., reply to this mail
and ask me for it if you need it). However, I first want to find out if
this is a known problem and if I should go through the effort of finding
that information.

Here's what I've figured out so far: The oops is happening in
umsdos_solve_hlink, and that function is being invoked by UMSDOS_link.
Code like the following is being executed in UMSDOS_link in both 2.2 and
2.4 (there are two instances of such code in UMSDOS_link in both 2.2 and
2.4 and I'm not sure which instance is causing this):

        /* Do a real lookup to get the short name dentry */
	[snip...]
        /* now resolve the link ... */
	        temp = umsdos_solve_hlink(temp);

(temp is a struct dentry*)

In 2.4.20, what happens next is:
struct dentry *umsdos_solve_hlink (struct dentry *hlink)
{
        /* root is our root for resolving pseudo-hardlink */
        struct dentry *base = hlink->d_sb->s_root;
        struct dentry *dentry_dst;
        char *path, *pt;
        int len;
        struct address_space *mapping = hlink->d_inode->i_mapping;
                                                      ^^OOPS

When it oopses, hlink->d_inode is NULL. (If I'm understanding the
VFS/dcache stuff correctly, that means hlink is a negative dentry when
this happens. Assuming we're not just stumbling into some corrupted data
or something.)

Similarly, in 2.2.24-rc2:
struct dentry *umsdos_solve_hlink (struct dentry *hlink)
{
        [snip...]
        len = umsdos_file_read_kmem (&filp, path, hlink->d_inode->i_size);
                                                                ^^OOPS

At this point I'm not sure what should be done to fix this. Should
umsdos_solve_hlink (or UMSDOS_link?) be turning the negative dentry into
some kind of error (-ENOENT?) for the calling function? (Hmmm... after I
send this e-mail I think I'll try making a patch to do this and see what
effect it has.) Or is the negative dentry itself a symptom/result of
another UMSDOS bug?

I'd appreciate any help in trying to fix this bug. If it turns out to be
something that can't be fixed without rewriting UMSDOS from scratch or
something equally hard, I'd like to at least add a debugging
check/printk to umsdos_solve_hlink to make life easier for the next
person who runs into this bug.

-Barry K. Nathan <barryn@pobox.com>
