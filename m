Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932758AbWBURSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbWBURSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbWBURRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:17:50 -0500
Received: from [151.97.230.9] ([151.97.230.9]:9438 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932758AbWBURR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:17:26 -0500
X-Antivirus-MYDOMAIN-Mail-From: blaisorblade@yahoo.it via ssc.unict.it
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:1(151.97.230.9):. Processed in 0.033019 secs Process 16157)
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 5/6] uml: better error reporting for read_output
Date: Tue, 21 Feb 2006 18:16:30 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060221171630.509.33472.stgit@zion.home.lan>
In-Reply-To: <20060221171535.509.28286.stgit@zion.home.lan>
References: <20060221171535.509.28286.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do precise error handling: print precise error messages, distinguishing short
reads and read errors. This functions fails frequently enough for me so I
bothered doing this fix.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/net_user.c |   34 ++++++++++++++++++++++------------
 1 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
index 098fa65..0e2f061 100644
--- a/arch/um/drivers/net_user.c
+++ b/arch/um/drivers/net_user.c
@@ -47,10 +47,12 @@ void tap_check_ips(char *gate_addr, unsi
 	}
 }
 
+/* Do reliable error handling as this fails frequently enough. */
 void read_output(int fd, char *output, int len)
 {
-	int remain, n, actual;
+	int remain, ret, expected;
 	char c;
+	char *str;
 
 	if(output == NULL){
 		output = &c;
@@ -58,23 +60,31 @@ void read_output(int fd, char *output, i
 	}
 		
 	*output = '\0';
-	n = os_read_file(fd, &remain, sizeof(remain));
-	if(n != sizeof(remain)){
-		printk("read_output - read of length failed, err = %d\n", -n);
-		return;
+	ret = os_read_file(fd, &remain, sizeof(remain));
+
+	if (ret != sizeof(remain)) {
+		expected = sizeof(remain);
+		str = "length";
+		goto err;
 	}
 
 	while(remain != 0){
-		n = (remain < len) ? remain : len;
-		actual = os_read_file(fd, output, n);
-		if(actual != n){
-			printk("read_output - read of data failed, "
-			       "err = %d\n", -actual);
-			return;
+		expected = (remain < len) ? remain : len;
+		ret = os_read_file(fd, output, expected);
+		if (ret != expected) {
+			str = "data";
+			goto err;
 		}
-		remain -= actual;
+		remain -= ret;
 	}
+
 	return;
+
+err:
+	if (ret < 0)
+		printk("read_output - read of %s failed, errno = %d\n", str, -ret);
+	else
+		printk("read_output - read of %s failed, read only %d of %d bytes\n", str, ret, expected);
 }
 
 int net_read(int fd, void *buf, int len)

