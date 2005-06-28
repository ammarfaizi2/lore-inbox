Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVF1JUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVF1JUM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVF1JUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:20:01 -0400
Received: from Nazgul.esiway.net ([193.194.16.154]:26551 "EHLO
	Nazgul.esiway.net") by vger.kernel.org with ESMTP id S261870AbVF1JPj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:15:39 -0400
Subject: Re: Tracking down a memory leak
From: Marco Colombo <marco@esi.it>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1119263592.31049.19.camel@Frodo.esi>
References: <1119263592.31049.19.camel@Frodo.esi>
Content-Type: text/plain
Organization: ESI srl
Date: Tue, 28 Jun 2005 11:18:02 +0200
Message-Id: <1119950283.26948.271.camel@Frodo.esi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-20 at 12:33 +0200, Marco Colombo wrote:
> Hi,
> today I've found a server in a OOM condition, the funny thing is that
> after some investigation I've found no process that has mem allocated
> to. I even switched to single user, here's what I've found: 

[...]
>              total       used       free     shared    buffers     cached
> Mem:       1035812     898524     137288          0       3588      16732
> -/+ buffers/cache:     878204     157608
> Swap:      1049248        788    1048460
> sh-2.05b# uptime
>  12:13:28 up 35 days,  1:48,  0 users,  load average: 0.00, 0.59, 16.13
> sh-2.05b# uname -a
> Linux xxxx.example.org 2.6.10-1.12_FC2.marco #1 Mon Feb 7 14:53:42 CET 2005
> i686 athlon i386 GNU/Linux
> 
> I know this is an old Fedora Core 2 kernel, eventually I'll bring the
> issue on thier lists. An upgrade has already been scheduled for this
> host, so I'm not really pressed in tracking this specific bug (unless it
> occurs on the new system, of course).
> 
> Anyway, I just wonder if generally there's a way to find out where those
> 850+ MBs are allocated. Since there are no big user processes, I'm
> assuming it's a memory leak in kernel space. I'm curious, this is the
> first time I see something like this. Any suggestion what to look at
> besides 'ps' and 'free'?
> 
> The server has been mainly running PostgreSQL at a fairly high load for
> the last 35 days, BTW.
> 
> TIA,
> .TM.

Thanks to everybody who replied to me. Here's more data:

sh-2.05b# sort -rn +1 /proc/slabinfo | head -5
biovec-1          7502216 7502296     16  226    1 : tunables  120   60    0 : slabdata  33196  33196      0
bio               7502216 7502262     96   41    1 : tunables  120   60    0 : slabdata 182982 182982      0
size-64             4948   5307     64   61    1 : tunables  120   60    0 : slabdata     87     87      0
buffer_head         3691   3750     52   75    1 : tunables  120   60    0 : slabdata     50     50      0
dentry_cache        2712   2712    164   24    1 : tunables  120   60    0 : slabdata    113    113      0

I've found no way do free that memory, so decided to reboot it.
In the following days I had been monitoring the system after upgrading
to kernel-2.6.10-1.770_FC2. Here are the results I got, day by day:

bio               115333 115333     96   41    1 : tunables  120   60    0 : slabdata   2813   2813      0
biovec-1          115322 115486     16  226    1 : tunables  120   60    0 : slabdata    511    511      0

biovec-1          325006 325440     16  226    1 : tunables  120   60    0 : slabdata   1440   1440      0
bio               324987 325212     96   41    1 : tunables  120   60    0 : slabdata   7930   7932      0

bio               538535 538535     96   41    1 : tunables  120   60    0 : slabdata  13135  13135      0
biovec-1          538528 538784     16  226    1 : tunables  120   60    0 : slabdata   2384   2384      0

bio               749870 750218     96   41    1 : tunables  120   60    0 : slabdata  18296  18298      0
biovec-1          749886 750772     16  226    1 : tunables  120   60    0 : slabdata   3322   3322      0

bio               960630 960630     96   41    1 : tunables  120   60    0 : slabdata  23430  23430      0
biovec-1          960642 960726     16  226    1 : tunables  120   60    0 : slabdata   4251   4251      0

bio               1170079 1170345     96   41    1 : tunables  120   60    0 : slabdata  28543  28545      0
biovec-1          1170066 1170906     16  226    1 : tunables  120   60    0 : slabdata   5181   5181      0

bio               1379857 1380019     96   41    1 : tunables  120   60    0 : slabdata  33658  33659      0
biovec-1          1379854 1380408     16  226    1 : tunables  120   60    0 : slabdata   6108   6108      0

Clearly, something was going on. So I decided to run a vanilla kernel
instead.

I'm running 2.6.12.1 right now, and after about one day of uptime:

bio                  345    369     96   41    1 : tunables  120   60    0 : slabdata      9      9      0
biovec-1             376    678     16  226    1 : tunables  120   60    0 : slabdata      3      3      0

which seem to me sane values (and they stay like that as far as I can
see). No more daily increase of more than 200,000.

I'll keep an eye on it in the next days, but I think 2.6.12.1 is not
affected.

.TM.
-- 
      ____/  ____/   /
     /      /       /                   Marco Colombo
    ___/  ___  /   /                  Technical Manager
   /          /   /                      ESI s.r.l.
 _____/ _____/  _/                      Colombo@ESI.it

