Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269801AbUJAOpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269801AbUJAOpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 10:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269799AbUJAOpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 10:45:13 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:51908 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269801AbUJAOoH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 10:44:07 -0400
Subject: Re: Windows Logical Disk Manager error
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Marcin =?iso-8859-2?Q?Gibu=B3a?= <mg@iceni.pl>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200410011626.09995@senat>
References: <200409231254.12287@senat> <200410010149.19951@senat>
	 <1096619799.17297.22.camel@imp.csi.cam.ac.uk>  <200410011626.09995@senat>
Content-Type: text/plain; charset=UTF-8
Organization: University of Cambridge Computing Service, UK
Message-Id: <1096641835.17297.45.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 15:43:56 +0100
Content-Transfer-Encoding: 8BIT
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 15:26, Marcin Gibuła wrote:
> > I would not advise you to use volume6 without the md driver.  You are
> > then missing the last 32kb off the end and you never know when they
> 
> Well, I can't even build it... mdadm failes and driver complains with
> md: Dev sda2 smaller than chunk_size: 0k < 32k
> Different chunk size doesn't make any difference.

That is a bug in the md driver then.

> > direction.  Fortunately you can fix this case by using the "--rounding="
> > parameter to mdadm.  So if you have a cluster size of 4k try
> > --rounding=4.  (If you don't know your cluster size enable debugging in
> > the ntfs driver and then do the mount and "dmesg | grep cluster_size"
> > will tell you the answer.  To enable debugging in the driver it must be
> > compiled with debugging enabled and you need to, as root, do: "echo 1 >
> > /proc/sys/fs/ntfs-debug" after loading the module if modular and before
> > doing the mount command.)
> 
> According to ntfs driver output my cluster size is indeed 4kb, but it still 
> failes to read mounted fs.
> 
> Error is now:
> NTFS-fs error (device md1): ntfs_readdir(): Actual VCN (0x20006500680054) of 
> index buffer is different from expected VCN (0x4). Directory inode 0x5 is 
> corrupt or driver bug.

So the number has changed.  Means it is aligning the two pieces
differently.  But still not correctly.  Actually, having looked at the
dump of your LDM database again, it is not rounding anything at all. It
behaves exactly like the NT4 fault tolerant arrays, i.e. it uses all
512-byte sectors to store data.

You can see it from:

Volume2 Size: 0x05AB2EA2 (46437 MB)
    Volume2-01
      Disk2-01   VolumeOffset: 0x00000000 Offset: 0x00000000 Length:
0x033A186B
      Disk2-02   VolumeOffset: 0x033A186B Offset: 0x033A18AA Length:
0x02711637

Disk2-01 contains 0x033a186B sectors == 5413987 in decimal an you can
see the number is odd and hence the Linux md driver cannot work as it
uses 1024 bytes minimum so it can never work.  )-:

Disk2-02 starts at the offset Disk2-01 stops and hence the Linux md
driver again cannot work.

Sorry but with current Linux md driver and tools it is not possible to
make your linear arrays work.

> Oh, and my system (and kernel) is x86-64 if it matters.

It doesn't.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

