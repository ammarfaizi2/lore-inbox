Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267488AbTAVN0B>; Wed, 22 Jan 2003 08:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267489AbTAVN0B>; Wed, 22 Jan 2003 08:26:01 -0500
Received: from noc7.BelWue.DE ([129.143.2.15]:47764 "EHLO smtp2.BelWue.DE")
	by vger.kernel.org with ESMTP id <S267488AbTAVNZ7>;
	Wed, 22 Jan 2003 08:25:59 -0500
Date: Wed, 22 Jan 2003 14:35:03 +0100 (MET)
From: Oliver Tennert <tennert@science-computing.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org, kaw@science-computing.de
Subject: Re: NFS client problem and IO blocksize
In-Reply-To: <15918.38755.480267.413305@charged.uio.no>
Message-ID: <Pine.GHP.4.02.10301221424430.848-100000@alderaan.science-computing.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

> rsize/wsize have in principle nothing to do with the blocksize that
> 'stat' returns. The f_bsize value specifies the 'optimal transfer
> block size'. Previously this has been set to the rsize/wsize, but when
> you add in O_DIRECT, then 32k becomes too large a value to align
> to. For this reason, the f_bsize value was changed to reflect the
> actual block size used by the *server*.
> 

OK that explains the data with my own computer. But there is another case
when a Linux NFS client mounts an AIX NFS file system:

(preferred_blksize.perl shows s_blksize of stat() and is used due to the
non-existent stat command on this machine)

root@w0008077 / # mount -o hard,intr,nfsvers=3,udp,rsize=8192,wsize=8192
ibm03:/net/ibm03/fs7/share/netinst_aix /mnt
root@w0008077 / # ~xrsc062/preferred_blksize.perl /mnt/nmon7.tar 
file /mnt/nmon7.tar has the preferred blksize 512.
root@w0008077 / # umount /mnt

root@ibm03 / # ~xrsc062/preferred_blksize.perl /net/ibm03/fs7/share/netinst_aix/nmon7.tar 
file /net/ibm03/fs7/share/netinst_aix/nmon7.tar has the preferred blksize 
4096.

As you can see, the actual server-side s_blksize is 4k, whereas the Linux
client takes it to be 512 bytes. An strace output confirms that a "cat" of
a file actually uses 512 byte IO chunks.

In each case the kernel used is a 2.4.20 with your NFS client patches (and
some of Neil's server patches).

If a RedHat or SuSE kernel is used (which probably does not include 
O_DIRECT, but I am not sure) then there seems to be the correct behaviour,
and the s_blksize is the same as the rsize/wsize options demand, e.g. 8k
or 32k.

Many thanks in advance for your help and best regards.

Oliver


		   Dr. Oliver Tennert
                    
  		   +49 -7071 -9457-598
                          
 		   e-mail: O.Tennert@science-computing.de
  		   science + computing AG
  		   Hagellocher Weg 71                  
   		   D-72070 Tuebingen                  
                                     


