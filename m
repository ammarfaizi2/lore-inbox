Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbUCERkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 12:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbUCERkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 12:40:55 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:2192 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262662AbUCERkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 12:40:52 -0500
Date: Fri, 5 Mar 2004 14:40:49 -0300
From: Flavio Bruno Leitner <fbl@conectiva.com.br>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at kernel/timer.c:370!
Message-ID: <20040305174049.GA1759@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1i
X-Bogosity: No, tests=bogofilter, spamicity=0.495734, version=0.16.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

My laptop is an Acer TravelMate 630 and somewhere between 2.6.2 and 2.6.3-rc2 
begins returning an oops right after boot.

kernel BUG at kernel/timer.c:370!
invalid operand: 0000 [#1]
CPU:	0
EIP:	0060:[<c0127177>]	Not tainted
EFLAGS: 00010006
EIP is at cascade+0x44/0x4e
eax: c03e4368	ebx: c03e02b0	ecx: fffce200	edx: c03e03b0
esi: c03e0398	edi: c03dfa80	ebp: c0387f08	esp: c0387ef4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0386000 task=c0306520)
Stack: c03dfa80 cde229c4 00000000 c03df7a8 c0387f20 c0387f38 c0127732 c03dfa80
       c03e0288 00000022 c0387f34 c0387f20 c0387f20 c0308d64 00000001 c03df7a8
       0000000a c0387f54 c0123b7c c03df7a8 00000046 00000000 c037da00 c0308d64
Call Trace:
  [<c0127732>] run_timer_softirq+0xec/0x16b
  [<c0123b7c>] do_softirq+0x98/0x9a
  [<c010d2ff>] do_IRQ+0xe4/0x11c
  [<c010b974>] common_interrupt+0x18/0x20
  [<d08c8257>] acpi_processor_idle+0xe9/0x1e5 [processor]
  [<c0105000>] _stext+0x0/0x2a
  [<c01090b7>] cpu_idle+0x2f/0x38
  [<c038c70a>] start_kernel+0x185/0x1c9
  [<c038c44a>] unknow_bootoption+0x0/0x108

Code: 0f 0b 72 01 3b 05 2d c0 eb d4 55 89 e5 56 53 83 ec 04 0f bf


Here is the function:
static int cascade(tvec_base_t *base, tvec_t *tv, int index)
{
        /* cascade all the timers from tv up one level */
        struct list_head *head, *curr;

        head = tv->vec + index;
        curr = head->next;
        /*
         * We are removing _all_ timers from the list, so we don't  have to
         * detach them individually, just clear the list afterwards.
         */
        while (curr != head) {
                struct timer_list *tmp;

                tmp = list_entry(curr, struct timer_list, entry);
                BUG_ON(tmp->base != base);
                curr = curr->next;
                internal_add_timer(base, tmp);
        }
        INIT_LIST_HEAD(head);

        return index;
}


Any ideas about this one?
Thanks!


-- 
Flávio Bruno Leitner <fbl@conectiva.com.br>
[ E74B 0BD0 5E05 C385 239E  531C BC17 D670 7FF0 A9E0 ]
