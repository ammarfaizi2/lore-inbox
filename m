Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318345AbSHEI4B>; Mon, 5 Aug 2002 04:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318346AbSHEIzz>; Mon, 5 Aug 2002 04:55:55 -0400
Received: from mail3.commerzbank.com ([212.149.48.102]:3202 "EHLO
	mail3.commerzbank.com") by vger.kernel.org with ESMTP
	id <S318345AbSHEIzY>; Mon, 5 Aug 2002 04:55:24 -0400
Message-ID: <A1081E14241CD4119D2B00508BCF80410843F27D@SV021558>
From: "Zeuner, Axel" <Axel.Zeuner@partner.commerzbank.com>
To: linux-kernel@vger.kernel.org
Subject: Thread group exit
Date: Mon, 5 Aug 2002 10:58:48 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C23C5E.4FCDB970"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C23C5E.4FCDB970
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,
I played a litte bit with thread groups and found an unexpected?? behaviour 
if the parent of a member of a thread group having childs dies. 
The child threads are configured to sent a different signal than SIGCHLD to 
their parent thread - a rt sig. The following configuration is checked:
init
\_ bash 
   \_ parent_process
      \_ thread_group_leader (created by fork, exit signal 17, tgid==pid)
         \_ thread_1 (created by clone(..., flags | CLONE_THREAD| sig33) by
the
         |            group_leader_thread)
         \_ thread_2 (create by clone(..., flags |CLONE_THREAD| sig33) 
                      by thread_1)

Thread_1 or thread_2 or both exits in this situation - a sig 33 is delivered

to the thread_group_leader for every thread as expected. 
Suppose the configuration above and the parent process exits. The thread
group 
leader thread was converted to a child of init:

init
\_ thread_group_leader (created by fork, exit signal 17, tgid==pid)
   \_ thread_1 (created by clone(..., flags | CLONE_THREAD| sig33) by the
   |            group_leader_thread)
   \_ thread_2 (create by clone(..., flags |CLONE_THREAD|CLONE_PARENT|sig33)

                by thread_1)

The function forget_original_parent in kernel/exit.c incremented the exec_id

of the thread_group_leader during the exit of the parent process. 
A SIGCHLD signal is sent now to the thread_group_leader if one of its 
child threads exits because of the queries in the function exit_notify in
the file kernel/exit.c:
 if (current->exit_signal != SIGCHLD &&
      (current->parent_exec_id != t->self_exec_id ||
       current->self_exec_id != current->parent_exec_id))
     && !capable (CAP_KILL))
      current->exit_signal = SIGCHLD;

I would expect, that changes of the parent of one member of the thread group

do not affect the interactions between the members of the group. 
Corrections are welcome.
(Please cc mails to me, I read only the archives of the 
linux-kernel list.)

The patch below keeps the child threads in the same exec_id if they are
childs
of the thread with the changing parent (against 2.4.18-ngpt, but should
apply
also against 2.4.19). For 2.5 series p_opptr has to be renamed real_parent.

Axel

Dr. Axel Zeuner
Consultant e.business D
email: axel.zeuner@systor.com.

--- kernel/exit.c.original	Mon Aug  5 09:09:31 2002
+++ kernel/exit.c	Mon Aug  5 09:53:22 2002
@@ -174,8 +174,22 @@
 
 	for_each_task(p) {
 		if (p->p_opptr == father) {
+			struct task_struct *tg_member;
 			/* We dont want people slaying init */
 			p->exit_signal = SIGCHLD;
+			/* Keep all members of the thread group with
+			   p as real parent in the same exec id.
+			   This prevents the generation of SIGCHLD
+			   instead of the configured signal on exit
+			   of slave threads of p
+			*/
+			for ( tg_member = next_thread(p); tg_member!=p;
+			      tg_member = next_thread(tg_member)) {
+				if ( tg_member->p_opptr == p ) {
+					++tg_member->self_exec_id;
+					++tg_member->parent_exec_id;
+				}
+			}
 			p->self_exec_id++;
 
 			/* Make sure we're not reparenting to ourselves */



------_=_NextPart_000_01C23C5E.4FCDB970
Content-Type: application/octet-stream;
	name="exit.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="exit.diff"

--- kernel/exit.c.original	Mon Aug  5 09:09:31 2002=0A=
+++ kernel/exit.c	Mon Aug  5 09:53:22 2002=0A=
@@ -174,8 +174,22 @@=0A=
 =0A=
 	for_each_task(p) {=0A=
 		if (p->p_opptr =3D=3D father) {=0A=
+			struct task_struct *tg_member;=0A=
 			/* We dont want people slaying init */=0A=
 			p->exit_signal =3D SIGCHLD;=0A=
+			/* Keep all members of the thread group with=0A=
+			   p as real parent in the same exec id.=0A=
+			   This prevents the generation of SIGCHLD=0A=
+			   instead of the configured signal on exit=0A=
+			   of slave threads of p=0A=
+			*/=0A=
+			for ( tg_member =3D next_thread(p); tg_member!=3Dp;=0A=
+			      tg_member =3D next_thread(tg_member)) {=0A=
+				if ( tg_member->p_opptr =3D=3D p ) {=0A=
+					++tg_member->self_exec_id;=0A=
+					++tg_member->parent_exec_id;=0A=
+				}=0A=
+			}=0A=
 			p->self_exec_id++;=0A=
 =0A=
 			/* Make sure we're not reparenting to ourselves */=0A=

------_=_NextPart_000_01C23C5E.4FCDB970--
