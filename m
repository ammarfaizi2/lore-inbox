Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVF2M4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVF2M4A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 08:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbVF2Mz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 08:55:59 -0400
Received: from cantor2.suse.de ([195.135.220.15]:19932 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262562AbVF2Mzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 08:55:47 -0400
From: Gernot Payer <gpayer@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Patch to disarm timers after an exec syscall
Date: Wed, 29 Jun 2005 14:55:45 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RppwC0lazdULkGE"
Message-Id: <200506291455.45468.gpayer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_RppwC0lazdULkGE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

while running the openposix testsuite I saw testcase timer_create/9-1.c 
failing. This testcase tests whether timers are disarmed when a process calls 
exec, as described in e.g. 
http://www.opengroup.org/onlinepubs/009695399/functions/timer_create.html.

The attached one-liner patch (+ one line comment) fixes this issue. I did the 
diff against 2.6.12.1, but the fix is pretty much the same for every other 
2.6.x kernel I had a look at.

I don't think this patch breaks anything, as relying on this (undocumented) 
behaviour would imho be bad style.

So tell me what you think, and if you have some pointers to interesting 
discussions about Linux and POSIX compliance then I would like to read that 
as well.

mfg
Gernot

--Boundary-00=_RppwC0lazdULkGE
Content-Type: text/x-diff;
  charset="us-ascii";
  name="delete-old-itimers-in-do_execve-linux-2.6.12.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="delete-old-itimers-in-do_execve-linux-2.6.12.1.patch"

--- linux-2.6.12.1-orig/fs/exec.c	2005-06-29 14:29:31.069738264 +0200
+++ linux-2.6.12.1/fs/exec.c	2005-06-29 14:34:46.034856288 +0200
@@ -1200,6 +1200,10 @@
 		acct_update_integrals(current);
 		update_mem_hiwater(current);
 		kfree(bprm);
+
+		/* delete old itimers */
+		exit_itimers(current->signal);
+		
 		return retval;
 	}
 

--Boundary-00=_RppwC0lazdULkGE--
