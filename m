Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVDCT6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVDCT6C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 15:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVDCT6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 15:58:02 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:40149 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S261882AbVDCT5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 15:57:54 -0400
Date: Sun, 3 Apr 2005 12:57:28 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
Subject: [PATCH] configfs, a filesystem for userspace-driven kernel object configuration
Message-ID: <20050403195728.GH31163@ca-server1.us.oracle.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Greg KH <greg@kroah.com>,
	Patrick Mochel <mochel@digitalimplant.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
	I humbly submit configfs.  With configfs, a configfs
config_item is created via an explicit userspace operation: mkdir(2).
It is destroyed via rmdir(2).  The attributes appear at mkdir(2) time,
and can be read or modified via read(2) and write(2).  readdir(3)
queries the list of items and/or attributes.
	The lifetime of the filesystem representation is completely
driven by userspace.  The lifetime of the objects themselves are managed
by a kref, but at rmdir(2) time they disappear from the filesystem.
	configfs is not intended to replace sysfs or procfs, merely to
coexist with them.
	An interface in /proc where the API is: 

	# echo "create foo 1 3 0x00013" > /proc/mythingy

or an ioctl(2) interface where the API is:

	struct mythingy_create {
		char *name;
		int index;
		int count;
		unsigned long address;
	}

	do_create {
		mythingy_create = {"foo", 1, 3, 0x0013};
		return ioctl(fd, MYTHINGY_CREATE, &mythingy_create);
	}

becomes this in configfs:

	# cd /config/mythingy
	# mkdir foo
	# echo 1 > foo/index
	# echo 3 > foo/count
	# echo 0x00013 > foo/address

	Instead of a binary blob that's passed around or a cryptic
string that has to be formatted just so, configfs provides an interface
that's completely scriptable and navigable.
	Patch is against 2.6.12-rc1-bk3.

http://oss.oracle.com/~jlbec/files/configfs/2.6.12-rc1-bk3/configfs-2.6.12-rc1-bk3-1.patch

Joel

-- 

"Not everything that can be counted counts, and not everything
 that counts can be counted."
        - Albert Einstein 

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
