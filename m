Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWDFGLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWDFGLW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 02:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWDFGLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 02:11:22 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:46279 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751100AbWDFGLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 02:11:21 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuznet@ms2.inr.ac.ru,
       "David S. Miller" <davem@davemloft.net>
Subject: tcf_generic_walker(): what's going on?
Date: Thu, 6 Apr 2006 09:11:00 +0300
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604060911.01140.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While hunting down oversized inlines
I stumbled on tcf_generic_walker().

It is defined in two separate files:
once as an inline in include/net/pkt_act.h
(really big one, ~750 bytes of code)
and once as a static function in net/sched/act_police.c

These two instances are not identical.
Second one has one extra parameter (int type)
and it uses it like this:

        for (i = 0; i < MY_TAB_SIZE; i++) {
                p = tcf_police_ht[tcf_police_hash(i)];

                for (; p; p = p->next) {
                        index++;
                        if (index < s_i)
                                continue;
                        a->priv = p;
                        a->order = index;
                        r = (struct rtattr*) skb->tail;
                        RTA_PUT(skb, a->order, 0, NULL);
+                       if (type == RTM_DELACTION)
+                               err = tcf_action_dump_1(skb, a, 0, 1);
+                       else
+                               err = tcf_action_dump_1(skb, a, 0, 0);

Having two functions with same name is rather confusing.
Worse, they are both are called via five different
tc_action_ops structs: 

static struct tc_action_ops act_ipt_ops = {
...
        .walk           =       tcf_generic_walker

and I fail to understand how it is supposed to work,
considering the fact that these two tcf_generic_walker's
have different prototypes.

1) What should I do with tcf_generic_walker?
2) Should I deinline huge inlines in include/net/pkt_act.h?
   If yes, to which .c file should I move them?
--
vda
