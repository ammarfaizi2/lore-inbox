Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbUK3SdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbUK3SdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbUK3Scu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:32:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:44439 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262251AbUK3Sbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:31:55 -0500
Date: Tue, 30 Nov 2004 10:31:50 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Buffer overrun in arch/x86_64/sys_ia32.c:sys32_ni_syscall()
Message-ID: <20041130103150.I14339@build.pdx.osdl.net>
References: <1101787520.4087.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1101787520.4087.5.camel@localhost>; from jeremy@goop.org on Mon, Nov 29, 2004 at 08:05:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> struct task_struct.comm is defined to be 16 chars, but
> arch/x86_64/sys_ia32.c:sys32_ni_syscall() copies it into a static 8 byte
> buffer, which will surely cause problems.  This patch makes lastcomm[]
> the right size, and makes sure it can't be overrun.  Since the code also
> goes to the effort of getting a local copy of current in "me", we may as
> well use it for printing the message.

Looks good, but you missed sys32_vm86_warning.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== arch/x86_64/ia32/sys_ia32.c 1.74 vs edited =====
--- 1.74/arch/x86_64/ia32/sys_ia32.c	2004-11-02 06:40:37 -08:00
+++ edited/arch/x86_64/ia32/sys_ia32.c	2004-11-30 09:42:26 -08:00
@@ -525,11 +525,12 @@ sys32_waitpid(compat_pid_t pid, unsigned
 int sys32_ni_syscall(int call)
 { 
 	struct task_struct *me = current;
-	static char lastcomm[8];
-	if (strcmp(lastcomm, me->comm)) {
-	printk(KERN_INFO "IA32 syscall %d from %s not implemented\n", call,
-	       current->comm);
-		strcpy(lastcomm, me->comm); 
+	static char lastcomm[sizeof(me->comm)];
+
+	if (strncmp(lastcomm, me->comm, sizeof(lastcomm))) {
+		printk(KERN_INFO "IA32 syscall %d from %s not implemented\n",
+		       call, me->comm);
+		strncpy(lastcomm, me->comm, sizeof(lastcomm));
 	} 
 	return -ENOSYS;	       
 } 
@@ -1125,11 +1126,11 @@ long sys32_fadvise64_64(int fd, __u32 of
 long sys32_vm86_warning(void)
 { 
 	struct task_struct *me = current;
-	static char lastcomm[8];
-	if (strcmp(lastcomm, me->comm)) {
+	static char lastcomm[sizeof(me->comm)];
+	if (strncmp(lastcomm, me->comm, sizeof(lastcomm))) {
 		printk(KERN_INFO "%s: vm86 mode not supported on 64 bit kernel\n",
 		       me->comm);
-		strcpy(lastcomm, me->comm); 
+		strncpy(lastcomm, me->comm, sizeof(lastcomm)); 
 	} 
 	return -ENOSYS;
 } 
