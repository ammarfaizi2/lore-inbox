Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbUASVVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbUASVVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:21:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14733 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263388AbUASVVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:21:07 -0500
Message-ID: <400C4A42.5070701@RedHat.com>
Date: Mon, 19 Jan 2004 16:21:06 -0500
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux NFS Mailing List <nfs@lists.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NFS/RPC modprobe -r sunrpc causes an oops
Content-Type: multipart/mixed;
 boundary="------------050407010200030304020701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050407010200030304020701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Here is a patch for the 2.6.1 kernel that fixes an oops
that occurs when the sunrpc module is unloaded.

The problem was the RPC cache_register() call was
not saving entry pointers to the procfs entries it was
creating. So when it came time to dismantle the
entires, a BUG_ON() was tripped in remove_proc_entry()
since the tree was not broken down completely.

Hopefully this will be a candidate for the next release.....

SteveD.

--------------050407010200030304020701
Content-Type: text/plain;
 name="linux-2.6.1-nfs-cachcleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.1-nfs-cachcleanup.patch"

--- linux-2.6.1/include/linux/sunrpc/cache.h.org	2004-01-09 01:59:42.000000000 -0500
+++ linux-2.6.1/include/linux/sunrpc/cache.h	2004-01-19 14:08:44.000000000 -0500
@@ -94,6 +94,8 @@ struct cache_detail {
 	/* fields for communication over channel */
 	struct list_head	queue;
 	struct proc_dir_entry	*proc_ent;
+	struct proc_dir_entry   *flush_ent, *channel_ent, *content_ent; 
+
 	atomic_t		readers;		/* how many time is /chennel open */
 	time_t			last_close;		/* it no readers, when did last close */
 };
--- linux-2.6.1/net/sunrpc/cache.c.org	2004-01-09 01:59:44.000000000 -0500
+++ linux-2.6.1/net/sunrpc/cache.c	2004-01-19 14:25:34.000000000 -0500
@@ -175,9 +175,11 @@ void cache_register(struct cache_detail 
 	if (cd->proc_ent) {
 		struct proc_dir_entry *p;
 		cd->proc_ent->owner = THIS_MODULE;
+		cd->channel_ent = cd->content_ent = NULL;
 		
  		p = create_proc_entry("flush", S_IFREG|S_IRUSR|S_IWUSR,
  				      cd->proc_ent);
+		cd->flush_ent =  p;
  		if (p) {
  			p->proc_fops = &cache_flush_operations;
  			p->owner = THIS_MODULE;
@@ -187,6 +189,7 @@ void cache_register(struct cache_detail 
 		if (cd->cache_request || cd->cache_parse) {
 			p = create_proc_entry("channel", S_IFREG|S_IRUSR|S_IWUSR,
 					      cd->proc_ent);
+			cd->channel_ent = p; 
 			if (p) {
 				p->proc_fops = &cache_file_operations;
 				p->owner = THIS_MODULE;
@@ -196,6 +199,7 @@ void cache_register(struct cache_detail 
  		if (cd->cache_show) {
  			p = create_proc_entry("content", S_IFREG|S_IRUSR|S_IWUSR,
  					      cd->proc_ent);
+			cd->content_ent = p; 
  			if (p) {
  				p->proc_fops = &content_file_operations;
  				p->owner = THIS_MODULE;
@@ -233,6 +237,13 @@ int cache_unregister(struct cache_detail
 	write_unlock(&cd->hash_lock);
 	spin_unlock(&cache_list_lock);
 	if (cd->proc_ent) {
+		if (cd->flush_ent) 
+			remove_proc_entry("flush", cd->proc_ent);
+		if (cd->channel_ent)
+			remove_proc_entry("channel", cd->proc_ent);
+		if (cd->content_ent)
+			remove_proc_entry("content", cd->proc_ent);
+
 		cd->proc_ent = NULL;
 		remove_proc_entry(cd->name, proc_net_rpc);
 	}

--------------050407010200030304020701--

