Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVCPWhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVCPWhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVCPWhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:37:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:25561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261547AbVCPWgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:36:22 -0500
Message-ID: <4238B4E0.7040003@osdl.org>
Date: Wed, 16 Mar 2005 14:36:16 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Artem Frolov <artemfrolov@gmail.com>
CC: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>
Subject: [PATCH] Taking strlen of buffers copied from userspace
References: <26092d8c0503151027ec75b63@mail.gmail.com>
In-Reply-To: <26092d8c0503151027ec75b63@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------080005060805060203000105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080005060805060203000105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Artem Frolov wrote:
> Hello,
> 
> I am in the process of testing static defect analyzer on a Linux
> kernel source code (see disclosure below).
> 
> I found some potential array bounds violations. The pattern is as
> follows: bytes are copied from the user space and then buffer is
> accessed on index strlen(buf)-1. This is a defect if user data start
> from 0. So the question is: can we make any assumptions what data may
> be received from the user or it could be arbitrary?

Both are potential problems for someone with CAP_SYS_ADMIN
capabilties.  Attached are patches for them.


> Full disclosure: I am working for Klocwork (http://www.klocwork.com/),
> which is a vendor of commercial closed-source proprietary products,
> static analyzer for C/C++ is part of its products


-- 
~Randy

--------------080005060805060203000105
Content-Type: text/x-patch;
 name="mtrr_strlen_v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mtrr_strlen_v2.patch"


mtrr: prevent copy_from_user(to, from, -1) or (if that should
  succeed somehow) write to line[-1] (on stack);

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 arch/i386/kernel/cpu/mtrr/if.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -Naurp ./arch/i386/kernel/cpu/mtrr/if.c~mtrr_strlen ./arch/i386/kernel/cpu/mtrr/if.c
--- ./arch/i386/kernel/cpu/mtrr/if.c~mtrr_strlen	2005-03-01 23:37:50.000000000 -0800
+++ ./arch/i386/kernel/cpu/mtrr/if.c	2005-03-15 20:02:35.000000000 -0800
@@ -98,16 +98,20 @@ mtrr_write(struct file *file, const char
 	unsigned long long base, size;
 	char *ptr;
 	char line[LINE_SIZE];
+	size_t linelen;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
+	if (!len)
+		return -EINVAL;
 	memset(line, 0, LINE_SIZE);
 	if (len > LINE_SIZE)
 		len = LINE_SIZE;
 	if (copy_from_user(line, buf, len - 1))
 		return -EFAULT;
-	ptr = line + strlen(line) - 1;
-	if (*ptr == '\n')
+	linelen = strlen(line);
+	ptr = line + linelen - 1;
+	if (linelen && *ptr == '\n')
 		*ptr = '\0';
 	if (!strncmp(line, "disable=", 8)) {
 		reg = simple_strtoul(line + 8, &ptr, 0);

--------------080005060805060203000105
Content-Type: text/x-patch;
 name="cciss_strlen.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cciss_strlen.patch"


cciss: prevent write to cmd[-1] (on stack);

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/block/cciss.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./drivers/block/cciss.c~cciss_strlen ./drivers/block/cciss.c
--- ./drivers/block/cciss.c~cciss_strlen	2005-03-14 15:28:18.000000000 -0800
+++ ./drivers/block/cciss.c	2005-03-15 14:53:52.000000000 -0800
@@ -304,7 +304,7 @@ cciss_proc_write(struct file *file, cons
 	if (copy_from_user(cmd, buffer, count)) return -EFAULT;
 	cmd[count] = '\0';
 	len = strlen(cmd);	// above 3 lines ensure safety
-	if (cmd[len-1] == '\n') 
+	if (len && cmd[len-1] == '\n') 
 		cmd[--len] = '\0';
 #	ifdef CONFIG_CISS_SCSI_TAPE
 		if (strcmp("engage scsi", cmd)==0) {

--------------080005060805060203000105--
