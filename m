Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130754AbQLCQoq>; Sun, 3 Dec 2000 11:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130802AbQLCQo1>; Sun, 3 Dec 2000 11:44:27 -0500
Received: from linux.kappa.ro ([194.102.255.131]:44303 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S130754AbQLCQoW>;
	Sun, 3 Dec 2000 11:44:22 -0500
Date: Sun, 3 Dec 2000 18:13:49 +0200
From: Mircea Damian <dmircea@linux.kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: Re: corruption on my ext2fs with 2.4.0-test10
Message-ID: <20001203181349.A5222@linux.kappa.ro>
In-Reply-To: <20001203142433.A3806@linux.kappa.ro> <20001203144605.A3936@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001203144605.A3936@linux.kappa.ro>; from dmircea@linux.kappa.ro on Sun, Dec 03, 2000 at 02:46:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, problem found.
Something is broken (I've tested on a new 2.4.0-test12-pre3). Look here:

If I run strace through the perl script I get something like:

root@invasion:/usr/src/archives/perl-5.6.0/t# strace ./perl op/lfs.t
...
open("big", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
fstat(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
_llseek(3, 5000000000, [5000000000], SEEK_SET) = 0
write(3, "big", 3)                      = 3
close(3)                                = 0
munmap(0x40015000, 4096)                = 0
stat("big", 0xbffff980)                 = -1 EOVERFLOW (Value too large for defined data type)
...

I believe that _llseek() call should return EINVAL. Right?




On Sun, Dec 03, 2000 at 02:46:06PM +0200, Mircea Damian wrote:
> 
> Sorry that I have to follow my self but I forgot to say that e2fsck is
> happy with it:
> 
> root@invasion:~# e2fsck -C 0 -f /dev/hda2
> e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure                                           
> Pass 3: Checking directory connectivity                                        
> Pass 4: Checking reference counts                                              
> Pass 5: Checking group summary information                                     
> /dev/hda2: 43056/1548288 files (1.7% non-contiguous), 237689/1548264 blocks 
> 
> ... file-utils like ls, rm say:
> root@invasion:/usr/src/perl-5.6.0/t# ls -sail
> /bin/ls: big: Value too large for defined data type
> total 8
> 1097360    4 drwx------   2 504      1001         4096 Dec  3 13:43 ./
> 1354979    4 drwxr-xr-x   3 504      1001         4096 Dec  3 13:43 ../
> 
> root@invasion:/usr/src/perl-5.6.0/t# rm big
> rm: cannot remove `big': Value too large for defined data type
> 
> I can not keep this machine down (my /-fs is read-only right now just to be
> sure that nothing changes) for too much time.

-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
