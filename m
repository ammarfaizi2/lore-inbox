Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272642AbRHaJVP>; Fri, 31 Aug 2001 05:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272643AbRHaJVF>; Fri, 31 Aug 2001 05:21:05 -0400
Received: from fe030.worldonline.dk ([212.54.64.197]:10507 "HELO
	fe030.worldonline.dk") by vger.kernel.org with SMTP
	id <S272642AbRHaJU4>; Fri, 31 Aug 2001 05:20:56 -0400
Date: Fri, 31 Aug 2001 11:20:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Joe Thornber <thornber@btconnect.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A possible direction for the next LVM driver
Message-ID: <20010831112020.K2855@suse.de>
In-Reply-To: <20010830164547.A807@btconnect.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20010830164547.A807@btconnect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 30 2001, Joe Thornber wrote:
> Hi,
> 
> I'm working on the next iteration of the LVM driver, specifically
> trying to address the critism directed at the rather ugly ioctl
> interface.  The code has reached the stage where it works and it's
> possible to see what I'm aiming for.  I would appreciate it if people
> could spare the time to review this and give me feedback.  If there is
> general agreement that this is moving in the right direction then the
> next major version of LVM may be based around a future version of this
> driver.  Please CC me in replies.  The code can be found at:
> 
> ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper.tar.bz2

Looks interesting, here's patch to fix possible infinite loop in your
make_request_fn. Another quick note -- you might want to consider
slab'ifying the io_hook allocation/deallocation...

-- 
Jens Axboe


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dm-1

--- dm.c~	Fri Aug 31 11:15:24 2001
+++ dm.c	Fri Aug 31 11:16:36 2001
@@ -346,7 +346,7 @@
 	int r, minor = MINOR(bh->b_rdev);
 
 	if (minor >= MAX_DEVICES)
-		return -ENXIO;
+		goto bad_rl;
 
 	rl;
 	md = _devs[minor];
@@ -359,10 +359,8 @@
 		ru;
 		r = queue_io(md, bh, rw);
 
-		if (r < 0) {
-			buffer_IO_error(bh);
-			return 0;
-
+		if (r < 0)
+			goto bad_rl;
 		} else if (r > 0)
 			return 0; /* deferred successfully */
 
@@ -377,6 +375,7 @@
 
  bad:
 	ru;
+ bad_rl:
 	buffer_IO_error(bh);
 	return 0;
 }

--X1bOJ3K7DJ5YkBrT--
