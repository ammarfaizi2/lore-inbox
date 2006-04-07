Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWDGOcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWDGOcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWDGOcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:32:36 -0400
Received: from [151.97.230.9] ([151.97.230.9]:43740 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932350AbWDGOcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:24 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 12/17] uml: fix hang on run_helper() failure on uml_net
Date: Fri, 07 Apr 2006 16:31:17 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143117.19201.85132.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix an hang on a pipe when run_helper() fails when called by change_tramp()
(i.e. when calling uml_net) - reproduced the bug and verified this fixes it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/net_user.c |    4 +++-
 arch/um/os-Linux/helper.c  |   10 +++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
index 0e2f061..0a7786e 100644
--- a/arch/um/drivers/net_user.c
+++ b/arch/um/drivers/net_user.c
@@ -182,7 +182,9 @@ static int change_tramp(char **argv, cha
 	pe_data.stdout = fds[1];
 	pid = run_helper(change_pre_exec, &pe_data, argv, NULL);
 
-	read_output(fds[0], output, output_len);
+	if (pid > 0)	/* Avoid hang as we won't get data in failure case. */
+		read_output(fds[0], output, output_len);
+
 	os_close_file(fds[0]);
 	os_close_file(fds[1]);
 
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 6490a4f..6987d1d 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -43,7 +43,7 @@ static int helper_child(void *arg)
 		(*data->pre_exec)(data->pre_data);
 	execvp(argv[0], argv);
 	errval = errno;
-	printk("execvp of '%s' failed - errno = %d\n", argv[0], errno);
+	printk("helper_child - execve of '%s' failed - errno = %d\n", argv[0], errno);
 	os_write_file(data->fd, &errval, sizeof(errval));
 	kill(os_getpid(), SIGKILL);
 	return(0);
@@ -92,15 +92,15 @@ int run_helper(void (*pre_exec)(void *),
 	close(fds[1]);
 	fds[1] = -1;
 
-	/*Read the errno value from the child.*/
+	/* Read the errno value from the child, if the exec failed, or get 0 if
+	 * the exec succeeded because the pipe fd was set as close-on-exec. */
 	n = os_read_file(fds[0], &ret, sizeof(ret));
-	if(n < 0){
+	if (n < 0) {
 		printk("run_helper : read on pipe failed, ret = %d\n", -n);
 		ret = n;
 		kill(pid, SIGKILL);
 		CATCH_EINTR(waitpid(pid, NULL, 0));
-	}
-	else if(n != 0){
+	} else if(n != 0){
 		CATCH_EINTR(n = waitpid(pid, NULL, 0));
 		ret = -errno;
 	} else {
