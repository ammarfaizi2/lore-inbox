Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314351AbSEIUy4>; Thu, 9 May 2002 16:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314352AbSEIUyz>; Thu, 9 May 2002 16:54:55 -0400
Received: from heffalump.fnal.gov ([131.225.9.20]:26054 "EHLO fnal.gov")
	by vger.kernel.org with ESMTP id <S314351AbSEIUyx>;
	Thu, 9 May 2002 16:54:53 -0400
Date: Thu, 09 May 2002 15:54:53 -0500
From: Dan Yocum <yocum@fnal.gov>
Subject: Re: ns83820 bug.  [was Re: Poor NFS client performance on 2.4.18?]
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        linux kernel <linux-kernel@vger.kernel.org>
Message-id: <3CDAE21D.F671AFFA@fnal.gov>
MIME-version: 1.0
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13SGI_XFS_1.0.2 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3CC86BDC.C8784EA2@fnal.gov> <shsu1pyppnz.fsf@charged.uio.no>
 <3CD6FE1E.A20384D@fnal.gov> <E174zP0-0007N9-00@charged.uio.no>
 <3CD7F385.BAA3870B@fnal.gov> <3CD7F8A2.24DF8433@fnal.gov>
 <3CD98837.16B32F84@fnal.gov> <20020508180705.B14959@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben, Trond,

Ugh.  It's been a bad week in general.  Anyway, yes, you're right, the 0.17
upgrade did the trick - I had actually tried that, but had accidentally
re-applied the rpc_tweaks dif which knocked the performance down again. 
Backing out that patch, updating to v 0.17 of the ns83820 driver and all is
well, again.  

So, it's back in Trond's court, with the rpc_tweaks causing the slow
read/write over NFS, problem.


Trond, if all I want is 32k block transfers from that dif, can I just apply
the following, or is there more to it:


diff -u --recursive --new-file
linux-2.4.18-svc_tcp/include/linux/nfsd/const.h
linux-2.4.18-rpc_cong/include/linux/nfsd/const.h
--- linux-2.4.18-svc_tcp/include/linux/nfsd/const.h     Sat Apr  1 18:04:27
2000+++ linux-2.4.18-rpc_cong/include/linux/nfsd/const.h    Wed Feb 20
17:20:45 2002@@ -21,7 +21,7 @@
 /*
  * Maximum blocksize supported by daemon currently at 8K
  */
-#define NFSSVC_MAXBLKSIZE      8192
+#define NFSSVC_MAXBLKSIZE      (32*1024)
 
 #ifdef __KERNEL__
 

Thanks,
Dan



Benjamin LaHaise wrote:
> 
> Upgrade to 0.17 (which is in 2.4.19-pre5 or so and later) and you should
> find the issue resolved.
> 
>                 -ben
> 
> On Wed, May 08, 2002 at 03:19:03PM -0500, Dan Yocum wrote:
> > Trond, et al.
> >
> > You're right, it's a driver (ns83820) issue.  Strange that it only shows up
> > when trying to execute an app that's mounted via NFS, but, whatever.
> > Running apps from the the NFS volumes with the eepro100 adapter that's on
> > the machine works fine with the updated NFS_all patch applied.
> >
> > Thanks, again,
> > Dan
> >
> >
> > Dan Yocum wrote:
> > >
> > > Dan Yocum wrote:
> > > >
> > > > Trond Myklebust wrote:
> > > > >
> > > > > On Tuesday 7. May 2002 00:05, Dan Yocum wrote:
> > > > > > Trond,
> > > > > >
> > > > > > OK, so backing out the rpc_tweaks dif fixed the performance problem,
> > > > > > however, seems to have introduced another problem that appears to be
> > > > > > stemming from the seekdir.dif.  Attempting to run an app from an IRIX
> > > > > > client (that has the 32bitclients option set) freezes the NFS volume - one
> > > > > > can't access it from the Linux side, anymore.
> > > > > >
> > > > > > You can read and write to the NFS volume *before* trying to run something
> > > > > > from there, but not after.
> > > > > >
> > > > > > Ideas?
> > > > >
> > > > > That smells like another network driver bug. Have you tcpdumped the traffic
> > > > > between client and server?
> > > >
> > > > Ah, that may be the case - the problem also exists with a Linux server as
> > > > well... let me check, and I'll let you know.
> > >
> > > I take that back - it's only hanging on the Linux server when the IRIX
> > > server is already hung.
> >
> >
> > --
> > Dan Yocum
> > Sloan Digital Sky Survey, Fermilab  630.840.6509
> > yocum@fnal.gov, http://www.sdss.org
> > SDSS.  Mapping the Universe.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> --
> "You will be reincarnated as a toad; and you will be much happier."

-- 
Dan Yocum
Sloan Digital Sky Survey, Fermilab  630.840.6509
yocum@fnal.gov, http://www.sdss.org
SDSS.  Mapping the Universe.
