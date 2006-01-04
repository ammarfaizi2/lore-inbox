Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWACXqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWACXqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWACXqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:46:20 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:41621 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965093AbWACXpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:45:54 -0500
Message-Id: <200601040037.k040bbBX012545@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/12] UML - Remove unneeded structure field
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jan 2006 19:37:37 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes a structure field which turned out to be pointless, and references
to it.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/chan_kern.c	2006-01-03 17:20:06.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/chan_kern.c	2006-01-03 17:26:38.000000000 -0500
@@ -315,7 +315,7 @@ int console_open_chan(struct line *line,
 		return 0;
 
 	if (0 != parse_chan_pair(line->init_str, &line->chan_list,
-				 line->init_pri, co->index, opts))
+				 co->index, opts))
 		return -1;
 	if (0 != open_chan(&line->chan_list))
 		return -1;
@@ -468,8 +468,7 @@ struct chan_type chan_table[] = {
 #endif
 };
 
-static struct chan *parse_chan(char *str, int pri, int device,
-			       struct chan_opts *opts)
+static struct chan *parse_chan(char *str, int device, struct chan_opts *opts)
 {
 	struct chan_type *entry;
 	struct chan_ops *ops;
@@ -507,13 +506,12 @@ static struct chan *parse_chan(char *str
 				 .output 	= 0,
 				 .opened  	= 0,
 				 .fd 		= -1,
-				 .pri 		= pri,
 				 .ops 		= ops,
 				 .data 		= data });
 	return chan;
 }
 
-int parse_chan_pair(char *str, struct list_head *chans, int pri, int device,
+int parse_chan_pair(char *str, struct list_head *chans, int device,
 		    struct chan_opts *opts)
 {
 	struct chan *new, *chan;
@@ -521,8 +519,6 @@ int parse_chan_pair(char *str, struct li
 
 	if(!list_empty(chans)){
 		chan = list_entry(chans->next, struct chan, list);
-		if(chan->pri >= pri)
-			return 0;
 		free_chan(chans);
 		INIT_LIST_HEAD(chans);
 	}
@@ -532,14 +528,14 @@ int parse_chan_pair(char *str, struct li
 		in = str;
 		*out = '\0';
 		out++;
-		new = parse_chan(in, pri, device, opts);
+		new = parse_chan(in, device, opts);
 		if(new == NULL)
 			return -1;
 
 		new->input = 1;
 		list_add(&new->list, chans);
 
-		new = parse_chan(out, pri, device, opts);
+		new = parse_chan(out, device, opts);
 		if(new == NULL)
 			return -1;
 
@@ -547,7 +543,7 @@ int parse_chan_pair(char *str, struct li
 		new->output = 1;
 	}
 	else {
-		new = parse_chan(str, pri, device, opts);
+		new = parse_chan(str, device, opts);
 		if(new == NULL)
 			return -1;
 
Index: linux-2.6.15/arch/um/include/chan_kern.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/chan_kern.h	2006-01-03 17:20:06.000000000 -0500
+++ linux-2.6.15/arch/um/include/chan_kern.h	2006-01-03 17:26:38.000000000 -0500
@@ -20,15 +20,14 @@ struct chan {
 	unsigned int output:1;
 	unsigned int opened:1;
 	int fd;
-	enum chan_init_pri pri;
 	struct chan_ops *ops;
 	void *data;
 };
 
 extern void chan_interrupt(struct list_head *chans, struct work_struct *task,
 			   struct tty_struct *tty, int irq);
-extern int parse_chan_pair(char *str, struct list_head *chans, int pri, 
-			   int device, struct chan_opts *opts);
+extern int parse_chan_pair(char *str, struct list_head *chans, int device,
+			   struct chan_opts *opts);
 extern int open_chan(struct list_head *chans);
 extern int write_chan(struct list_head *chans, const char *buf, int len,
 			     int write_irq);
Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2006-01-03 17:21:49.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2006-01-03 17:26:38.000000000 -0500
@@ -438,7 +438,7 @@ int line_open(struct line *lines, struct
 		}
 		if (list_empty(&line->chan_list)) {
 			err = parse_chan_pair(line->init_str, &line->chan_list,
-					      line->init_pri, tty->index, opts);
+					      tty->index, opts);
 			if(err) goto out;
 			err = open_chan(&line->chan_list);
 			if(err) goto out;

