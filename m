Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVGHKZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVGHKZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVGHKZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:25:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:10990 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262432AbVGHKZo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:25:44 -0400
Subject: [RFC PATCH 0/8] shared subtree
From: Ram <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <1120816072.30164.10.camel@localhost>
References: <1120816072.30164.10.camel@localhost>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1120817327.30164.40.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Jul 2005 03:25:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am enclosing 8 patches that implement shared subtree functionality as
detailed in Al Viro's RFC found at http://lwn.net/Articles/119232/

The incremental patches provide the following functionality:

1) shared_private_slave.patch : Provides the ability to mark a subtree
as shared or private or slave.
	
2) unclone.patch : provides the ability to mark a subtree as unclonable.
NOTE: this feature is an addition to Al Viro's RFC, to solve the
vfsmount explosion. The problem is  detailed here:  
	http://www.ussg.iu.edu/hypermail/linux/kernel/0502.0/0468.html

3) rbind.patch : this patch adds the ability to propogate binds/rbinds
across vfsmounts.

4) move.patch : this patch provides the ability to move a
shared/private/slave/unclonable subtree to some other mountpoint. It
also provides the same feature to pivot_root()

5) umount.patch: this patch provides the ability to propogate unmounts.

6) namespace.patch: this patch provides ability to clone a namespace,
with propogation set to vfsmounts in the new namespace.

7) automount.patch: this patch provides the automatic propogation for
mounts/unmounts done through automounter.

8) pnode_opt.patch: this patch optimizes the redundent code in pnode.c .


I have unit tested the code and it mostly works. However i am still
debugging some race conditions.

Also have enclosed a mount command source (initially written by Miklos)
that helps to create shared/private/unclone/slave trees. 


Thanks to Mike Waychison, Miklos Szeredi, J. Bruce Fields for helping
out with the various scenarios and initial comments on the code. And to
Al Viro for silently listening to our conversation.

Looking forward towards lots of feedback and comments,
RP

----------------------------------------------------------------------------------------

//
//this code was developed my Miklos Szeredi <miklos@szeredi.hu>
//and modified by Ram Pai <linuxram@us.ibm.com>
// sample usage:
// 		newmount /tmp shared
//
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mount.h>
#include <sys/fsuid.h>

int main(int argc, char *argv[])
{
	int type;
    if(argc != 3) {
        fprintf(stderr, "usage: %s dir
<shared|slave|private|unclone>\n", argv[0]);
        return 1;
    }

     fprintf(stdout, "%s %s %s\n", argv[0], argv[1], argv[2]);

    if (strcmp(argv[2],"shared")==0)
	    type=1048576;
    else if (strcmp(argv[2],"slave")==0)
	    type=524288;
    else if (strcmp(argv[2],"private")==0)
	    type=262144;
    else if (strcmp(argv[2],"unclone")==0)
	    type=131072;
    else {
        fprintf(stderr, "invalid operation: %s\n", argv[2]);
        return 1;
    }

    setfsuid(getuid());
    if(mount("", argv[1], "ext2", type, "") == -1) {
        perror("mount");
        return 1;
    }
    return 0;
}

----------------------------------------------------------------------------------------


