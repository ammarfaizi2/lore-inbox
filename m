Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932710AbVINUVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbVINUVY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVINUVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:21:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9937 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932710AbVINUVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:21:22 -0400
Message-ID: <432884CE.9060506@redhat.com>
Date: Wed, 14 Sep 2005 16:15:10 -0400
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

>Peter Staubach <staubach@redhat.com> writes:
>  
>
>>Yes, I think that there is a bug in the boundary checking.  I think that:
>>
>>        if (len > rcvbuf->page_len)
>>
>>should be
>>
>>        if (len >= rcvbuf->page_len - sizeof(u32) || len > 1024)
>>    
>>
>
>Thanks for your feedback.  The patch to 2.4.31 that incorporates your
>suggsted changes is here:
>
>diff -u linux-2.4.31.orig/fs/nfs/nfs2xdr.c linux-2.4.31/fs/nfs/nfs2xdr.c
>--- linux-2.4.31.orig/fs/nfs/nfs2xdr.c	2002-11-28 18:53:15.000000000 -0500
>+++ linux-2.4.31/fs/nfs/nfs2xdr.c	2005-09-14 15:33:30.000000000 -0400
>@@ -571,8 +571,8 @@
> 	strlen = (u32*)kmap(rcvbuf->pages[0]);
> 	/* Convert length of symlink */
> 	len = ntohl(*strlen);
>-	if (len > rcvbuf->page_len)
>-		len = rcvbuf->page_len;
>+	if (len >= rcvbuf->page_len - sizeof(u32) || len > NFS2_MAXPATHLEN)
>+		len = rcvbuf->page_len - sizeof(u32) - 1;
> 	*strlen = len;
> 	/* NULL terminate the string we got */
> 	string = (char *)(strlen + 1);
>diff -u linux-2.4.31.orig/fs/nfs/nfs3xdr.c linux-2.4.31/fs/nfs/nfs3xdr.c
>--- linux-2.4.31.orig/fs/nfs/nfs3xdr.c	2003-11-28 13:26:21.000000000 -0500
>+++ linux-2.4.31/fs/nfs/nfs3xdr.c	2005-09-14 15:33:53.000000000 -0400
>@@ -759,8 +759,8 @@
> 	strlen = (u32*)kmap(rcvbuf->pages[0]);
> 	/* Convert length of symlink */
> 	len = ntohl(*strlen);
>-	if (len > rcvbuf->page_len)
>-		len = rcvbuf->page_len;
>+	if (len >= rcvbuf->page_len - sizeof(u32))
>+		len = rcvbuf->page_len - sizeof(u32) - 1;
> 	*strlen = len;
> 	/* NULL terminate the string we got */
> 	string = (char *)(strlen + 1);
>

One other thing -- it doesn't seem particularly correct to me to just
silently truncate the symbolic link contents.  If the contents can not
be handled correctly because they are too large, then some sort of error
should be generated.  Silently truncating could lead to interoperability
issues when multiple clients handle the contents in different fashions,
some truncating, some returning errors, and some handling the long returns.

    Thanx...

       ps
