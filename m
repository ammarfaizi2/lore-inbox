Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWJQV2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWJQV2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWJQV1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:27:34 -0400
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79]:3263 "HELO
	smtp010.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750733AbWJQV1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:27:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=fBTbaJFpwwl1Fy6WFeZiC4+Iw6gyg2Xw8cuQ5mtNS690b4ljQLmfDyZ5+CQG/QkLasOAcnJGgUxygNaRyGepT4S6/3MfrLJpNZijGXRMIXKbwRaDWA2kGMkysLdi00lgMydMyLQFNc4LZ3JdzkaJ01mVyk4OSuaT9Jdsx+G7Bq8=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 08/10] uml: cleanup run_helper() API to fix a leak
Date: Tue, 17 Oct 2006 23:27:19 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061017212719.26445.39606.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Freeing the stack is left uselessly to the caller of run_helper in some cases -
this is taken from run_helper_thread, but here it is useless, so no caller needs
it and the only place where this happens has a potential leak - in case of error
neither run_helper() nor xterm_open() call free_stack().
At this point passing a pointer is not needed - the stack pointer should be passed
directly, but this change is not done here.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/xterm.c   |    2 --
 arch/um/os-Linux/helper.c |    7 +++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
index 386f8b9..850221d 100644
--- a/arch/um/drivers/xterm.c
+++ b/arch/um/drivers/xterm.c
@@ -136,8 +136,6 @@ int xterm_open(int input, int output, in
 		return(pid);
 	}
 
-	if(data->stack == 0) free_stack(stack, 0);
-
 	if (data->direct_rcv) {
 		new = os_rcv_fd(fd, &data->helper_pid);
 	} else {
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index e887179..c316dfc 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -52,7 +52,8 @@ static int helper_child(void *arg)
 }
 
 /* Returns either the pid of the child process we run or -E* on failure.
- * XXX The alloc_stack here breaks if this is called in the tracing thread */
+ * XXX The alloc_stack here breaks if this is called in the tracing thread, so
+ * we need to receive a preallocated stack (a local buffer is ok). */
 int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv,
 	       unsigned long *stack_out)
 {
@@ -118,10 +119,8 @@ out_close:
 		close(fds[1]);
 	close(fds[0]);
 out_free:
-	if (stack_out == NULL)
+	if ((stack_out == NULL) || (*stack_out == 0))
 		free_stack(stack, 0);
-	else
-		*stack_out = stack;
 	return ret;
 }
 
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
