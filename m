Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268965AbTGJG5u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 02:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269003AbTGJG5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 02:57:50 -0400
Received: from nice-2-a7-62-147-225-73.dial.proxad.net ([62.147.225.73]:27396
	"EHLO monpc") by vger.kernel.org with ESMTP id S268965AbTGJG5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 02:57:37 -0400
From: Guillaume Chazarain <gfc@altern.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 10 Jul 2003 09:14:57 +0200
X-Priority: 3 (Normal)
In-Reply-To: <JFNL84UTSKFOJFDFD9D8GBF2WICKG.3f0b25af@monpc>
Message-Id: <86JEQO767187204DB6082KETIGUR.3f0d1271@monpc>
Subject: Re: [PATCH] Interactivity bits
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----------WVGaVv0VR1w13ys0oUll6n"
X-Mailer: Opera 6.06 build 1145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------WVGaVv0VR1w13ys0oUll6n
Content-Type: text/plain; charset="iso-8859-15"

Hello,

here is the latest version of my simple patch.
I increased INTERACTIVE_DELTA to 4 as told me
Mike Galbraith, he also explained to me why
the p->state == TASK_INTERRUPTIBLE test was a bad thing.

The previous patch against -mm3 was an accident, it
messed my tweaks with Con's work and it was... cough
not tested...

I'd appreciate any feedback.
Thanks.


Guillaume



--- linux-2.5.74-bk7/kernel/sched.c.old	2003-07-09 10:08:01.000000000 +0200
+++ linux-2.5.74-bk7/kernel/sched.c	2003-07-10 00:35:59.000000000 +0200
@@ -68,11 +68,11 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		50
-#define PARENT_PENALTY		100
+#define CHILD_PENALTY		80
+#define PARENT_PENALTY		90
 #define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
-#define INTERACTIVE_DELTA	2
+#define PRIO_BONUS_RATIO	45
+#define INTERACTIVE_DELTA	4
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
@@ -88,13 +88,13 @@
  * We scale it linearly, offset by the INTERACTIVE_DELTA delta.
  * Here are a few examples of different nice levels:
  *
- *  TASK_INTERACTIVE(-20): [1,1,1,1,1,1,1,1,1,0,0]
- *  TASK_INTERACTIVE(-10): [1,1,1,1,1,1,1,0,0,0,0]
- *  TASK_INTERACTIVE(  0): [1,1,1,1,0,0,0,0,0,0,0]
- *  TASK_INTERACTIVE( 10): [1,1,0,0,0,0,0,0,0,0,0]
- *  TASK_INTERACTIVE( 19): [0,0,0,0,0,0,0,0,0,0,0]
+ *  TASK_INTERACTIVE(-20): [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0]
+ *  TASK_INTERACTIVE(-10): [1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0]
+ *  TASK_INTERACTIVE(  0): [1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0]
+ *  TASK_INTERACTIVE( 10): [1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
+ *  TASK_INTERACTIVE( 19): [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
  *
- * (the X axis represents the possible -5 ... 0 ... +5 dynamic
+ * (the X axis represents the possible -9 ... 0 ... +9 dynamic
  *  priority range a task can explore, a value of '1' means the
  *  task is rated interactive.)
  *
@@ -303,9 +303,9 @@
  * priority but is modified by bonuses/penalties.
  *
  * We scale the actual sleep average [0 .... MAX_SLEEP_AVG]
- * into the -5 ... 0 ... +5 bonus/penalty range.
+ * into the -9 ... 0 ... +9 bonus/penalty range.
  *
- * We use 25% of the full 0...39 priority range so that:
+ * We use 50% of the full 0...39 priority range so that:
  *
  * 1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
  * 2) nice -20 CPU hogs do not get preempted by nice 0 tasks.
@@ -347,9 +347,9 @@
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	long sleep_time = jiffies - p->last_run - 1;
+	long sleep_time = jiffies - p->last_run;
 
-	if (sleep_time > 0) {
+	if (sleep_time) {
 		int sleep_avg;
 
 		/*
@@ -361,15 +361,9 @@
 		 * higher the priority boost gets as well.
 		 */
 		sleep_avg = p->sleep_avg + sleep_time;
-
-		/*
-		 * 'Overflow' bonus ticks go to the waker as well, so the
-		 * ticks are not lost. This has the effect of further
-		 * boosting tasks that are related to maximum-interactive
-		 * tasks.
-		 */
 		if (sleep_avg > MAX_SLEEP_AVG)
 			sleep_avg = MAX_SLEEP_AVG;
+
 		if (p->sleep_avg != sleep_avg) {
 			p->sleep_avg = sleep_avg;
 			p->prio = effective_prio(p);


------------WVGaVv0VR1w13ys0oUll6n
Content-Disposition: attachment;
	filename="patch.-mm3"
Content-Type: application/octet-stream
Content-Transfer-Encoding: Base64

LS0tIGxpbnV4LTIuNS43NC1tbTMva2VybmVsL3NjaGVkLmMub2xkCTIwMDMt
MDctMDkgMTY6NDQ6MzEuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjUu
NzQtbW0zL2tlcm5lbC9zY2hlZC5jCTIwMDMtMDctMTAgMDA6MzQ6MjcuMDAw
MDAwMDAwICswMjAwCkBAIC02OSwxNSArNjksMTMgQEAKICNkZWZpbmUgTUlO
X1RJTUVTTElDRQkJKCAxMCAqIEhaIC8gMTAwMCkKICNkZWZpbmUgTUFYX1RJ
TUVTTElDRQkJKDIwMCAqIEhaIC8gMTAwMCkKICNkZWZpbmUgQ0hJTERfUEVO
QUxUWQkJODAKLSNkZWZpbmUgUEFSRU5UX1BFTkFMVFkJCTEwMAorI2RlZmlu
ZSBQQVJFTlRfUEVOQUxUWQkJOTAKICNkZWZpbmUgRVhJVF9XRUlHSFQJCTMK
LSNkZWZpbmUgUFJJT19CT05VU19SQVRJTwkyNQotI2RlZmluZSBJTlRFUkFD
VElWRV9ERUxUQQkyCi0jZGVmaW5lIE1JTl9TTEVFUF9BVkcJCShIWikKKyNk
ZWZpbmUgUFJJT19CT05VU19SQVRJTwk0NQorI2RlZmluZSBJTlRFUkFDVElW
RV9ERUxUQQk0CiAjZGVmaW5lIE1BWF9TTEVFUF9BVkcJCSgxMCpIWikKICNk
ZWZpbmUgU1RBUlZBVElPTl9MSU1JVAkoMTAqSFopCiAjZGVmaW5lIE5PREVf
VEhSRVNIT0xECQkxMjUKLSNkZWZpbmUgTUFYX0JPTlVTCQkoKE1BWF9VU0VS
X1BSSU8gLSBNQVhfUlRfUFJJTykgKiBQUklPX0JPTlVTX1JBVElPIC8gMTAw
KQogCiAvKgogICogSWYgYSB0YXNrIGlzICdpbnRlcmFjdGl2ZScgdGhlbiB3
ZSByZWluc2VydCBpdCBpbiB0aGUgYWN0aXZlCkBAIC05MCwxMyArODgsMTMg
QEAKICAqIFdlIHNjYWxlIGl0IGxpbmVhcmx5LCBvZmZzZXQgYnkgdGhlIElO
VEVSQUNUSVZFX0RFTFRBIGRlbHRhLgogICogSGVyZSBhcmUgYSBmZXcgZXhh
bXBsZXMgb2YgZGlmZmVyZW50IG5pY2UgbGV2ZWxzOgogICoKLSAqICBUQVNL
X0lOVEVSQUNUSVZFKC0yMCk6IFsxLDEsMSwxLDEsMSwxLDEsMSwwLDBdCi0g
KiAgVEFTS19JTlRFUkFDVElWRSgtMTApOiBbMSwxLDEsMSwxLDEsMSwwLDAs
MCwwXQotICogIFRBU0tfSU5URVJBQ1RJVkUoICAwKTogWzEsMSwxLDEsMCww
LDAsMCwwLDAsMF0KLSAqICBUQVNLX0lOVEVSQUNUSVZFKCAxMCk6IFsxLDEs
MCwwLDAsMCwwLDAsMCwwLDBdCi0gKiAgVEFTS19JTlRFUkFDVElWRSggMTkp
OiBbMCwwLDAsMCwwLDAsMCwwLDAsMCwwXQorICogIFRBU0tfSU5URVJBQ1RJ
VkUoLTIwKTogWzEsMSwxLDEsMSwxLDEsMSwxLDEsMSwxLDEsMSwxLDAsMCww
LDBdCisgKiAgVEFTS19JTlRFUkFDVElWRSgtMTApOiBbMSwxLDEsMSwxLDEs
MSwxLDEsMSwwLDAsMCwwLDAsMCwwLDAsMF0KKyAqICBUQVNLX0lOVEVSQUNU
SVZFKCAgMCk6IFsxLDEsMSwxLDEsMSwwLDAsMCwwLDAsMCwwLDAsMCwwLDAs
MCwwXQorICogIFRBU0tfSU5URVJBQ1RJVkUoIDEwKTogWzEsMSwwLDAsMCww
LDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDBdCisgKiAgVEFTS19JTlRFUkFD
VElWRSggMTkpOiBbMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCww
LDAsMF0KICAqCi0gKiAodGhlIFggYXhpcyByZXByZXNlbnRzIHRoZSBwb3Nz
aWJsZSAtNSAuLi4gMCAuLi4gKzUgZHluYW1pYworICogKHRoZSBYIGF4aXMg
cmVwcmVzZW50cyB0aGUgcG9zc2libGUgLTkgLi4uIDAgLi4uICs5IGR5bmFt
aWMKICAqICBwcmlvcml0eSByYW5nZSBhIHRhc2sgY2FuIGV4cGxvcmUsIGEg
dmFsdWUgb2YgJzEnIG1lYW5zIHRoZQogICogIHRhc2sgaXMgcmF0ZWQgaW50
ZXJhY3RpdmUuKQogICoKQEAgLTI5OSwzNSArMjk3LDE1IEBACiAJYXJyYXkt
Pm5yX2FjdGl2ZSsrOwogCXAtPmFycmF5ID0gYXJyYXk7CiB9Ci0vKgotICog
bm9ybWFsaXNlX3NsZWVwIGNvbnZlcnRzIGEgdGFzaydzIHNsZWVwX2F2ZyB0
bwotICogYW4gYXBwcm9wcmlhdGUgcHJvcG9ydGlvbiBvZiBNSU5fU0xFRVBf
QVZHLgotICovCi1zdGF0aWMgaW5saW5lIHZvaWQgbm9ybWFsaXNlX3NsZWVw
KHRhc2tfdCAqcCkKLXsKLQl1bnNpZ25lZCBsb25nIG9sZF9hdmdfdGltZSA9
IGppZmZpZXMgLSBwLT5hdmdfc3RhcnQ7Ci0KLQlpZiAodW5saWtlbHkob2xk
X2F2Z190aW1lIDwgTUlOX1NMRUVQX0FWRykpCi0JCXJldHVybjsKLQotCWlm
IChwLT5zbGVlcF9hdmcgPiBNQVhfU0xFRVBfQVZHKQotCQlwLT5zbGVlcF9h
dmcgPSBNQVhfU0xFRVBfQVZHOwotCi0JaWYgKG9sZF9hdmdfdGltZSA+IE1B
WF9TTEVFUF9BVkcpCi0JCW9sZF9hdmdfdGltZSA9IE1BWF9TTEVFUF9BVkc7
Ci0KLQlwLT5zbGVlcF9hdmcgPSBwLT5zbGVlcF9hdmcgKiBNSU5fU0xFRVBf
QVZHIC8gb2xkX2F2Z190aW1lOwotCXAtPmF2Z19zdGFydCA9IGppZmZpZXMg
LSBNSU5fU0xFRVBfQVZHOwotfQogCiAvKgogICogZWZmZWN0aXZlX3ByaW8g
LSByZXR1cm4gdGhlIHByaW9yaXR5IHRoYXQgaXMgYmFzZWQgb24gdGhlIHN0
YXRpYwogICogcHJpb3JpdHkgYnV0IGlzIG1vZGlmaWVkIGJ5IGJvbnVzZXMv
cGVuYWx0aWVzLgogICoKICAqIFdlIHNjYWxlIHRoZSBhY3R1YWwgc2xlZXAg
YXZlcmFnZSBbMCAuLi4uIE1BWF9TTEVFUF9BVkddCi0gKiBpbnRvIHRoZSAt
NSAuLi4gMCAuLi4gKzUgYm9udXMvcGVuYWx0eSByYW5nZS4KKyAqIGludG8g
dGhlIC05IC4uLiAwIC4uLiArOSBib251cy9wZW5hbHR5IHJhbmdlLgogICoK
LSAqIFdlIHVzZSAyNSUgb2YgdGhlIGZ1bGwgMC4uLjM5IHByaW9yaXR5IHJh
bmdlIHNvIHRoYXQ6CisgKiBXZSB1c2UgNTAlIG9mIHRoZSBmdWxsIDAuLi4z
OSBwcmlvcml0eSByYW5nZSBzbyB0aGF0OgogICoKICAqIDEpIG5pY2UgKzE5
IGludGVyYWN0aXZlIHRhc2tzIGRvIG5vdCBwcmVlbXB0IG5pY2UgMCBDUFUg
aG9ncy4KICAqIDIpIG5pY2UgLTIwIENQVSBob2dzIGRvIG5vdCBnZXQgcHJl
ZW1wdGVkIGJ5IG5pY2UgMCB0YXNrcy4KQEAgLTMzNywyOCArMzE1LDExIEBA
CiBzdGF0aWMgaW50IGVmZmVjdGl2ZV9wcmlvKHRhc2tfdCAqcCkKIHsKIAlp
bnQgYm9udXMsIHByaW87Ci0JdW5zaWduZWQgbG9uZyBzbGVlcF9wZXJpb2Q7
CiAKIAlpZiAocnRfdGFzayhwKSkKIAkJcmV0dXJuIHAtPnByaW87CiAKLQlz
bGVlcF9wZXJpb2QgPSBqaWZmaWVzIC0gcC0+YXZnX3N0YXJ0OwotCi0JaWYg
KHVubGlrZWx5KCFzbGVlcF9wZXJpb2QpKQotCQlyZXR1cm4gcC0+c3RhdGlj
X3ByaW87Ci0KLQlpZiAoc2xlZXBfcGVyaW9kID4gTUFYX1NMRUVQX0FWRykK
LQkJc2xlZXBfcGVyaW9kID0gTUFYX1NMRUVQX0FWRzsKLQotCWlmIChwLT5z
bGVlcF9hdmcgPiBzbGVlcF9wZXJpb2QpCi0JCXNsZWVwX3BlcmlvZCA9IHAt
PnNsZWVwX2F2ZzsKLQotCS8qCi0JICogVGhlIGJvbnVzIGlzIGRldGVybWlu
ZWQgYWNjb3JkaW5nIHRvIHRoZSBhY2N1bXVsYXRlZAotCSAqIHNsZWVwIGF2
ZyBvdmVyIHRoZSBkdXJhdGlvbiB0aGUgdGFzayBoYXMgYmVlbiBydW5uaW5n
Ci0JICogdW50aWwgaXQgcmVhY2hlcyBNQVhfU0xFRVBfQVZHLiAtY2sKLQkg
Ki8KLQlib251cyA9IE1BWF9VU0VSX1BSSU8qUFJJT19CT05VU19SQVRJTypw
LT5zbGVlcF9hdmcvc2xlZXBfcGVyaW9kLzEwMCAtCisJYm9udXMgPSBNQVhf
VVNFUl9QUklPKlBSSU9fQk9OVVNfUkFUSU8qcC0+c2xlZXBfYXZnL01BWF9T
TEVFUF9BVkcvMTAwIC0KIAkJCU1BWF9VU0VSX1BSSU8qUFJJT19CT05VU19S
QVRJTy8xMDAvMjsKIAogCXByaW8gPSBwLT5zdGF0aWNfcHJpbyAtIGJvbnVz
OwpAQCAtMzg2LDEwICszNDcsMTAgQEAKICAqLwogc3RhdGljIGlubGluZSB2
b2lkIGFjdGl2YXRlX3Rhc2sodGFza190ICpwLCBydW5xdWV1ZV90ICpycSkK
IHsKLQlsb25nIHNsZWVwX3RpbWUgPSBqaWZmaWVzIC0gcC0+bGFzdF9ydW4g
LSAxOworCWxvbmcgc2xlZXBfdGltZSA9IGppZmZpZXMgLSBwLT5sYXN0X3J1
bjsKIAotCWlmIChzbGVlcF90aW1lID4gMCkgewotCQl1bnNpZ25lZCBsb25n
IHJ1bnRpbWUgPSBqaWZmaWVzIC0gcC0+YXZnX3N0YXJ0OworCWlmIChzbGVl
cF90aW1lKSB7CisJCWludCBzbGVlcF9hdmc7CiAKIAkJLyoKIAkJICogVGhp
cyBjb2RlIGdpdmVzIGEgYm9udXMgdG8gaW50ZXJhY3RpdmUgdGFza3MuCkBA
IC0zOTksMzQgKzM2MCwxNSBAQAogCQkgKiBzcGVuZHMgc2xlZXBpbmcsIHRo
ZSBoaWdoZXIgdGhlIGF2ZXJhZ2UgZ2V0cyAtIGFuZCB0aGUKIAkJICogaGln
aGVyIHRoZSBwcmlvcml0eSBib29zdCBnZXRzIGFzIHdlbGwuCiAJCSAqLwot
CQlwLT5zbGVlcF9hdmcgKz0gc2xlZXBfdGltZTsKLQkJLyoKLQkJICogR2l2
ZSBhIGJvbnVzIHRvIHRhc2tzIHRoYXQgd2FrZSBlYXJseSBvbiB0byBwcmV2
ZW50Ci0JCSAqIHRoZSBwcm9ibGVtIG9mIHRoZSBkZW5vbWluYXRvciBpbiB0
aGUgYm9udXMgZXF1YXRpb24KLQkJICogZnJvbSBjb250aW51YWxseSBnZXR0
aW5nIGxhcmdlci4KLQkJICovCi0JCWlmIChydW50aW1lIDwgTUFYX1NMRUVQ
X0FWRykKLQkJCXAtPnNsZWVwX2F2ZyArPSAocnVudGltZSAtIHAtPnNsZWVw
X2F2ZykgKiAoTUFYX1NMRUVQX0FWRyAtIHJ1bnRpbWUpICoKLQkJCQkoTUFY
X0JPTlVTIC0gSU5URVJBQ1RJVkVfREVMVEEpIC8gTUFYX0JPTlVTIC8gTUFY
X1NMRUVQX0FWRzsKLQotCQlpZiAocC0+c2xlZXBfYXZnID4gTUFYX1NMRUVQ
X0FWRykKLQkJCXAtPnNsZWVwX2F2ZyA9IE1BWF9TTEVFUF9BVkc7Ci0KLQkJ
LyoKLQkJICogVGFza3MgdGhhdCBzbGVlcCBhIGxvbmcgdGltZSBhcmUgY2F0
ZWdvcmlzZWQgYXMgaWRsZSBhbmQKLQkJICogZ2V0IHRoZWlyIHN0YXRpYyBw
cmlvcml0eSBvbmx5Ci0JCSAqLwotCQlpZiAoc2xlZXBfdGltZSA+IE1JTl9T
TEVFUF9BVkcpewotCQkJcC0+YXZnX3N0YXJ0ID0gamlmZmllcyAtIE1JTl9T
TEVFUF9BVkc7Ci0JCQlwLT5zbGVlcF9hdmcgPSBNSU5fU0xFRVBfQVZHIC8g
MjsKLQkJfQotCi0JCWlmICh1bmxpa2VseShwLT5hdmdfc3RhcnQgPiBqaWZm
aWVzKSl7Ci0JCQlwLT5hdmdfc3RhcnQgPSBqaWZmaWVzOwotCQkJcC0+c2xl
ZXBfYXZnID0gMDsKKwkJc2xlZXBfYXZnID0gcC0+c2xlZXBfYXZnICsgc2xl
ZXBfdGltZTsKKwkJaWYgKHNsZWVwX2F2ZyA+IE1BWF9TTEVFUF9BVkcpCisJ
CQlzbGVlcF9hdmcgPSBNQVhfU0xFRVBfQVZHOworCisJCWlmIChwLT5zbGVl
cF9hdmcgIT0gc2xlZXBfYXZnKSB7CisJCQlwLT5zbGVlcF9hdmcgPSBzbGVl
cF9hdmc7CisJCQlwLT5wcmlvID0gZWZmZWN0aXZlX3ByaW8ocCk7CiAJCX0K
IAl9Ci0JcC0+cHJpbyA9IGVmZmVjdGl2ZV9wcmlvKHApOwogCV9fYWN0aXZh
dGVfdGFzayhwLCBycSk7CiB9CiAKQEAgLTYwMyw3ICs1NDUsNiBAQAogCSAq
IGZyb20gZm9ya2luZyB0YXNrcyB0aGF0IGFyZSBtYXgtaW50ZXJhY3RpdmUu
CiAJICovCiAJY3VycmVudC0+c2xlZXBfYXZnID0gY3VycmVudC0+c2xlZXBf
YXZnICogUEFSRU5UX1BFTkFMVFkgLyAxMDA7Ci0Jbm9ybWFsaXNlX3NsZWVw
KHApOwogCXAtPnNsZWVwX2F2ZyA9IHAtPnNsZWVwX2F2ZyAqIENISUxEX1BF
TkFMVFkgLyAxMDA7CiAJcC0+cHJpbyA9IGVmZmVjdGl2ZV9wcmlvKHApOwog
CXNldF90YXNrX2NwdShwLCBzbXBfcHJvY2Vzc29yX2lkKCkpOwpAQCAtNjQ0
LDggKzU4NSw2IEBACiAJICogSWYgdGhlIGNoaWxkIHdhcyBhIChyZWxhdGl2
ZS0pIENQVSBob2cgdGhlbiBkZWNyZWFzZQogCSAqIHRoZSBzbGVlcF9hdmcg
b2YgdGhlIHBhcmVudCBhcyB3ZWxsLgogCSAqLwotCW5vcm1hbGlzZV9zbGVl
cChwKTsKLQlub3JtYWxpc2Vfc2xlZXAocC0+cGFyZW50KTsKIAlpZiAocC0+
c2xlZXBfYXZnIDwgcC0+cGFyZW50LT5zbGVlcF9hdmcpCiAJCXAtPnBhcmVu
dC0+c2xlZXBfYXZnID0gKHAtPnBhcmVudC0+c2xlZXBfYXZnICogRVhJVF9X
RUlHSFQgKwogCQkJcC0+c2xlZXBfYXZnKSAvIChFWElUX1dFSUdIVCArIDEp
Owo=
------------WVGaVv0VR1w13ys0oUll6n--


