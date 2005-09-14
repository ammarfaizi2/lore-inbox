Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbVINURv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbVINURv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbVINURv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:17:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59854 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932576AbVINURu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:17:50 -0400
Message-ID: <432883E5.6000004@redhat.com>
Date: Wed, 14 Sep 2005 16:11:17 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Assar <assar@permabit.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>	<200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>	<784q8qrsad.fsf@sober-counsel.permabit.com>	<200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>	<788xy2qas0.fsf@sober-counsel.permabit.com>	<20050913183948.GE14889@dmt.cnet>	<784q8okdfn.fsf@sober-counsel.permabit.com>	<20050913193539.GB17222@dmt.cnet>	<784q8oivp4.fsf@sober-counsel.permabit.com>	<43287221.8020602@redhat.com> <7864t3h1xw.fsf@sober-counsel.permabit.com>
In-Reply-To: <7864t3h1xw.fsf@sober-counsel.permabit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assar wrote:

>>The 2.6 kernel code is also broken, but in a different, but once again,
>>similar fashions.
>>    
>>
>
>You mean for length > 1024 ?
>
>diff -u linux-2.6.13.orig/fs/nfs/nfs2xdr.c linux-2.6.13/fs/nfs/nfs2xdr.c
>--- linux-2.6.13.orig/fs/nfs/nfs2xdr.c	2005-08-28 19:41:01.000000000 -0400
>+++ linux-2.6.13/fs/nfs/nfs2xdr.c	2005-09-14 15:40:13.000000000 -0400
>@@ -557,7 +557,7 @@
> 		return -nfs_stat_to_errno(status);
> 	/* Convert length of symlink */
> 	len = ntohl(*p++);
>-	if (len >= rcvbuf->page_len || len <= 0) {
>+	if (len >= rcvbuf->page_len || len <= 0 || len > NFS2_MAXPATHLEN) {
> 		dprintk(KERN_WARNING "nfs: server returned giant symlink!\n");
> 		return -ENAMETOOLONG;
> 	}
>

This code appears to assume that rcvbuf->page_base is zero here, but then
uses rcvbuf->page_base when calculating where to place the null byte.  It
seems to me that it should either use rcvbuf->page_base in both
calculations or neither.

    Thanx...

       ps
