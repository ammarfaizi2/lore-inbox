Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267850AbUI1Ufy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267850AbUI1Ufy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267852AbUI1Ufy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:35:54 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:48285 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S267850AbUI1Ufs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:35:48 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: John McCutchan <ttb@tentacle.dhs.org>
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org, rml@ximian.com,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, iggy@gentoo.org
In-Reply-To: <4159A187.3060402@sun.com>
References: <1096250524.18505.2.camel@vertex>  <4159A187.3060402@sun.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096403740.30123.16.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 16:35:40 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.0.0, Antispam-Data: 2004.9.28.2
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __LINES_OF_YELLING 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 13:38, Mike Waychison wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> John McCutchan wrote:
> |
> | --Why Not dnotify and Why inotify (By Robert Love)--
> |
> 
> | * inotify has an event that says "the filesystem that the item you were
> |   watching is on was unmounted" (this is particularly cool).
> 
> | +++ linux/fs/super.c	2004-09-18 02:24:33.000000000 -0400
> | @@ -36,6 +36,7 @@
> |  #include <linux/writeback.h>		/* for the emergency remount stuff */
> |  #include <linux/idr.h>
> |  #include <asm/uaccess.h>
> | +#include <linux/inotify.h>
> |
> |
> |  void get_filesystem(struct file_system_type *fs);
> | @@ -204,6 +205,7 @@
> |
> |  	if (root) {
> |  		sb->s_root = NULL;
> | +		inotify_super_block_umount (sb);
> |  		shrink_dcache_parent(root);
> |  		shrink_dcache_anon(&sb->s_anon);
> |  		dput(root);
> 
> This doesn't seem right.  generic_shutdown_super is only called when the
> last instance of a super is released.  If a system were to have a
> filesystem mounted in two locations (for instance, by creating a new
> namespace), then the umount and ignore would not get propagated when one
> is unmounted.
> 
> How about an approach that somehow referenced vfsmounts (without having
> a reference count proper)?  That way you could queue messages in
> umount_tree and do_umount..

I was not aware of this subtlety. You are right, we should make sure
events are sent for every unmount, not just the last.

John
