Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270947AbRHNXuX>; Tue, 14 Aug 2001 19:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270949AbRHNXuE>; Tue, 14 Aug 2001 19:50:04 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:49362 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S270950AbRHNXuA>;
	Tue, 14 Aug 2001 19:50:00 -0400
Message-ID: <3B79BA07.B57634FD@sun.com>
Date: Tue, 14 Aug 2001 16:53:43 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: poll change
In-Reply-To: <3B79B381.58266C13@sun.com>
		<20010814.162710.131914269.davem@redhat.com>
		<3B79B5F3.C816CBED@sun.com> <20010814.163804.66057702.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------19D25FEECDB0D2EA3D56BF6C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------19D25FEECDB0D2EA3D56BF6C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"David S. Miller" wrote:
 
>    The standard also says that any pollfd with (fd < 0) is ignored.  Holes are
>    explicitly ALLOWED.
> 
> Dude, it ignores negative fds, check fs/select.c:do_pollfd()

Right - we're running in circles.

The standard says negative fd's are ignored.  We get that right.  What we
are left with is an overly paranoid check against max_fds.  This check
should go away.  You should be able to pass in up to your rlimit fds, and
let negative ones (holes or tails) be ignored.

I'm attaching a patch :).

Am I still not making the problem clear?

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------19D25FEECDB0D2EA3D56BF6C
Content-Type: text/plain; charset=us-ascii;
 name="select.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="select.diff"

Index: fs/select.c
===================================================================
RCS file: /home/cvs/linux-2.4/fs/select.c,v
retrieving revision 1.5
diff -u -r1.5 select.c
--- fs/select.c	2001/07/09 23:10:25	1.5
+++ fs/select.c	2001/08/14 23:47:46
@@ -416,11 +416,8 @@
 	int nchunks, nleft;
 
 	/* Do a sanity check on nfds ... */
-	if (nfds > NR_OPEN)
+	if (nfds > current->rlim[RLIMIT_NOFILE].rlim_cur)
 		return -EINVAL;
-
-	if (nfds > current->files->max_fds)
-		nfds = current->files->max_fds;
 
 	if (timeout) {
 		/* Careful about overflow in the intermediate values */

--------------19D25FEECDB0D2EA3D56BF6C--

