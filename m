Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWBTQp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWBTQp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWBTQp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:45:57 -0500
Received: from dsl092-073-214.bos1.dsl.speakeasy.net ([66.92.73.214]:44495
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S1161026AbWBTQp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:45:56 -0500
Date: Mon, 20 Feb 2006 11:41:20 -0500
From: Sonny Rao <sonny@burdell.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Chris Mason <mason@suse.com>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       Vitaly Fertman <vetalf@inbox.ru>
Subject: Re: kernel oops: trying to mount a corrupted xfs partition (2.6.16-rc3)
Message-ID: <20060220164120.GA24077@kevlar.burdell.org>
Mail-Followup-To: Sonny Rao <sonny@burdell.org>,
	Hans Reiser <reiser@namesys.com>, Chris Mason <mason@suse.com>,
	Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com, Vitaly Fertman <vetalf@inbox.ru>
References: <20060216183629.GA5672@skyscraper.unix9.prv> <20060217063157.B9349752@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0602171753590.27452@yvahk01.tjqt.qr> <20060220082946.A9478997@wobbly.melbourne.sgi.com> <20060219215209.GB7974@redhat.com> <20060220070916.GA8101@kevlar.burdell.org> <43F96DE9.7070209@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F96DE9.7070209@namesys.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(trimmed the cc list a bit since this is all Reiserfs specific)

On Sun, Feb 19, 2006 at 11:21:13PM -0800, Hans Reiser wrote:
> Thanks kindly Sonny, Chris is this bug known/fixed?

Hi, I'm still seeing the issue on 2.6.16-rc4 so I don't think it's
fixed yet. 

Here's some output :

Feb 20 10:36:25 localhost kernel: ReiserFS: loop0: found reiserfs format "3.6" with standard journal
Feb 20 10:36:25 localhost kernel: ReiserFS: loop0: using ordered data mode
Feb 20 10:36:25 localhost kernel: ReiserFS: loop0: journal params: device loop0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Feb 20 10:36:25 localhost kernel: ReiserFS: loop0: checking transaction log (loop0)
Feb 20 10:36:27 localhost kernel: __find_get_block_slow() failed. block=18446744072887476243, b_blocknr=3472891923
Feb 20 10:36:27 localhost kernel: b_state=0x00000020, b_size=4096
Feb 20 10:36:27 localhost kernel: device blocksize: 4096
Feb 20 10:36:27 localhost kernel: __find_get_block_slow() failed. block=18446744072887476243, b_blocknr=3472891923
Feb 20 10:36:27 localhost kernel: b_state=0x00000020, b_size=4096
Feb 20 10:36:27 localhost kernel: device blocksize: 4096
Feb 20 10:36:27 localhost kernel: __find_get_block_slow() failed. block=18446744072887476243, b_blocknr=3472891923
Feb 20 10:36:27 localhost kernel: b_state=0x00000020, b_size=4096
Feb 20 10:36:27 localhost kernel: device blocksize: 4096
Feb 20 10:36:27 localhost kernel: __find_get_block_slow() failed. block=18446744072887476243, b_blocknr=3472891923
Feb 20 10:36:27 localhost kernel: b_state=0x00000020, b_size=4096
Feb 20 10:36:27 localhost kernel: device blocksize: 4096
...
ad infinitum

I'll try and add a dump_stack() to the code that prints this stuff later today

Sonny




> 
> Sonny Rao wrote:
> 
> >On Sun, Feb 19, 2006 at 04:52:09PM -0500, Dave Jones wrote:
> ><snip> 
> >  
> >
> >>Just for kicks, I just hacked this up..
> >>
> >>#!/bin/bash
> >>wget http://www.digitaldwarf.be/products/mangle.c
> >>gcc mangle.c -o mangle
> >>
> >>dd if=/dev/zero of=data.img count=70000
> >>
> >>while [ 1 ];
> >>do
> >>        mkfs.xfs -f data.img >/dev/null
> >>		./mangle data.img $RANDOM
> >>        sudo mount -t xfs data.img mntpt -o loop
> >>        sudo ls -R mntpt
> >>        sudo umount mntpt
> >>done
> >>    
> >>
> >
> >Cool script, you might want to multiply $RANDOM by some factor (I used
> >8) to catch some more stuff, I know JFS, for example, doesn't put
> >anything in the first 32k, so the first time I ran it on JFS it did
> >nothing ;-) 
> >
> >
> >Reiserfs folks, 
> >
> >I also found an infinte loop in Reiserfs on 2.6.15, if the Reiser
> >folks are interested, I've gziped the fs and put it here:
> >
> >http://burdell.org/~sonny/data.img.breaks.reiserfs.gz
> >
> >The fs is only 52k when zipped, so its not too bad to download.
> >
> >This is under stock 2.6.15, sorry I can't post dmesg output because I
> >end up having to reboot when it happens and don't have time to debug
> >right now.  It looks like it's in the journal replay code where it
> >keeps trying to grab some block with a ridiculously large offset. 
> >
> >
> >  
> >
> >>xfs wins the award for 'noisiest fs in the face of corruption' :-)
> >>After a few dozen backtraces from xfs_corruption_error,
> >>this fell out...
> >>
> >>divide error: 0000 [1] SMP
> >>    
> >>
> ><snip trace>
> > 
> >  
> >
> >>(The kernel is based on 2.6.16rc4)
> >>    
> >>
> >
> >I see a similar breakage (divide error) on x86 using 2.6.15
> >
> >Sonny
> >
> >
> >  
> >
