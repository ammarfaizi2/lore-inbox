Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270341AbUJTOSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270341AbUJTOSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270342AbUJTORW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:17:22 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:19879 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S270341AbUJTOKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:10:51 -0400
Date: Wed, 20 Oct 2004 16:09:56 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: unix@fi.muni.cz, nfs@lists.sourceforge.net, trond.myklebust@fys.uio.no,
       neilb@cse.unsw.edu.au
Subject: [Solved, patch]: NFS mount hang (no response to getattr)
Message-ID: <20041020140955.GA7605@fi.muni.cz>
References: <20041015144701.GD4473@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015144701.GD4473@fi.muni.cz>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: 	I have ran into the following problem with Linux NFS code. Following
: examples are the simplest test (meaningless) cases, the real /etc/exports
: is more complicated, of course.
[...]

	I have found why this is happening to me, but I am not sure
about the solution. The problem is, that mountd joins all the
host/subnet/wild-card names which match the IP address from all 
/etc/exports (not only from the appropriate line in exports),
and then sends this as a ip->name translation to the kernel
via /proc/net/rpc/auth.unix.ip/channel. Now the problem occurs when
the "FQDN+aliases+wildcards" part is 50 characters or more. Kernel then
replies to write() with EINVAL, which mountd ignores.

	So the bug is probably in linux/net/sunrpc/svcauth_unix.c
- the number 50 is hardcoded there several times (ugly, ugly, ...)
and it is too low anyway - the _single_componet_ of FQDN can be
up to 63 chars, FQDN can be up to 255 chars, and I am not counting
possible aliases/wildcards/subnets which mountd decides to add there.

	And the bug is in mountd as well, because it should at least
report to syslog when the write to /proc/.../channel returns EINVAL.

	I propose the following patch to svcauth_unix.c. It is
relative to 2.6.8.1-mm2. I have additionally made the "class" and "buf"
variables static, thus shaving 100 bytes off the kernel stack.
NFS maintaners, please verify this and apply.

-Yenya

--- linux-2.6.8.1-mm2/net/sunrpc/svcauth_unix.c.orig	2004-08-19 22:29:13.000000000 +0200
+++ linux-2.6.8.1-mm2/net/sunrpc/svcauth_unix.c	2004-10-20 15:51:49.495844584 +0200
@@ -151,11 +151,13 @@
 }
 
 static struct ip_map *ip_map_lookup(struct ip_map *, int);
+#define DOMAINNAME_MAX  1024    /* FQDN + possible aliases/subnets/wildcards */
+#define CLASS_MAX	50
 static int ip_map_parse(struct cache_detail *cd,
 			  char *mesg, int mlen)
 {
 	/* class ipaddress [domainname] */
-	char class[50], buf[50];
+	static char class[CLASS_MAX], buf[DOMAINNAME_MAX];
 	int len;
 	int b1,b2,b3,b4;
 	char c;
@@ -168,11 +170,11 @@
 	mesg[mlen-1] = 0;
 
 	/* class */
-	len = qword_get(&mesg, class, 50);
+	len = qword_get(&mesg, class, CLASS_MAX);
 	if (len <= 0) return -EINVAL;
 
 	/* ip address */
-	len = qword_get(&mesg, buf, 50);
+	len = qword_get(&mesg, buf, DOMAINNAME_MAX);
 	if (len <= 0) return -EINVAL;
 
 	if (sscanf(buf, "%u.%u.%u.%u%c", &b1, &b2, &b3, &b4, &c) != 4)
@@ -183,7 +185,7 @@
 		return -EINVAL;
 
 	/* domainname, or empty for NEGATIVE */
-	len = qword_get(&mesg, buf, 50);
+	len = qword_get(&mesg, buf, DOMAINNAME_MAX);
 	if (len < 0) return -EINVAL;
 
 	if (len) {



-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
btw, David, I'm wondering about this loop: [...]  Is this
a busy-wait-until-someone-plugs-in-more-ram-chips thing? ;)  --Andrew Morton
