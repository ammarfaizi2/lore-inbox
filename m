Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWCVX1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWCVX1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWCVX1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:27:14 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:11735 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932496AbWCVX1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:27:12 -0500
Date: Wed, 22 Mar 2006 15:27:09 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Possible NULL pointer dereference in fs/configfs/dir.c
Message-ID: <20060322232709.GD7844@ca-server1.us.oracle.com>
Mail-Followup-To: Eric Sesterhenn <snakebyte@gmx.de>,
	linux-kernel@vger.kernel.org
References: <1143068729.27276.1.camel@alice>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143068729.27276.1.camel@alice>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 12:05:29AM +0100, Eric Sesterhenn wrote:
> this fixes coverity bug #845, if group is NULL,
> we dereference it when setting up dentry.

	Is the converity checker merly looking at in-function patterns?
Where can I access the bug report (sorry for the question).
	group cannot be null here, we aren't called any other way.  So
while you are correct that the code below is needed in the presence of a
NULL group, really the "if (group" isn't necessary, just the "if
(group->default_groups)".  I could even BUG_ON() if you'd like.

Joel

> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> --- linux-2.6.16/fs/configfs/dir.c.orig	2006-03-23 00:02:23.000000000 +0100
> +++ linux-2.6.16/fs/configfs/dir.c	2006-03-23 00:03:49.000000000 +0100
> @@ -500,7 +500,7 @@ static int create_default_group(struct c
>  static int populate_groups(struct config_group *group)
>  {
>  	struct config_group *new_group;
> -	struct dentry *dentry = group->cg_item.ci_dentry;
> +	struct dentry *dentry;
>  	int ret = 0;
>  	int i;
>  
> @@ -512,6 +512,8 @@ static int populate_groups(struct config
>  		 * parent to find us, let alone mess with our tree.
>  		 * That said, taking our i_mutex is closer to mkdir
>  		 * emulation, and shouldn't hurt. */
> +		dentry = group->cg_item.ci_dentry;
> +
>  		mutex_lock(&dentry->d_inode->i_mutex);
>  
>  		for (i = 0; group->default_groups[i]; i++) {
> 
> 

-- 

"Win95 file and print sharing are for relatively friendly nets."
	- Paul Leach, Microsoft

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
