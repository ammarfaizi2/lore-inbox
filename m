Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSJCRdQ>; Thu, 3 Oct 2002 13:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261623AbSJCRdQ>; Thu, 3 Oct 2002 13:33:16 -0400
Received: from isis.lip6.fr ([132.227.60.2]:20495 "EHLO isis.lip6.fr")
	by vger.kernel.org with ESMTP id <S261559AbSJCRdM>;
	Thu, 3 Oct 2002 13:33:12 -0400
X-pt: isis.lip6.fr
Date: Thu, 3 Oct 2002 19:38:43 +0200 (CEST)
From: Cedric Roux <Cedric.Roux@lip6.fr>
Reply-To: Cedric.Roux@lip6.fr
To: linux-kernel@vger.kernel.org
cc: Cedric Roux <cedric@asim.lip6.fr>
Subject: ipc - msg : a race bug ? (kernel 2.4.19)
In-Reply-To: <3D9C72A4.1090504@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0210031907220.3164-100000@bop.lip6.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it's me again.

Still analyzing the msg code. I must create questions for some
students, so I must understand how all this works.
In the process, I found a bug (I think it's a bug, I don't
know if the standard permits the behavior reported here).

Description :
=============

Process A creates a message queue QA, and sends a message to it, then
waits a bit, doing other things.

Process B does weird things, then deletes QA, then creates QB and sends
a message to QB.

Process A has finished his job and now decides to read queue QA, and 
receives the message from process B, so it reads QB, not QA. QA has been
replace by QB.

It should not happen, should it ? Process A should receive EIDRM, no ?

(The test has been done on a host where there initially was
no queue at all and no other process was creating/deleting queues.)

Problem :
=========

The generation of the id of the queue is the key problem.
You do seq++, and seq ranges from 0 to 65535. You
then creates the id : seq * 65536 + array_indice
where array_indice represents the array cell where was
created the queue.

If a process creates a lot of queues, seq will go back
to its first value.

Now, you delete the previous queue, and creates a new one,
which will get the same seq as the previous one, and be
created in the same array cell of msg_ids (this might not
be always true, noone should create or delete any other
queue at the same time and the first free cell in the array
should be the good one).

Code :
======

Below is the code that demonstrates it all.

To use it, compile naif, compile stole.
Run naif in one terminal, then run stole in another terminal, then come
back to the terminal where naif runs, and press enter.
If all is ok (I mean, if your kernel is buggy :-)),
naif should read 'N'. If your kernel is not buggy, naif should print :
----
msgrcv: Invalid argument
we have an error (expected behavior, all is ok)
----

naif.c
--------------------------------------
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <stdio.h>

struct tt {
  long type;
  char z;
};

int main(void)
{
  struct tt t;
  int f = msgget(0x1, IPC_CREAT|IPC_EXCL|0666);

  if (f == -1) {
    perror("msgget");
    return 1;
  }

  /* we send a message to the queue */
  t.type = 1;
  t.z = 'Y';
  fprintf(stdout, "we send to the queue a message with value %c\n", t.z);
  if (msgsnd(f, &t, 1, 0) == -1) {
    perror("msgsnd");
    msgctl(f, IPC_RMID, 0);
    return 1;
  }
  
  fprintf(stdout, "press enter after completion of stole\n");
  getchar();

  /* here, the queue has been deleted by stole, which has created a
   * new queue, we should receive a EIDRM, but...
   */

  if (msgrcv(f, &t, 1, 1, 0) == -1) {
    perror("msgrcv");
    fprintf(stdout, "we have an error (expected behavior, all is ok)\n");
    return 1;
  }

  fprintf(stdout, "we could read the queue, this is a bug\n");
  fprintf(stdout, "we receive value %c\n", t.z);   /* this will be N */

  msgctl(f, IPC_RMID, 0);

  return 0;
}
-----------------------------

stole.c
----------------------------
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <stdio.h>

struct pipo {
  long type;
  char x;
};

int main(void)
{
  int f;
  int i;
  struct pipo t;

  /* let's use all the seq possible values */
  for (i=0; i<65535; i++) {
    f = msgget(0x2, IPC_CREAT|IPC_EXCL|0666);
    if (f == -1) {
      perror("msgget");
      return 1;
    }
    if (msgctl(f, IPC_RMID, 0) == -1) {
      perror("msgctl");
      return 1;
    }
  }

  fprintf(stdout, "we did the loop, now let's delete the other queue\n");
  f = msgget(0x1, 0);
  if (f == -1) {
    perror("msgget");
    return 1;
  }
  if (msgctl(f, IPC_RMID, 0) == -1) {
    perror("msgget");
    return 1;
  }

  fprintf(stdout, "create a new queue, this is really a *new* queue :-)\n");
  f = msgget(0x1, IPC_CREAT|IPC_EXCL|0666);
  if (f==-1) {
    perror("msgget");
    return 1;
  }

  /* let's send a message into it */
  t.type = 1;
  t.x = 'N';
  fprintf(stdout, "we send a message to the queue with value %c\n", t.x);
  if (msgsnd(f, &t, 1, 0) == -1) {
    perror("msgsnd");
    return 1;
  }

  return 0;
}
---------------------------

Cédric.

PS: I'm not on the kernel mailing list. CC is welcome in your replies.
(I know it is bad practice.)

