Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276331AbRJUQfg>; Sun, 21 Oct 2001 12:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276335AbRJUQf1>; Sun, 21 Oct 2001 12:35:27 -0400
Received: from bitmover.com ([192.132.92.2]:64424 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S276331AbRJUQfN>;
	Sun, 21 Oct 2001 12:35:13 -0400
Date: Sun, 21 Oct 2001 09:35:47 -0700
From: Larry McVoy <lm@bitmover.com>
To: Christoph Rohland <cr@sap.com>
Cc: Jan-Frode Myklebust <janfrode@parallab.uib.no>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>,
        Wayne Scott <wscott@bitmover.com>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Message-ID: <20011021093547.A24227@work.bitmover.com>
Mail-Followup-To: Christoph Rohland <cr@sap.com>,
	Jan-Frode Myklebust <janfrode@parallab.uib.no>,
	ML-linux-kernel <linux-kernel@vger.kernel.org>,
	Wayne Scott <wscott@work.bitmover.com>
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com> <m33d4gjaoa.fsf@linux.local> <20011020171730.A28057@parallab.uib.no> <3BD28673.1060302@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3BD28673.1060302@sap.com>; from cr@sap.com on Sun, Oct 21, 2001 at 10:25:23AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan-Frode Myklebust wrote:
> 
>  > Running BitKeeper regression tests fails for me on tmpfs /tmp/. I have
>  > reported it to the bitkeeper bugtracking, but am not sure if this is a
>  > bitkeeper or tmpfs bug. Any insight?
>  >
>  > 	http://bitkeeper.bkserver.com/cgi-bin/bugview?open/2001-09-11-001
>  >
>  > Last tested with Bitkeeper 2.0 on linux 2.4.10-xfs.

One of the engineers here has also seen this.  The root cause is that
readdir() is returning a file multiple times.  We've seen it on tmpfs.
We also have seen in in NFS and had a workaround, the workaround
depended that the file would be returned twice right next to each other
and that's not the case in tmpfs.  wscott@bitmover.com can provide you
with the details of his machine config, here's the mail he sent a while
back about it:

> Date: Tue, 16 Oct 2001 17:32:32 -0500 (EST)
> To: dev@bitmover.com
> Subject: bug in tmpfs found by bitkeeper                                        
> From: Wayne Scott <wscott@bitmover.com>                                         
> X-Mailer: Mew version 2.0.56 on Emacs 20.7 / Mule 4.1 (AOI)
>     
>    
> My new machine has a reiserfs filesystem for /tmp.
>    
> Since BK has a bug that prevents it from working correctly on reiserfs
> that I explained list week I can't run the regressions locally.
>    
> I thought I would work around the problem by mounting the kernel
> 'tmpfs' filesystem on /tmp.  Now the regressions again fail, but this
> time I thing the filesystem is to blame.  A readdir() call is
> returning the same files multiple times.
>    
> Look at this patch:
>    
> --- /tmp/geta4199       Tue Oct 16 17:24:55 2001
> +++ sfiles.c    Tue Oct 16 17:24:10 2001
> @@ -659,11 +659,13 @@
>                 return;
>         }                                                                       
>         if (base[-1] != '/') *base++ = '/';
> +       fprintf(stderr, "dir = %s\n", path);
>         while ((e = readdir(d)) != NULL) {
>  #ifndef WIN32  /* Linux 2.3.x NFS bug, skip repeats. */                        
>                 if (lastInode == e->d_ino) continue;
>                 lastInode = e->d_ino;
>  #endif                                                                         
> +               fprintf(stderr, "%s: %x\n", e->d_name, e->d_ino);
>                 if (streq(e->d_name, ".") || streq(e->d_name, "..")) {
>                         continue;
>                 }                                                               
>    
> At this output from running t.bk_basic
>    
> dir = ./BitKeeper/etc/SCCS/.bk_skip
> .: 1f72
> ..: 1f71
> s.config: 1f85
> x.dfile: 1f86
> s.ignore: 1f7f
> s.logging_ok: 1f7d
> s.ignore: 1f7f
> ROOTKEY
> +wscott@wscott1.homeip.net|BitKeeper/etc/ignore|20011016222415|54740|3065f497fd7
> +ed3bd
>         used by BitKeeper/etc/SCCS/s.ignore
>         and by  BitKeeper/etc/SCCS/s.ignore
>    
> The file s.ignore occurs more than once.  An unlike the old 2.3 NFS
> bug I see that already has a workaround, these files are not ever
> adjecent.
>     
> However the tests that do complete do so very very fast.  :)
> (Yes I know the value of fast and broken!)

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
