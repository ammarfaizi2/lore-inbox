Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbULTXE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbULTXE0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbULTXBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:01:10 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:8957 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261683AbULTW6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:58:34 -0500
Date: Mon, 20 Dec 2004 14:58:17 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, willy@debian.org,
       benh@kernel.crashing.org
Subject: Re: [PATCH] add PCI API to sysfs
Message-ID: <20041220225817.GA21404@kroah.com>
References: <200412201450.47952.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412201450.47952.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 02:50:46PM -0800, Jesse Barnes wrote:
> Ok, how does this one look?  It needs some obvious work, but is the approach 
> of adding functionality to sysfs instead of /proc the right way to go?  What 
> I've done:
> 
>   o add mmap support to bin files in sysfs
>   o make PCI resources available via mmap
>   o make legacy I/O and memory space available in sysfs

How about splitting this up into the different patches that each do one
thing?

That way finding stuff like the following is easier:

> ===== fs/sysfs/bin.c 1.19 vs edited =====
> --- 1.19/fs/sysfs/bin.c	2004-11-01 12:46:46 -08:00
> +++ edited/fs/sysfs/bin.c	2004-12-20 11:07:58 -08:00
> @@ -92,6 +92,15 @@
>  	return count;
>  }
>  
> +static int mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct dentry *dentry = file->f_dentry;
> +	struct bin_attribute *attr = to_bin_attr(dentry);
> +	struct kobject *kobj = to_kobj(dentry->d_parent);
> +
> +	return attr->mmap(kobj, attr, vma);
> +}
> +

What happens if mmap is not set?  oops...

also CC: to the sysfs and pci maintainer will jog his memory that he
should be looking at these types of patches :)

thanks,

greg k-h
