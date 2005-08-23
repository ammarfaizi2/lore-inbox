Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVHWHlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVHWHlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 03:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVHWHlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 03:41:39 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:54216 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750838AbVHWHlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 03:41:39 -0400
Date: Tue, 23 Aug 2005 17:32:58 +1000
From: Nathan Scott <nathans@sgi.com>
To: Pekka Enberg <penberg@gmail.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: sysfs: write returns ENOMEM?
Message-ID: <20050823073258.GE743@frodo>
References: <11394.1124781401@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508190055.25747.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 8/19/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > According to the SuS write() can not return ENOMEM, only ENOBUFS is allowed
> > (surprisingly read() is allowed to use both ENOMEM and ENOBUFS):
> > 
> > http://www.opengroup.org/onlinepubs/000095399/functions/write.html
> > 
> > Should we adjust sysfs write to follow the standard?
> 
> Please note that sysfs is not the only one to do this. A quick peek
> reveals XFS and CIFS returing ENOMEM for write() and there are
> probably others as well. Perhaps we should replace ENOMEM with ENOBUFS

FWIW, all filesystems using the generic page cache routines are able
to return this - see mm/filemap.c -> generic_file_buffered_write...

	page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
	if (!page) {
		status = -ENOMEM;
		break;
	}

which is a similar condition to the one under which the XFS code is
returning this error.  Let me know what the verdict is and I'll get
the XFS side of this merged if its really necessary.

cheers.

-- 
Nathan
