Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130896AbQJ1FmW>; Sat, 28 Oct 2000 01:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130913AbQJ1FmM>; Sat, 28 Oct 2000 01:42:12 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:27407 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130896AbQJ1FmG>; Sat, 28 Oct 2000 01:42:06 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Tony.Lill@ajlc.waterloo.on.ca
Date: Sat, 28 Oct 2000 16:41:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14842.26381.840222.185953@notabene.cse.unsw.edu.au>
Cc: nfs-devel@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: OOPS in nfsd, affects all 2.2 and 2.4 kernels
In-Reply-To: message from Tony Lill on Friday October 27
In-Reply-To: <200010272220.SAA31698@spider.ajlc.waterloo.on.ca>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday October 27, ajlill@ajlc.waterloo.on.ca wrote:
> This was first reported in 2.2.12, according to Deja. Solaris clients,
> on rare occaisons, will send some command to a linux server which
> causes a null resp->fh.fh_dentry to be passed to routines in
> /usr/src/linux/fs/nfsd/nfsxdr.c. This causes an oops, and then the nfs
> server subsystem stop functioning. A fix is to check that this is not
> null before de-referencing it in the following three routines. I
> looked and this bug is present in the latest 2.2 and 2.4 kernels.
> 
> Whatever condition causes this is very rare. We had a linux server
> supporting 100 Solaris and HP-UX boxes running flawlessly for 8
> months, then one day something triggered this bug, and it wouldn't go
> away until I implemented this fix. There were no apparent side effects
> to doing this, although you may want to print some informative message
> to try and track down the real culprit.
> 
> THis patch is against 2.2.16, but the code looks unchanged in
> 2.4.0.

Thanks for sending me this.

This problem that you are addressing is caused when solaris sends a
zero length write (I assume to implement the "access" system call, but
I haven't checked).
If you look at the code at the top of nfsd_write in nfsd/vfs.c, you
will see that if cnt (the number of bytes to write) is zero, then it
jumps straight out without setting an error or initialising fhp (by
calling nfsd_open).
As there is no error, nfsd tried to return status information (hence
the call the nfssvc_encode_attrstat) but doesn't have a valid file
handle.  So it Oopses.

The correct fix, which is in 2.4 and would have recently gone into the
2.2.18 pre-patches (but I haven't actually looked at them) is to move 
the test for (!cnt) to after the call to nfsd_open.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
