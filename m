Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272458AbTHFEeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 00:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272476AbTHFEeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 00:34:18 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:31250
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S272458AbTHFEeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 00:34:17 -0400
Subject: Re: [PATCH] autofs4 doesn't expire
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: maneesh@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Dick Streefland <dick.streefland@xs4all.nl>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030806042853.GA1298@in.ibm.com>
References: <4b0c.3f302ca5.93873@altium.nl>
	 <20030805164904.36b5d2cc.akpm@osdl.org>  <20030806042853.GA1298@in.ibm.com>
Content-Type: text/plain
Message-Id: <1060144454.18625.5.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 05 Aug 2003 21:34:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-05 at 21:28, Maneesh Soni wrote:
> Sorry, I don't think it is correct. This code is called under dcache_lock,
> taken in is_tree_busy(). mntput() calls dput() and which can lead to deadlock.

Urk.  On the other hand, it only calls dput if the refcount drops to
zero, which it can't because there's already a reference (hence the -2
in is_vfsmnt_tree_busy).

I'm not too keen on releasing dcache lock, since the whole point is to
keep the dcache tree stable while we traverse it.

> @@ -71,7 +74,8 @@ static int check_vfsmnt(struct vfsmount 
>         struct vfsmount *vfs = lookup_mnt(mnt, dentry);
>  
>         if (vfs && is_vfsmnt_tree_busy(vfs))
> -               ret--;
> +               ret = 0;

Erm, why?

	J

