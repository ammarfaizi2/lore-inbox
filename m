Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129507AbQKWLgj>; Thu, 23 Nov 2000 06:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129514AbQKWLg3>; Thu, 23 Nov 2000 06:36:29 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:46854 "HELO
        note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
        id <S129507AbQKWLgS>; Thu, 23 Nov 2000 06:36:18 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alexander Viro <viro@math.psu.edu>
Date: Thu, 23 Nov 2000 22:05:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14876.64017.161207.36430@notabene.cse.unsw.edu.au>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tigran Aivazian <tigran@veritas.com>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: message from Alexander Viro on Thursday November 23
In-Reply-To: <14876.45844.670274.366687@notabene.cse.unsw.edu.au>
        <Pine.GSO.4.21.0011230435280.10127-100000@weyl.math.psu.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
        LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
        8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 23, viro@math.psu.edu wrote:
> 
> Guys, could you try to reproduce it with the following:

Well, I tried.... but it didn't go real well.

I build a 2 drive raid5 array (the script goes on to 3,4,5,6,7 drive
arrays), ran mkfs, mounted, ran "hdparm -t" on /dev/md0, ran bonnie.
So far so good.

Then I ran "dbench 20".

This produced lots of errors.

The first few were :

(3012) unlink CLIENTS/CLIENT9/~DMTMP/ACCESS/FASTENER.LDB failed (Operation not permitted)
.(3012) unlink CLIENTS/CLIENT11/~DMTMP/ACCESS/FASTENER.LDB failed (Operation not permitted)
.(3012) unlink CLIENTS/CLIENT2/~DMTMP/ACCESS/FASTENER.LDB failed (Operation not permitted)
.(3012) unlink CLIENTS/CLIENT0/~DMTMP/ACCESS/FASTENER.LDB failed (Operation not permitted)
.(3012) unlink CLIENTS/CLIENT8/~DMTMP/ACCESS/FASTENER.LDB failed (Operation not permitted)
.(3012) unlink CLIENTS/CLIENT5/~DMTMP/ACCESS/FASTENER.LDB failed (Operation not permitted)
...(3012) unlink CLIENTS/CLIENT18/~DMTMP/ACCESS/FASTENER.LDB failed (Operation not permitted)
.(3012) unlink CLIENTS/CLIENT4/~DMTMP/ACCESS/FASTENER.LDB failed (Operation not permitted)
.(3012) unlink CLIENTS/CLIENT19/~DMTMP/ACCESS/FASTENER.LDB failed (Operation not permitted)
....(11810) open CLIENTS/CLIENT0/~DMTMP/PARADOX/__S31.VAL failed for handle 4247 (Permission denied)
(3012) unlink CLIENTS/CLIENT10/~DMTMP/ACCESS/FASTENER.LDB failed (Operation not permitted)
..(11846) open CLIENTS/CLIENT0/~DMTMP/PARADOX/COURSES.VAL failed for handle 4251 (Permission denied)
(11855) nb_close: handle 4247 was not open
(11858) unlink CLIENTS/CLIENT0/~DMTMP/PARADOX/__S31.VAL failed (Operation not permitted)
.(11864) unlink CLIENTS/CLIENT0/~DMTMP/PARADOX/__S31.DB failed (Operation not permitted)
.(11810) open CLIENTS/CLIENT8/~DMTMP/PARADOX/__S31.VAL failed for handle 4247 (Permission denied)
..(3012) unlink CLIENTS/CLIENT3/~DMTMP/ACCESS/FASTENER.LDB failed (Operation not permitted)
(11928) open CLIENTS/CLIENT0/~DMTMP/PARADOX/__3F2C4.DB failed for handle 4259 (Permission denied)
(11935) nb_write: handle 4259 was not open size=2048 ofs=2048
(11940) nb_stat: CLIENTS/CLIENT0/~DMTMP/PARADOX/__3F2C4.DB wrong size 2048 4096

So it looks pretty sick.
After a reboot I tried some simple experiments. Watch what happened.

cage # echo hello > /afile
cage # > /afile
cage # echo there > /afile
bash: /afile: Permission denied
cage # echo hello > /bfile
cage # echo there > /bfile
cage # echo all >> /bfile
bash: /bfile: Permission denied
cage # echo > /cfile
cage # echo > /cfile
cage # echo xx > /cfile
bash: /cfile: Permission denied
cage # cat /vmlinuz > /dfile
cage # cat /vmlinuz > /dfile
cage # cat /vmlinuz >> /dfile
bash: /dfile: Permission denied
cage # 

(all run as root).

It looks like extending a file is not allowed any more.

This is with 2.4.0-test11 plus assorted patches to knfsd (which should
be totally irrelevant) and raid5 (Which should not affect ext2), plus
your patch, which applied cleanly.

I'll try with a clean test11 plus your patches in the morning, but it
doesn't look good.

NeilBrown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
