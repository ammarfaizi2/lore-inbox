Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262148AbTCRDFO>; Mon, 17 Mar 2003 22:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262149AbTCRDFO>; Mon, 17 Mar 2003 22:05:14 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:38075 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262148AbTCRDFM>; Mon, 17 Mar 2003 22:05:12 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Date: Tue, 18 Mar 2003 12:01:40 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15990.28660.687262.457216@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: 2.4.20: ext3/raid5 - allocating block in system zone/multiple 1 requests for sector
In-Reply-To: message from Dr. David Alan Gilbert on Sunday March 16
References: <20030316150148.GC1148@gallifrey>
X-Mailer: VM 7.08 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday March 16, gilbertd@treblig.org wrote:
> Hi,
>   I've just built an 800GB RAID5 array and built an ext3 file system
> on it; on trying to copy data off the 200GB RAID it is replacing I'm
> starting to see errors of the form:
> 
> kernel: EXT3-fs error (device md(9,2)): ext3_new_block: Allocating block in
> system zone - block = 140509185
> 
> and
> 
> kernel: EXT3-fs error (device md(9,2)): ext3_add_entry: bad entry in
> directory #70254593: rec_len %% 4 != 0 - offset=28, inode=23880564,
> rec_len=21587, name_len=76
> 
> and
> 
> kernel: raid5: multiple 1 requests for sector 281018464

I had exactly these symptoms about a year ago in 2.4.18.  I found and
fixed the problem and have just checked and the fix is definately in
2.4.20.
So if you really are running 2.4.20 then it looks like a similar bug
has appeared.

These two symptoms strongly suggest a buffer aliasing problem.
i.e. you have two buffers (one for data and one for metadata)
that refer to the same location on disc.
One is part of a file that was recently deleted, but the buffer hasn't
been flushed yet.  The other is part of a new directory.
The old buffer and the new buffer both get written to disc at much the
same time (hence the "multiple 1 requests"), but the old buffer hits
the disc second and so corrupts the filesystem.

The bug I found was specific to data=journal mode, and this certainly
has more options for buffer aliasing.  Were you using data=journal?

NeilBrown
