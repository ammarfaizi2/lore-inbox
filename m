Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWHAQrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWHAQrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 12:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWHAQrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 12:47:40 -0400
Received: from pat.uio.no ([129.240.10.4]:47049 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750817AbWHAQrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 12:47:40 -0400
Subject: Re: [PATCH 0/6] AVR32 update for 2.6.18-rc2-mm1
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
In-Reply-To: <20060801101210.0548a382@cad-250-152.norway.atmel.com>
References: <1154354115351-git-send-email-hskinnemoen@atmel.com>
	 <20060731174659.72da734f@cad-250-152.norway.atmel.com>
	 <1154371259.13744.4.camel@localhost>
	 <20060801101210.0548a382@cad-250-152.norway.atmel.com>
Content-Type: multipart/mixed; boundary="=-scdnRbaUpYFz4zAJb0u9"
Date: Tue, 01 Aug 2006 09:47:27 -0700
Message-Id: <1154450847.5605.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.182, required 12,
	autolearn=disabled, AWL 1.82, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-scdnRbaUpYFz4zAJb0u9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-08-01 at 10:12 +0200, Haavard Skinnemoen wrote:
> On Mon, 31 Jul 2006 11:40:58 -0700
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > On Mon, 2006-07-31 at 17:46 +0200, Haavard Skinnemoen wrote:
> > > On Mon, 31 Jul 2006 15:55:15 +0200
> > > Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> > > 
> > > > Anyway, 2.6.18-rc2-mm1 boots successfully on my target with these
> > > > patches, but there's something strange going on with NFS and a few
> > > > other things that I didn't notice on 2.6.18-rc1. I'll investigate
> > > > some more and see if I can figure out what's going on.
> > > 
> > > All forms of write access to the NFS root file system seem to return
> > > -EACCESS. If I leave out git-nfs.patch, the problem goes away, so
> > > I'll try bisecting the NFS git tree tomorrow.
> > 
> > can you check in /proc/self/mountstats what mount options are set on
> > the root file system?
> 
> rw,vers=2,rsize=4096,wsize=4096,acregmin=3,acregmax=60,acdirmin=30,
> acdirmax=60,hard,nolock,proto=udp,timeo=11,retrans=2,sec=null

That 'sec=null' would explain why you are seeing a problem, and the
attached patch ought to fix it.

Cheers,
 Trond

--=-scdnRbaUpYFz4zAJb0u9
Content-Disposition: inline; filename=linux-2.6.18-036-nfs-fix_auth_mount.dif
Content-Type: message/rfc822; name=linux-2.6.18-036-nfs-fix_auth_mount.dif

From: Trond Myklebust <Trond.Myklebust@netapp.com>
NFS: Ensure NFSv2/v3 mounts respect the NFS_MOUNT_SECFLAVOUR flag
Date: Tue, 01 Aug 2006 09:47:17 -0700
Subject: No Subject
Message-Id: <1154450837.5605.20.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/super.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 867b5dc..d744f63 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -471,9 +471,10 @@ static int nfs_validate_mount_data(struc
 						data->version);
 				return -EINVAL;
 			}
-			/* Fill in pseudoflavor for mount version < 5 */
-			data->pseudoflavor = RPC_AUTH_UNIX;
 		case 5:
+			/* Set the pseudoflavor */
+			if (!(data->flags & NFS_MOUNT_SECFLAVOUR))
+				data->pseudoflavor = RPC_AUTH_UNIX;
 			memset(data->context, 0, sizeof(data->context));
 	}
 

--=-scdnRbaUpYFz4zAJb0u9--

