Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTEUJTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTEUJTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:19:47 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:48346 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262030AbTEUJTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:19:46 -0400
Date: Wed, 21 May 2003 02:35:23 -0700
From: Andrew Morton <akpm@digeo.com>
To: maneesh@in.ibm.com
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       dipankar@in.ibm.com, Paul.McKenney@us.ibm.com
Subject: Re: [patch 1/2] vfsmount_lock
Message-Id: <20030521023523.655bc8f2.akpm@digeo.com>
In-Reply-To: <20030521092502.GD1198@in.ibm.com>
References: <20030521092502.GD1198@in.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2003 09:32:47.0877 (UTC) FILETIME=[F0DA1B50:01C31F7B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
>  struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
>   {
>   	struct list_head * head = mount_hashtable + hash(mnt, dentry);
>   	struct list_head * tmp = head;
>  -	struct vfsmount *p;
>  +	struct vfsmount *p, *found = NULL;
>   
>  +	spin_lock(&vfsmount_lock);
>   	for (;;) {
>   		tmp = tmp->next;
>   		p = NULL;
>   		if (tmp == head)
>   			break;
>   		p = list_entry(tmp, struct vfsmount, mnt_hash);
>  -		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry)
>  +		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry) {
>  +			found = mntget(p);
>   			break;
>  +		}
>   	}
>  -	return p;
>  +	spin_lock(&vfsmount_lock);
>  +	return found;
>   }

err, how many times do you want to spin that lock?

