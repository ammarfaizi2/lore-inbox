Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbVL2EKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVL2EKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 23:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbVL2EKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 23:10:07 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:63145 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965008AbVL2EKF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 23:10:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BMxUsdL8JW9ZfNjsvhuAJwNsZpLclw7WqhFdwXQyNwxP2ucqbZ+iZC9Wfue4m2Hwf1p6akUfvqUTirbUqNYj/yRqcPybwkBII91TwHQn10w9a6aQC+YBfVoHfHH9wHhcBxHCjwCN+BwevgNtnzHmsilZhD02q7rRqGl2kwTNSk4=
Message-ID: <5c49b0ed0512282010x156d59afmb2e1dd420542440b@mail.gmail.com>
Date: Wed, 28 Dec 2005 20:10:04 -0800
From: Nate Diller <nate.diller@gmail.com>
To: JaniD++ <djani22@dynamicweb.hu>
Subject: Re: buffer cache question
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz
In-Reply-To: <006001c6080b$03759da0$a700a8c0@dcccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <EXCHG2003iSnRMWuLn500000618@EXCHG2003.microtech-ks.com>
	 <00ad01c5eefd$7990b370$a700a8c0@dcccs>
	 <5c49b0ed0512230058q157ddedx96059d876c45a69f@mail.gmail.com>
	 <006001c6080b$03759da0$a700a8c0@dcccs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ----- Original Message -----
> From: Nate Diller
> To: JaniD++
> Cc: Roger Heflin ; linux-kernel@vger.kernel.org
> Sent: Friday, December 23, 2005 9:58 AM
> Subject: Re: buffer cache question
>
> looks like you're barely using any of your high memory.  maybe NBD doesn't
> have highmem support.  what file system are you using?
>
> NATE
>
>
> I cannot understant this.
> NBD need to support highmem for buffering?
> If know right, the kernel does buffering, not NBD!
> But the kernel only use ~830MB for buffer cache instead of dinamically use
> all free memory like page cache.
>
> This is one raw disk node, independent from file system.
>

this is an NBD client, using CONFIG_BLK_DEV_NBD?  on the 2.6 series
kernel?  if so, then it, like any other kernel component using the
page cache, needs to explicity use kmap/kunmap to make use of memory
in the high memory zone.  on a 32 bit machine, any pages above the 896
meg mark are treated specially inside the linux kernel (see
http://kerneltrap.org/node/2450).

if you don't have highmem support (CONFIG_HIGHMEM4G) enabled, then
enabling that should fix it.  if you already have it enabled (it
looked like it to me, based on your /proc/meminfo) then there is a bug
somewhere.

it would seem from a brief inspection that the send/recv_bvec
functions in nbd (2.6.13) do use kmap.  I don't know the nbd code very
well, it seems that Pavel Machek wrote the code, he or block layer
maintainer Jens Axboe may know something I don't.  So if enabling
highmem in your .config doesn't help, try CC'ing them with your issue.
 in the mean time, one of the memory split patches, such as the 4G:4G
patch, should get things working.

NATE
