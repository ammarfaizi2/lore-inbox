Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275752AbRI0DTl>; Wed, 26 Sep 2001 23:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275753AbRI0DTb>; Wed, 26 Sep 2001 23:19:31 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:19206 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S275752AbRI0DTU>; Wed, 26 Sep 2001 23:19:20 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Erik DeBill <erik@www.creditminders.com>
Date: Thu, 27 Sep 2001 13:19:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15282.39610.651263.180653@notabene.cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 - knfsd symlink corruption
In-Reply-To: message from Erik DeBill on Tuesday September 25
In-Reply-To: <20010925194412.A11184@www.creditminders.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday September 25, erik@www.creditminders.com wrote:
> Under 2.4.10, I can mount an exported directory to another machine (or
> loopback to the localhost), and while creating symlinks some will end
> up with corrupt destinations.  It looks like random binary garbage is
> being appended to the end of the file name.

Oh dear, dear, dear.  That was careless wasn't it....

In fs/nfsd/nfs3xdr.c
 in decode_pathname
  change "xdr_decode_string_inplace" to "xdr_decode_string".

This won't affect NFSv2, only v3.

I would like to use the "_inplace" version, but "vfs_symlink" doesn't
take a length argument for the symlink, and _inplace cannot nul
terminate. 

NeilBrown

> 
> Normal files seem to be copied and created just fine, but symlinks end
> up with massive corruption in the name of the file they point to (I
> haven't tried checksumming files after copying, though).
> 
> This happens while using 2.4.10 as the nfs server.  Tested with both
> 2.4.2-12 (RH 7.1 stock) and 2.4.10 as client.  The problem doesn't
> show with the stock RH kernel on the server.
> 
> It seems to help if you pick a long file name to link to (ln -s
> /usr/IBMdb2/V7.1/instance foo   is much more likely to trip the bug than
> ln -s /dev/null foo) and sometimes it seems that repeating links to
> the same file can get more of the links to create successfully.
> 
> I'll attach an example of triggering the bug (I suspect all the binary
> involved will trip up MTA's without some encoding).
> 
> Both the nfs server and client in this case are dual proc Xeon 700's
> w/ 4gig of RAM.  The actual directory being nfs exported is mounted on
> an internal scsi drive.
> 
> I'll be happy to try out any patches or provide access to test boxes
> if it'll help track things down.
> 
> 
> Erik 
> 
