Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269630AbRHCVw4>; Fri, 3 Aug 2001 17:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269631AbRHCVwr>; Fri, 3 Aug 2001 17:52:47 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:2731 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S269630AbRHCVwj>; Fri, 3 Aug 2001 17:52:39 -0400
From: "Stefan Burkei" <stefan@burkei.de>
To: "'@Linux Kernel Miller, David S.'" <davem@redhat.com>,
        "'@Linux Kernel Ostrowski, Michal'" <mostrows@us.ibm.com>
Cc: "'@Linux Kernel Mailingliste'" <linux-kernel@vger.kernel.org>
Subject: oops in skbuff.c
Date: Fri, 3 Aug 2001 23:40:44 +0200
Message-ID: <000001c11c64$f3bc5d40$3100000a@sb>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2377.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using Kernel 2.4.7 (i think with the actual
pppoe-patches 0.6.8) and it still oopses on the
same place - in the routine skb_drop_fraglist.

My Linux-Box acts as a NAT-Router to the Internet
for my Win98-Clients with a german DSL-Connection
using pppoe with pppd 2.4.1.
With pppd 2.4.0 the result is the same.

The problem appears with Kernel 2.4.4 and
is always reproducable since then.
I start on my Win98-Box the Gnutella-Client
BearShare and don't have to wait longer
than 10 sec. until the machine crashes.

I figured out, that the kernel attempts to free
a fraglist in the routine skb_drop_fraglist with
an invalid pointer to it.
During one pppd-session this "pointer" has
always the same (i think) false value. The
high word is always zero and the low word doesn't
change during one online session of pppd.
The low word will have a new value on the next
dialup of pppd. Again - this value stays in place
until the pppd hangs up.

I use a short code fragment to check this invalid
pointer and, if detected, jumps over the kfree-routine.
This isn't a really patch, because the real error wasn't
corrected - but the kernel remains stable since then.

This here is my skb_drop_fraglist-routine:

static void skb_drop_fraglist(struct sk_buff *skb)
{
        struct sk_buff *list = skb_shinfo(skb)->frag_list;

        skb_shinfo(skb)->frag_list = NULL;

        if ((unsigned long)list & 0xffff0000) {
            do {
                    struct sk_buff *this = list;
                    list = list->next;
                    kfree_skb(this);
            } while (list);
        } else
            printk(KERN_WARNING "Warning: skb_drop_fraglist() \
	    invalid pointer detected: %08lx.\n", (unsigned long)list);
}


I hope I can give you two a hint on your bug-hunting.

ciao - stebu

