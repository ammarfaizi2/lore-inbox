Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbTIVFRn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 01:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262968AbTIVFRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 01:17:30 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:49679
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262958AbTIVFRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 01:17:16 -0400
Subject: Re: [ANNOUNCE]  slab information utility
From: Robert Love <rml@tech9.net>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Chris Rivera <cmrivera@ufl.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20030922044354.GA18855@DUK2.13thfloor.at>
References: <1064199786.1199.29.camel@boobies.awol.org>
	 <20030922042308.GA8691@DUK2.13thfloor.at>
	 <1064205590.8888.207.camel@localhost>
	 <20030922044354.GA18855@DUK2.13thfloor.at>
Content-Type: multipart/mixed; boundary="=-IrEueW9xgnmQt70SDQMG"
Message-Id: <1064207838.8888.241.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Mon, 22 Sep 2003 01:17:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IrEueW9xgnmQt70SDQMG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-09-22 at 00:43, Herbert Poetzl wrote:

> what about checking at which position the space occurs?
> 
> at least to me it seems like pos < 20 would be okay
> for a space in the name  8-)

Not too pretty with the sscanf we do.  Or even possible -- how do we
differentiate between n spaces and the next delimiter followed by a
legal field?

Anyhow, Chris and I concocted a little patch.  Its not sexy but it
works.  Apply it and recompile -- let me know.

	Robert Love



--=-IrEueW9xgnmQt70SDQMG
Content-Disposition: attachment; filename=slabtop-bogus-space-fix-rml-1.patch
Content-Type: text/x-patch; name=slabtop-bogus-space-fix-rml-1.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


 proc/slab.c |   20 ++++++++------------
 slabtop.c   |    5 +++++
 2 files changed, 13 insertions(+), 12 deletions(-)


diff -urN --exclude=CVS procps-cvs/proc/slab.c procps/proc/slab.c
--- procps-cvs/proc/slab.c	2003-09-21 23:01:59.816907168 -0400
+++ procps/proc/slab.c	2003-09-22 01:14:43.456249968 -0400
@@ -88,10 +88,8 @@
 			continue;
 	
 		curr = get_slabnode();
-		if (!curr) {
-			curr = NULL;
+		if (!curr)
 			break;
-		}
 
 		if (entries++ == 0)
 			*list = curr;
@@ -107,9 +105,9 @@
 				&curr->nr_slabs);
 
 		if (assigned < 8) {
-			fprintf(stderr, "unrecognizable data in slabinfo!\n");
-			curr = NULL;
-			break;
+			curr->obj_size = 0;
+			prev = curr;
+			continue;
 		}
 
 		if (curr->obj_size < stats->min_obj_size)
@@ -168,10 +166,8 @@
 		int assigned;
 
 		curr = get_slabnode();
-		if (!curr) {
-			curr = NULL;
+		if (!curr)
 			break;
-		}
 
 		if (entries++ == 0)
 			*list = curr;
@@ -186,9 +182,9 @@
 				&curr->pages_per_slab);
 
 		if (assigned < 6) {
-			fprintf(stderr, "unrecognizable data in slabinfo!\n");
-			curr = NULL;
-			break;
+			curr->obj_size = 0;
+			prev = curr;
+			continue;
 		}
 
 		if (curr->obj_size < stats->min_obj_size)
diff -urN --exclude=CVS procps-cvs/slabtop.c procps/slabtop.c
--- procps-cvs/slabtop.c	2003-09-21 23:01:59.822906256 -0400
+++ procps/slabtop.c	2003-09-22 01:12:58.069271224 -0400
@@ -330,6 +330,11 @@
 
 		curr = slab_list;
 		for (i = 0; i < rows - 8 && curr->next; i++) {
+			if (!curr->obj_size) {
+				curr = curr->next;
+				i--;
+				continue;
+			}
 			printw("%6d %6d %3d%% %7.2fK %6d %8d %9dK %-23s\n",
 				curr->nr_objs, curr->nr_active_objs, curr->use,
 				curr->obj_size / 1024.0, curr->nr_slabs,

--=-IrEueW9xgnmQt70SDQMG--

