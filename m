Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263317AbSJCOqJ>; Thu, 3 Oct 2002 10:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263319AbSJCOqJ>; Thu, 3 Oct 2002 10:46:09 -0400
Received: from isis.lip6.fr ([132.227.60.2]:53773 "EHLO isis.lip6.fr")
	by vger.kernel.org with ESMTP id <S263317AbSJCOqG>;
	Thu, 3 Oct 2002 10:46:06 -0400
X-pt: isis.lip6.fr
Date: Thu, 3 Oct 2002 16:51:36 +0200 (CEST)
From: Cedric Roux <Cedric.Roux@lip6.fr>
Reply-To: Cedric.Roux@lip6.fr
To: linux-kernel@vger.kernel.org
Subject: ipc - msg : memory usage too big ?
Message-ID: <Pine.LNX.4.44.0210031637090.18081-100000@ouessant.lip6.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel hackers,

While looking into msg.c, I noticed that in
sys_msgsnd, there is the test :

        if(msgsz + msq->q_cbytes > msq->q_qbytes ||
                1 + msq->q_qnum > msq->q_qbytes) {

so that you can send a message only if ressources won't
be exhausted.

The second case means I can send at most MSGMNB messages
to a queue, which is by default 16384.

Now suppose we send messages of length 0 (only type is used).

Knowing that load_msg calls :

        msg = (struct msg_msg *) kmalloc (sizeof(*msg) + alen, GFP_KERNEL);

it will result in allocating 36 bytes of memory (suppose we
are on a ia32) per message.

We have 16 queues by default, so if we use the 16 queues this way,
we have :
16 * 36 * 16384 = 9437184, more than 9 MB used.

I hope I am right :-)

Don't you think it is far beyond the 256 KB someone is
expected to be used at maximum for the msg stuff ?

If it is seen as a problem, a solution might be to add
the memory overhead usage into the queue size, or add a
variable that counts the real memory used, and limits it
to a reasonable amount.

Cédric.

PS: I am not on the kernel mailing list, so CC is welcome. (I know it is 
bad practice.)
-- 
main(){int i,j;{printf("\n      Who did you say ? Sierpinski ?      \n");}
for(i=0;i<80;i++){for(j=0;j<80;j++)printf("%c",i&j?'.':' ');printf("\n");}
printf("\n   Life is a beach - George Sand (1804-1876)  \n\n"); return 0;}

