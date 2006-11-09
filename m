Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424051AbWKIPYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424051AbWKIPYv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424050AbWKIPYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:24:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61910 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424031AbWKIPYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:24:50 -0500
Subject: [PATCH 0/3] new_inode_autonum: intro -- ensure uniqueness of i_ino
	and try to prevent st_ino EOVERFLOW in userspace
From: Jeff Layton <jlayton@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Date: Thu, 09 Nov 2006 10:24:36 -0500
Message-Id: <1163085876.21469.43.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This started as a rather simple problem. glibc uses fstat64() internally
when making a stat() call. If the st_ino field returned by this call
does not fit in the buffer allocated by the program, glibc (rightly)
generates an EOVERFLOW in userspace. This is generally only a problem
when the program is compiled without -D_FILE_OFFSET_BITS=64.

The kernel declares ino_t to be an unsigned long which is generally
32-bits on 32-bit kernels and 64-bits on 64-bit kernels. The new_inode
function has a static unsigned long counter that it uses to assign out
i_ino values.

On a 64-bit kernel, the value in this counter eventually becomes too
large to fit in 32-bits, and glibc starts throwing EOVERFLOW errors to
programs compiled without large file offsets. This creates a situation
where such a program will work fine on a 32-bit kernel, but when run on
a 64-bit kernel it will eventually start falling down.

We can't do much about this on filesystems that have true 64-bit inodes,
but on filesystems that get "pseudo_inode" values via new_inode or
iunique, we should attempt to make them fit in a 32-bit value.

While fixing this, we discovered that many filesystems seem to blindly
accept the i_ino value given by new_inode. new_inode makes no actual
check to see if an i_ino value is unique, so once the counter overflows
you can end up with more than one inode with the same i_ino value.

The following set of patches should remedy both of these problems. While
these are arguably security-related, these patches are probably better
suited to 2.6.20 than anything earlier.

-- Jeff


