Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUHYNJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUHYNJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 09:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUHYNJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 09:09:18 -0400
Received: from mx01.netapp.com ([198.95.226.53]:2982 "EHLO mx01.netapp.com")
	by vger.kernel.org with ESMTP id S267350AbUHYNJP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 09:09:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: nfsroot compile broken in 2.6.9-rc1?
Date: Wed, 25 Aug 2004 06:08:47 -0700
Message-ID: <482A3FA0050D21419C269D13989C61130435E6ED@lavender-fe.eng.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: nfsroot compile broken in 2.6.9-rc1?
Thread-Index: AcSJ/7hHn2e/L9BQTlCClykQ50pn7gApNnVw
From: "Lever, Charles" <cel@netapp.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       "Ray Lehtiniemi" <rayl@mail.com>, "Linus Torvalds" <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Aug 2004 13:08:47.0592 (UTC) FILETIME=[A84A2E80:01C48AA4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACK.  i think that one was controversial anyway.  go ahead and revert it for now.

> -----Original Message-----
> From: Trond Myklebust [mailto:trond.myklebust@fys.uio.no] 
> Sent: Tuesday, August 24, 2004 1:28 PM
> To: Ray Lehtiniemi; Linus Torvalds; Lever, Charles
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: nfsroot compile broken in 2.6.9-rc1?
> 
> 
> På ty , 24/08/2004 klokka 12:50, skreiv Ray Lehtiniemi:
> > just pulled the latest changes, and it seems nfsroot no longer
> > compiles:
> > 
> >      CC      fs/nfs/nfsroot.o
> >    fs/nfs/nfsroot.c: In function `root_nfs_get_handle':
> >    fs/nfs/nfsroot.c:499: error: cannot convert to a pointer type
> >    fs/nfs/nfsroot.c:499: error: cannot convert to a pointer type
> >    make[2]: *** [fs/nfs/nfsroot.o] Error 1
> 
> Chuck, that conversion to nfs_fh_copy() is bogus since we're 
> not copying into an nfs_fh anyway. Let's just revert it.
> 
> Cheers,
>   Trond
> 
> --- linux-2.6.9-up/fs/nfs/nfsroot.c.orig	2004-08-24 
> 11:18:27.000000000 -0400
> +++ linux-2.6.9-up/fs/nfs/nfsroot.c	2004-08-24 
> 13:18:32.000000000 -0400
> @@ -495,8 +495,10 @@ static int __init root_nfs_get_handle(vo
>  	if (status < 0)
>  		printk(KERN_ERR "Root-NFS: Server returned error %d "
>  				"while mounting %s\n", status, 
> nfs_path);
> -	else
> -		nfs_copy_fh(nfs_data.root, fh);
> +	else {
> +		nfs_data.root.size = fh.size;
> +		memcpy(nfs_data.root.data, fh.data, fh.size);
> +	}
>  
>  	return status;
>  }
> 
> 
