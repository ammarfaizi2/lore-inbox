Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263656AbUEaLbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbUEaLbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 07:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbUEaLb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 07:31:28 -0400
Received: from 62-15-228-226.inversas.jazztel.es ([62.15.228.226]:46254 "EHLO
	servint.tedial.com") by vger.kernel.org with ESMTP id S263656AbUEaLbS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 07:31:18 -0400
From: Antonio Larrosa =?iso-8859-1?q?Jim=E9nez?= <antlarr@tedial.com>
Organization: Tedial
To: Andrew Morton <akpm@osdl.org>
Subject: Re: iowait problems on 2.6, not on 2.4
Date: Mon, 31 May 2004 13:24:37 +0200
User-Agent: KMail/1.6.1
Cc: Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <200405261743.28111.antlarr@tedial.com> <1085877991.18642.336.camel@compaq.xsintricity.com> <20040529215226.68605319.akpm@osdl.org>
In-Reply-To: <20040529215226.68605319.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405311324.38424.antlarr@tedial.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 May 2004 06:52, Andrew Morton wrote:
> Also there was breakage (recently fixed) in which /dev/sdaN's readahead
> setting was being inherited from the blockdev on which /dev resides.  But
> reading regular files is OK.
>

I don't think I have that fix applied here.

I couldn't find any read_ahead* nor *ra_* under /sys, but blockdev works.

Btw, by default it was using a read ahead of 128 Kb (blockdev returned 256)

I re-run the dd read tests on reiserfs on the qla device (the one that took 
1m27s before). These are the results on 2.6.4 :

blockdev --setra 1024 /dev/sde : 28s
(but this is the dd test in a most probably unfragmented file, so it's not a 
value that can be used in real life)
blockdev --setra 512 /dev/sde : 51s (approx. what 2.4.21 took by default)
blockdev --setra 256 /dev/sde : 1m27s
blockdev --setra 128 /dev/sde : 2m9s
blockdev --setra 64 /dev/sde  : 2m55s
blockdev --setra 0 /dev/sde   : 13m33s

On 2.4.21:

By default, /proc/sys/vm/min-readahead is 3 and /proc/sys/vm/max-readahead is 
127. I suppose those are Kb, since it didn't allow me to set a read ahead 
value over 255 when using blockdev.

blockdev --setra 1024 /dev/sde : n/a (BLKRASET: Invalid argument)
blockdev --setra 512 /dev/sde : n/a (BLKRASET: Invalid argument)
blockdev --setra 256 /dev/sde : n/a (BLKRASET: Invalid argument)
blockdev --setra 255 /dev/sde :  52s
blockdev --setra 0 /dev/sde   : 54s

As this was unexpected (it seems blockdev is a NOP on 2.4.21 ?), I tried 
modifying /proc/sys/vm/min-readahead and max.

I set both to 512 (which should match blockdev --setra 1024 on 2.6.4) and got
25s reading

Setting both to 128kb (blockdev --setra 256), it took 49s.

Setting both to 0 (disabling read-ahead), it took 3m29s (compare that to  
13m33s on 2.6.4, so definitely, there's some problem here).

Anything else I can do to help to find the problem?

--
Antonio Larrosa
Tecnologias Digitales Audiovisuales, S.L.
http://www.tedial.com
Parque Tecnologico de Andalucia . Málaga (Spain)
