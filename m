Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbUBZG1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 01:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbUBZG1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 01:27:39 -0500
Received: from mail013.syd.optusnet.com.au ([211.29.132.67]:41624 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262706AbUBZG1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 01:27:34 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16445.37304.155370.819929@wombat.chubb.wattle.id.au>
Date: Thu, 26 Feb 2004 17:27:04 +1100
To: akpm@osdl.org, kingsley@aurema.com
CC: linux-kernel@vger.kernel.org
Subject: /proc visibility patch breaks GDB, etc.
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In fs/proc/base.c:proc_pid_lookup(), the patch

        read_unlock(&tasklist_lock); 
        if (!task) 
                goto out; 
+       if (!thread_group_leader(task)) 
+               goto out_drop_task; 
  
        inode = proc_pid_make_inode(dir->i_sb, task, PROC_TGID_INO); 

means that threads other than the thread group leader don't appear in
the /proc top-level directory.  Programs that are informed via pid of
events can no longer find the appropriate process -- for example,
using gdb on a multi-threaded process, or profiling using perfmon.

The immediate symptom is GDB saying:
    Could not open /proc/757/status
when 757 is a TID not a PID.

