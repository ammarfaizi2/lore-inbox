Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSDYRNh>; Thu, 25 Apr 2002 13:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313633AbSDYRNg>; Thu, 25 Apr 2002 13:13:36 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:58863 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313628AbSDYRNf>; Thu, 25 Apr 2002 13:13:35 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 25 Apr 2002 11:11:43 -0600
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "David S. Miller" <davem@redhat.com>, taka@valinux.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020425171143.GA16982@turbolinux.com>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Andi Kleen <ak@suse.de>, Jamie Lokier <lk@tantalophile.demon.co.uk>,
	"David S. Miller" <davem@redhat.com>, taka@valinux.co.jp,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020412.213011.45159995.taka@valinux.co.jp> <20020412143559.A25386@wotan.suse.de> <20020412222252.A25184@kushida.apsleyroad.org> <20020412.143150.74519563.davem@redhat.com> <20020413012142.A25295@kushida.apsleyroad.org> <20020413083952.A32648@wotan.suse.de> <m1662vjtil.fsf@frodo.biederman.org> <20020413213700.A17884@wotan.suse.de> <m1zo07ibi3.fsf@frodo.biederman.org> <20020424231153.GM574@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 24, 2002  16:11 -0700, Mike Fedyk wrote:
> Actually, with ext3 the only mode IIRC is data=journal that will keep this
> from happening.  In ordered or writeback mode there is a window where the
> pages will be zeroed in memory, but not on disk.  
> 
> Admittedly, the time window is largest in writeback mode, smaller in ordered
> and smallest (non-existant?) in data journaling mode.

One thing you are forgetting is that with data=ordered mode, the inode
itself is not updated until the data has been written to the disk.  So
technically you are correct - with ordered mode there is a window where
pages are updated in memory but not on disk, but if you crash during
that window the inode size will be the old size so you will still not be
able to access the un-zero'd data on disk.

It is only with data=writeback that this could be a problem, because
there is no ordering between updating the inode and writing the data
to disk.  That's why there is only a real benefit to using
data=writeback for applications like databases and such where the file
size doesn't change and you are writing into the middle of the file.
In many cases, data=ordered is actually faster than data=writeback.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

