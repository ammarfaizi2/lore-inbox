Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbUCKXL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 18:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbUCKXL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 18:11:27 -0500
Received: from fungus.teststation.com ([212.32.186.211]:15370 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S261809AbUCKXLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 18:11:17 -0500
Date: Fri, 12 Mar 2004 00:10:47 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Adam Sampson <azz@us-lot.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smbfs Oops with Linux 2.6.3
In-Reply-To: <Pine.LNX.4.58.0403110124390.29087@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0403112355350.8470-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004, Zwane Mwaikambo wrote:

> Two patches applied in this order;
> 
> patch-smbfs-readdir-oops
>  fs/smbfs/inode.c          |    1 +
>  fs/smbfs/proc.c           |   45 ++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/smb_fs_sb.h |    2 +-
>  3 files changed, 44 insertions(+), 4 deletions(-)
> 
> patch-smbfs-rcls-cleanup
>  fs/smbfs/proc.c           |   12 ++++++------
>  include/linux/smb_fs_sb.h |    3 ---
>  2 files changed, 6 insertions(+), 9 deletions(-)
> 
> I avoided adding the BUG() placeholders, since we will PF# when we hit the
> NULL pointer and the call trace should give us a decent idea of where it
> is.

Not quite there yet.

I have added a sleep(10); in send_fs_socket (smbmount) to give me time to 
send other requests to the fs. Here is what I get when I run the mount and 
two 'ls' in parallel:

1. smbmount mounts and goes to sleep
2. ls 1 ends up in smb_proc_ops_wait
3. ls 2 ends up in smb_proc_ops_wait
4. smbmount wakes up and passes the socket to smbfs

5a. ls 1 & 2 are woken and lists files

5b. Everyone is waiting for ls 1 (or 2 I don't know) to timeout.
6b. ls 1 lists nothing because of the timeout
7b. ls 2 lists normally


The difference between a and b is that in the first case I wait a few 
seconds between the two ls' but in the second I run the within one second 
of each other.

Some debug printks give:

a:
smb_proc_getattr_null: 
smb_proc_ops_wait: state: 1
smb_proc_getattr_null: 
smb_proc_ops_wait: state: 1
(here it waits for smbmount to do the ioctl)
smb_proc_ops_wait: result: 26192
smb_proc_ops_wait: result: 23014

b:
smb_proc_readdir_null: 
smb_proc_ops_wait: state: 1
smb_proc_getattr_null: 
smb_proc_ops_wait: state: 1
(here it waits for smbmount to do the ioctl)
smb_proc_ops_wait: result: 0
smb_proc_ops_wait: result: 682


The difference must be that in a the inode data for the root inode is not 
considered current when the second ls runs, but I don't understand why the 
readdir is printed before the getattr.

/Urban

