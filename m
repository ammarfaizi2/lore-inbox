Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbUJZPG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbUJZPG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 11:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbUJZPG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 11:06:56 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:12957 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262288AbUJZPGi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:06:38 -0400
Date: Tue, 26 Oct 2004 11:06:40 -0400
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       trond.myklebust@fys.uio.no, neilb@cse.unsw.edu.au, torvalds@osdl.org
Subject: Re: [PATCH] NFS mount hang fix
Message-ID: <20041026150640.GA24881@fieldses.org>
References: <20041026141148.GM6408@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026141148.GM6408@fi.muni.cz>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 04:11:48PM +0200, Jan Kasprzak wrote:
> I am sorry to repost this, but I have got no feedback from NFS maintainers,
> while I've got postitive feedback from three people whose problems
> was fixed by this patch. NFS maintaners - are you alive? If not,
> Linus, please apply this patch. Thanks,

Hm.  For some reason, your message never made it into my mailbox, though
I can see it in the marc.theaimsgroup.com archives of the nfs list.

Changing those buffers to static strikes me as potentially dangerous--we
currently call the ->parse() methods under a semaphore, so it's safe for
now, but that might change some day and then there'll be an ugly race
condition.

Could you check whether the following fixes your problem?--b.


Problem identified by Jan Kasprzak.

Limit on domainname size (currently 50) is too small.

Just use the beginning of input buffer as scratch space for it, and
save a little stack space while we're at it.

Signed-off-by: J. Bruce Fields
---

 linux-2.6.10-rc1-bfields/net/sunrpc/svcauth_unix.c      |   14 
 linux-2.6.10-rc1-bfields/net/sunrpc/svcauth_unix.c.orig |  511 ++++++++++++++++
 2 files changed, 518 insertions(+), 7 deletions(-)

diff -puN net/sunrpc/svcauth_unix.c~fqdn_length_fix net/sunrpc/svcauth_unix.c
--- linux-2.6.10-rc1/net/sunrpc/svcauth_unix.c~fqdn_length_fix	2004-10-22 23:36:50.000000000 -0400
+++ linux-2.6.10-rc1-bfields/net/sunrpc/svcauth_unix.c	2004-10-22 23:37:47.000000000 -0400
@@ -150,11 +150,14 @@ static void ip_map_request(struct cache_
 }
 
 static struct ip_map *ip_map_lookup(struct ip_map *, int);
+
 static int ip_map_parse(struct cache_detail *cd,
 			  char *mesg, int mlen)
 {
 	/* class ipaddress [domainname] */
-	char class[50], buf[50];
+	/* should be safe just to use the start of the input buffer
+	 * for scratch: */
+	char *buf = mesg;
 	int len;
 	int b1,b2,b3,b4;
 	char c;
@@ -167,13 +170,11 @@ static int ip_map_parse(struct cache_det
 	mesg[mlen-1] = 0;
 
 	/* class */
-	len = qword_get(&mesg, class, 50);
+	len = qword_get(&mesg, ipm.m_class, sizeof(ipm.m_class));
 	if (len <= 0) return -EINVAL;
-	if (len >= sizeof(ipm.m_class))
-		return -EINVAL;
 
 	/* ip address */
-	len = qword_get(&mesg, buf, 50);
+	len = qword_get(&mesg, buf, mlen);
 	if (len <= 0) return -EINVAL;
 
 	if (sscanf(buf, "%u.%u.%u.%u%c", &b1, &b2, &b3, &b4, &c) != 4)
@@ -184,7 +185,7 @@ static int ip_map_parse(struct cache_det
 		return -EINVAL;
 
 	/* domainname, or empty for NEGATIVE */
-	len = qword_get(&mesg, buf, 50);
+	len = qword_get(&mesg, buf, mlen);
 	if (len < 0) return -EINVAL;
 
 	if (len) {
@@ -194,7 +195,6 @@ static int ip_map_parse(struct cache_det
 	} else
 		dom = NULL;
 
-	strcpy(ipm.m_class, class);
 	ipm.m_addr.s_addr =
 		htonl((((((b1<<8)|b2)<<8)|b3)<<8)|b4);
 	ipm.h.flags = 0;
_
