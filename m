Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSJWBMs>; Tue, 22 Oct 2002 21:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262440AbSJWBMs>; Tue, 22 Oct 2002 21:12:48 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:1007 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S262414AbSJWBMr>; Tue, 22 Oct 2002 21:12:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15797.63740.520358.783516@wombat.chubb.wattle.id.au>
Date: Wed, 23 Oct 2002 11:18:52 +1000
To: david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
       dhinds@zen.standford.edu
Subject: Ejecting an orinoco card causes hang
From: peterc@gelato.unsw.edu.au
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Davids,
   I see the following problems with the orinoco plus cardbus plus
yenta_socket system on 2.5.44.
I'm using a Netgear MA401.

1.  cardctl reset gives a warning:
      orinoco_lock() called with hw_unavailable.
    I added a call to dump_stack() where the message was being printed
    out --- it's happening when pcmcia_release_configuration() calls
    set_socket, which calls yenta_get_socket() which calls set_cis_map
    which causes an interrupt, and then orinoco_interrupt reports the
    problem.   So it's probably benign.

2.  cardctl eject gives a warning, Bad: scheduling while atomic. I
    think this is a generic problem, not orinoco-specific ---
    pcmcia_eject_card() disables interrupts, then calls do_shutdown()
    which calls cs_sleep(), and cs_sleep() tries to sleep (but with
    interrupts disabled, bad)

3.  Manually ejecting the card (without doing a cardctl eject first)
    locks the machine solid.  Nothing in the logs, nothing on the
    screen.  I suspect it's disabling interrupts then doing something
    silly. 

4.  Transferring lots of data causes the link to collapse, and the
    logs to fill up with `eth0: Error -110 writing Tx descriptor to
    BAP' messages

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
