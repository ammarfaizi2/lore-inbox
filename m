Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311193AbSCVLEF>; Fri, 22 Mar 2002 06:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311171AbSCVLDr>; Fri, 22 Mar 2002 06:03:47 -0500
Received: from mons.uio.no ([129.240.130.14]:49378 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S310646AbSCVLD2>;
	Fri, 22 Mar 2002 06:03:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15515.3958.533172.840461@charged.uio.no>
Date: Fri, 22 Mar 2002 12:03:18 +0100
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@ton.iguana.be (Ton Hospel), linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client) 
In-Reply-To: <24969.1016793219@redhat.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David Woodhouse <dwmw2@infradead.org> writes:

     > trond.myklebust@fys.uio.no said:
    >> As for re-exporting: that can be done pretty easily too unless
    >> of course you actually expect it to be reliable. The tough
    >> cookie is to get it to survive server reboots.

     > The problem here is that we're using the anonymous device which
     > the NFS mount happens to have as sb->s_dev as the device ID in
     > our exported file handles. We don't have to do that; we could
     > use something slightly more useful, based on the root fh we got
     > from the _real_ server, surely?
 
That is an issue, but it is really only a minor one.

The real problem is that whereas the tuple (sb->s_dev,i_ino) suffices
in order to be able to iget() a typical ext2 file, you require the the
tuple (sb->s_dev, 32/64 byte opaque filehandle) if you want to
iget() an NFS file.

Basically, if you want to be able to recover gracefully from the
situation in which the re-exporting server reboots, you would need to
compress the entire filehandle from the original server + the
sb->s_dev (in some manner that survives a reboot, I'll grant you) and
fit that into the filehandle that the NFS client uses.


To complicate matters a bit further, you have the fact that NFSv3
filehandles are 0-64 bytes long, and NFSv2 filehandles are always 32
bytes long...

Cheers,
  Trond
