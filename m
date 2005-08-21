Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVHUAnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVHUAnx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 20:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVHUAnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 20:43:53 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:24886 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750732AbVHUAnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 20:43:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=JrDE+aJE9d8Mb/c6OgnxJhDisSJ31RHU/9S3nG3a7cF/d56cgBLFMU+w3KnZT1WUQOrTgWfUs6i7MXEzEOtkVGnSG5l6u/df8AqVQLeX9LPQGQeen6fTSf2DZt6Uw+mw30yPkI1XOPaY8OQ8BsMPaAIYDlgOjb3gg2EGyMZfBas=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATHC] remove a redundant variable in sys_prctl()
Date: Sun, 21 Aug 2005 02:44:31 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200508210244.31401.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a re-send of a small patch I sent on Aug. 9.

The patch removes a redundant variable `sig' from sys_prctl().

For some reason, when sys_prctl is called with option == PR_SET_PDEATHSIG
then the value of arg2 is assigned to an int variable named sig. Then sig
is tested with valid_signal() and later used to set the value of 
current->pdeath_signal . 
There is no reason to use this intermediate variable since valid_signal() 
takes a unsigned long argument, so it can handle being passed arg2 directly, 
and if the call to valid_signal is OK, then we know the value of arg2 is in 
the range  zero to _NSIG and thus it'll easily fit in a plain int and thus 
there's no problem assigning it later to current->pdeath_signal (which is 
an int).

The patch gets rid of the pointless variable `sig'.
This reduces the size of kernel/sys.o in 2.6.13-rc6-mm1 by 32 bytes on my 
system.

Patch has been compile tested, boot tested, and just to make damn sure I 
didn't break anything I wrote a quick test app that calls 
prctl(PR_SET_PDEATHSIG ...) with the entire range of values for a 
unsigned long, and it behaves as expected with and without the patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 kernel/sys.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.13-rc6-mm1-orig/kernel/sys.c	2005-08-19 19:21:25.000000000 +0200
+++ linux-2.6.13-rc6-mm1/kernel/sys.c	2005-08-21 01:30:03.000000000 +0200
@@ -1709,7 +1709,6 @@ asmlinkage long sys_prctl(int option, un
 			  unsigned long arg4, unsigned long arg5)
 {
 	long error;
-	int sig;
 
 	error = security_task_prctl(option, arg2, arg3, arg4, arg5);
 	if (error)
@@ -1717,12 +1716,11 @@ asmlinkage long sys_prctl(int option, un
 
 	switch (option) {
 		case PR_SET_PDEATHSIG:
-			sig = arg2;
-			if (!valid_signal(sig)) {
+			if (!valid_signal(arg2)) {
 				error = -EINVAL;
 				break;
 			}
-			current->pdeath_signal = sig;
+			current->pdeath_signal = arg2;
 			break;
 		case PR_GET_PDEATHSIG:
 			error = put_user(current->pdeath_signal, (int __user *)arg2);



