Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbVIURux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVIURux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVIURs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:48:56 -0400
Received: from [151.97.230.9] ([151.97.230.9]:16579 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751341AbVIURsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:48:54 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 09/10] Uml: use GFP_ATOMIC for allocations under spinlocks.
Date: Wed, 21 Sep 2005 19:29:28 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921172928.10219.63412.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

setup_initial_poll is only called with sigio_lock() held, so use appropriate
allocation.

Also, parse_chan() can also be called when holding a spinlock (see line_open()
 -> parse_chan_pair()).

I have sporadical problems (spinlock taken twice, with spinlock debugging on
UP) which could be caused by a sequence like "take spinlock, alloc and go to
sleep, take again the spinlock in the other thread".

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/chan_kern.c |    2 +-
 arch/um/kernel/sigio_user.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -465,7 +465,7 @@ static struct chan *parse_chan(char *str
 	data = (*ops->init)(str, device, opts);
 	if(data == NULL) return(NULL);
 
-	chan = kmalloc(sizeof(*chan), GFP_KERNEL);
+	chan = kmalloc(sizeof(*chan), GFP_ATOMIC);
 	if(chan == NULL) return(NULL);
 	*chan = ((struct chan) { .list	 	= LIST_HEAD_INIT(chan->list),
 				 .primary	= 1,
diff --git a/arch/um/kernel/sigio_user.c b/arch/um/kernel/sigio_user.c
--- a/arch/um/kernel/sigio_user.c
+++ b/arch/um/kernel/sigio_user.c
@@ -340,7 +340,7 @@ static int setup_initial_poll(int fd)
 {
 	struct pollfd *p;
 
-	p = um_kmalloc(sizeof(struct pollfd));
+	p = um_kmalloc_atomic(sizeof(struct pollfd));
 	if(p == NULL){
 		printk("setup_initial_poll : failed to allocate poll\n");
 		return(-1);

