Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbUJZOM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbUJZOM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUJZOM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:12:57 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:49372 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262271AbUJZOMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:12:15 -0400
Date: Tue, 26 Oct 2004 16:11:48 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: nfs@lists.sourceforge.net, trond.myklebust@fys.uio.no,
       neilb@cse.unsw.edu.au, torvalds@osdl.org
Subject: [PATCH] NFS mount hang fix
Message-ID: <20041026141148.GM6408@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

The attached patch fixes the problem where Linux NFS server is not
able to serve clients with FQDN longer than 49 characters (altough
FQDN can be up to 255 characters, and I am not counting exports to
subnet or wildcard, which can add to the total length). The patch
also fixes at least the following two bugs from RH bugzilla:

http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=127521
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=135109

I am sorry to repost this, but I have got no feedback from NFS maintainers,
while I've got postitive feedback from three people whose problems
was fixed by this patch. NFS maintaners - are you alive? If not,
Linus, please apply this patch. Thanks,

-Yenya

Patch relative to 2.6.9:

Signed-Off-By: Jan "Yenya" Kasprzak <kas@fi.muni.cz>


--- linux-2.6.9/net/sunrpc/svcauth_unix.c.orig	2004-10-26 15:47:51.497924576 +0200
+++ linux-2.6.9/net/sunrpc/svcauth_unix.c	2004-10-26 16:01:20.121995032 +0200
@@ -150,11 +150,13 @@
 }
 
 static struct ip_map *ip_map_lookup(struct ip_map *, int);
+#define DOMAINNAME_MAX  1024    /* FQDN + possible aliases/subnets/wildcards */
+#define CLASS_MAX    50
 static int ip_map_parse(struct cache_detail *cd,
 			  char *mesg, int mlen)
 {
 	/* class ipaddress [domainname] */
-	char class[50], buf[50];
+	static char class[CLASS_MAX], buf[DOMAINNAME_MAX];
 	int len;
 	int b1,b2,b3,b4;
 	char c;
@@ -167,13 +169,13 @@
 	mesg[mlen-1] = 0;
 
 	/* class */
-	len = qword_get(&mesg, class, 50);
+	len = qword_get(&mesg, class, CLASS_MAX);
 	if (len <= 0) return -EINVAL;
 	if (len >= sizeof(ipm.m_class))
 		return -EINVAL;
 
 	/* ip address */
-	len = qword_get(&mesg, buf, 50);
+	len = qword_get(&mesg, buf, DOMAINNAME_MAX);
 	if (len <= 0) return -EINVAL;
 
 	if (sscanf(buf, "%u.%u.%u.%u%c", &b1, &b2, &b3, &b4, &c) != 4)
@@ -184,7 +186,7 @@
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
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
