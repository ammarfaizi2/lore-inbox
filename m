Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWAPWJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWAPWJy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWAPWJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:09:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65510 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751221AbWAPWJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:09:53 -0500
Date: Mon, 16 Jan 2006 17:17:55 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: mingo@elte.hu
cc: linux-kernel@vger.kernel.org, drepper@redhat.com, Tony.Reix@bull.net
Subject: [2.6 patch] fix sched_setscheduler semantics
Message-ID: <Pine.LNX.4.61.0601161650540.21530@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279734611-99286315-1137449875=:21530"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--279734611-99286315-1137449875=:21530
Content-Type: TEXT/PLAIN; charset=US-ASCII


hi,

Currently, a negative policy argument passed into the 
'sys_sched_setscheduler()' system call, will return with success.  
However, the manpage for 'sys_sched_setscheduler' says:

EINVAL The scheduling policy is not one of the recognized policies, or the
              parameter p does not make sense for the policy.

'sys_sched_setscheduler()' is implemented as a wrapper around 
'sched_setscheduler()', which treats negative values as 'use current 
policy'. This is used to implement sys_sched_setparam(), see:

asmlinkage long sys_sched_setparam(pid_t pid, struct sched_param __user 
*param)
{
        return do_sched_setscheduler(pid, -1, param);
}


Therefore, i'd suggest the following patch. Verified to fix the attached 
test case. Thanks to Tony Reix for pointing this out.

-Jason



Signed-off-by: Jason Baron <jbaron@redhat.com

 sched.c |    4 ++++
 1 files changed, 4 insertions(+)

--- linux-2.6/kernel/sched.c.bak	2006-01-16 15:55:16.000000000 -0500
+++ linux-2.6/kernel/sched.c	2006-01-16 15:56:23.000000000 -0500
@@ -3824,6 +3824,10 @@ do_sched_setscheduler(pid_t pid, int pol
 asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
 				       struct sched_param __user *param)
 {
+	/* negative values for policy are not valid */
+	if (policy < 0)
+		return -EINVAL;
+
 	return do_sched_setscheduler(pid, policy, param);
 }
 
--279734611-99286315-1137449875=:21530
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="19-5.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0601161717550.21530@dhcp83-105.boston.redhat.com>
Content-Description: setscheduler test
Content-Disposition: attachment; filename="19-5.c"

LyogDQogKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBj
YW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCiAqICBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IHZlcnNpb24gMi4NCiAqDQogKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1
dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQogKiAg
YnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGlt
cGxpZWQgd2FycmFudHkgb2YNCiAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklU
TkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlDQogKiAg
R05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4N
CiAqDQogKg0KICogVGVzdCB0aGF0IHNjaGVkX3NldHNjaGVkdWxlcigpIHNl
dHMgZXJybm8gPT0gRUlOVkFMIHdoZW4gdGhlIHBvbGljeSB2YWx1ZSBpcw0K
ICogbm90IGRlZmluZWQgaW4gdGhlIHNjaGVkLmggaGVhZGVyLg0KICoNCiAq
IEFzc3VtZSB0aGF0IHRoZSBoZWFkZXIgZG9lcyBub3QgZGVmaW5lZCBhIHNj
aGVkdWxpbmcgcG9saWN5IHdpdGggYSB2YWx1ZQ0KICogb2YgLTEuIChJdCBp
cyBtb3JlIGNvaGVyZW50IHdpdGggdGhlIHNwZWNpZmljYXRpb25TIG9mIHNj
aGVkX2dldHNjaGVkdWxlcg0KICogYW5kIHNjaGVkX3NldHNjaGVkdWxlciBm
b3Igd2hpY2ggdGhlIHJlc3VsdCBjb2RlIC0xIGluZGljYXRlIGFuIGVycm9y
LikNCiAqIElmIG5vIGVycm9yIG9jY3VycyB3aGl0aCAtMSwgdGhlIHRlc3Qg
d2lsbCBydW4gc2NoZWRfc2V0c2NoZWR1bGVyIHdpdGggdGhlDQogKiB2ZXJ5
IGltcHJvYmFibGUgcG9saWN5IHZhbHVlIElOVkFMSURfUE9MSUNZLg0KICov
DQojaW5jbHVkZSA8c2NoZWQuaD4NCiNpbmNsdWRlIDxzdGRpby5oPg0KI2lu
Y2x1ZGUgPGVycm5vLmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5jbHVk
ZSAicG9zaXh0ZXN0LmgiDQoNCg0KLyogVGhlcmUgaXMgbm8gY2hhbmNlIHRo
YXQgYSBzY2hlZHVsaW5nIHBvbGljeSBoYXMgc3VjaCBhIHZhbHVlICovDQoj
ZGVmaW5lIElOVkFMSURfUE9MSUNZIC0yNzM2Nw0KDQppbnQgbWFpbigpew0K
CWludCByZXN1bHQ7DQoJc3RydWN0IHNjaGVkX3BhcmFtIHBhcmFtOw0KDQoJ
cGFyYW0uc2NoZWRfcHJpb3JpdHkgPSAwOw0KDQoJcmVzdWx0ID0gc2NoZWRf
c2V0c2NoZWR1bGVyKDAsIC0xLCAmcGFyYW0pOw0KDQoJaWYocmVzdWx0ID09
IC0xICYmIGVycm5vID09IEVJTlZBTCl7DQoJCXByaW50ZigiVGVzdCBQQVNT
RURcbiIpOw0KCQlyZXR1cm4gUFRTX1BBU1M7DQoJfSBlbHNlIGlmKGVycm5v
ID09IEVQRVJNKXsNCgkJcHJpbnRmKCJUaGlzIHByb2Nlc3MgZG9lcyBub3Qg
aGF2ZSB0aGUgcGVybWlzc2lvbiB0byBzZXQgaXRzIG93biBzY2hlZHVsaW5n
IHBvbGljeS5cblRyeSB0byBsYXVuY2ggdGhpcyB0ZXN0IGFzIHJvb3QuXG4i
KTsNCgkJcmV0dXJuIFBUU19VTlJFU09MVkVEOw0KCX0gZWxzZSBpZihlcnJu
byA9PSAwKSB7DQoJCXByaW50ZigiTm8gZXJyb3Igb2NjdXJzLCBjaGVjayBp
ZiAtMSBhIHZhbGlkIHZhbHVlIGZvciB0aGUgc2NoZWR1bGluZyBwb2xpY3ku
XG4iKTsNCgl9IGVsc2Ugew0KCQlwZXJyb3IoIlVua25vdyBlcnJvciIpOw0K
CQlyZXR1cm4gUFRTX0ZBSUw7DQoJfQ0KDQoJcHJpbnRmKCJUZXN0aW5nIHdp
dGggdmVyeSBpbXByb2JhYmxlIHBvbGljeSB2YWx1ZSAlaTpcbiIsDQoJICAg
ICAgIElOVkFMSURfUE9MSUNZKTsNCg0KCXJlc3VsdCA9IHNjaGVkX3NldHNj
aGVkdWxlcigwLCBJTlZBTElEX1BPTElDWSwgJnBhcmFtKTsNCg0KCWlmKHJl
c3VsdCA9PSAtMSAmJiBlcnJubyA9PSBFSU5WQUwpew0KCQlwcmludGYoIlRl
c3QgUEFTU0VEIHdpdGggcG9saWN5IHZhbHVlICVpXG4iLCBJTlZBTElEX1BP
TElDWSk7DQoJCXJldHVybiBQVFNfUEFTUzsgDQoJfSBlbHNlIGlmKGVycm5v
ID09IDApIHsNCgkJcHJpbnRmKCJObyBlcnJvciBvY2N1cnMsIGNvdWxkICVp
IGJlIGEgdmFsaWQgdmFsdWUgZm9yIHRoZSBzY2hlZHVsaW5nIHBvbGljeSA/
Pz9cbiIsIElOVkFMSURfUE9MSUNZKTsNCgkJcmV0dXJuIFBUU19VTlJFU09M
VkVEOw0KCX0gZWxzZSB7DQoJCXBlcnJvcigiVW5rbm93IGVycm9yIik7DQoJ
CXJldHVybiBQVFNfRkFJTDsNCgl9DQoNCg0KfQ0K

--279734611-99286315-1137449875=:21530--
