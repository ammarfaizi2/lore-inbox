Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWFBBCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWFBBCw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 21:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWFBBCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 21:02:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30613 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751047AbWFBBCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 21:02:51 -0400
Date: Thu, 1 Jun 2006 18:06:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: jblunck@suse.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@zeniv.linux.org.uk, dgc@sgi.com, balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries
 list (2nd version)
Message-Id: <20060601180659.56e69968.akpm@osdl.org>
In-Reply-To: <20060601095125.773684000@hasse.suse.de>
References: <20060601095125.773684000@hasse.suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 11:51:25 +0200
jblunck@suse.de wrote:

> This is an attempt to have per-superblock unused dentry lists.

Fairly significant clashes with
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/broken-out/fix-dcache-race-during-umount.patch 

I guess Neil's patch will go into the 2.6.18 tree, so you'd be best off
working against that.


Also, you're making what appears to be a quite deep design change to a
pretty important part of the memory reclaim code and all the info we have
is this:


+				/*
+				 * Try to be fair to the unused lists:
+				 *  sb_count/sb_unused ~ count/global_unused
+				 *
+				 * Additionally, if the age_limit of the
+				 * superblock is expired shrink at least one
+				 * dentry from the superblock
+				 */
+				tmp = sb->s_dentry_stat.nr_unused /
+					((unused / count) + 1);
+				if (!tmp && time_after(jiffies,
+						       sb->s_dentry_unused_age))
+					tmp = 1;


Please, we'll need much much more description of what this is trying to
achieve, why it exists, analysis, testing results, etc, etc.  Coz my
immediate reaction is "wtf is that, and what will that do to my computer?".

In particular, `jiffies' has near-to-zero correlation with the rate of
creation and reclaim of these objects, so it looks highly inappropriate
that it's in there.  If anything can be used to measure "time" in this code
it is the number of scanned entries, not jiffies.

But I cannot say more, because I do not know what that code is doing, nor
what problem it is trying to solve.  The patch changelog would be an
appropriate place for that info ;)


