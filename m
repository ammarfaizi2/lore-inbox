Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315671AbSEIJvt>; Thu, 9 May 2002 05:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315672AbSEIJvs>; Thu, 9 May 2002 05:51:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:62188 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315671AbSEIJvr>; Thu, 9 May 2002 05:51:47 -0400
Date: Thu, 9 May 2002 11:46:48 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.14-dj2
In-Reply-To: <20020508225147.GA11390@suse.de>
Message-ID: <Pine.NEB.4.44.0205091140100.19321-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

I got the following compile error:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.14-full/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=irlmp  -c -o
irlmp.o irlmp.c
irlmp.c:1302: redefinition of `irlmp_flow_indication'
irlmp.c:1236: `irlmp_flow_indication' previously defined here
{standard input}: Assembler messages:
{standard input}:2987: Error: symbol `irlmp_flow_indication' is already
defined
make[3]: *** [irlmp.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.14-full/net/irda'

<--  snip  -->

It seems that the changes to irlmp.c were merged by Linus but not removed
from the -dj patch. Unfortunately the context of this patch allows to
apply it several times...


The following patch needs to be removed from -dj:


--- linux-2.5.14/net/irda/irlmp.c	Mon May  6 04:38:05 2002
+++ linux-2.5/net/irda/irlmp.c	Fri May  3 12:57:32 2002
@@ -1289,6 +1289,72 @@
 }

 /*
+ * Receive flow control indication from LAP.
+ * LAP want us to send it one more frame. We implement a simple round
+ * robin scheduler between the active sockets so that we get a bit of
+ * fairness. Note that the round robin is far from perfect, but it's
+ * better than nothing.
+ * We then poll the selected socket so that we can do synchronous
+ * refilling of IrLAP (which allow to minimise the number of buffers).
+ * Jean II
+ */
+void irlmp_flow_indication(struct lap_cb *self, LOCAL_FLOW flow)
+{
+	struct lsap_cb *next;
+	struct lsap_cb *curr;
+	int	lsap_todo;
+
+	ASSERT(self->magic == LMP_LAP_MAGIC, return;);
+	ASSERT(flow == FLOW_START, return;);
+
+	/* Get the number of lsap. That's the only safe way to know
+	 * that we have looped around... - Jean II */
+	lsap_todo = HASHBIN_GET_SIZE(self->lsaps);
+	IRDA_DEBUG(4, __FUNCTION__ "() : %d lsaps to scan\n", lsap_todo);
+
+	/* Poll lsap in order until the queue is full or until we
+	 * tried them all.
+	 * Most often, the current LSAP will have something to send,
+	 * so we will go through this loop only once. - Jean II */
+	while((lsap_todo--) &&
+	      (IRLAP_GET_TX_QUEUE_LEN(self->irlap) < LAP_HIGH_THRESHOLD)) {
+		/* Try to find the next lsap we should poll. */
+		next = self->flow_next;
+		if(next != NULL) {
+			/* Note that if there is only one LSAP on the LAP
+			 * (most common case), self->flow_next is always NULL,
+			 * so we always avoid this loop. - Jean II */
+			IRDA_DEBUG(4, __FUNCTION__ "() : searching my LSAP\n");
+
+			/* We look again in hashbins, because the lsap
+			 * might have gone away... - Jean II */
+			curr = (struct lsap_cb *) hashbin_get_first(self->lsaps);
+			while((curr != NULL ) && (curr != next))
+				curr = (struct lsap_cb *) hashbin_get_next(self->lsaps);
+		} else
+			curr = NULL;
+
+		/* If we have no lsap, restart from first one */
+		if(curr == NULL)
+			curr = (struct lsap_cb *) hashbin_get_first(self->lsaps);
+		/* Uh-oh... Paranoia */
+		if(curr == NULL)
+			break;
+
+		/* Next time, we will get the next one (or the first one) */
+		self->flow_next = (struct lsap_cb *) hashbin_get_next(self->lsaps);
+		IRDA_DEBUG(4, __FUNCTION__ "() : curr is %p, next was %p and is now %p, still %d to go - queue len = %d\n", curr, next, self->flow_next, lsap_todo, IRLAP_GET_TX_QUEUE_LEN(self->irlap));
+
+		/* Inform lsap user that it can send one more packet. */
+		if (curr->notify.flow_indication != NULL)
+			curr->notify.flow_indication(curr->notify.instance,
+						     curr, flow);
+		else
+			IRDA_DEBUG(1, __FUNCTION__ "(), no handler\n");
+	}
+}
+
+/*
  * Function irlmp_hint_to_service (hint)
  *
  *    Returns a list of all servics contained in the given hint bits. This

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

