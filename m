Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbTDYLZP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 07:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTDYLZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 07:25:15 -0400
Received: from mta02.telering.at ([212.95.31.39]:18648 "EHLO smtp.telering.at")
	by vger.kernel.org with ESMTP id S263862AbTDYLZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 07:25:12 -0400
Date: Fri, 25 Apr 2003 12:40:24 +0200
From: Bernhard Kaindl <kaindl@telering.at>
X-X-Sender: bkaindl@hase.a11.local
To: Andreas Gietl <Listen@e-admin.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.4-rc1] fix side effects of the kmod/ptrace secfix
In-Reply-To: <200304250037.45133.Listen@e-admin.de>
Message-ID: <Pine.LNX.4.53.0304251215200.2582@hase.a11.local>
References: <200304250037.45133.Listen@e-admin.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283901862-134127159-1051267224=:2582"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1283901862-134127159-1051267224=:2582
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 25 Apr 2003, Andreas Gietl wrote:
> > system monitoring stuff this way(I've even heard shutdown is affected)
>
> i can confirm that shutdown (halt|reboot) does not work on my 2.4.21-rc1-ac1
> boxes. (gentoo + redhat).

Thanks for the info!

> But your patch does not seem to fix it.

Very interesting also, the two liner adressed only the well-known problems.
To fix the other not so well-known side effects, a real cleanup is the way
to go.

Can you try the attached cleanup patch instead of the two-liner?

It's an inital cleanup and should fix the other side effects which
I described in my mails.

Bernhard Kaindl

PS: If either patch is applied correctly, this

	su guest -c 'ps $PPID;wc -m </proc/$PPID/cmdline'

should give:

  PID TTY      STAT   TIME COMMAND
 2452 pts/2    S      0:00 su bin -c ps $PPID;wc -m </proc/$PPID/cmdline
     46

If it does not, access_process_vm is not fixed properly.

Second, calling this as root:

	strace -fewrite su -c /bin/echo 2>&1 | grep pid

should give:

[pid  2599] --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
[pid  2599] write(1, "\n", 1

If it does not, ptrace_check_attach is not fixed properly.

(These are only the checks for the well known side
effects which should be fixed even with the short
is_dumpable() -> task_dumpable patch.)
--1283901862-134127159-1051267224=:2582
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ptrace-cleanup-1.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0304251240240.2582@hase.a11.local>
Content-Description: 
Content-Disposition: attachment; filename="ptrace-cleanup-1.diff"

LS0tIGtlcm5lbC9wdHJhY2UuYwkyMDAzLzA0LzIyIDIxOjE0OjIwCTEuMQ0K
KysrIGtlcm5lbC9wdHJhY2UuYwkyMDAzLzA0LzI1IDA2OjIxOjE2CTEuMw0K
QEAgLTIxLDkgKzIxLDYgQEANCiAgKi8NCiBpbnQgcHRyYWNlX2NoZWNrX2F0
dGFjaChzdHJ1Y3QgdGFza19zdHJ1Y3QgKmNoaWxkLCBpbnQga2lsbCkNCiB7
DQotCW1iKCk7DQotCWlmICghaXNfZHVtcGFibGUoY2hpbGQpKQ0KLQkJcmV0
dXJuIC1FUEVSTTsNCiANCiAJaWYgKCEoY2hpbGQtPnB0cmFjZSAmIFBUX1BU
UkFDRUQpKQ0KIAkJcmV0dXJuIC1FU1JDSDsNCkBAIC0xMjcsOCArMTI0LDYg
QEAgaW50IGFjY2Vzc19wcm9jZXNzX3ZtKHN0cnVjdCB0YXNrX3N0cnVjdA0K
IAkvKiBXb3JyeSBhYm91dCByYWNlcyB3aXRoIGV4aXQoKSAqLw0KIAl0YXNr
X2xvY2sodHNrKTsNCiAJbW0gPSB0c2stPm1tOw0KLQlpZiAoIWlzX2R1bXBh
YmxlKHRzaykgfHwgKCZpbml0X21tID09IG1tKSkNCi0JCW1tID0gTlVMTDsN
CiAJaWYgKG1tKQ0KIAkJYXRvbWljX2luYygmbW0tPm1tX3VzZXJzKTsNCiAJ
dGFza191bmxvY2sodHNrKTsNCi0tLSBrZXJuZWwvc3lzLmMJMjAwMy8wNC8y
NSAwNjoyMzoxNQkxLjENCisrKyBrZXJuZWwvc3lzLmMJMjAwMy8wNC8yNSAw
NjoyMzo1MQ0KQEAgLTEyNTIsOCArMTI1Miw3IEBAIGFzbWxpbmthZ2UgbG9u
ZyBzeXNfcHJjdGwoaW50IG9wdGlvbiwgdW4NCiAJCQkJZXJyb3IgPSAtRUlO
VkFMOw0KIAkJCQlicmVhazsNCiAJCQl9DQotCQkJaWYgKGlzX2R1bXBhYmxl
KGN1cnJlbnQpKQ0KLQkJCQljdXJyZW50LT5tbS0+ZHVtcGFibGUgPSBhcmcy
Ow0KKwkJCWN1cnJlbnQtPm1tLT5kdW1wYWJsZSA9IGFyZzI7DQogCQkJYnJl
YWs7DQogDQogCSAgICAgICAgY2FzZSBQUl9TRVRfVU5BTElHTjoNCg==

--1283901862-134127159-1051267224=:2582--
