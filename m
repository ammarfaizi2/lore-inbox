Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVG0MJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVG0MJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 08:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVG0MJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 08:09:13 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:25535 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262210AbVG0MJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 08:09:03 -0400
Message-ID: <42E77948.2050600@in.ibm.com>
Date: Wed, 27 Jul 2005 17:38:40 +0530
From: Suzuki <suzuki@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-aio <linux-aio@kvack.org>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [RFC] Races in aio call back path.
Content-Type: multipart/mixed;
 boundary="------------060507080605060805090306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060507080605060805090306
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I found some races in the AIO call back path which is the root cause for
a few problems in the AIO code. The race is between the aio call back
path ( executed by softirqs ) and the aio_run_iocb().

(1) Suppose a retry returned -EIOCBRETRY and wait has been queued.

Now, whenever the wait event has been completed, the aio_wake_function()
is invoked by the softirqs. aio_wake_function deletes the wait entry
(iocb->ki_wait.task_list) and invokes kick_iocb() to kick the iocb and
queue it back to the run_list.

Consider a situation like:

SOFTIRQ:
	list_del_init(&wait->task_list);
           ## SOFTIRQ gets scheduled or PROCESS executes on another CPU ##
	kick_iocb(iocb);
PROCESS:
	/*
	 * Issue an additional retry to avoid waiting forever if
	 * no waits were queued (e.g. in case of a short read).
	 */
	if (list_empty(&iocb->ki_wait.task_list))
	kiocbSetKicked(iocb);

So, PROCESS might see the deleted(empty) wait list
(iocb->ki_wait.task_list) and will kick and queue it up and it will be
retried again. Now if the next retry is going to happen before SOFTIRQ
gets a chance to run, we are running into problems.

There are two possiblities:

(a) The iocb may get completed.
	If this happens before the SOFTIRQ enters kick_iocb(iocb), we are about
to kick an iocb which is no more valid. This might cause a Kernel Oops
while trying,
	spin_lock_irqsave(&ctx->ctx_lock, flags);
since the iocb->ki_ctx may be invalid.

(b) The iocb might encounter another wait condition.
	This case iocb would be queued for some events. This would cause the
SOFTIRQ hit
	WARN_ON((!list_empty(&iocb->ki_wait.task_list)));
in queue_kicked_iocb().

(2) Similar races occur due to Kicking the iocb.

i.e,
SOFTIRQ: [in kick_iocb()]
		if(!kiocbTryKick(iocb)) {
	# If we get scheduled here. And PROCESS reaches as below #
			queue_kicked_iocb(iocb);
PROCESS: [ in aio_run_iocb() ]
		/* will make __queue_kicked_iocb succeed from here on */
		INIT_LIST_HEAD(&iocb->ki_run_list);
		/* we must queue the next iteration ourselves, if it
		 * has already been kicked */
		if (kiocbIsKicked(iocb)) { <- Will be true see ( kicked by kick_iocb)
			__queue_kicked_iocb(iocb);
		}

Thus iocb will get queued and may be retried. This again can cause the
problems described above.

Conclusion
===========

  From this I conclude that the following operations in call back path
for async iocbs should be atomic.

(*) Deletion of the wait queue entry.
(*) Kicking the iocb.
(*) Queue back to run_list. ( which is already atomic with ctx_lock held ).

Also the check for waits being queued in aio_run_iocb() should be done
with the ctx_lock held.

Solution
========
I have created a patch which makes above operations to be done with the
iocb->ki_ctx->ctx_lock held. Also, I have moved the check :

   > if (list_empty(&iocb->ki_wait.task_list))
   >	kiocbSetKicked(iocb);

to be done under the ctx_lock held.

Since we already holds a lock before calling queue_kicked_iocb(), there
is no need for a queue_kicked_iocb anymore. So I have renamed the
__queue_kicked_iocb to queue_kicked_iocb.

Testing
========
I tested the proposed patch in 2.6.13-rc3-mm1 on a 2-way Intel Xeon(with HT) with aio-stress and fsx-linux test cases.
The tests ran fine.


Comments ?

regards,

Suzuki K P
Linux Technology Centre
IBM India Software Labs
Bangalore.

"Sorrow keeps u Human ,Failure Keeps u Humble,Success keeps u Glowing.
    But only God Keeps u Going..... "




--------------060507080605060805090306
Content-Type: text/plain;
 name="aio-fix-races-kick-path.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="aio-fix-races-kick-path.patch"

LS0tIGxpbnV4LTIuNi4xMy1yYzMvZnMvYWlvLmMub2xkCTIwMDUtMDctMjcgMTA6MTk6MjEu
MDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjYuMTMtcmMzL2ZzL2Fpby5jCTIwMDUtMDct
MjcgMTA6MjI6MjcuMDAwMDAwMDAwIC0wNzAwCkBAIC02MDksNyArNjA5LDcgQEAgc3RhdGlj
IHZvaWQgdW51c2VfbW0oc3RydWN0IG1tX3N0cnVjdCAqbQogICogU2hvdWxkIGJlIGNhbGxl
ZCB3aXRoIHRoZSBzcGluIGxvY2sgaW9jYi0+a2lfY3R4LT5jdHhfbG9jawogICogaGVsZAog
ICovCi1zdGF0aWMgaW5saW5lIGludCBfX3F1ZXVlX2tpY2tlZF9pb2NiKHN0cnVjdCBraW9j
YiAqaW9jYikKK3N0YXRpYyBpbmxpbmUgaW50IHF1ZXVlX2tpY2tlZF9pb2NiKHN0cnVjdCBr
aW9jYiAqaW9jYikKIHsKIAlzdHJ1Y3Qga2lvY3R4ICpjdHggPSBpb2NiLT5raV9jdHg7CiAK
QEAgLTcyNCwxMyArNzI0LDYgQEAgc3RhdGljIHNzaXplX3QgYWlvX3J1bl9pb2NiKHN0cnVj
dCBraW9jYgogCQkJYWlvX2NvbXBsZXRlKGlvY2IsIHJldCwgMCk7CiAJCQkvKiBtdXN0IG5v
dCBhY2Nlc3MgdGhlIGlvY2IgYWZ0ZXIgdGhpcyAqLwogCQl9Ci0JfSBlbHNlIHsKLQkJLyoK
LQkJICogSXNzdWUgYW4gYWRkaXRpb25hbCByZXRyeSB0byBhdm9pZCB3YWl0aW5nIGZvcmV2
ZXIgaWYKLQkJICogbm8gd2FpdHMgd2VyZSBxdWV1ZWQgKGUuZy4gaW4gY2FzZSBvZiBhIHNo
b3J0IHJlYWQpLgotCQkgKi8KLQkJaWYgKGxpc3RfZW1wdHkoJmlvY2ItPmtpX3dhaXQudGFz
a19saXN0KSkKLQkJCWtpb2NiU2V0S2lja2VkKGlvY2IpOwogCX0KIG91dDoKIAlzcGluX2xv
Y2tfaXJxKCZjdHgtPmN0eF9sb2NrKTsKQEAgLTc0MSwxNyArNzM0LDIzIEBAIG91dDoKIAkJ
ICogYW5kIGtub3cgdGhhdCB0aGVyZSBpcyBtb3JlIGxlZnQgdG8gZ28sCiAJCSAqIHRoaXMg
aXMgd2hlcmUgd2UgbGV0IGdvIHNvIHRoYXQgYSBzdWJzZXF1ZW50CiAJCSAqICJraWNrIiBj
YW4gc3RhcnQgdGhlIG5leHQgaXRlcmF0aW9uCisJCSAqCisJCSAqIElzc3VlIGFuIGFkZGl0
aW9uYWwgcmV0cnkgdG8gYXZvaWQgd2FpdGluZyBmb3JldmVyIGlmCisJCSAqIG5vIHdhaXRz
IHdlcmUgcXVldWVkIChlLmcuIGluIGNhc2Ugb2YgYSBzaG9ydCByZWFkKS4KKwkJICogKFNo
b3VsZCBiZSBkb25lIHdpdGggY3R4X2xvY2sgaGVsZC4pCiAJCSAqLwogCi0JCS8qIHdpbGwg
bWFrZSBfX3F1ZXVlX2tpY2tlZF9pb2NiIHN1Y2NlZWQgZnJvbSBoZXJlIG9uICovCisJCWlm
IChsaXN0X2VtcHR5KCZpb2NiLT5raV93YWl0LnRhc2tfbGlzdCkpCisJCQlraW9jYlNldEtp
Y2tlZChpb2NiKTsKKwkJLyogd2lsbCBtYWtlIHF1ZXVlX2tpY2tlZF9pb2NiIHN1Y2NlZWQg
ZnJvbSBoZXJlIG9uICovCiAJCUlOSVRfTElTVF9IRUFEKCZpb2NiLT5raV9ydW5fbGlzdCk7
CiAJCS8qIHdlIG11c3QgcXVldWUgdGhlIG5leHQgaXRlcmF0aW9uIG91cnNlbHZlcywgaWYg
aXQKIAkJICogaGFzIGFscmVhZHkgYmVlbiBraWNrZWQgKi8KIAkJaWYgKGtpb2NiSXNLaWNr
ZWQoaW9jYikpIHsKLQkJCV9fcXVldWVfa2lja2VkX2lvY2IoaW9jYik7CisJCQlxdWV1ZV9r
aWNrZWRfaW9jYihpb2NiKTsKIAogCQkJLyoKLQkJCSAqIF9fcXVldWVfa2lja2VkX2lvY2Ig
d2lsbCBhbHdheXMgcmV0dXJuIDEgaGVyZSwgYmVjYXVzZQorCQkJICogcXVldWVfa2lja2Vk
X2lvY2Igd2lsbCBhbHdheXMgcmV0dXJuIDEgaGVyZSwgYmVjYXVzZQogCQkJICogaW9jYi0+
a2lfcnVuX2xpc3QgaXMgZW1wdHkgYXQgdGhpcyBwb2ludCBzbyBpdCBzaG91bGQKIAkJCSAq
IGJlIHNhZmUgdG8gdW5jb25kaXRpb25hbGx5IHF1ZXVlIHRoZSBjb250ZXh0IGludG8gdGhl
CiAJCQkgKiB3b3JrIHF1ZXVlLgpAQCAtODcwLDIxICs4NjksMzEgQEAgc3RhdGljIHZvaWQg
YWlvX2tpY2tfaGFuZGxlcih2b2lkICpkYXRhKQogCiAKIC8qCi0gKiBDYWxsZWQgYnkga2lj
a19pb2NiIHRvIHF1ZXVlIHRoZSBraW9jYiBmb3IgcmV0cnkKLSAqIGFuZCBpZiByZXF1aXJl
ZCBhY3RpdmF0ZSB0aGUgYWlvIHdvcmsgcXVldWUgdG8gcHJvY2VzcwotICogaXQKKyAqIEtp
Y2tpbmcgYW4gYXN5bmMgaW9jYi4KKyAqIFRoZSBmb2xsb3dpbmcgb3BlcmF0aW9ucyBmb3Ig
dGhlIGFzeW5jIGlvY2JzIHNob3VsZCBiZSBhdG9taWMKKyAqIHRvIGF2b2lkIHJhY2VzIHdp
dGggdGhlIGFpb19ydW5faW9jYigpIGNvZGUuCisgKiAoMSkgRGVsZXRpbmcgdGhlIHdhaXQg
cXVldWUgZW50cnkuCisgKiAoMikgS2lja2luZyB0aGUgaW9jYi4KKyAqICgzKSBRdWV1ZSB0
aGUgaW9jYiBiYWNrIHRvIHJ1bl9saXN0LgorICogSG9sZHMgdGhlIGN0eC0+Y3R4X2xvY2sg
dG8gYXZvaWQgcmFjZXMuCiAgKi8KLXN0YXRpYyB2b2lkIHF1ZXVlX2tpY2tlZF9pb2NiKHN0
cnVjdCBraW9jYiAqaW9jYikKK3N0YXRpYyB2b2lkIGtpY2tfYXN5bmNfaW9jYihzdHJ1Y3Qg
a2lvY2IgKmlvY2IpCiB7CiAgCXN0cnVjdCBraW9jdHgJKmN0eCA9IGlvY2ItPmtpX2N0eDsK
IAl1bnNpZ25lZCBsb25nIGZsYWdzOwogCWludCBydW4gPSAwOwotCi0JV0FSTl9PTigoIWxp
c3RfZW1wdHkoJmlvY2ItPmtpX3dhaXQudGFza19saXN0KSkpOwotCisJCiAJc3Bpbl9sb2Nr
X2lycXNhdmUoJmN0eC0+Y3R4X2xvY2ssIGZsYWdzKTsKLQlydW4gPSBfX3F1ZXVlX2tpY2tl
ZF9pb2NiKGlvY2IpOworCWxpc3RfZGVsX2luaXQoJmlvY2ItPmtpX3dhaXQudGFza19saXN0
KTsKKwkvKiBJZiBpdHMgYWxyZWFkeSBraWNrZWQgd2Ugc2hvdWxkbid0IHF1ZXVlIGl0IGFn
YWluICovCisJaWYgKCFraW9jYlRyeUtpY2soaW9jYikpIHsKKwkJcnVuID0gcXVldWVfa2lj
a2VkX2lvY2IoaW9jYik7CisJfQogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmN0eC0+Y3R4
X2xvY2ssIGZsYWdzKTsKKworCS8qIEFjdGl2YXRlIHRoZSBhaW8gd29ya2VyIHF1ZXVlIGlm
IHdlIGhhdmUgc3VjY2Vzc2Z1bGx5IHF1ZXVlZAorCSAqIHRoZSBpb2NiLCBzbyB0aGF0IGl0
IGNhbiBiZSBwcm9jZXNzZWQKKwkgKi8KIAlpZiAocnVuKQogCQlhaW9fcXVldWVfd29yayhj
dHgpOwogfQpAQCAtOTAxLDE1ICs5MTAsMTMgQEAgdm9pZCBmYXN0Y2FsbCBraWNrX2lvY2Io
c3RydWN0IGtpb2NiICppbwogCS8qIHN5bmMgaW9jYnMgYXJlIGVhc3k6IHRoZXkgY2FuIG9u
bHkgZXZlciBiZSBleGVjdXRpbmcgZnJvbSBhIAogCSAqIHNpbmdsZSBjb250ZXh0LiAqLwog
CWlmIChpc19zeW5jX2tpb2NiKGlvY2IpKSB7CisJCWxpc3RfZGVsX2luaXQoJmlvY2ItPmtp
X3dhaXQudGFza19saXN0KTsKIAkJa2lvY2JTZXRLaWNrZWQoaW9jYik7CiAJICAgICAgICB3
YWtlX3VwX3Byb2Nlc3MoaW9jYi0+a2lfb2JqLnRzayk7CiAJCXJldHVybjsKLQl9Ci0KLQkv
KiBJZiBpdHMgYWxyZWFkeSBraWNrZWQgd2Ugc2hvdWxkbid0IHF1ZXVlIGl0IGFnYWluICov
Ci0JaWYgKCFraW9jYlRyeUtpY2soaW9jYikpIHsKLQkJcXVldWVfa2lja2VkX2lvY2IoaW9j
Yik7Ci0JfQorCX0gZWxzZSAKKwkJa2lja19hc3luY19pb2NiKGlvY2IpOworCQogfQogRVhQ
T1JUX1NZTUJPTChraWNrX2lvY2IpOwogCkBAIC0xNDYxLDcgKzE0NjgsNiBAQCBzdGF0aWMg
aW50IGFpb193YWtlX2Z1bmN0aW9uKHdhaXRfcXVldWVfCiB7CiAJc3RydWN0IGtpb2NiICpp
b2NiID0gY29udGFpbmVyX29mKHdhaXQsIHN0cnVjdCBraW9jYiwga2lfd2FpdCk7CiAKLQls
aXN0X2RlbF9pbml0KCZ3YWl0LT50YXNrX2xpc3QpOwogCWtpY2tfaW9jYihpb2NiKTsKIAly
ZXR1cm4gMTsKIH0K
--------------060507080605060805090306--
