Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbTGHT4i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267572AbTGHTzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:55:46 -0400
Received: from zeus.kernel.org ([204.152.189.113]:63386 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265297AbTGHTzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:55:19 -0400
From: Guillaume Chazarain <gfc@altern.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2003 22:12:31 +0200
X-Priority: 3 (Normal)
Message-Id: <JFNL84UTSKFOJFDFD9D8GBF2WICKG.3f0b25af@monpc>
Subject: [PATCH] Interactivity bits
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----------i44jPxOffw+HC6Kh0o4zzN"
X-Mailer: Opera 6.06 build 1145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------i44jPxOffw+HC6Kh0o4zzN
Content-Type: text/plain; charset="iso-8859-15"

Hello,

Currently the interactive points a process can have are in a [-5, 5] range,
that is, 25% of the [0, 39] range. Two reasons are mentionned:

1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
2) nice -20 CPU hogs do not get preempted by nice 0 tasks.

But, using 50% of the range, instead of 25% the interactivity points are better
spread and both rules are still respected.  Having a larger range for
interactivity points it's easier to choose between two interactive tasks.

So, why not changing PRIO_BONUS_RATIO to 50 instead of 25?
Actually it should be in the [45, 49] range to maximize the bonus points
range and satisfy both rules due to integer arithmetic.

Something like that:

--- linux-2.5.74-mm2-O3/kernel/sched.c  2003-07-07 18:46:29.000000000 +0200
+++ linux-2.5.74-mm2-O3/kernel/sched.c-bonus    2003-07-08 15:27:12.000000000 +0200
@@ -71,7 +71,7 @@
 #define CHILD_PENALTY		80
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
+#define PRIO_BONUS_RATIO	45
 #define INTERACTIVE_DELTA	2
 #define MIN_SLEEP_AVG		(HZ)
 #define MAX_SLEEP_AVG		(10*HZ)
@@ -90,13 +90,13 @@
  * We scale it linearly, offset by the INTERACTIVE_DELTA delta.
  * Here are a few examples of different nice levels:
  *
- *  TASK_INTERACTIVE(-20): [1,1,1,1,1,1,1,1,1,0,0]
- *  TASK_INTERACTIVE(-10): [1,1,1,1,1,1,1,0,0,0,0]
- *  TASK_INTERACTIVE(  0): [1,1,1,1,0,0,0,0,0,0,0]
- *  TASK_INTERACTIVE( 10): [1,1,0,0,0,0,0,0,0,0,0]
- *  TASK_INTERACTIVE( 19): [0,0,0,0,0,0,0,0,0,0,0]
+ *  TASK_INTERACTIVE(-20): [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0]
+ *  TASK_INTERACTIVE(-10): [1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0]
+ *  TASK_INTERACTIVE(  0): [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0]
+ *  TASK_INTERACTIVE( 10): [1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
+ *  TASK_INTERACTIVE( 19): [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
  *
- * (the X axis represents the possible -5 ... 0 ... +5 dynamic
+ * (the X axis represents the possible -9 ... 0 ... +9 dynamic
  *  priority range a task can explore, a value of '1' means the
  *  task is rated interactive.)
  *
@@ -325,9 +325,9 @@
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



And if you want to try other values for PRIO_BONUS_RATIO, I attached a simple
hack to generate the infos in the above comment.



Another thing that I was wondering is: should every absence on the runqueue be
considered interactive bonus?  For example, TASK_UNINTERRIBLE tasks receive
bonus when they wake up.  This implies that when a CPU hog becomes a memory hog
and starts swapping, it is considered interactive.  OTOH when a task is swapping
I would like it to consume its data the earliest possible, to avoid losing the
swapping benefit.
So I'd like to know if the patch below is a good or bad thing.

--- linux-2.5.74-mm2-O3/kernel/sched.c  2003-07-07 18:46:29.000000000 +0200
+++ linux-2.5.74-mm2-O3/kernel/sched.c-INTERR   2003-07-08 17:43:59.000000000 +0200
@@ -388,7 +388,7 @@ static inline void activate_task(task_t 
 {
	long sleep_time = jiffies - p->last_run - 1;
 
-	if (sleep_time > 0) {
+	if (sleep_time > 0 && p->state == TASK_INTERRUPTIBLE) {
		unsigned long runtime = jiffies - p->avg_start;
 
		/*




Thanks for your wisdom.
Guillaume


------------i44jPxOffw+HC6Kh0o4zzN
Content-Disposition: attachment;
	filename="testbonus.c"
Content-Type: application/octet-stream
Content-Transfer-Encoding: Base64

I2luY2x1ZGUgPHN0ZGlvLmg+CgovKiBzY2hlZC5oICovCiNkZWZpbmUgTUFY
X1VTRVJfUlRfUFJJTyAgICAgICAgMTAwCiNkZWZpbmUgTUFYX1JUX1BSSU8g
ICAgICAgICAgICAgTUFYX1VTRVJfUlRfUFJJTwojZGVmaW5lIE1BWF9QUklP
ICAgICAgICAgICAgICAgIChNQVhfUlRfUFJJTyArIDQwKQoKLyogc2NoZWQu
YyAqLwojZGVmaW5lIE5JQ0VfVE9fUFJJTyhuaWNlKSAgICAgIChNQVhfUlRf
UFJJTyArIChuaWNlKSArIDIwKQojZGVmaW5lIFBSSU9fVE9fTklDRShwcmlv
KSAgICAgICgocHJpbykgLSBNQVhfUlRfUFJJTyAtIDIwKQojZGVmaW5lIFRB
U0tfTklDRShwKSAgICAgICAgICAgIFBSSU9fVE9fTklDRSgocCktPnN0YXRp
Y19wcmlvKQoKI2RlZmluZSBVU0VSX1BSSU8ocCkgICAgICAgICAgICAoKHAp
LU1BWF9SVF9QUklPKQojZGVmaW5lIE1BWF9VU0VSX1BSSU8gICAgICAgICAg
IChVU0VSX1BSSU8oTUFYX1BSSU8pKQoKI2RlZmluZSBQUklPX0JPTlVTX1JB
VElPICAgICAgICA0NSAgICAgIC8qIEJldHdlZW4gNDUgYW5kIDQ5ICovCiNk
ZWZpbmUgSU5URVJBQ1RJVkVfREVMVEEgICAgICAgMgoKI2RlZmluZSBTQ0FM
RSh2MSx2MV9tYXgsdjJfbWF4KSBcCiAgICAgICAgKHYxKSAqICh2Ml9tYXgp
IC8gKHYxX21heCkKCiNkZWZpbmUgREVMVEEocCkgXAogICAgICAgIChTQ0FM
RShUQVNLX05JQ0UocCksIDQwLCBNQVhfVVNFUl9QUklPKlBSSU9fQk9OVVNf
UkFUSU8vMTAwKSArIFwKICAgICAgICAgICAgICAgIElOVEVSQUNUSVZFX0RF
TFRBKQoKI2RlZmluZSBUQVNLX0lOVEVSQUNUSVZFKHApIFwKICAgICAgICAo
KHApLT5wcmlvIDw9IChwKS0+c3RhdGljX3ByaW8gLSBERUxUQShwKSkKCi8q
KioqKioqKioqKioqKioqKi8KCiNkZWZpbmUgTUFYX0JPTlVTIChNQVhfVVNF
Ul9QUklPICogUFJJT19CT05VU19SQVRJTyAvIDEwMCAvIDIpCiNkZWZpbmUg
TUlOX0JPTlVTICgtTUFYX0JPTlVTKQoKdHlwZWRlZiBzdHJ1Y3QgewogICAg
aW50IHN0YXRpY19wcmlvOwogICAgaW50IHByaW87Cn0gbWluaV90YXNrX3Q7
CgpzdGF0aWMgdm9pZCB3cml0ZV92YWx1ZXMoaW50IG5pY2UpCnsKICAgIGlu
dCBib251czsKICAgIG1pbmlfdGFza190IHA7CgogICAgcC5zdGF0aWNfcHJp
byA9IE5JQ0VfVE9fUFJJTyhuaWNlKTsKICAgIHAucHJpbyA9IHAuc3RhdGlj
X3ByaW8gKyBNSU5fQk9OVVM7CgogICAgcHJpbnRmKCJUQVNLX0lOVEVSQUNU
SVZFKCUzZCk6IFslZCIsIG5pY2UsIFRBU0tfSU5URVJBQ1RJVkUoJnApKTsK
CiAgICBmb3IgKGJvbnVzID0gTUlOX0JPTlVTICsgMTsgYm9udXMgPD0gTUFY
X0JPTlVTOyBib251cysrKSB7CiAgICAgICAgcC5wcmlvID0gcC5zdGF0aWNf
cHJpbyArIGJvbnVzOwogICAgICAgIHByaW50ZigiLCVkIiwgVEFTS19JTlRF
UkFDVElWRSgmcCkpOwogICAgfQoKICAgIHB1dHMoIl0iKTsKfQoKaW50IG1h
aW4odm9pZCkKewogICAgcHJpbnRmKCJJbnRlcmFjdGl2aXR5IGJvbnVzIGJl
dHdlZW4gJWQgYW5kICVkXG5cbiIsIE1JTl9CT05VUywgTUFYX0JPTlVTKTsK
CiAgICB3cml0ZV92YWx1ZXMoLTIwKTsKICAgIHdyaXRlX3ZhbHVlcygtMTAp
OwogICAgd3JpdGVfdmFsdWVzKDApOwogICAgd3JpdGVfdmFsdWVzKDEwKTsK
ICAgIHdyaXRlX3ZhbHVlcygxOSk7CgogICAgcHV0cygiIik7CiAgICBwcmlu
dGYoIm5pY2UgKzE5IGludGVyYWN0aXZlIHRhc2tzIDogJWRcbiIsIE5JQ0Vf
VE9fUFJJTygxOSkgLSBNQVhfQk9OVVMpOwogICAgcHJpbnRmKCJuaWNlIDAg
Q1BVIGhvZ3MgOiAlZFxuIiwgTklDRV9UT19QUklPKDApIC0gTUlOX0JPTlVT
KTsKCiAgICBwdXRzKCIiKTsKICAgIHByaW50ZigibmljZSAtMjAgQ1BVIGhv
Z3MgOiAlZFxuIiwgTklDRV9UT19QUklPKC0yMCkgLSBNSU5fQk9OVVMpOwog
ICAgcHJpbnRmKCJuaWNlIDAgaW50ZXJhY3RpdmUgdGFza3MgOiAlZFxuIiwg
TklDRV9UT19QUklPKDApIC0gTUFYX0JPTlVTKTsKCiAgICByZXR1cm4gMDsK
fQo=
------------i44jPxOffw+HC6Kh0o4zzN--


