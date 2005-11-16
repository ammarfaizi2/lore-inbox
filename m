Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVKPJAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVKPJAc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 04:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbVKPJAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 04:00:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030241AbVKPJAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 04:00:31 -0500
Date: Wed, 16 Nov 2005 00:59:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Cal Peake <cp@absolutedigital.net>
Cc: linux-kernel@vger.kernel.org, jcm@jonmasters.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@lst.de
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct
 ..."
Message-Id: <20051116005958.25adcd4a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal Peake <cp@absolutedigital.net> wrote:
>
> Hi,
> 
> Commit 88baf3e85af72f606363a85e9a60e9e61cc64a6c:
> 
>  "[PATCH] fix floppy.c to store correct ro/rw status in underlying gendisk"
> 
> causes an annoying side-effect. Upon first write attempt to a floppy I get 
> this:
> 
> $ dd if=bootdisk.img of=/dev/fd0 bs=1440k
> dd: writing `/dev/fd0': Operation not permitted
> 1+0 records in
> 0+0 records out
> 
> Any successive attempts succeed without problem. Confirmed that backing 
> out the patch fixes it.
> 

hmm, yes, when floppy_open() does its test we haven't yet gone and
determined the state of FD_DISK_WRITABLE.  On later opens, we have done, so
things work OK.

We may be able to do the test at the end of floppy_open(), after
check_disk_change() has called floppy_revalidate().  But for O_NDELAY opens
we appear to be screwed.
