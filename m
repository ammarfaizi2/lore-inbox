Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSGNXss>; Sun, 14 Jul 2002 19:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317260AbSGNXss>; Sun, 14 Jul 2002 19:48:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6667 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317257AbSGNXsq>;
	Sun, 14 Jul 2002 19:48:46 -0400
Message-ID: <3D321041.2D25D649@zip.com.au>
Date: Sun, 14 Jul 2002 16:58:57 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.gmd.de>
CC: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <200207141811.g6EIBXKc019318@burner.fokus.gmd.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> 
> ...
> ftp://ftp.fokus.gmd.de/pub/unix/star/testscript/rock.tar.bz2
> 
> It is a tar archive that contains 207,440 empty files and one directory
> using the names of the files in the 'rock' subdirectory from the
> freedb project. This is a snapshot taken on May 30th 2002.
> 
> If you extract this archive on a machine running Solaris or FreeBSD,
> it takes less than 7 minutes.

With ext3 and the htree directory indexing, a 500MHz PIII does
it in 57 seconds.

tar xjf ~/rock.tar.bz2  19.63s user 29.42s system 84% cpu 57.879 total

> A pentium 800 running Solaris 9 results in:
> 
> # star -xp -time < rock.tar.bz2
> star: WARNING: Archive is bzip2 compressed, trying to use the -bz option.
> star: 10372 blocks + 1536 bytes (total of 106210816 bytes = 103721.50k).
> star: Total time 405.988sec (255 kBytes/sec)
> 6:46.051r 12.920u 63.420s 18% 0M 0+0k 0st 0+0io 0pf+0w
> 
> You see during the 6:43, the machine is 82% idle.
> 
> A Pentium 1200 running Linux-2.5.25 (ext3) results in:
> 
> # star -xp -time < rock.tar.bz2
> star: WARNING: Archive is bzip2 compressed, trying to use the -bz option.
> star: 10372 blocks + 1536 bytes (total of 106210816 bytes = 103721.50k).
> star: Total time 3190.483sec (32 kBytes/sec)
> 53:10.490r 12.299u 2970.099s 93% 0M 0+0k 0st 0+0io 4411pf+0w
> 
> You see, during the 53:20, the machine is only 7% idle!
> 
> It wasted 2900 seconds of CPU time on Linux. Let me guess: this was done
> inside the function strcmp().

Nope. ext3 and ext2 directories use the traditional first-fit
search-from-start for directories.  So adding 200k files to
a single directory is pathological.

> There are ~ 5 different filesystems on Linux, but none if the projects seem
> to care about the code outside the FS low level code. I suspect, that
> this is not any better if you use reiserfs.
> 
> Solaris and FreeBSD put all the effort into one filesystem trying to make
> it as good as possible. In Linux, it seems that nobody prooved the overall
> concept of the kernel.

Apply http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.25/ext3-htree.patch
to your 2.5.25 tree, mount with `-o index' and enjoy watching ext3 eat
Solaris and FreeBSD's lunch.

htree isn't quite ready yet and development seems a little moribund.
It'd be nice to get it finished off.

-
