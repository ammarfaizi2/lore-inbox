Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbSJPTgb>; Wed, 16 Oct 2002 15:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbSJPTgb>; Wed, 16 Oct 2002 15:36:31 -0400
Received: from ce00521-p19-hertas5.cenara.com ([195.38.1.140]:5063 "EHLO
	ce00521-p19-hertas5.cenara.com") by vger.kernel.org with ESMTP
	id <S261268AbSJPTg2>; Wed, 16 Oct 2002 15:36:28 -0400
Date: Wed, 16 Oct 2002 21:42:00 +0200 (CEST)
From: =?iso-8859-1?Q?Per_Lid=E9n?= <per@fukt.bth.se>
X-X-Sender: per@ce00521-p19-hertas5.cenara.com
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: devfs@oss.sgi.com, <linux-kernel@vger.kernel.org>
Subject: option "root=" doesn't work with devfs device names
Message-ID: <Pine.LNX.4.44.0210162018130.9032-100000@ce00521-p19-hertas5.cenara.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The "root=" kernel option doesn't work when used together with devfs
device names, e.g. root=/dev/discs/disc0/part1.

in do_mounts.c:

static int __init root_dev_setup(char *line)
{
        int i;
        char ch;

        ROOT_DEV = name_to_kdev_t(line);
                   ^^^^^^^^^^^^^^^^^^^^

The call to name_to_kdev_t() should return 0 if the device name starts
with "/dev/" but was not found in root_dev_names[] (which is the case if
e.g.  root=/dev/discs/disc0/part1 is used as a kernel option). But instead
of returning 0, name_to_kdev_t() will treat "discs/disc0/part1" as a
hex-number, which results in "discs/disc0/part1" being passed to
simple_strtoul(). The returned value from name_to_kdev_t() will thus be
garbage, and later calls to create_dev() will fail to create the
appropriate devfs entries because ROOT_DEV is non-zero.

The end result is a kernel panic "VFS: Unable to mount root fs on ...".

This has been broken since 2.4.19.

The patch below fixes this problem. It would be nice if this problem was
solved before 2.4.20 was released.

/Per


--- linux-2.4.20-pre10/init/do_mounts.c.old	2002-10-09 23:04:59.000000000 +0200
+++ linux-2.4.20-pre10/init/do_mounts.c	2002-10-09 23:50:46.000000000
+0200
@@ -258,6 +258,8 @@
 			}
 			dev++;
 		} while (dev->name);
+		if (!(dev->name))
+			return to_kdev_t(0);
 	}
 	return to_kdev_t(base + simple_strtoul(line,NULL,base?10:16));
 }



