Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277933AbRJNXwp>; Sun, 14 Oct 2001 19:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277937AbRJNXwg>; Sun, 14 Oct 2001 19:52:36 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:21470 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S277933AbRJNXw0> convert rfc822-to-8bit; Sun, 14 Oct 2001 19:52:26 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Larry McVoy <lm@bitmover.com>
Date: Mon, 15 Oct 2001 09:52:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <15306.9552.673923.69404@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS file locking?
In-Reply-To: message from Larry McVoy on Sunday October 14
In-Reply-To: <200110141811.f9EIB4823631@work.bitmover.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 14, lm@bitmover.com wrote:
> Hi, the open(2) man page says:
> 
>        O_EXCL When  used with O_CREAT, if the file already exists
>               it is an error and the open will fail.   O_EXCL  is
>               broken  on NFS file systems, programs which rely on
>               it for performing locking tasks will contain a race
>               condition.  The solution for performing atomic file
>               locking using a lockfile is to create a unique file
>               on  the  same  fs (e.g., incorporating hostname and
>               pid), use link(2) to make a link to  the  lockfile.
>               If  link() returns 0, the lock is successful.  Oth­
>               erwise, use stat(2) on the unique file to check  if
>               its  link  count  has increased to 2, in which case
>               the lock is also successful.
> 
> I coded this up and tried it here on a cluster of different operating
> systems (Linux 2.4.5 server, linux, freebsd, solaris, aix, hpux, irix
> clients) and it doesn't work.
> 
> 2 questions:
> 
> a) is it the belief of folks here that this should work?

No.  It is unsupportable with NFSv2.
The NFSv3 protocol does provide support, the I don't think the Linux
NFSv3 client supports it yet because the VFS layer tries to handle all
the exclusion, and doesn't give the file-system a chance.

> 
> b) if performance isn't a big issue, is there any portable way to do
>    locking over NFS with just files?

   Instead of creating a lock file, create a lock symlink.
   Have the content of the symlink be something recognisably unique.
   e.g. hostname.pid
   If the "symlink" syscall succeeds, you have got the lock.
   If it fails, issue a readlink and see if the content is what you
   tried to create (RPC packet loss and retransmit could have caused
   an incorrect failure return).  If it is, you have the lock.
   If not, you don't.

   Similar tricks can be done with hard links if you really want a
   file.
   i.e. create a file with a unique name and then hard-link it to the
   lock-file-name.  On apparent failure, check the inode number.


   With all these approaches (including O_EXCL) the tricky bit is
   cleaning up after a failed application left a lockfile lying
   around.
   Automatically deleting it is racy unless you guarantee that only
   one process could ever consider deleting an old lock file.  e.g. a
   cron job on the fileserver that runs every 5 minutes and deletes
   any lock file older that 10 minutes.

NeilBrown

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
