Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTKMTXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 14:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbTKMTXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 14:23:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:30104 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264372AbTKMTXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 14:23:47 -0500
Date: Thu, 13 Nov 2003 11:34:04 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 0/5] Backing Store for sysfs (Overhauled)
In-Reply-To: <20031112122344.GD14580@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0311131127170.11822-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The main complaint was of over bloating kobject structure which becomes more
> painful when kobject is not part of sysfs. So now I have changed the data
> structures entirely. There is _no_ increase in the size of kobject structure.
> The kobject hierarchy is represented in the form of a new structure called
> sysfs_dirent (size 48 - bytes). sysfs_dirent will be there only for kobject
> elements (kobject, attribute, attribute group, symlink) which are represented 
> in sysfs. kobject structre has just one change. Now kobject has a field
> pointing to its sysfs_dirent instead of dentry.
> 
> struct sysfs_dirent {
>         struct list_head        s_sibling;
>         struct list_head        s_children;
>         void                    * s_element;
>         struct dentry           * s_dentry;
>         int                     s_type;
>         struct rw_semaphore     s_rwsem;
> };
> 
> The concept is still the same that in this prototype also we create dentry and 
> inode on the fly when they are first looked up. This is done for both leaf or 
> non-leaf dentries. The generic nature of sysfs_dirent makes it easy to do for 
> both leaf or non-leaf dentries. 

I still don't like it, though I think things are gradually getting better. 

I still think that keeping the directories static and only creating the 
leaf (file) dentries dynamically is the best tradeoff between complexity 
and memory consumption. 

It will require some minor infrastructural modification to associate a
kobject with all of its leaf nodes, but the result will be cleaner, and
the worst-case memory consumption will be less than your patches with a 
per-attribute-per-kobject data structure (which there currently isn't).

Thanks,


	Pat

