Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVC1IMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVC1IMk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 03:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVC1IMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 03:12:40 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:15368 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261305AbVC1IMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 03:12:37 -0500
Date: Mon, 28 Mar 2005 10:12:28 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Tetsuo Handa <from-linux-kernel@I-love.sakura.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Off-by-one bug at unix_mkname ?
Message-ID: <20050328081228.GS30052@alpha.home.local>
References: <200503281700.HHE91205.FtVLOStGOSPMYJFMN@I-love.sakura.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503281700.HHE91205.FtVLOStGOSPMYJFMN@I-love.sakura.ne.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 28, 2005 at 05:00:05PM +0900, Tetsuo Handa wrote:
> Hi,
> 
> It seems to me that the following code is off-by-one bug.
> 
> http://lxr.linux.no/source/net/unix/af_unix.c#L191
> http://lxr.linux.no/source/net/unix/af_unix.c?v=2.4.28#L182
> 
> I think
> ((char *)sunaddr)[len]=0;
> should be
> ((char *)sunaddr)[len-1]=0;

it seems you're right, or the first test in the function is wrong, so
there's clearly something to be fixed there :

static int unix_mkname(struct sockaddr_un * sunaddr, int len, unsigned *hashp)
{
	if (len <= sizeof(short) || len > sizeof(*sunaddr))
                                    ^^^^^^^^^^^^^^^^^^^^^^
		return -EINVAL;
	if (!sunaddr || sunaddr->sun_family != AF_UNIX)
		return -EINVAL;
	if (sunaddr->sun_path[0]) {
		((char *)sunaddr)[len]=0;
                        ^^^^^^^^^^^^^^
		len = strlen(sunaddr->sun_path)+1+sizeof(short);
		return len;
	}

	*hashp = unix_hash_fold(csum_partial((char*)sunaddr, len, 0));
	return len;
}


Then, I would propose this patch (both for 2.4 and 2.6) :

--- ./net/unix/af_unix.c.bad	Sat Mar 26 07:42:49 2005
+++ ./net/unix/af_unix.c	Mon Mar 28 10:11:25 2005
@@ -179,7 +179,7 @@
 	if (!sunaddr || sunaddr->sun_family != AF_UNIX)
 		return -EINVAL;
 	if (sunaddr->sun_path[0]) {
-		((char *)sunaddr)[len]=0;
+		((char *)sunaddr)[len-1]=0;
 		len = strlen(sunaddr->sun_path)+1+sizeof(short);
 		return len;
 	}

Regards,
Willy

