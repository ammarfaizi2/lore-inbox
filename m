Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262729AbRE3LIT>; Wed, 30 May 2001 07:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbRE3LIK>; Wed, 30 May 2001 07:08:10 -0400
Received: from [212.1.33.3] ([212.1.33.3]:34106 "EHLO borg4.zapnet.de")
	by vger.kernel.org with ESMTP id <S262729AbRE3LHt>;
	Wed, 30 May 2001 07:07:49 -0400
From: Ivan Schreter <is@zapwerk.com>
To: george anzinger <george@mvista.com>
Subject: Re: [patch] sched_yield in 2.2.x - version 2
Date: Wed, 30 May 2001 12:54:52 +0200
X-Mailer: KMail [version 1.0.29.2]
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD"
In-Reply-To: <01053002030500.01197@linux> <3B146125.77845217@mvista.com>
In-Reply-To: <3B146125.77845217@mvista.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01053013065000.01375@linux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hello,

please CC: replies to me as I am not subscribed to the list.

> The real problem with this patch is that if a real time task yields, the
> patch will cause the scheduler to pick a lower priority task or a
> SCHED_OTHER task.  This one is not so easy to solve.  You want to scan
> the run_list in the proper order so that the real time task will be the
> last pick at its priority.  Problem is, the pre load with the prev task
> is out of order.  You might try: http://rtsched.sourceforge.net/

No it's not a problem at all, since RR tasks will just be moved to the end of
the queue and no SCHED_YIELD flag is set for them => no lower-priority task may
be scheduled.

However, I found a bug in my own patch :-)
The problem is that when a process yields and no process has a timeslice left,
recalc is called. But then we lose YIELD flag once again. So the simple
solution (and hopefully this time right :-) was to NOT clear YIELD flag at all
before exit from schedule() and move test for this flag from goodness_prev() to
goodness() function (getting rid of goodness_prev() altogether).

However, one of my tests still show strange behavior, so maybe you will get 3rd
version of the patch :-) Anyway, I got good 30% performance boost for
high-contention case in user-space spinlocks when sched_yield() is working
right.

Another function that would be very interesting is possibility to give up our
timeslice to specific other process. This way I could transfer control to other
process/thread that owns the lock directly so that process/thread may finish
working with the lock. This can again speed up everything. When I have now 4
processes contending for a lock, I get performance 1x. However, when there are
20 processes contending, performance is only 0.7x. I suppose this is due to
excessive context switches. I will try to implement something like
"sched_switchto" to switch to specific pid (from user space) and see if that
helps. Or is there such a function already?

Ivan Schreter
is@zapwerk.com

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/x-c;
  name="sched_patch.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sched_patch.diff"

LS0tIGtlcm5lbC9zY2hlZC5jLm9yaWcJV2VkIE1heSAzMCAwMToxNzoyNCAyMDAxCisrKyBrZXJu
ZWwvc2NoZWQuYwlXZWQgTWF5IDMwIDEyOjMwOjAzIDIwMDEKQEAgLTE0NSw2ICsxNDUsMTEgQEAK
IHsKIAlpbnQgd2VpZ2h0OwogCisJaWYgKHAtPnBvbGljeSAmIFNDSEVEX1lJRUxEKSB7CisJCS8q
IGRvIG5vdCBzY2hlZHVsZSB5aWVsZGVkIHByb2Nlc3Mgbm93ICovCisJCXJldHVybiAtMTsKKwl9
CisKIAkvKgogCSAqIFJlYWx0aW1lIHByb2Nlc3MsIHNlbGVjdCB0aGUgZmlyc3Qgb25lIG9uIHRo
ZQogCSAqIHJ1bnF1ZXVlICh0YWtpbmcgcHJpb3JpdGllcyB3aXRoaW4gcHJvY2Vzc2VzCkBAIC0x
ODMsMjUgKzE4OCw2IEBACiB9CiAKIC8qCi0gKiBzdWJ0bGUuIFdlIHdhbnQgdG8gZGlzY2FyZCBh
IHlpZWxkZWQgcHJvY2VzcyBvbmx5IGlmIGl0J3MgYmVpbmcKLSAqIGNvbnNpZGVyZWQgZm9yIGEg
cmVzY2hlZHVsZS4gV2FrZXVwLXRpbWUgJ3F1ZXJpZXMnIG9mIHRoZSBzY2hlZHVsaW5nCi0gKiBz
dGF0ZSBkbyBub3QgY291bnQuIEFub3RoZXIgb3B0aW1pemF0aW9uIHdlIGRvOiBzY2hlZF95aWVs
ZCgpLWVkCi0gKiBwcm9jZXNzZXMgYXJlIHJ1bm5hYmxlIChhbmQgdGh1cyB3aWxsIGJlIGNvbnNp
ZGVyZWQgZm9yIHNjaGVkdWxpbmcpCi0gKiByaWdodCB3aGVuIHRoZXkgYXJlIGNhbGxpbmcgc2No
ZWR1bGUoKS4gU28gdGhlIG9ubHkgcGxhY2Ugd2UgbmVlZAotICogdG8gY2FyZSBhYm91dCBTQ0hF
RF9ZSUVMRCBpcyB3aGVuIHdlIGNhbGN1bGF0ZSB0aGUgcHJldmlvdXMgcHJvY2VzcycKLSAqIGdv
b2RuZXNzIC4uLgotICovCi1zdGF0aWMgaW5saW5lIGludCBwcmV2X2dvb2RuZXNzIChzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKiBwcmV2LAotCQkJCQlzdHJ1Y3QgdGFza19zdHJ1Y3QgKiBwLCBpbnQgdGhp
c19jcHUpCi17Ci0JaWYgKHAtPnBvbGljeSAmIFNDSEVEX1lJRUxEKSB7Ci0JCXAtPnBvbGljeSAm
PSB+U0NIRURfWUlFTEQ7Ci0JCXJldHVybiAwOwotCX0KLQlyZXR1cm4gZ29vZG5lc3MocHJldiwg
cCwgdGhpc19jcHUpOwotfQotCi0vKgogICogdGhlICdnb29kbmVzcyB2YWx1ZScgb2YgcmVwbGFj
aW5nIGEgcHJvY2VzcyBvbiBhIGdpdmVuIENQVS4KICAqIHBvc2l0aXZlIHZhbHVlIG1lYW5zICdy
ZXBsYWNlJywgemVybyBvciBuZWdhdGl2ZSBtZWFucyAnZG9udCcuCiAgKi8KQEAgLTc0MCw2ICs3
MjYsMTAgQEAKIAkvKiBEbyB3ZSBuZWVkIHRvIHJlLWNhbGN1bGF0ZSBjb3VudGVycz8gKi8KIAlp
ZiAoIWMpCiAJCWdvdG8gcmVjYWxjdWxhdGU7CisKKwkvKiBjbGVhbiB1cCBwb3RlbnRpYWwgU0NI
RURfWUlFTEQgYml0ICovCisJcHJldi0+cG9saWN5ICY9IH5TQ0hFRF9ZSUVMRDsKKwogCS8qCiAJ
ICogZnJvbSB0aGlzIHBvaW50IG9uIG5vdGhpbmcgY2FuIHByZXZlbnQgdXMgZnJvbQogCSAqIHN3
aXRjaGluZyB0byB0aGUgbmV4dCB0YXNrLCBzYXZlIHRoaXMgZmFjdCBpbgpAQCAtODA5LDcgKzc5
OSw3IEBACiAJfQogCiBzdGlsbF9ydW5uaW5nOgotCWMgPSBwcmV2X2dvb2RuZXNzKHByZXYsIHBy
ZXYsIHRoaXNfY3B1KTsKKwljID0gZ29vZG5lc3MocHJldiwgcHJldiwgdGhpc19jcHUpOwogCW5l
eHQgPSBwcmV2OwogCWdvdG8gc3RpbGxfcnVubmluZ19iYWNrOwogCg==

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD--
