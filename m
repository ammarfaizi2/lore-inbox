Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265184AbUFHMAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265184AbUFHMAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 08:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUFHL5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:57:01 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:21133
	"EHLO voidhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S265184AbUFHLt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:49:56 -0400
Date: Tue, 8 Jun 2004 12:49:35 +0100
From: Andy Whitcroft <apw@shadowen.org>
Message-Id: <200406081149.i58BnZHD026164@voidhawk.shadowen.org>
To: linux-kernel@vger.kernel.org
Subject: sysctl uts write size
Cc: akpm@osdl.org, apw@shadowen.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sysctl interfaces for updating the uts entries such as hostname
and domainname are using the wrong length for these buffers; they are
hard coded to 64.  Although safe, this artifically limits the size
of these fields to one less than the true maximum.  This generates an
inconsistency between the various methods of update for these fields.

# hostname 12345678901234567890123456789012345678901234567890123456789012345
hostname: name too long
# hostname 1234567890123456789012345678901234567890123456789012345678901234
# hostname
1234567890123456789012345678901234567890123456789012345678901234

# sysctl -w kernel.hostname=1234567890123456789012345678901234567890123456789012345678901234567890
kernel.hostname = 1234567890123456789012345678901234567890123456789012345678901234567890
# hostname
123456789012345678901234567890123456789012345678901234567890123
# 

The error originates from the fact the handler for strings (proc_dostring)
already allows for the string terminator.  This patch corrects the
limit, taking the oppotunity to convert to use of sizeof().

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

---
 sysctl.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/kernel/sysctl.c current/kernel/sysctl.c
--- reference/kernel/sysctl.c	2004-05-10 14:55:16.000000000 +0100
+++ current/kernel/sysctl.c	2004-06-08 13:26:23.000000000 +0100
@@ -218,7 +218,7 @@ static ctl_table kern_table[] = {
 		.ctl_name	= KERN_OSTYPE,
 		.procname	= "ostype",
 		.data		= system_utsname.sysname,
-		.maxlen		= 64,
+		.maxlen		= sizeof(system_utsname.sysname),
 		.mode		= 0444,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
@@ -227,7 +227,7 @@ static ctl_table kern_table[] = {
 		.ctl_name	= KERN_OSRELEASE,
 		.procname	= "osrelease",
 		.data		= system_utsname.release,
-		.maxlen		= 64,
+		.maxlen		= sizeof(system_utsname.release),
 		.mode		= 0444,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
@@ -236,7 +236,7 @@ static ctl_table kern_table[] = {
 		.ctl_name	= KERN_VERSION,
 		.procname	= "version",
 		.data		= system_utsname.version,
-		.maxlen		= 64,
+		.maxlen		= sizeof(system_utsname.version),
 		.mode		= 0444,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
@@ -245,7 +245,7 @@ static ctl_table kern_table[] = {
 		.ctl_name	= KERN_NODENAME,
 		.procname	= "hostname",
 		.data		= system_utsname.nodename,
-		.maxlen		= 64,
+		.maxlen		= sizeof(system_utsname.nodename),
 		.mode		= 0644,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
@@ -254,7 +254,7 @@ static ctl_table kern_table[] = {
 		.ctl_name	= KERN_DOMAINNAME,
 		.procname	= "domainname",
 		.data		= system_utsname.domainname,
-		.maxlen		= 64,
+		.maxlen		= sizeof(system_utsname.domainname),
 		.mode		= 0644,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
