Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUI1Jfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUI1Jfa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 05:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUI1Jfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 05:35:30 -0400
Received: from zeus.kernel.org ([204.152.189.113]:16526 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266195AbUI1JfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 05:35:19 -0400
Date: Tue, 28 Sep 2004 02:33:50 -0700
From: Paul Jackson <pj@sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       csa@oss.sgi.com, akpm@osdl.org, guillaume.thouvenin@bull.net,
       tim@physik3.uni-rostock.de, corliss@digitalmages.com
Subject: Re: [PATCH 2.6.9-rc2 2/2] enhanced MM accounting data collection
Message-Id: <20040928023350.611c84d8.pj@sgi.com>
In-Reply-To: <41589927.5080803@engr.sgi.com>
References: <4158956F.3030706@engr.sgi.com>
	<41589927.5080803@engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nits:

1) I'm not sure the "no-op if CONFIG_CSA not set" comments
   are worthwhile - it does not seem to be a common practice
   to mark macros that collapse under certain CONFIG's with
   such comments, and some code, such as in fork.c, would
   become quite a bit less readable if such comments were
   widely used.

2) Three of the added csa_update_integrals() lines have
   leading spaces, instead of a tab char, such as in:

===================================================================
--- linux.orig/fs/exec.c	2004-09-27 11:57:40.201435722 -0700
+++ linux/fs/exec.c	2004-09-27 14:05:41.266160725 -0700
@@ -1163,6 +1164,9 @@
 
 		/* execve success */
 		security_bprm_free(&bprm);
+		/* no-op if CONFIG_CSA not set */
+                csa_update_integrals();		<=========
+                update_mem_hiwater();			<=========
 		return retval;
 	}
 
3) Is it always the case that csa_update_integrals() and
   update_mem_hiwater() are used together?  If so, perhaps
   they could be collapsed into one?  Even the current->mm
   test inside them could be made one test, perhaps?

4) What kind of kernel text size expansion does this cause?
   There seem to be about a dozen of these calls.  What are
   the pros and cons of inlining csa_update_integrals() and
   update_mem_hiwater()?  Are these on hot enough kernel code
   paths that we should benchmark with and without these hooks
   enabled, both inline and out-of-line?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
