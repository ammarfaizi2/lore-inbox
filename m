Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279613AbRJ2XXk>; Mon, 29 Oct 2001 18:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279618AbRJ2XXU>; Mon, 29 Oct 2001 18:23:20 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:10674 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S279616AbRJ2XXL>; Mon, 29 Oct 2001 18:23:11 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Simon Kirby <sim@netnation.com>
Date: Tue, 30 Oct 2001 11:23:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15325.62229.637726.355892@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Jan Kara <jack@ucw.cz>
Subject: Re: Oops: Quota race in 2.4.12?
In-Reply-To: message from Simon Kirby on Sunday October 28
In-Reply-To: <20011028215818.A7887@netnation.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 28, sim@netnation.com wrote:
> Some of our dual CPU web servers with 2.4.12 are Oopsing while running
> quotacheck.  

And speaking of quota oopses, I have had oops while enabling quota on
an active filesystem (which admittedly isn't very smart, but shouldn't
oops).
I think the following patch fixes it for 2.4.13.  I had a quick look
at the latest -ac code it doesn't have the same problem.

--------------------------------------------------------------------
Avoid Oops when quotas turned on on active filesystem

Current code
  sets quotas-enabled flag
  possibly blocks on dqget or dqput
  then sets dq_op

If other code call DQUOT_INIT (for example) during the block, it will oops.


--- ./fs/dquot.c	2001/10/30 00:17:23	1.1
+++ ./fs/dquot.c	2001/10/30 00:18:26	1.2
@@ -1363,6 +1363,7 @@
 	inode->i_flags |= S_NOQUOTA;
 
 	dqopt->files[type] = f;
+	sb->dq_op = &dquot_operations;
 	set_enable_flags(dqopt, type);
 
 	dquot = dqget(sb, 0, type);
@@ -1370,7 +1371,6 @@
 	dqopt->block_expire[type] = (dquot != NODQUOT) ? dquot->dq_btime : MAX_DQ_TIME;
 	dqput(dquot);
 
-	sb->dq_op = &dquot_operations;
 	add_dquot_ref(sb, type);
 
 	up(&dqopt->dqoff_sem);


-------------------------------------------------------------------
