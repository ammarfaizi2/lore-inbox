Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262448AbSKRO1d>; Mon, 18 Nov 2002 09:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbSKRO1c>; Mon, 18 Nov 2002 09:27:32 -0500
Received: from mx3.mail.ru ([194.67.57.13]:18447 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id <S261613AbSKRO12>;
	Mon, 18 Nov 2002 09:27:28 -0500
From: "Samium Gromoff" <_deepfire@mail.ru>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.4, 2.5, USB] locking issue
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 194.226.0.89 via proxy [194.226.0.63]
Date: Mon, 18 Nov 2002 17:34:20 +0300
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E18Dmyi-000FRS-00@f16.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        The possible problem is encountered in ehci-q.c and ehci-sched.c
  in 2.4.19-pre9 and in one occurence in ehci-q.c of 2.5.47.

        the offending pattern is the same in both files:

        if (!list_empty (qtd_list)) {
 -----------------------8<----------------------------------------------
                list_splice (qtd_list, &qh->qtd_list);
                qh_update (qh, list_entry (qtd_list->next, struct ehci_qtd, qtd\_list));
 -----------------------8<----------------------------------------------
        } else {
                qh->hw_qtd_next = qh->hw_alt_next = EHCI_LIST_END;
        }


        since list_splice() the qtd_list is diposed of its belongings and
        immediately in the next line we rely on qtd_list->next to point
        at an existing list_head.

        i haven`t noticed any locking out there, and i`m afraid of what
        could result from a preemption happening between these two lines.


regards, Samium Gromoff
_______________________________
____________________________________

