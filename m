Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVCNBl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVCNBl6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 20:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVCNBl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 20:41:58 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:40359 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261611AbVCNBl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 20:41:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16948.60419.257853.470644@wombat.chubb.wattle.id.au>
Date: Mon, 14 Mar 2005 12:42:27 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
In-Reply-To: <9e47339105031317193c28cbcf@mail.gmail.com>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	<9e473391050312075548fb0f29@mail.gmail.com>
	<16948.56475.116221.135256@wombat.chubb.wattle.id.au>
	<9e47339105031317193c28cbcf@mail.gmail.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:

>>  The scenario I'm thinking about with these patches are things like
>> low-latency user-level networking between nodes in a cluster, where
>> for good performance even with a kernel driver you don't want to
>> share your interrupt line with anything else.

Jon> The code needs to refuse to install if the IRQ line is shared.

It does.  The request_irq() call explicitly does not include SA_SHARED
in its flags, so if the line is shared, it'll return an error to user
space when the driver tries to open the file representing the interrupt.

Jon> Also what about SMP, if you shut the IRQ off on one CPU isn't it
Jon> still enabled on all of the others?

Nope.   disable_irq_nosync() talks to the interrupt controller, which
is common to all the processors.  The main problem is that it's slow,
because it has to go off-chip.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
