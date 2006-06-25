Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWFYK3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWFYK3R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 06:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFYK3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 06:29:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29806 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932317AbWFYK3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 06:29:16 -0400
Date: Sun, 25 Jun 2006 12:28:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org
Subject: Re: 2.6.17-ck1: fcache problem...
Message-ID: <20060625102837.GC20702@suse.de>
References: <20060625093534.1700e8b6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625093534.1700e8b6@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25 2006, Paolo Ornati wrote:
> Hello,
> 
> I'm trying to get fcache (2.6.17-ck1) working on my machine, but it
> works just once ;)
> 
> In Gentoo the root fs is remounted rw in "checkroot" init script, so
> I've done this:
> 
> --- /etc/init.d/checkroot.orig  2006-06-24 18:47:41.000000000 +0200
> +++ /etc/init.d/checkroot       2006-06-25 09:17:52.000000000 +0200
> @@ -70,8 +70,10 @@
>         if mount -vf -o remount / 2> /dev/null | \
>            awk '{ if ($6 ~ /rw/) exit 0; else exit 1; }'
>         then
> -               ebegin "Remounting root filesystem read/write"
> -               mount -n -o remount,rw / &> /dev/null
> +               ebegin "Remounting root filesystem read/write (FCACHE)"
> +               # try with fcache
> +               mount -n -o remount,rw,fcache_dev=8/10,fcache_prime=0 / &> /dev/null || \
> +                       mount -n -o remount,rw / &> /dev/null
>                 if [[ $? -ne 0 ]] ; then
>                         eend 2 "Root filesystem could not be mounted read/write :("
>                         if [[ ${RC_FORCE_AUTO} != "yes" ]] ; then
> 
> 
> 1) priming - it works
> 
> [  167.488268] fcache: ios r/w 8304/4747, hits 0, misses 0, overwrites 1217
> [  167.882597] fcache: wrote 8304 extents, holding 347648 sectors of data
> [  167.899555] fcache: wrote header (extents=8304,serial=33)
> 
> "remounting with priming=0"
> 
> [  167.905498] fcache: header looks valid (extents=8304 extents, serial=33)
> [  167.928273] fcache: loaded 8304 extents
> [  167.928320] fcache: sda10 opened successfully (not priming)
> 
> 
> 2) first boot with priming=0 - it works! Great speedup :)
> 
> [   37.845964] fcache: header looks valid (extents=8304 extents, serial=33)
> [   37.874101] fcache: loaded 8304 extents
> [   37.874105] fcache: sda10 opened successfully (not priming)
> 
> 
> 3) reboot - it doesn't work anymore :(
> 
> [   26.673525] fcache: found serial 33, expected 34.
> [   26.673529] fcache: reprime the cache!
> [   26.673535] ext3: failed to open fcache (err=-22)

Hmm, and you are sure that the fs is properly umounted on reboot? Or is
it just remounted ro? It looks like fcache_close_dev() isn't being
called, so the cache serial doesn't match what we expect from the fs,
hence fcache bails out since it could indicate that the fs has been
changed without fcache being attached.

What kind of speedup did you see?

-- 
Jens Axboe

