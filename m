Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312332AbSDXQmd>; Wed, 24 Apr 2002 12:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312357AbSDXQmc>; Wed, 24 Apr 2002 12:42:32 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:12783 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S312332AbSDXQma>; Wed, 24 Apr 2002 12:42:30 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 24 Apr 2002 10:40:56 -0600
To: il boba <il_boba@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what`s wrong?
Message-ID: <20020424164056.GA15812@turbolinux.com>
Mail-Followup-To: il boba <il_boba@hotmail.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <F218eE3VsX7PVTdAMDm0000842f@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 24, 2002  18:06 +0200, il boba wrote:
> Is there anybody that can help me understand what`s wrong with this code?

Yes, easily spotted a major problem without even reading the whole
thing.

> #define BUFSIZ 8192
> 
> int init_module()
> {
>  int err_frame[BUFSIZ];

The entire kernel stack is only 8kB in size.  You have already killed
a bunch of random memory by allocating this much memory on the stack.
You allocated 4*8192 = 32kB on the stack here.

> #if CONFIG_MODVERSIONS==1
> #define MODVERSIONS
> #include <linux/modversions.h>
> #endif

You shouldn't do things like this.  Rather have a makefile which sets
the correct defines.

> int init_err_frame(int err_frame[]) {
>  int i, k = 0, j = 0;
>  char buffer[BUFSIZ];

Another 8kB on the stack here - further random corruption.

>  struct file * f = 
> filp_open("/usr/src/kernel-source-2.2.19/pinux/misc/err_file", 0, 0);  /* i 
> want it only readable */

More clear to add "O_RDONLY" to filp_open, even though it is still 0.

>  if (f == '\0'){
>       printk ("errore nell' APERTURA del file d'errore");
>       return -1;
>  }

How about "if (f == NULL)"?

>  if ((generic_file_read(f, buffer, BUFSIZ, &f->f_pos)) < 0 ){

Calling generic_file_read() may work in some cases, but not others.  It
depends on the filesystem.  Use "f->f_op->read" instead.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

