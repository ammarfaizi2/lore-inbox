Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270408AbTGMVXR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 17:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270409AbTGMVXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 17:23:17 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:2253 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S270408AbTGMVXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 17:23:07 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jan Dittmer <j.dittmer@portrix.net>
Date: Mon, 14 Jul 2003 07:37:27 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16145.53527.749969.347814@gargle.gargle.HOWL>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: 'NFS stale file handle' with 2.5
In-Reply-To: message from Jan Dittmer on Saturday July 12
References: <3F1068C9.1070900@portrix.net>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday July 12, j.dittmer@portrix.net wrote:
> Hi,
> 
> I'm experiencing really big problems with nfs on 2.5 - and I'm a bit 
> stuck debugging.
> 
> Server:
> Pentium II SMP Dual Server with Raid5/dm and nfs running 2.5.7[045][-mm]
> 
> Clients:
> Athlon, same kernels
> P3 800, same kernels and 2.4
> 
> Problem:
> Accessing the nfs shares on the Server gives lots of 'nfs stale file 
> handles', making it unusuable. A simple cp from nfs to nfs triggers it 
> in a matter of seconds.
> The shares are mounted with (hard,intr), that used to work with 2.4.20 
> on the server, but I also tried no option, only hard and only soft, 
> problem persists. Also I tried to remove nfs_directio from the build and 
> only compiled in nfs2, all the same.
> Being curious whats wrong I set up an export on the P3 800 and mounted 
> it from the athlon (both running 2.5.75-mm1). This seems to work fine 
> (just tested for 10 minutes or so, but typically the problem is 
> triggered much earlier).
> I also tried enabling the VERBOSE_DEBUG define in nfs source. But that 
> doesn't give any more information.
> Only one line that gets my attention:
> NFS: giant filename in readdir (len 0x2f0a0969)

This makes me a bit suspicious of hardware, probably networking.  It
really looks like data is getting corrupted between client and server.

The fact that two different servers behaved differently while both
running the same kernel, sees to support the hardware theory.

Maybe if you could get a tcpdump (-s 1500 port 2049) on both the server and the
client  I could have a look at the filehandles as see if I can see why
they are 'stale', and whether it could be a hardware problem.

NeilBrown

> 
> I'm really lost here. What can I try/do to further narrow this down? Any 
> specific kernel revision I could try to go back, notice that already 
> 2.5.70 triggered it. With 2.4 on the server nothing of this happens.
> Only thing left is to try booting the server without smp support, but I 
> get some 'hde: lost interrupt' messages and it doesn't boot.
> Note that I also tried to export a partition not on dm. Filesystem is 
> ext3. I also tried the patches you posted some days ago in another thread.
> 
> Thanks for any suggestions,
> 
> Jan
> 
> # grep NFS .config
> CONFIG_NFS_FS=m
> CONFIG_NFS_V3=y
> CONFIG_NFS_V4=y
> CONFIG_NFS_DIRECTIO=y
> CONFIG_NFSD=m
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_TCP=y
> 
> 
> -- 
> Linux rubicon 2.5.75-mm1-jd10 #1 SMP Sat Jul 12 19:40:28 CEST 2003 i686
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
