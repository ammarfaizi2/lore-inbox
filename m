Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWAILLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWAILLw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 06:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWAILLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 06:11:52 -0500
Received: from mail.gmx.de ([213.165.64.21]:56285 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932217AbWAILLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 06:11:51 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060109112238.00be96f8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 09 Jan 2006 12:11:31 +0100
To: Paolo Ornati <ornati@fastwebnet.it>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <5.2.1.1.2.20060102092903.00bde090@pop.gmx.net>
References: <20060101123902.27a10798@localhost>
 <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
 <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
 <200512281027.00252.kernel@kolivas.org>
 <20051227190918.65c2abac@localhost>
 <20051227224846.6edcff88@localhost>
 <200512281027.00252.kernel@kolivas.org>
 <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
 <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_17772421==_"
X-Antivirus: avast! (VPS 0601-0, 01/02/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_17772421==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 10:15 AM 1/2/2006 +0100, Mike Galbraith wrote:
>At 12:39 PM 1/1/2006 +0100, Paolo Ornati wrote:
>>On Sat, 31 Dec 2005 17:37:11 +0100
>>Mike Galbraith <efault@gmx.de> wrote:
>>
>> > Strange.  Using the exact same arguments, I do see some odd bouncing up to
>> > high priorities, but they spend the vast majority of their time down 
>> at 25.
>>
>>Mmmm... to make it more easly reproducible I've enlarged the sleep time
>>(1 microsecond is likely to be rounded too much and give different
>>results on different hardware/kernel/config...).
>>
>>Compile this _without_ optimizations and try again:
>
><snip>
>
>>Try different values: 1000, 2000, 3000 ... are you able to reproduce it
>>now?
>
>Yeah.  One instance running has to sustain roughly _95%_ cpu before it's 
>classified as a cpu piggy.  Not good.
>
>>If yes, try to start 2 of them with something like this:
>>
>>"./a.out 3000 & ./a.out 3161"
>>
>>so they are NOT syncronized and they use almost all the CPU time:
>>
>>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>>  5582 paolo     16   0  2396  320  252 S 45.7  0.1   0:05.52 a.out
>>  5583 paolo     15   0  2392  320  252 S 45.7  0.1   0:05.49 a.out
>>
>>This is the bad situation I hate: some cpu-eaters that eat all the CPU
>>time BUT have a really good priority only because they sleeps a bit.
>
>Yup, your proggy fools the interactivity estimator quite well.  This 
>problem was addressed a long time ago, and thought to be more or less 
>cured.  Guess not.

Care to try an experiment?  I'd be very interested in knowing if the 
attached patch cures the real-life problem you were investigating.

It attempts to catch tasks which the interactivity logic has misidentified, 
and "pull their plug".  It maintains a running plausibility check 
(slice_avg) against sleep_avg, and if a sustained disparity appears, cuts 
off a cpu burning task's supply of bonus points such that it has to "run on 
battery" until the disparity decreases to within acceptable limits.

Obviously, anything that affects fairness _will_ affect interactivity to 
some degree. This simple bolt-on throttle has delayed initiation and 
accelerated release in the hopes of keeping it's impact acceptable.  After 
some initial testing, It doesn't _seem_ to suck.

         -Mike 
--=====================_17772421==_
Content-Type: application/octet-stream; name="sched_throttle"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sched_throttle"

LS0tIGluY2x1ZGUvbGludXgvc2NoZWQuaC5vcmcJVHVlIEphbiAgMyAwOToyNjo1MCAyMDA2Cisr
KyBpbmNsdWRlL2xpbnV4L3NjaGVkLmgJU2F0IEphbiAgNyAxNDo0NTozNyAyMDA2CkBAIC03MDEs
OCArNzAxLDggQEAKIAogCXVuc2lnbmVkIHNob3J0IGlvcHJpbzsKIAotCXVuc2lnbmVkIGxvbmcg
c2xlZXBfYXZnOwotCXVuc2lnbmVkIGxvbmcgbG9uZyB0aW1lc3RhbXAsIGxhc3RfcmFuOworCXVu
c2lnbmVkIGxvbmcgc2xlZXBfYXZnLCBzbGljZV9hdmc7CisJdW5zaWduZWQgbG9uZyBsb25nIHRp
bWVzdGFtcCwgbGFzdF9yYW4sIGxhc3Rfc2xpY2U7CiAJdW5zaWduZWQgbG9uZyBsb25nIHNjaGVk
X3RpbWU7IC8qIHNjaGVkX2Nsb2NrIHRpbWUgc3BlbnQgcnVubmluZyAqLwogCWludCBhY3RpdmF0
ZWQ7CiAKLS0tIGxpbnV4LTIuNi4xNS9rZXJuZWwvc2NoZWQuYy5vcmcJU2F0IEphbiAgNyAxNjoy
MjoxMyAyMDA2CisrKyBsaW51eC0yLjYuMTUva2VybmVsL3NjaGVkLmMJTW9uIEphbiAgOSAxMTo1
MDo0MCAyMDA2CkBAIC00Nyw2ICs0Nyw3IEBACiAjaW5jbHVkZSA8bGludXgvc3lzY2FsbHMuaD4K
ICNpbmNsdWRlIDxsaW51eC90aW1lcy5oPgogI2luY2x1ZGUgPGxpbnV4L2FjY3QuaD4KKyNpbmNs
dWRlIDxsaW51eC9qaWZmaWVzLmg+CiAjaW5jbHVkZSA8YXNtL3RsYi5oPgogCiAjaW5jbHVkZSA8
YXNtL3VuaXN0ZC5oPgpAQCAtMTM1Myw3ICsxMzU0LDcgQEAKIAogb3V0X2FjdGl2YXRlOgogI2Vu
ZGlmIC8qIENPTkZJR19TTVAgKi8KLQlpZiAob2xkX3N0YXRlID09IFRBU0tfVU5JTlRFUlJVUFRJ
QkxFKSB7CisJaWYgKG9sZF9zdGF0ZSAmIFRBU0tfVU5JTlRFUlJVUFRJQkxFKSB7CiAJCXJxLT5u
cl91bmludGVycnVwdGlibGUtLTsKIAkJLyoKIAkJICogVGFza3Mgb24gaW52b2x1bnRhcnkgc2xl
ZXAgZG9uJ3QgZWFybgpAQCAtMTQ5Miw2ICsxNDkzLDggQEAKIAkgKi8KIAlwLT5zbGVlcF9hdmcg
PSBKSUZGSUVTX1RPX05TKENVUlJFTlRfQk9OVVMocCkgKgogCQlDSElMRF9QRU5BTFRZIC8gMTAw
ICogTUFYX1NMRUVQX0FWRyAvIE1BWF9CT05VUyk7CisJcC0+c2xpY2VfYXZnID0gTlNfTUFYX1NM
RUVQX0FWRzsKKwlwLT5sYXN0X3NsaWNlID0gc2NoZWRfY2xvY2soKTsKIAogCXAtPnByaW8gPSBl
ZmZlY3RpdmVfcHJpbyhwKTsKIApAQCAtMjY0Niw2ICsyNjQ5LDEyIEBACiAJcnVucXVldWVfdCAq
cnEgPSB0aGlzX3JxKCk7CiAJdGFza190ICpwID0gY3VycmVudDsKIAl1bnNpZ25lZCBsb25nIGxv
bmcgbm93ID0gc2NoZWRfY2xvY2soKTsKKyNpZiAxCisJc3RhdGljIHVuc2lnbmVkIGxvbmcgcHJp
bnRtZSA9IDA7CisKKwlpZiAodW5saWtlbHkoIXByaW50bWUpKQorCQlwcmludG1lID0gamlmZmll
czsKKyNlbmRpZgogCiAJdXBkYXRlX2NwdV9jbG9jayhwLCBycSwgbm93KTsKIApAQCAtMjY3OSw2
ICsyNjg4LDcgQEAKIAkJaWYgKChwLT5wb2xpY3kgPT0gU0NIRURfUlIpICYmICEtLXAtPnRpbWVf
c2xpY2UpIHsKIAkJCXAtPnRpbWVfc2xpY2UgPSB0YXNrX3RpbWVzbGljZShwKTsKIAkJCXAtPmZp
cnN0X3RpbWVfc2xpY2UgPSAwOworCQkJcC0+bGFzdF9zbGljZSA9IG5vdzsKIAkJCXNldF90c2tf
bmVlZF9yZXNjaGVkKHApOwogCiAJCQkvKiBwdXQgaXQgYXQgdGhlIGVuZCBvZiB0aGUgcXVldWU6
ICovCkBAIC0yNjg3LDEyICsyNjk3LDQwIEBACiAJCWdvdG8gb3V0X3VubG9jazsKIAl9CiAJaWYg
KCEtLXAtPnRpbWVfc2xpY2UpIHsKKwkJdW5zaWduZWQgbG9uZyBsb25nIG5zZWNzID0gbm93IC0g
cC0+bGFzdF9zbGljZTsKKwkJdW5zaWduZWQgbG9uZyBpZGxlLCB0aWNrczsKKwkJaW50IHcgPSAx
MDsKKwogCQlkZXF1ZXVlX3Rhc2socCwgcnEtPmFjdGl2ZSk7CiAJCXNldF90c2tfbmVlZF9yZXNj
aGVkKHApOwogCQlwLT5wcmlvID0gZWZmZWN0aXZlX3ByaW8ocCk7CiAJCXAtPnRpbWVfc2xpY2Ug
PSB0YXNrX3RpbWVzbGljZShwKTsKIAkJcC0+Zmlyc3RfdGltZV9zbGljZSA9IDA7CiAKKwkJaWYg
KG5zZWNzID4gfjBVTCkKKwkJCW5zZWNzID0gfjBVTDsKKwkJdGlja3MgPSBOU19UT19KSUZGSUVT
KCh1bnNpZ25lZCBsb25nKSBuc2Vjcyk7CisJCWlmICh0aWNrcyA8IHAtPnRpbWVfc2xpY2UpCisJ
CQl0aWNrcyA9IHAtPnRpbWVfc2xpY2U7CisJCWlkbGUgPSAxMDAgLSAoMTAwICogcC0+dGltZV9z
bGljZSAvIHRpY2tzKTsKKwkJcC0+c2xpY2VfYXZnIC89IE5TX01BWF9TTEVFUF9BVkcgLyAxMDA7
CisJCS8qCisJCSAqIElmIHdlJ3JlIGltcHJvdmluZyBvdXIgYmVoYXZpb3VyLCBzcGVlZCB1cCB0
aGUgaW1wcm92ZW1lbnQncworCQkgKiBlZmZlY3Qgc28gd2UgZG9uJ3Qgb3ZlciB0aHJvdHRsZS4K
KwkJICovCisJCWlmIChpZGxlID4gcC0+c2xpY2VfYXZnICsgMTApCisJCQl3IC09ICgxMDAgKiBw
LT5zbGljZV9hdmcgLyBpZGxlKSAvIDEwOworCQlwLT5zbGljZV9hdmcgPSAodyAqIHAtPnNsaWNl
X2F2ZyArIGlkbGUpIC8gKHcgKyAxKTsKKwkJcC0+c2xpY2VfYXZnICo9IE5TX01BWF9TTEVFUF9B
VkcgLyAxMDA7CisJCXAtPmxhc3Rfc2xpY2UgPSBub3c7CisjaWYgMQorCQlpZiAocC0+bW0gJiYg
dGltZV9hZnRlcihqaWZmaWVzLCBwcmludG1lICsgSFopKSB7CisJCQlwcmludGsoS0VSTl9ERUJV
RyIlcyBwaWQ6JWQgc2xlOiVsZCBzbGk6JWxkIHRpYzolbGQgaWRsZTolbGQgdzolZFxuIiwKKwkJ
CQlwLT5jb21tLHAtPnBpZCxwLT5zbGVlcF9hdmcscC0+c2xpY2VfYXZnLHRpY2tzLGlkbGUsdyk7
CisJCQlwcmludG1lID0gIGppZmZpZXMgKyBIWjsKKwl9CisjZW5kaWYKKwogCQlpZiAoIXJxLT5l
eHBpcmVkX3RpbWVzdGFtcCkKIAkJCXJxLT5leHBpcmVkX3RpbWVzdGFtcCA9IGppZmZpZXM7CiAJ
CWlmICghVEFTS19JTlRFUkFDVElWRShwKSB8fCBFWFBJUkVEX1NUQVJWSU5HKHJxKSkgewpAQCAt
MzAxMCw3ICszMDQ4LDcgQEAKIAkJCQl1bmxpa2VseShzaWduYWxfcGVuZGluZyhwcmV2KSkpKQog
CQkJcHJldi0+c3RhdGUgPSBUQVNLX1JVTk5JTkc7CiAJCWVsc2UgewotCQkJaWYgKHByZXYtPnN0
YXRlID09IFRBU0tfVU5JTlRFUlJVUFRJQkxFKQorCQkJaWYgKHByZXYtPnN0YXRlICYgVEFTS19V
TklOVEVSUlVQVElCTEUpCiAJCQkJcnEtPm5yX3VuaW50ZXJydXB0aWJsZSsrOwogCQkJZGVhY3Rp
dmF0ZV90YXNrKHByZXYsIHJxKTsKIAkJfQpAQCAtMzA5NSw2ICszMTMzLDEzIEBACiAJcHJldi0+
c2xlZXBfYXZnIC09IHJ1bl90aW1lOwogCWlmICgobG9uZylwcmV2LT5zbGVlcF9hdmcgPD0gMCkK
IAkJcHJldi0+c2xlZXBfYXZnID0gMDsKKwlpZiAocHJldi0+c3RhdGUgJiAoVEFTS19JTlRFUlJV
UFRJQkxFfFRBU0tfVU5JTlRFUlJVUFRJQkxFKSAmJgorCQkJcHJldi0+c2xlZXBfYXZnID4gcHJl
di0+c2xpY2VfYXZnICsgKE5TX01BWF9TTEVFUF9BVkcvMTApICYmCisJCQkhcnRfdGFzayhwcmV2
KSkKKwkJcHJldi0+c3RhdGUgfD0gVEFTS19OT05JTlRFUkFDVElWRTsKKwlpZiAoIXJ0X3Rhc2so
bmV4dCkgJiYgIShuZXh0LT50aW1lX3NsaWNlICUgREVGX1RJTUVTTElDRSkpCisJCW5leHQtPmxh
c3Rfc2xpY2UgPSBub3c7CisKIAlwcmV2LT50aW1lc3RhbXAgPSBwcmV2LT5sYXN0X3JhbiA9IG5v
dzsKIAogCXNjaGVkX2luZm9fc3dpdGNoKHByZXYsIG5leHQpOwo=
--=====================_17772421==_--

