Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312768AbSCZWFD>; Tue, 26 Mar 2002 17:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312772AbSCZWEy>; Tue, 26 Mar 2002 17:04:54 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:59629 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S312768AbSCZWEu>; Tue, 26 Mar 2002 17:04:50 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Anders Peter Fugmann <afu@fugmann.dhs.org>
Date: Wed, 27 Mar 2002 09:06:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15520.61687.962869.841296@notabene.cse.unsw.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre4-ac1
In-Reply-To: message from Anders Peter Fugmann on Tuesday March 26
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 26, afu@fugmann.dhs.org wrote:
> Compiling static NFSv3 support in kernel, gives me:
> 
> Mar 26 22:30:01 gw kernel: RPC request reserved 240 but used 244
> Mar 26 22:30:32 gw last message repeated 60 times
> Mar 26 22:31:34 gw last message repeated 124 times
> Mar 26 22:32:36 gw last message repeated 124 times
> Mar 26 22:33:37 gw last message repeated 120 times
> Mar 26 22:34:01 gw last message repeated 51 times
> 
> Other errormessages also appears on the form
> RPC request reserved X but used Y, but only where Y=4+X.
> 
> Client is vanilla 2.5.7. This happens with and without TCP support 
> compiled in, and  regardsless of usage of TCP or not.
> 

Thanks.  This is me not being able to count...

We need an early estimate of how big the reply for each request might
be so we can reserve space in the transmit queue.  I counted the
maximum size for each response and obviously got this one wrong and
missed it in my testing.

--- fs/nfsd/nfs3proc.c	2002/03/18 01:44:00	1.3
+++ fs/nfsd/nfs3proc.c	2002/03/26 22:02:46
@@ -679,6 +679,6 @@
   PROC(readdirplus,readdirplus,	readdir,	fhandle,  RC_NOCACHE, 0),
   PROC(fsstat,	 fhandle,	fsstat,		void,     RC_NOCACHE, 1+14),
   PROC(fsinfo,   fhandle,	fsinfo,		void,     RC_NOCACHE, 1+13),
-  PROC(pathconf, fhandle,	pathconf,	void,     RC_NOCACHE, 1+6),
+  PROC(pathconf, fhandle,	pathconf,	void,     RC_NOCACHE, 1+7),
   PROC(commit,	 commit,	commit,		fhandle,  RC_NOCACHE, 1+7+22+2),
 };


should fix it.  If it doesn't (and there is something else that I have
missed), please

  echo 16 > /proc/sys/sunrpc/nfsd_debug

and then watch for the error to appear.  You will get something like:

Mar 27 08:56:55 elfman kernel: nfsd: FSINFO(3)   12: 00000001 01000800 00000002 00000000 00000000 00000000
Mar 27 08:56:55 elfman kernel: nfsd: GETATTR(3)  12: 00000001 01000800 00000002 00000000 00000000 00000000
Mar 27 08:56:55 elfman kernel: nfsd: ACCESS(3)   12: 00000001 01000800 00000002 00000000 00000000 00000000 0x2
Mar 27 08:56:55 elfman kernel: nfsd: PATHCONF(3) 12: 00000001 01000800 00000002 00000000 00000000 00000000
Mar 27 08:56:55 elfman kernel: RPC request reserved 56 but used 60
Mar 27 08:56:55 elfman kernel: nfsd: GETATTR(3)  12: 00000001 01000800 00000002 00000000 00000000 00000000
Mar 27 08:56:55 elfman kernel: nfsd: ACCESS(3)   12: 00000001 01000800 00000002 00000000 00000000 00000000 0x1
Mar 27 08:56:55 elfman kernel: nfsd: READDIR+(3) 12: 00000001 01000800 00000002 00000000 00000000 00000000 8192 bytes at 0
Mar 27 08:56:55 elfman kernel: nfsd: READLINK(3) 28: 02000001 01000800 00000002 0000000d 3a270305 00000002

which, in this case, shows that the error happened for a PATHCONF(3)
call.

NeilBrown
