Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWEGCZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWEGCZU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 22:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWEGCZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 22:25:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:32138 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751173AbWEGCZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 22:25:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=A5wsQTKJWVMbK9+Q1n5przsRnfKomWIixSqahFMTTQtQa9a2BBWYfQMKejpgyrzxBO+9+KhOosoVzicRbk5BPB0ZUu+EoicmGr6BTBPAQdT63o0et4hXWwaQ5vojPjkMUtqRQGQPM0VvPdLvarRz/bn7WipU9r0OJbppDX/kIWk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix mem-leak in netfilter
Date: Sun, 7 May 2006 04:26:10 +0200
User-Agent: KMail/1.9.1
Cc: Stephen Frost <sfrost@snowman.net>, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605070426.10405.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted that we may leak 'hold' in 
net/ipv4/netfilter/ipt_recent.c::checkentry() when the following
is true : 
  if (!curr_table->status_proc) {
    ...
    if(!curr_table) {
    ...
      return 0;  <-- here we leak.
Simply moving an existing vfree(hold); up a bit avoids the possible leak.


(please keep me on CC when replying since I'm not subscribed 
 to netfilter-devel)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 net/ipv4/netfilter/ipt_recent.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc3-git12-orig/net/ipv4/netfilter/ipt_recent.c	2006-05-07 03:25:38.000000000 +0200
+++ linux-2.6.17-rc3-git12/net/ipv4/netfilter/ipt_recent.c	2006-05-07 04:16:26.000000000 +0200
@@ -821,6 +821,7 @@ checkentry(const char *tablename,
 	/* Create our proc 'status' entry. */
 	curr_table->status_proc = create_proc_entry(curr_table->name, ip_list_perms, proc_net_ipt_recent);
 	if (!curr_table->status_proc) {
+		vfree(hold);
 		printk(KERN_INFO RECENT_NAME ": checkentry: unable to allocate for /proc entry.\n");
 		/* Destroy the created table */
 		spin_lock_bh(&recent_lock);
@@ -845,7 +846,6 @@ checkentry(const char *tablename,
 		spin_unlock_bh(&recent_lock);
 		vfree(curr_table->time_info);
 		vfree(curr_table->hash_table);
-		vfree(hold);
 		vfree(curr_table->table);
 		vfree(curr_table);
 		return 0;


