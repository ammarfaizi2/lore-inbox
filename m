Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbTD3Pol (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbTD3Pol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:44:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7833 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262347AbTD3Pof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:44:35 -0400
Date: Wed, 30 Apr 2003 16:56:52 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall
Message-ID: <20030430155652.GU10374@parcelfarce.linux.theplanet.co.uk>
References: <20030430160239.A8956@infradead.org> <200304301513.h3UFDNGi023355@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304301513.h3UFDNGi023355@locutus.cmf.nrl.navy.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 11:13:23AM -0400, chas williams wrote:
> at the time afs was written it wasnt a mistake.  syscall was the only
> (easy) way into the kernel from user space.  adding multiple syscalls
> would have just been completely painful.  as for examples, pioctl() --
> the user space of the afs syscall -- is a bit like syssgi() i am afraid:
> 
> venus/fs.c:     code = pioctl(0, VIOC_GETCELLSTATUS, &blob, 1);
> venus/fs.c:    code = pioctl(0, VIOC_SETRXKCRYPT, &blob, 1);
> vlserver/sascnvldb.c:   code = pioctl(ti->data, VIOCGETVOLSTAT, &blob, 1);
> auth/ktc_nt.c:  code = pioctl(0, VIOCNEWGETTOK, &iob, 0);
> auth/ktc_nt.c:  code = pioctl(0, VIOCDELTOK, &iob, 0);
> package/package.c:  code = pioctl(0, VIOC_AFS_SYSNAME, &data, 1);
> venus/up.c:          code = pioctl(file1, _VICEIOCTL(2), &blob, 1);
> 
> in reality, very few things other than afs are going to want to use
> the afs syscall (arla might be a possible user).

Which means only one thing - changing that API will affect very few
things.

Let's keep the kernel side sane.  We don't have to mess with multiplexors
and even if we decide to use them, we will be better off by having decoder
outside of AFS proper.  Again, take a look at interaction between userland
and knfsd.  Right now we have a sane interface (IO on nfsctl files) and
we have a wrapper (sys_nfsctl) that does decode/open/write/read/close.
