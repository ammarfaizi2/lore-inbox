Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbSIZAMQ>; Wed, 25 Sep 2002 20:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbSIZAMQ>; Wed, 25 Sep 2002 20:12:16 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:57848 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S261289AbSIZAMP>; Wed, 25 Sep 2002 20:12:15 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15762.20827.271317.595537@wombat.chubb.wattle.id.au>
Date: Thu, 26 Sep 2002 10:14:19 +1000
To: Lightweight Patch Manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tomas Szepe <szepe@pinerecords.com>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH][2.5] Single linked lists for Linux
In-Reply-To: <83015759@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+
+/**
+ * slist_del -	remove an entry from list
+ * @head:	head to remove it from
+ * @entry:	entry to be removed
+ */
+#define slist_del(_head, _entry)		\
+do {						\
+	(_head)->next = (_entry)->next;		\
+	(_entry)->next = NULL;			\
+}
+

This only works if head->next == entry otherwise you lose half your
list.  Also, none of this is SMP-safe.

I think you need something like this (but with locking!)

/*
 * remove entry from list starting at head
 * Return 0 if successful, non-zero otherwise.
 */
static inline int slist_del(struct slist *head, struct slist *entry)
{
	struct slist **p;
	for (p = &head->next; *p; p = &(*p)->next)
	    if (*p == entry) {
	       *p = entry->next;
	       entry->next = NULL;
	       return 0;
        }
        return -1;
}

Peter C
