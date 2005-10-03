Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVJCMnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVJCMnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 08:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVJCMny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 08:43:54 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:5454 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750793AbVJCMny convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 08:43:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SRjtfyX1HZFO5OhlbROOGEQRrdk+RNE7j9VSzIrUHzKjV6C5uZdyvkBDYx5uezzuGwF0zlB8vEDVUv12URz2aj8382OmwLcOoX9DhmUlUNIkru/iiq3C95d738VHjIzORyO6y9nsM/YiOHdFbLNRraKP5tK2p6Mj/71ZAg2e9xc=
Message-ID: <84144f020510030543q10ff4fd2g138de4d06eddc440@mail.gmail.com>
Date: Mon, 3 Oct 2005 15:43:50 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
Reply-To: Pekka Enberg <penberg@cs.helsinki.fi>
To: Jesper Juhl <jesper.juhl@gmail.com>, Ben Dooks <ben-linux@fluff.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] release_resource() check for NULL resource
In-Reply-To: <20051003100431.GA16717@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002170318.GA22074@home.fluff.org>
	 <20051002103922.34dd287d.rdunlap@xenotime.net>
	 <20051003094803.GC3500@home.fluff.org>
	 <9a8748490510030259o43646cbbo22b37f1791d267e@mail.gmail.com>
	 <20051003100431.GA16717@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> It makes sense for kfree() to ignore NULL pointers, but does it really
> make sense for *_unregister() to do so too?  Surely you want to only
> unregister things which you know have previously been registered?

Usually yes but it makes releasing partial initialization much simpler
because you can  reuse the normal release counterpart. For example,

static int driver_init(void)
{
     dev->resource1 = request_region(...);
     if (!dev->resource1)
             goto failed;

     dev->resource2 = request_region(...);
     if (!dev->resource2)
             goto failed;

     return 0;

failed:
     driver_release(dev);
     return -1;
}

static void driver_release(struct device * dev)
{
     release_resource(dev->resource1);
     release_resource(dev->resource2);
     kfree(dev);
}

Many drivers have the release function copy-pasted to init with lots
of goto labels exactly because release_region, iounmap, and friends
aren't NULL safe.

                                       Pekka
