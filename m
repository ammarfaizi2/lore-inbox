Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVBVSkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVBVSkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 13:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVBVSkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 13:40:22 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:64658 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261203AbVBVSkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 13:40:18 -0500
Subject: Re: idr_remove
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Houston <jim.houston@ccur.com>
Cc: russell@coker.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <1109096566.1010.53.camel@new.localdomain>
References: <200502192332.54815.russell@coker.com.au>
	 <1109096566.1010.53.camel@new.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 22 Feb 2005 13:32:48 -0500
Message-Id: <1109097168.15893.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 13:22 -0500, Jim Houston wrote:
> I spent time looking at the pty and selinux code yesterday.
> I had little luck finding where the selinux code hooks into 
> the pty code.

The call to lookup_one_len() by fs/devpts/inode.c:get_node() ultimately
calls permission(...,MAY_EXEC,...) on the devpts root directory, which
will call security_inode_permission() -> selinux_inode_permission() to
check search access to the directory.  Hence, get_node() can fail if
SELinux is enabled and the process has no permission at all to
search /dev/pts.  If it can get that far, then the inode will ultimately
have its security label set upon the d_instantiate() call (via
security_d_instantiate() -> selinux_d_instantiate()), and be
subsequently checked for opens/reads/writes via the
selinux_inode_permission() and selinux_file_permission() hook functions.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

