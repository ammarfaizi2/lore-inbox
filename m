Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVBROPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVBROPZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 09:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVBROPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 09:15:25 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:4737 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261208AbVBROPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 09:15:15 -0500
Message-ID: <4215F89F.9050801@sgi.com>
Date: Fri, 18 Feb 2005 06:15:59 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Christoph Lameter <clameter@sgi.com>
CC: Andrew Morton <akpm@osdl.org>
Subject: initialize_acct_integrals
Content-Type: multipart/mixed;
 boundary="------------040107010300000601040803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040107010300000601040803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

The new "move-accounting-function-calls-out-of-critical-vm-code-paths"
patch in 2.6.11-rc3-mm2 was different from the code i tested.

In particular, it mistakenly dropped the accounting routine calls
in fs/exec.c. The calls in do_execve() are needed to properly
initialize accounting fields. Specifically, the tsk->acct_stimexpd
needs to be initialized to tsk->stime.

I have discussed this with Christoph Lameter and he gave me full
blessings to bring the calls back.

This initialize_acct_integrals patch was generated against
2.6.11-rc3-mm2 to fix the problem. Thanks!

Signed-off-by: Jay Lan <jlan@sgi.com>


--------------040107010300000601040803
Content-Type: text/plain;
 name="initialize_acct_integrals"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="initialize_acct_integrals"

Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c	2005-02-17 19:24:45.785343748 -0800
+++ linux/fs/exec.c	2005-02-18 05:45:19.868493728 -0800
@@ -1193,6 +1193,8 @@ int do_execve(char * filename,
 
 		/* execve success */
 		security_bprm_free(bprm);
+		acct_update_integrals(current);
+		update_mem_hiwater(current);
 		kfree(bprm);
 		return retval;
 	}

--------------040107010300000601040803--

