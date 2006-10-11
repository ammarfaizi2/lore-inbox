Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161419AbWJKVWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161419AbWJKVWd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161422AbWJKVHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:07:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:17057 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161419AbWJKVHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:07:19 -0400
Date: Wed, 11 Oct 2006 14:06:48 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, seto.hidetoshi@jp.fujitsu.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 38/67] sysfs: remove duplicated dput in sysfs_update_file
Message-ID: <20061011210648.GM16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-remove-duplicated-dput-in-sysfs_update_file.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

Following function can drops d_count twice against one reference
by lookup_one_len.

<SOURCE>
/**
 * sysfs_update_file - update the modified timestamp on an object attribute.
 * @kobj: object we're acting for.
 * @attr: attribute descriptor.
 */
int sysfs_update_file(struct kobject * kobj, const struct attribute * attr)
{
        struct dentry * dir = kobj->dentry;
        struct dentry * victim;
        int res = -ENOENT;

        mutex_lock(&dir->d_inode->i_mutex);
        victim = lookup_one_len(attr->name, dir, strlen(attr->name));
        if (!IS_ERR(victim)) {
                /* make sure dentry is really there */
                if (victim->d_inode &&
                    (victim->d_parent->d_inode == dir->d_inode)) {
                        victim->d_inode->i_mtime = CURRENT_TIME;
                        fsnotify_modify(victim);

                        /**
                         * Drop reference from initial sysfs_get_dentry().
                         */
                        dput(victim);
                        res = 0;
                } else
                        d_drop(victim);

                /**
                 * Drop the reference acquired from sysfs_get_dentry() above.
                 */
                dput(victim);
        }
        mutex_unlock(&dir->d_inode->i_mutex);

        return res;
}
</SOURCE>

PCI-hotplug (drivers/pci/hotplug/pci_hotplug_core.c) is only user of
this function. I confirmed that dentry of /sys/bus/pci/slots/XXX/*
have negative d_count value.

This patch removes unnecessary dput().

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/sysfs/file.c |    5 -----
 1 file changed, 5 deletions(-)

--- linux-2.6.18.orig/fs/sysfs/file.c
+++ linux-2.6.18/fs/sysfs/file.c
@@ -483,11 +483,6 @@ int sysfs_update_file(struct kobject * k
 		    (victim->d_parent->d_inode == dir->d_inode)) {
 			victim->d_inode->i_mtime = CURRENT_TIME;
 			fsnotify_modify(victim);
-
-			/**
-			 * Drop reference from initial sysfs_get_dentry().
-			 */
-			dput(victim);
 			res = 0;
 		} else
 			d_drop(victim);

--
