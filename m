Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRAXTJ1>; Wed, 24 Jan 2001 14:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRAXTJR>; Wed, 24 Jan 2001 14:09:17 -0500
Received: from detroit.gci.com ([205.140.80.57]:14596 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S129532AbRAXTJG>;
	Wed, 24 Jan 2001 14:09:06 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA31503515856@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: linux-kernel@vger.kernel.org
Subject: Error compiling for sparc64
Date: Wed, 24 Jan 2001 10:08:58 -0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported this to Alan around -ac5, but never saw the patch included.

In arch/sparc64/kernel/sys_sparc32.c:~900

struct dqblk32 {
    __u32 dqb_bhardlimit;
    __u32 dqb_bsoftlimit;
    __u32 dqb_curblocks;
    __u32 dqb_ihardlimit;
    __u32 dqb_isoftlimit;
    __u32 dqb_curinodes;
    __kernel_time_t32 dqb_btime;
    __kernel_time_t32 dqb_itime;
};
                                
extern asmlinkage int sys_quotactl(int cmd, const char *special, int id,
caddr_t addr);

asmlinkage int sys32_quotactl(int cmd, const char *special, int id, unsigned
long addr)
{
	int cmds = cmd >> SUBCMDSHIFT;
	int err;
	struct dqblk d;
             ^^^^^

You can see the typo pretty easily.

The following patch allows the kernel to compile correctly
and has been working fine for the last 2 weeks under 2.4.0-ac5.
It should apply cleanly to ac11 as well.

---  linux/arch/sparc64/kernel/sys_sparc32.c	Wed Jan 10 13:08:10 2001
+++ linux/arch/sparc64/kernel/sys_sparc32.c~	Fri Dec 29 13:07:21 2000
@@ +904,7 -904,7 @@
 {
 	int cmds = cmd >> SUBCMDSHIFT;
 	int err;
+	struct dqblk32 d;
-	struct dqblk d;
 	mm_segment_t old_fs;
 	char *spec;


Thanks.

--
Leif Sawyer   --  Pi@4398680
leif@gci.net  ||  lsawyer@gci.com  ||  internic: LS2540 
(907) 868 - 0116   ||  ICQ - 3749190  || http://home.gci.net/~leif
Network Engineer -- General Communication Inc.
PGP Fingerprint: 77 C8 34 B8 FD BC C6 32  5F FE 93 4B AE 6C F7 4E
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GAT d+ s: a C+++(++)$ US++++$ UL++++$ P+++ L++(+++) E---
W+++ N+ o+ K w O- M- V PS+ PE Y+ PGP(+) t+@ 5- X R- tv b++(+++)
DI++++ D++ G+ e(+)* h-- r++ y+ PP++++ HH++++ A19 NT{--}
------END GEEK CODE BLOCK------
Decode it! http://www.ebb.org/ungeek/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
