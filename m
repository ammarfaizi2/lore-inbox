Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTH1ODw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 10:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbTH1ODw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 10:03:52 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:1408 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263637AbTH1ODt (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 10:03:49 -0400
Message-Id: <200308280842.h7S8gCln032095@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: nagendra_tomar@adaptec.com
Cc: Timo Sirainen <tss@iki.fi>, Jamie Lokier <jamie@shareable.org>,
       root@chaos.analogic.com, Martin Konold <martin.konold@erfrakon.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading 
In-Reply-To: Your message of "Thu, 28 Aug 2003 00:12:30 +0530."
             <Pine.LNX.4.44.0308272353470.13148-100000@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0308272353470.13148-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1295763292P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 28 Aug 2003 04:42:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1295763292P
Content-Type: text/plain; charset=us-ascii

On Thu, 28 Aug 2003 00:12:30 +0530, Nagendra Singh Tomar said:

> Why do u require file locking if there is a *single* writer ?? I don't 
> understand why a 123 written over XXX can result in 1X3.

You'd be *amazed* at what can go strange (not wrong, just strange) at the
hardware level.  Let's assume for the sake of argument that  in your '123' and
'XXX', each character represents 4 or 8 or however many bytes wide your memory
bus is (so "123" is really a 24 byte string).  The following can happen
(especially if your hardware doesn't have cache coherency):

1) CPU 0 stores the 24 bytes, and it splits across a cache line boundary.
The '12' goes in one line, '3' in the next.

2) Cache controller 0 does the writeback of '3' first.

3) Cache controller 0 starts the writeback of the other cache line,
and gets the '1' written, still waiting for next memory cycle to write '2'.

4) CPU 1 or a DMA device snarfs up the 24 bytes before the '2' gets there.
'3' got there, '1' got there, '2' will get there the *NEXT* bus cycle.

1X3.  Whoops. 

Real hardware does this sort of thing all the time. Consider *this* gem from
the IBM S/370 Principles of Operation (GA22-7000-10, page 5-12):

"For the instructions EDIT, EDIT AND MARK, and TRANSLATE, the portions of the
operands that are actually used in the operation may be established in a trial
execution for operand accessibility that is performed before the execution of
the instruction is started.  This trial execution consists in an execution of
the instruction in which results are not stored.  If the first operand of
TRANSLATE or either operand of EDIT or EDIT AND MARK is changed by another CPU
or by a channel, after the initial trial execution but before completion of
execution, the contents of any fields due to be changed by the instruction are
unpredictable. Furthermore, it is unpredictable whether or not an interruption
occurs for an access exception that was not initially applicable".

In Linux terms, the S/370 family has a hardware instruction that does a
somewhat limited 'sprintf'.  It may make a dummy pass through the format string
to compute how long the result is (so it can tell if you should get a SEGV for
going off the end of a page) and it's possible for the format string to get
changed out from under it while it's doing that.  In addition, if the format
*used* to be a %4d that wrote to the last 4 bytes of a page, and somebody nails
it to be a %8d halfway through, we may or may not get a SEGV when we scribble 4
bytes onto the next page in memory, even if it's a readonly page we scribbled
on....

The description of what order things are seen to happen in runs for 11 pages,
*not* including special-cases like the above....







--==_Exmh_1295763292P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/TcBkcC3lWbTT17ARApN/AKDb3LS/jLcV+t/cx4N5auMalaQj7gCfcmYA
ETgdDIdG5OpuH18+J9DmTGk=
=R6BT
-----END PGP SIGNATURE-----

--==_Exmh_1295763292P--
