Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbRGXKys>; Tue, 24 Jul 2001 06:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267414AbRGXKyj>; Tue, 24 Jul 2001 06:54:39 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:61315 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267048AbRGXKyV>; Tue, 24 Jul 2001 06:54:21 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
Date: Tue, 24 Jul 2001 20:54:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15197.21462.625678.700365@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: nfs weirdness
In-Reply-To: message from Roeland Th. Jansen on Monday July 23
In-Reply-To: <20010723154217.F19492@grobbebol.xs4all.nl>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Monday July 23, roel@grobbebol.xs4all.nl wrote:
> 
> yesterday cleanly installed a system that is known to export three dirs
> without problems with NFS on 2.2.16.
> 
> The system is at 2.4.4 (SuSE) and while the same exports file is used, I
> get a problem that is identified with exportfs.
> 
> using knfsd, exports looks like :
> 
> /cdrom          192.168.1.2(ro)
> /windows        192.168.1.2(ro)
> /udf            192.168.1.2(ro)
> 
> exportfs -av with :
>  
> /dev/hdd on /udf type udf; /dev/hdc on /media/cdrom type iso9660 and
> /windows is NOT mounted.
> 
> exporting 192.168.1.2:/media/cdrom
> exporting 192.168.1.2:/windows
> exporting 192.168.1.2:/udf
> reexporting 192.168.1.2:/media/cdrom to kernel
> reexporting 192.168.1.2:/windows to kernel
> reexporting 192.168.1.2:/udf to kernel
> 
> looks good. remote mounts als shows no error :
> 
> toshiba:/cdrom          575506    575506         0 100% /tcdrom
> toshiba:/windows        976216    895820     30804  97% /windows
> toshiba:/udf            545984    530948     15036  98% /udf
> 
> except that /windows was NOT mounted so should be empty. it in fact
> reflects the fs size, free etc of the root FS of toshiba. ls /windows on
> 192.168.1.2 shows no files.
> 
> now, if I mount /windows on toshiba, there are files. all ok, however,
> exporting it causes :
> 
> reexporting 192.168.1.2:/windows to kernel
> 192.168.1.2:/windows: Invalid argument
> 
> (/dev/hda1 on /windows type vfat)
> 
> and mounting via nfs :
> 
> mount: toshiba:/windows failed, reason given by server: Permission
> denied
> 
> /v/l/m shows :
> 
> rpc.mountd: authenticated mount request from 192.168.1.2:670 for /windows (/windows)
> rpc.mountd: getfh failed: Operation not permitted
> 
> I'm lost, completely now. it worked with the old kernel/setup, now it
> doesn't.

What you describe is exactly what I would expect.  It might work
differently with unfsd - the user space nfs server, but this is all
correct for knfsd.

knfsd exports filesystems, or parts there-of.  It doesn't export
'parts of the visible namespace'.

If you ask to export "/windows" and nothing is mounted on "/windows",
then you are asking to export part of the root filesystem starting at
"/windows".  If you subsequently mount something on /windows, then you
haven't asked for that to be exported so it won't be, and mountd will
get confused.
You should always mount filesystems before trying to export them.

Now I appreciate that this could all be a bit more transparent, but
unfortunately it isn't and probably won't be for a while.

Possible changes to reduce the confusion:

1/ Don't allow a directory that is exported to be mounted on.
2/ Have a "mountpoint" export option which means "only export this
    directory if it is a mountpoint".


Patches welcome.....

NeilBrown

