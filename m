Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTKLOj1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 09:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbTKLOj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 09:39:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52609 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261863AbTKLOj0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 09:39:26 -0500
Date: Wed, 12 Nov 2003 14:39:24 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 2/5] sysfs-dir.patch
Message-ID: <20031112143923.GF24159@parcelfarce.linux.theplanet.co.uk>
References: <20031112122344.GD14580@in.ibm.com> <20031112122503.GE14580@in.ibm.com> <20031112122529.GF14580@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112122529.GF14580@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 05:55:29PM +0530, Maneesh Soni wrote:
> @@ -110,10 +231,15 @@ void sysfs_remove_subdir(struct dentry *
>  void sysfs_remove_dir(struct kobject * kobj)
>  {
>  	struct list_head * node;
> -	struct dentry * dentry = dget(kobj->dentry);
> +	struct dentry * dentry = kobj->s_dirent->s_dentry;
> +	struct sysfs_dirent * parent_sd;
>  
>  	if (!dentry)
> -		return;
> +		goto exit;
> +		
> +	spin_lock(&dcache_lock);
> +	dentry = dget_locked(dentry);
> +	spin_unlock(&dcache_lock);

Racy.  Directory might've been looked up just as you've decided that it
had no dentry.

>  void sysfs_rename_dir(struct kobject * kobj, const char *new_name)
> @@ -162,14 +292,170 @@ void sysfs_rename_dir(struct kobject * k
>  	if (!kobj->parent)
>  		return;
>  
> -	parent = kobj->parent->dentry;
> +	parent = kobj->parent->s_dirent->s_dentry;
> +	if (parent) {

Ditto.

Look, the *only* benefit of ramfs as a backing store for sysfs was that we
could easily get locking right.  You want second tree - you get to fight
for coherency.
