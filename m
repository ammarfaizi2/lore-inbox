Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318148AbSHZVtg>; Mon, 26 Aug 2002 17:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318236AbSHZVtf>; Mon, 26 Aug 2002 17:49:35 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:31992 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318148AbSHZVtF>; Mon, 26 Aug 2002 17:49:05 -0400
Date: Mon, 26 Aug 2002 17:53:22 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] compile fix for fs/aio.c on non-highmem systems
Message-ID: <20020826175322.B6178@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Patrik Mochel noticed that fs/aio.c doesn't compile on a non-highmem config.  
The patch below (and in the bk tree on master.kernel.org:/home/bcrl/aio-2.5) 
fixes that by making the helper functions #defines, and should also be a 
bit faster.

		-ben

:r ~/patches/v2.5.31-aio-nohighmem.diff
diff -urN linux-2.5/fs/aio.c linux-2.5.aio/fs/aio.c
--- linux-2.5/fs/aio.c	Mon Aug 26 17:03:12 2002
+++ linux-2.5.aio/fs/aio.c	Mon Aug 26 17:42:54 2002
@@ -174,29 +174,24 @@
 /* aio_ring_event: returns a pointer to the event at the given index from
  * kmap_atomic(, km).  Release the pointer with put_aio_ring_event();
  */
-static inline struct io_event *aio_ring_event(struct aio_ring_info *info, int nr, enum km_type km)
-{
-	struct io_event *events;
 #define AIO_EVENTS_PER_PAGE	(PAGE_SIZE / sizeof(struct io_event))
 #define AIO_EVENTS_FIRST_PAGE	((PAGE_SIZE - sizeof(struct aio_ring)) / sizeof(struct io_event))
+#define AIO_EVENTS_OFFSET	(AIO_EVENTS_PER_PAGE - AIO_EVENTS_FIRST_PAGE)
 
-	if (nr < AIO_EVENTS_FIRST_PAGE) {
-		struct aio_ring *ring;
-		ring = kmap_atomic(info->ring_pages[0], km);
-		return &ring->io_events[nr];
-	}
-	nr -= AIO_EVENTS_FIRST_PAGE;
+#define aio_ring_event(info, nr, km) ({					\
+	unsigned pos = (nr) + AIO_EVENTS_OFFSET;			\
+	struct io_event *__event;					\
+	__event = kmap_atomic(						\
+			(info)->ring_pages[pos / AIO_EVENTS_PER_PAGE], km); \
+	__event += pos % AIO_EVENTS_PER_PAGE;				\
+	__event;							\
+})
 
-	events = kmap_atomic(info->ring_pages[1 + nr / AIO_EVENTS_PER_PAGE], km);
-
-	return events + (nr % AIO_EVENTS_PER_PAGE);
-}
-
-static inline void put_aio_ring_event(struct io_event *event, enum km_type km)
-{
-	void *p = (void *)((unsigned long)event & PAGE_MASK);
-	kunmap_atomic(p, km);
-}
+#define put_aio_ring_event(event, km) do {	\
+	struct io_event *__event = (event);	\
+	(void)__event;				\
+	kunmap_atomic((void *)((unsigned long)__event & PAGE_MASK), km); \
+} while(0)
 
 /* ioctx_alloc
  *	Allocates and initializes an ioctx.  Returns an ERR_PTR if it failed.
