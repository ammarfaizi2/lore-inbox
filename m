Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265747AbSJTC7v>; Sat, 19 Oct 2002 22:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265748AbSJTC7v>; Sat, 19 Oct 2002 22:59:51 -0400
Received: from packet.digeo.com ([12.110.80.53]:56045 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265747AbSJTC7t>;
	Sat, 19 Oct 2002 22:59:49 -0400
Message-ID: <3DB21D88.2E845F02@digeo.com>
Date: Sat, 19 Oct 2002 20:05:44 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: conman@kolivas.net
CC: Rik van Riel <riel@conectiva.com.br>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Pathological case identified from contest
References: <1034820820.3dae1cd4bc0e3@kolivas.net> <1034839006.3dae63de3f69a@kolivas.net> <3DAE6826.72C345EE@digeo.com> <200210201259.34935.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2002 03:05:45.0450 (UTC) FILETIME=[953834A0:01C277E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Thu, 17 Oct 2002 05:35 pm, you wrote:
> > Con Kolivas wrote:
> > > ...
> > > Well this has become more common with 2.5.43-mm2. I had to abort the
> > > process_load run 3 times when benchmarking it. Going back to other
> > > kernels and trying them it didnt happen so I dont think its my hardware
> > > failing or something like that.
> >
> > No, it's a bug in either the pipe code or the CPU scheduler I'd say.
> >
> > You could try backing out to the 2.5.40 pipe implementation; not sure if
> > that would tell us much though.
> 
> I massaged the patch a little for it to apply and  it _is_ the offending code.
> Backing out the pipe changes fixed the problem. I was unable to reproduce the
> holdup I was seeing with process_load even at higher data sizes. Now what?
> 

Try Manfred's pipe fix I guess?


--- 2.5/fs/pipe.c	Sat Oct 19 11:40:14 2002
+++ build-2.5/fs/pipe.c	Sat Oct 19 19:44:04 2002
@@ -109,7 +109,7 @@
 			break;
 		}
 		if (do_wakeup) {
-			wake_up_interruptible(PIPE_WAIT(*inode));
+			wake_up_interruptible_sync(PIPE_WAIT(*inode));
  			kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 		}
 		pipe_wait(inode);
@@ -117,7 +117,7 @@
 	up(PIPE_SEM(*inode));
 	/* Signal writers asynchronously that there is more room.  */
 	if (do_wakeup) {
-		wake_up_interruptible_sync(PIPE_WAIT(*inode));
+		wake_up_interruptible(PIPE_WAIT(*inode));
 		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 	}
 	if (ret > 0)
