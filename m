Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUIEITL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUIEITL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 04:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUIEITL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 04:19:11 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:29456 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S266345AbUIEITD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 04:19:03 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
From: Tim Connors <tconnors+linuxkernel1094371411@astro.swin.edu.au>
X-test-to: Trond Myklebust <trond.myklebust@fys.uio.no>
X-cc-to: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>,
 linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: why do i get "Stale NFS file handle" for hours?
In-reply-to: <1094353267.13791.156.camel@lade.trondhjem.org>
References: <chdp06$e56$1@sea.gmane.org>  <1094348385.13791.119.camel@lade.trondhjem.org>  <413A7119.2090709@upb.de>  <1094349744.13791.128.camel@lade.trondhjem.org>  <413A789C.9000501@upb.de> <1094353267.13791.156.camel@lade.trondhjem.org>
X-Face: "0\RuOFb6AcQ}B_F/^%;;AmS%><zZ_q?N1w1%1voDY7#Ywj~qRaL7].8HB'2~pDUS|{E=$R\-s?;+p!RCe:w||kS\T@[(eQHB*-8u;~)ZP4;QYUI`|GJ)NS\`jLbW<e'R*y+Od,S5D+Vz++a<[$g'>"qr*^0t%eriBMe_x]B7&@b8_\i<A/A@T
Message-ID: <slrn-0.9.7.4-19971-22570-200409051803-tc@hexane.ssi.swin.edu.au>
Date: Sun, 5 Sep 2004 18:17:53 +1000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> said on Sat, 04 Sep 2004 23:01:07 -0400:
> På lau , 04/09/2004 klokka 22:23, skreiv Sven Köhler:
> 
> > Sorry? Why is my server broken? I'm using kernel 2.6.8.1 with nfs-utils 
> > 1.0.6 on my server, and i don't see, what should be broken.
> 
> When your server fails to work as per spec, then it is said to be
> "broken" no matter what kernel/nfs-utils combination you are using.
> The spec is that reboots are not supposed to clobber filehandles.
> 
> So, there are 3 possibilities:
> 
>  1) You are exporting a non-supported filesystem, (e.g. FAT). See the
> FAQ on http://nfs.sourceforge.org.
>  2) A bug in your initscripts is causing the table of exports to be
> clobbered. Running "exportfs" in legacy 2.4 mode (without having the
> nfsd filesystem mounted on /proc/fs/nfsd) appears to be broken for me at
> least...
>  3) There is some other bug in knfsd that nobody else appears to be
> seeing.

Have I got 2 cases of 3) for you perhaps?

I can't give you more info, because I am not the admin of the boxes
concerned, but we lose filehandles of specific files and spontaneously
sometimes (no server reboots, nfsd restarts, etc).

Background:

We have a compute cluster of machines all running SuSE's 2.4.20, or
thereabouts. The nfs servers run Linus's 2.4.26, talking to ext3, on
bigass apple Xserves.

I will update one directory with rsync from one host, and then try, a
little later on, to operate on that directory from another host. Every
now and then, from a single host only, a few files in that tree will
get stale filehandles - an ls of that directory will mostly be fine
apart from those files. They will also be fine from any other machine.

I have found that if I clobber cache with my alloclargemem program,
then those files will come back immediately.

The other problem we see regularly, and I have encoded explicitly into
my scripts to workaround, because it is such a common occurence, is
when I start 120 jobs in a short time on 120 nodes, which deal with a
bunch of common files read-only, and then write their own private
files, a few of them will die with the read-only files being stale. It
looks as if the server just can't cope with a hundred requests (and
possibly mounts, since they are automounted) in the space of half a
minute (big files, mind you), and starts returning bogus data.

The entire mount (which is automounted, looks like version 3) will
then remain stale for eternity, with df returning its minus 3
bazillion GB free, until automount is restarted.


Known problems? I googled for '"stale nfs file handle" spontaneous'
with no luck. Or is it likely perhaps that SuSE fscked with the nfs
(and autofs) client side code? The sysadmins look at these failures as
being a fact of life, but perhaps no-one else is seeing this, so it's
worth reporting.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
PUBLIC NOTICE AS REQUIRED BY LAW: Any Use of This Product, in Any Manner 
Whatsoever, Will Increase the Amount of Disorder in the Universe. Although No 
Liability Is Implied Herein, the Consumer Is Warned That This Process Will 
Ultimately Lead to the Heat Death of the Universe.
