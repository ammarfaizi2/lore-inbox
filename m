Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264346AbRFMDAs>; Tue, 12 Jun 2001 23:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264505AbRFMDAh>; Tue, 12 Jun 2001 23:00:37 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:28691 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S264346AbRFMDAZ>; Tue, 12 Jun 2001 23:00:25 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: John Covici <covici@ccs.covici.com>
Date: Wed, 13 Jun 2001 13:00:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15142.55093.846398.117560@notabene.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: is there a way to export a fat32 file system using nfs?
In-Reply-To: message from John Covici on Tuesday June 12
In-Reply-To: <Pine.LNX.4.31.0106122148560.788-100000@ccs.covici.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday June 12, covici@ccs.covici.com wrote:
> Hi.  I seem to remember  that at one time in the 2.2 series I was able
> to to export fat32 file systems using nfs, but now it doesn't work
> anymore.

No, it doesn't.

It did in early 2.2 due to some fairly ugly hacks which just had to
go.  They worked in a lot of simple cases, but it wouldn't be too
difficult to confuse such a server so that it would start losing files.

It would be possible to add to 2.4.5, but not easy.
The basic problem is that you cannot create a reliable NFS filehandle
for a file in a FAT filesystem as there are no inode numbers or
anything similar.

What might work would be:

 In fat_fill_inode, set i_generation to the current time.

 When creating a filehandle, store:
    i_ino
    i_generation
    i_location
    i_logstart

 When when asked to lookup a filehandle:
   Call find_inode(i_ino).  
    If this finds something check i_generation.
    If it matches, SUCCESS.

   Call fat_iget(i_location).
    If this finds something, check i_logstart. 
    If it matches, assume SUCCESS.

   Then comes the tricky bit:  read the directory entry
    indicated by i_location, check the i_logstart is right,
    if it is, try to get it into the inode cache properly.
    
It is something that I would like to do, but I have lots of other
things that I want to do at the moment.

NeilBrown


> 
> If I remember correctly, I get "get: operation not permitted" when
> trying to export the directory in question.
> 
> I am using 2.4.5.
> 
> Any assistance would be appreciated.
> 
> -- 
>          John Covici
>          covici@ccs.covici.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
