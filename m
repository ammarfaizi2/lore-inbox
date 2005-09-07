Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVIGRh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVIGRh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVIGRh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:37:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:13233 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751067AbVIGRh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:37:58 -0400
Date: Wed, 7 Sep 2005 13:37:42 -0400 (Eastern Daylight Time)
From: Janak Desai <janak@us.ibm.com>
To: viro@ZenIV.linux.org.uk, akpm@osdl.org
cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] (repost) New System call, unshare
Message-ID: <Pine.WNT.4.63.0509071335040.3520@IBM-AIP3070F3AM>
X-X-Sender: janak@imap.linux.ibm.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches were posted to lkml and fsdevel on 8/8/2005. I
amd resubmitting them for inclusion in the latest -mm tree.

Patch Summary:
This patch implements a new system call, unshare.  unshare allows
a process to disassociate parts of the process context that were 
initially being shared using the clone() system call.

The patch consists of two parts:
[1/2] Implements the system call handler function sys_unshare.
[2/2] Implements system call setup for x86 architecture.

Patch Justification:
Inspiration for this patch came from the 4/20/05 post by Al Viro
on linux-fsdevel mailing list and the needs of per-process namespace 
based polyinstantiated directories. In his post Mr. Viro saw 
usefulness of the ability to create a private namespace without
forking. He also mentioned that "There used to be a kinda-sorta 
agreement on a new syscall: unshare(bitmap) with arguments like 
those of clone(2)".

Polyinstantiated directories provide an instance of a directory
based on the process security context (user id and/or extended
selinux attributes). Polyinstantiation of public directories such 
as /tmp provide better separation of processes and prevent 
illegal information flow through file name. Polyinstantiated
directories are needed for common criteria certification using 
Mandatory Access Control based Protection Profiles.

Legacy Mandatory Access Control based UNIX operating systems
often modified kernel's pathname translation routines to
implement polyinstantiated directories. We are currently working
on a userspace polyinstantiation mechanism that was proposed by 
Stephen Smalley on the selinux mailing list and that uses the
per-process namespace.  Without the unshare system call, namespace
separation can only be achieved by clone(2), which would require 
porting and maintaining all commands such as login, su, gdm, ssh,
cron, newrole, etc, that establish a user session.  With unshare,
namespace setup can be done using PAM session management functions
without patching individual commands. 

This patch was first submitted on linux-fsdevel in mid-may and 
suggestions for improvement have been incorporated. It is now
ported to the latest rc5-mm tree and is being submitted for
consideration for inclusion in the mm tree for 2.6.14.

Overall Approach:
The overall approach followed clone system call and its permission
enforcement. However, instead of clone's "what do we leave shared?" 
logic, here the logic was based on "what do we unshare, that was 
previously being shared?". Unlike clone, which operated on a newly 
allocated and not-yet schedulable task structure, additional
task_lock()s were taken to avoid race conditions from unshare 
having to work on the current process. Before unsharing any part 
of the context, a check is made to ensure that that part of the
context is being shared in the first place. If the context is not
being shared to begin with, the system call returns success. If 
the context is being shared, the system call makes a private copy
of that context and updates the appropriate pointers of the 
current task structure to point to this new private copy. If 
allocation and setup of the private copy fails, the system call 
appropriately restores the current task structures to continue 
using the shared context.

Currently, the system call only allows "unsharing" of namespace, 
signal handlers and virtual memory, because those three were deemed 
useful on the linux-fsdevel mailing list.

Testing:
The patch has been unit tested on uni-processor i386 architecture
based Fedora Core 3 system. It has been tested to ensure successful
unsharing of namespace, signal handlers and virtual memory. 
Requirement of root privileges to unshare namespace have been
verified.


Signed off by: Janak Desai

