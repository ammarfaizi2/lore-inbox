Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSHaETc>; Sat, 31 Aug 2002 00:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSHaETc>; Sat, 31 Aug 2002 00:19:32 -0400
Received: from cttsv008.ctt.ne.jp ([210.166.4.137]:38573 "EHLO
	cttsv008.ctt.ne.jp") by vger.kernel.org with ESMTP
	id <S315928AbSHaETb> convert rfc822-to-8bit; Sat, 31 Aug 2002 00:19:31 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Gabor Kerenyi <wom@tateyama.hu>
To: linux-kernel@vger.kernel.org
Subject: extended file permissions based on LSM
Date: Sat, 31 Aug 2002 06:16:04 +0200
User-Agent: KMail/1.4.2
Cc: Chris Wright <chris@wirex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208310616.04709.wom@tateyama.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm looking around the LSM module and I know it has got some
functions for the filesystem part. Well, it looks good, but the
permission thing is not enough. In fact it's enough to check
the permission of an inode, but I'd like to check permissions
for a dentry AND its inode at the same place and time.

I don't know why the dentry can't be passed to the permission
function along with the inode in the VFS.
When a user opens a file it may be useful in some cases
to decide whether a user can access an inode for the
requested operation according to it's the dentry (and
to the parent dentry)

In this case you could specify rights for the directory
too affecting the files' permissions belonging to that dir.
like how Novell does.
Before it starts a flame: I don't say  I would like to
have such a default feature in the kernel, but I'd like to
have the possibility to write a LSM.

In this case we could have some very interesting (useful
or not who knows) features. For example if there are two
hardlinks for an inode in two different directories, the user
could get different rights for the file depending on the
path he reaches it.

I've got some reports that people switching from Windows
(not mentioning those who would like to switch from Novell)
don not find the current file permission system satisfying
even with ACL.
I think there is a demand for an extended file access
feature. This could be done filesystem independent way
storing additional information in a database (at file level).

As I've been thinking for 2 days I think at least the
following modificatoins would be necessary:

int vfs_permission(struct inode *inode, int mask, struct dentry *dentry);
int permission(struct inode *inode, int mask, struct dentry *dentry);
and in the LSM the same.

The current permission checking method could be left
untouched and if there are some cases when the dentry
can be NULL it wouldn't hurt. But on the other hand
we could build something more complex in LSM if needed.

To be honest I'd welcome if the whole file permisssion
part were moved to LSM. It would allow us to override the
currently implemented default behavior easily.
Now the LSM is only an extension and if the vfs_permission
(or the i_ops->permission) fails then the security_ops->permission
can't override it.
If we also pass the "retval" to the LSM's permission
fn. then it can decide whether it wants to override the
previously failed perm. check or just returns the "retval".

We could get more control of these if the may_* functions
were moved to LSM as well.

Any thoughts about these?

Gabor

