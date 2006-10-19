Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946569AbWJSWNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946569AbWJSWNO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946570AbWJSWNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:13:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63399 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946569AbWJSWNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:13:13 -0400
Subject: Re: [PATCH 1/7] KVM: userspace interface
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Avi Kivity <avi@qumranet.com>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4537D298.6010105@us.ibm.com>
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com>
	 <4537C807.4@us.ibm.com> <4537CC24.2070708@qumranet.com>
	 <4537CD54.8020006@us.ibm.com> <4537D174.8090204@qumranet.com>
	 <4537D298.6010105@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 23:15:48 +0100
Message-Id: <1161296148.17335.150.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 14:31 -0500, ysgrifennodd Anthony Liguori:
> > My plan was to allow userspace to register certain mmio addresses for 
> > cacheing, so that if the guest code had a code sequence like

Thats actually not ideal having played with this for something else. The
best results I got with real world hardware was supporting registration
of sequences and address/mask pairs. You can also pre-load answers to
avoid trapping back out to user apps. Obviously emulating virtualized
hardware with proper guest OS drivers is far better still.

What I had in the end looked something like this

Groups of addresses in a table. Each table has state bits. Each access
can be conditional on a mask of statebits being 1/0. Each access can
also either trap or not

Within each access the rule was matched by address and width then by
masks

Firstly if the bits matching a transition mask changed to the transition
state bits then we trapped

	ie   if ((new_value & transition_mask) == transition_bits)

so you can avoid trapping out on stuff that doesn't "fire" an event - eg
the head select on IDE.

Then the I/O was merged with a mask of fixed bits (for read only bits
without trapping in emulation) which occur a lot, and stored in an array
slot number given by the rule (with overlaps for .b/.w allowed). Finally
the statebits were updated by the rule again using a mask and bits.

Similar rules applied to reads so that values that didn't need traps
could be handled directly. Repeating I/O had a special case (thats
"hack") rule type for saying eg "512 bytes" then trap.

A trap was also allowed to load back a prediction sequence. That allowed
the user space side to "guess" the usual behaviour of the driver stuff
being emulated so if it got a given event it could feed a sequence of
address/size/value back [never did make these conditional to be
cleverer]

This means you can do stuff like IDE by trapping mostly on the final
'kick' of a command, and if its a read the predict then 512 byte insw()
from the driver and the next 5 or 6 port read accesses for each I/O.

The state stuff is very compact as its basically

	while (rule) {
		if (bitcompare(table->state, rule->state)) {
			rule = rule->next;
			continue;
		}
		if (bitcompare(rule->transition, value) == 0)
			return TRAP;
		value &= rule->value[0];
		value |= rule->value[1];
		table->state &= rule->newstate[0];
		table->state |= rule->newstate[1];
		table->cache[rule->cache] = value;
		rule = rule->next;
	} 

and for read on a given table just a case of

	if (predictor == NULL || port != predictor->port || size !=
predictor->size)
		TRAP();
	else {
		value = table->cache[predictor->cache];
		predictor = predictor->next;
	}

Alan

