Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312953AbSC0CFU>; Tue, 26 Mar 2002 21:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312955AbSC0CFL>; Tue, 26 Mar 2002 21:05:11 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:19335 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S312953AbSC0CE5>; Tue, 26 Mar 2002 21:04:57 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Anders Peter Fugmann <afu@fugmann.dhs.org>
Date: Wed, 27 Mar 2002 13:07:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15521.10564.475227.372522@notabene.cse.unsw.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre4-ac1
In-Reply-To: message from Anders Peter Fugmann on Wednesday March 27
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday March 27, afu@fugmann.dhs.org wrote:
> Thanks.
> 
> It seems that there is some more problems.
> I have not verified the lookup (since I just booted right away with the patch), but
> I have found that:
> 
> Mar 26 23:56:58 gw kernel: nfsd: LOOKUP(3)   24: 03000001 03000900 00000002 0000106d 0000106c 0000070d WMRootMenu
> Mar 26 23:56:58 gw kernel: RPC request reserved 240 but used 244
> 
> Mar 27 00:30:09 gw kernel: nfsd: CREATE(3)   24: 03000001 03000900 00000002 00000003 00000002 00000000 test
> Mar 27 00:30:09 gw kernel: RPC request reserved 272 but used 276
> 
> Mar 27 00:30:21 gw kernel: nfsd: SYMLINK(3)  24: 03000001 03000900 00000002 00000003 00000002 00000000 test1 -> test
> Mar 27 00:30:21 gw kernel: RPC request reserved 272 but used 276
> 
> And there might be others.

I bet you're using reisferfs ???

It occasionaly uses filehandles longer than 32 bytes (the max for
NFSv2) and my calculations forgot that nfsv3 allows for 64 bytes.
So "9" (8 longs and a count) should be "17" (16 longs and a count).

Thanks again,
NeilBrown

--- fs/nfsd/nfs3proc.c	2002/03/18 01:44:00	1.3
+++ fs/nfsd/nfs3proc.c	2002/03/27 02:04:30
@@ -662,15 +662,15 @@
   PROC(null,	 void,		void,		void,	 RC_NOCACHE, 1),
   PROC(getattr,	 fhandle,	attrstat,	fhandle, RC_NOCACHE, 1+21),
   PROC(setattr,  sattr,		wccstat,	fhandle,  RC_REPLBUFF, 1+7+22),
-  PROC(lookup,	 dirop,		dirop,		fhandle2, RC_NOCACHE, 1+9+22+22),
+  PROC(lookup,	 dirop,		dirop,		fhandle2, RC_NOCACHE, 1+17+22+22),
   PROC(access,	 access,	access,		fhandle,  RC_NOCACHE, 1+22+1),
   PROC(readlink, fhandle,	readlink,	fhandle,  RC_NOCACHE, 1+22+1+256),
   PROC(read,	 read,		read,		fhandle, RC_NOCACHE, 1+22+4+NFSSVC_MAXBLKSIZE),
   PROC(write,	 write,		write,		fhandle,  RC_REPLBUFF, 1+7+22+4),
-  PROC(create,	 create,	create,		fhandle2, RC_REPLBUFF, 1+(1+9+22)+7+22),
-  PROC(mkdir,	 mkdir,		create,		fhandle2, RC_REPLBUFF, 1+(1+9+22)+7+22),
-  PROC(symlink,	 symlink,	create,		fhandle2, RC_REPLBUFF, 1+(1+9+22)+7+22),
-  PROC(mknod,	 mknod,		create,		fhandle2, RC_REPLBUFF, 1+(1+9+22)+7+22),
+  PROC(create,	 create,	create,		fhandle2, RC_REPLBUFF, 1+(1+17+22)+7+22),
+  PROC(mkdir,	 mkdir,		create,		fhandle2, RC_REPLBUFF, 1+(1+17+22)+7+22),
+  PROC(symlink,	 symlink,	create,		fhandle2, RC_REPLBUFF, 1+(1+17+22)+7+22),
+  PROC(mknod,	 mknod,		create,		fhandle2, RC_REPLBUFF, 1+(1+17+22)+7+22),
   PROC(remove,	 dirop,		wccstat,	fhandle,  RC_REPLBUFF, 1+7+22),
   PROC(rmdir,	 dirop,		wccstat,	fhandle,  RC_REPLBUFF, 1+7+22),
   PROC(rename,	 rename,	rename,		fhandle2, RC_REPLBUFF, 1+7+22+7+22),
@@ -679,6 +679,6 @@
   PROC(readdirplus,readdirplus,	readdir,	fhandle,  RC_NOCACHE, 0),
   PROC(fsstat,	 fhandle,	fsstat,		void,     RC_NOCACHE, 1+14),
   PROC(fsinfo,   fhandle,	fsinfo,		void,     RC_NOCACHE, 1+13),
-  PROC(pathconf, fhandle,	pathconf,	void,     RC_NOCACHE, 1+6),
+  PROC(pathconf, fhandle,	pathconf,	void,     RC_NOCACHE, 1+7),
   PROC(commit,	 commit,	commit,		fhandle,  RC_NOCACHE, 1+7+22+2),
 };
