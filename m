Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161131AbWJDHu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbWJDHu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbWJDHuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:50:55 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:36710 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161131AbWJDHuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:50:54 -0400
Message-ID: <452367A8.3010405@sw.ru>
Date: Wed, 04 Oct 2006 11:50:00 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Stephen Tweedie <sct@redhat.com>,
       Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ext4@vger.kernel.org, devel@openvz.org, cmm@us.ibm.com
CC: Eric Sandeen <sandeen@sandeen.net>, Kirill Korotaev <dev@openvz.org>
Subject: ext2/ext3 errors behaviour fixes
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Current error behaviour for ext2 and ext3 filesystems does not fully correspond
to the documentation and should be fixed.

According to man 8 mount, ext2 and ext3 file systems allow to set one of 3
different on-errors behaviours:

---- start of quote man 8 mount ----
errors=continue / errors=remount-ro / errors=panic
    Define the behaviour when an error is encountered. (Either ignore errors and
just mark the file system erroneous and continue, or remount the file system
read-only, or panic and halt the system.) The default is set in the filesystem
superblock, and can be changed using tune2fs(8).
---- end of quote ----

However EXT3_ERRORS_CONTINUE is not read from the superblock, and thus
ERRORS_CONT is not saved on the sbi->s_mount_opt. It leads to the incorrect
handle of errors on ext3.

Then we've checked corresponding code in ext2 and discovered that it is
buggy as well:
- EXT2_ERRORS_CONTINUE is not read from the superblock (the same);
- parse_option() does not clean the alternative values and thus
  something like (ERRORS_CONT|ERRORS_RO) can be set;
- if options are omitted, parse_option() does not set any of these options.

Therefore it is possible to set any combination of these options on the ext2:
- none of them may be set:
 EXT2_ERRORS_CONTINUE on superblock / empty mount options;
- any of them may be set using mount options;
- 2 any options may be set: by using EXT2_ERRORS_RO/EXT2_ERRORS_PANIC on the
superblock and other value in mount options;
- and finally all three options may be set by adding third option in remount.

Currently ext2 uses these values only in ext2_error() and it is not leading to
any noticeable troubles. However somebody may be discouraged when he will try to
workaround EXT2_ERRORS_PANIC on the superblock by using errors=continue in mount
options.

The following patches fix this.

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team

