Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVJFTRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVJFTRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVJFTRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:17:52 -0400
Received: from pat.uio.no ([129.240.130.16]:26292 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751315AbVJFTRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:17:51 -0400
Subject: Re: [RFC] atomic create+open
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
	 <1128620528.16534.26.camel@lade.trondhjem.org>
	 <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
	 <1128623899.31797.14.camel@lade.trondhjem.org>
	 <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 15:17:38 -0400
Message-Id: <1128626258.31797.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.557, required 12,
	autolearn=disabled, AWL 1.44, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 06.10.2005 Klokka 20:49 (+0200) skreiv Miklos Szeredi:

> For simplicity case let's omit the creation of simlink, just say, the
> file is removed.
> 
> So NFS calls have_submounts(), which returns true.
> 
> Then the bind is umounted.  Nothing prevents this happening
> concurrently with the lookup.
> 
> Then the file is removed on the server.
> 
> When open_namei() gets around to following the mounts, it is not there
> any more, so the dentry for /mnt/foo (the NFS one is returned) and
> NFS's ->open is called on the file, which returns -ENOENT.  But
> open(..., O_CREAT, ...) should never return -ENOENT.

...and so the VFS can recognise the case, and be made to retry the
operation.
A more difficult race to deal with occurs if you allow a mount while
inside d_revalidate(). In that case NFS can end up opening the wrong
file.
Both these two races could, however, be fixed by moving the
__follow_mount() in open_namei() inside the section that is protected by
the parent directory i_sem.

In any case, all you are doing here is showing that the situation w.r.t.
mount races and lookup+create+open is difficult. I see nothing that
convinces me that a special atomic create+open will help to resolve
those races.
Nor do I see that adding a special atomic create+open will help me avoid
intents for the case of atomic lookup+open(). As far as I'm concerned,
the case of lookup+create+open is just a special case of lookup+open.

Cheers,
  Trond

