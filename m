Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbWHQWuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbWHQWuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWHQWuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:50:05 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:57067 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030327AbWHQWuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:50:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=aZpLhJ7AykbgT+QMFyKcBEjBOCcAAqdXfjYrK2FUAJ3qA/LHMqoBXJTddl724krC+NAG64FK1puWy2Wn2WTJWahFWWXrMW6b5DB9o4MOeTZRQPdhwUEIym5/kAU3K94PMxeFwfGhKeuKqyloOCm7sibXqyUQQlWHUPbq6J9pcfc=
Message-ID: <44E4F2B1.30408@gmail.com>
Date: Thu, 17 Aug 2006 16:50:25 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RFC-patch - make sysfs_create_group skip members with attr.mode ==
 0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, code in hwmon/*.c uses sysfs_create_group less than it could.
A contributing reason is that many individual attr-files are created 
conditionally,
depending upon both underlying hardware, driver configuration, etc.

With proposed patch, the members of a group are conditionally created,
based upon the mode of the underlying attribute.  mode == 0 suppresses 
attr-file
creation, allowing run-time tweaks of compile-time defined groups.

The driver defining the group need only disable the unwanted members
before calling sysfs_create_group()  (theyre 'enabled' by initialization 
macros,
since thats the most useful default)

Specifically
- only group members are created conditionally,
    theres no effect on calls to device_create_file.
- only mode == 0 disables member creation,
    common values like  S_IWUSR | S_IRUGO have un-altered behavior.


Signed-off-by:  Jim Cromie  <jim.cromie@gmail.com>

$ diffstat diff.sys-grp-conditional-members
 group.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -ruNp -X dontdiff -X exclude-diffs try1/fs/sysfs/group.c try2/fs/sysfs/group.c
--- try1/fs/sysfs/group.c	2006-06-17 19:49:35.000000000 -0600
+++ try2/fs/sysfs/group.c	2006-08-17 10:06:26.000000000 -0600
@@ -32,7 +33,8 @@ static int create_files(struct dentry * 
 	int error = 0;
 
 	for (attr = grp->attrs; *attr && !error; attr++) {
-		error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
+		if ((*attr)->mode)
+			error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
 	}
 	if (error)
 		remove_files(dir,grp);


