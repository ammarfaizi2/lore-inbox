Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262058AbRE3ADh>; Tue, 29 May 2001 20:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262483AbRE3AD2>; Tue, 29 May 2001 20:03:28 -0400
Received: from [212.1.33.3] ([212.1.33.3]:10358 "EHLO borg4.zapnet.de")
	by vger.kernel.org with ESMTP id <S262058AbRE3ADL>;
	Tue, 29 May 2001 20:03:11 -0400
From: Ivan Schreter <is@zapwerk.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] sched_yield in 2.2.x
Date: Wed, 30 May 2001 01:49:06 +0200
X-Mailer: KMail [version 1.0.29.2]
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD"
MIME-Version: 1.0
Message-Id: <01053002030500.01197@linux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hello,

I'm not subscribed, so eventual replies please CC: to me (is@zapwerk.com).

Here is a 2-line patch that fixes sched_yield() call to actually really yield
the processor in 2.2.x kernels. I am using 2.2.16 and so have tested it in
2.2.16 only, but I suppose it should work with other kernels as well (there
seem not to be so many changes).

Bug description: When a process called sched_yield() it was properly marked for
reschedule and bit SCHED_YIELD for reschedule was properly set in p->policy.
However, prev_goodness() cleared this bit returning goodness 0 (I changed it to
-1 just to be sure this process isn't accidentally picked when there is other
process to run - maybe I'm wrong here, but 2.4.5 gives it also goodness -1, so
it should be OK). This was not that bad, but successive calls to goodness()
while searching for next process to run included last process, which had
meanwhile YIELD bit cleared and thus it's goodness value was calculated as
better. And we come to second line of the fix - do not consider prev process in
searching for next process to run, as it is anyway already selected as next by
default when no better process is found.

I hope that it will work in SMP environment as well (it should, since
schedule() seems to be mostly independent of UP/SMP).

And why do I want to use sched_yield()? Well, to implement user-space
longer-duration locks which don't consume the whole timeslice when waiting, but
rather relinquish processor to other task so it finishes it's work in critical
region sooner.

It's funny nobody has fixed this by now, but as I've seen there were couple
of discussion about sched_yield() already... I come probably too late...

Ivan Schreter
is@zapwerk.com

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain;
  name="sched_patch.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sched_patch.diff"

LS0tIGtlcm5lbC9zY2hlZC5jLm9yaWcJV2VkIE1heSAzMCAwMToxNzoyNCAyMDAxCisrKyBrZXJu
ZWwvc2NoZWQuYwlXZWQgTWF5IDMwIDAxOjQxOjM0IDIwMDEKQEAgLTE5Niw3ICsxOTYsNyBAQAog
ewogCWlmIChwLT5wb2xpY3kgJiBTQ0hFRF9ZSUVMRCkgewogCQlwLT5wb2xpY3kgJj0gflNDSEVE
X1lJRUxEOwotCQlyZXR1cm4gMDsKKwkJcmV0dXJuIC0xOwogCX0KIAlyZXR1cm4gZ29vZG5lc3Mo
cHJldiwgcCwgdGhpc19jcHUpOwogfQpAQCAtNzI5LDcgKzcyOSw3IEBACiAgKiBsaXN0LCBzbyBv
dXIgbGlzdCBzdGFydGluZyBhdCAicCIgaXMgZXNzZW50aWFsbHkgZml4ZWQuCiAgKi8KIAl3aGls
ZSAocCAhPSAmaW5pdF90YXNrKSB7Ci0JCWlmIChjYW5fc2NoZWR1bGUocCkpIHsKKwkJaWYgKHAg
IT0gcHJldiAmJiBjYW5fc2NoZWR1bGUocCkpIHsKIAkJCWludCB3ZWlnaHQgPSBnb29kbmVzcyhw
cmV2LCBwLCB0aGlzX2NwdSk7CiAJCQlpZiAod2VpZ2h0ID4gYykKIAkJCQljID0gd2VpZ2h0LCBu
ZXh0ID0gcDsK

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD--
