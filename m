Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265371AbUAZBVK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 20:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbUAZBVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 20:21:10 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:38847 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265371AbUAZBVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 20:21:06 -0500
Date: Mon, 26 Jan 2004 02:37:15 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: [PATCH] oprofile per-cpu buffer overrun
Message-ID: <20040126023715.GA3166@zaniah>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

In a ring buffer controlled by a read and write positions we
can't use buffer_size but only buffer_size - 1 entry, the last
free entry act as a guard to avoid write pos overrun. This bug
was hidden because the writer, oprofile_add_sample(), request
one more entry than really needed.

regards,
Phil

Index: drivers/oprofile/cpu_buffer.c
===================================================================
RCS file: /usr/local/cvsroot/linux-2.5/drivers/oprofile/cpu_buffer.c,v
retrieving revision 1.9
diff -u -p -r1.9 cpu_buffer.c
--- drivers/oprofile/cpu_buffer.c	26 May 2003 04:42:54 -0000	1.9
+++ drivers/oprofile/cpu_buffer.c	24 Jan 2004 21:07:03 -0000
@@ -86,9 +86,9 @@ static unsigned long nr_available_slots(
 	unsigned long tail = b->tail_pos;
 
 	if (tail > head)
-		return tail - head;
+		return (tail - head) - 1;
 
-	return tail + (b->buffer_size - head);
+	return tail + (b->buffer_size - head) - 1;
 }
 
 
