Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbSJOUWt>; Tue, 15 Oct 2002 16:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264648AbSJOUWp>; Tue, 15 Oct 2002 16:22:45 -0400
Received: from smtp3.us.dell.com ([143.166.148.134]:49423 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP
	id <S263208AbSJOUWG>; Tue, 15 Oct 2002 16:22:06 -0400
Date: Tue, 15 Oct 2002 15:27:59 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: mochel@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: driverfs dir removal bug in 2.5.41
Message-ID: <Pine.LNX.4.44.0210151520020.22262-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat, I've run across a weird error with driverfs.  When removing a 
directory that has had a symlink created in it, directory removal fails.  
Since there's no return code from the function, there's no way to 
know that it failed, but it shouldn't fail regardless.

The driverfs_remove_dir(&dir) fails.  The files and symlinks in the
directory are removed, but the directory itself isn't removed.  Below is a
small test module (tried in 2.5.41) that shows the behavior.  In
test_exit(), driverfs_remove_file() shouldn't be necessary, and in fact
doesn't matter if it's there or not - same failure is seen either way.  
The name of the symlink doesn't matter either.

I haven't torn into driverfs (nor played with ramfs) to see where the 
failure is occurring, hoped you'd know off the top of your head.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

/*
 * driverfs_symlink_test.c
 */

#include <linux/module.h>
#include <linux/string.h>
#include <linux/types.h>
#include <linux/init.h>
#include <linux/stat.h>
#include <linux/err.h>
#include <linux/driverfs_fs.h>

MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
MODULE_DESCRIPTION("driverfs symlink test");
MODULE_LICENSE("GPL");

static struct driver_dir_entry test_dir = {
	.name = "test",
	.mode = (S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO),
};

static int __init
test_init(void)
{
	int rc;

	printk(KERN_INFO "driverfs symlink test\n");
	rc = driverfs_create_dir(&test_dir, NULL);
	if (rc)
		return rc;
	rc = driverfs_create_symlink(&test_dir, "test", "../");
	return rc;
}

static void __exit
test_exit(void)
{
	driverfs_remove_file(&test_dir, "test");
	driverfs_remove_dir(&test_dir);
}

late_initcall(test_init);
module_exit(test_exit);

