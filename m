Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVHaN7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVHaN7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVHaN7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:59:41 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:21667 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964815AbVHaN7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:59:40 -0400
Message-ID: <4315B74D.8020100@us.ibm.com>
Date: Wed, 31 Aug 2005 08:57:33 -0500
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: CFQ refcounting fix
References: <200508302241.j7UMf8ag018433@d01av03.pok.ibm.com> <20050831072830.GG4018@suse.de> <4315B366.5040906@us.ibm.com> <20050831134259.GW4018@suse.de>
In-Reply-To: <20050831134259.GW4018@suse.de>
Content-Type: multipart/mixed;
 boundary="------------030203090007040106080905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030203090007040106080905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
> On Wed, Aug 31 2005, Brian King wrote:
> 
>>Jens Axboe wrote:
>>
>>>On Tue, Aug 30 2005, brking@us.ibm.com wrote:
>>>
>>>
>>>>I ran across a memory leak related to the cfq scheduler. The cfq
>>>>init function increments the refcnt of the associated request_queue.
>>>>This refcount gets decremented in cfq's exit function. Since blk_cleanup_queue
>>>>only calls the elevator exit function when its refcnt goes to zero, the
>>>>request_q never gets cleaned up. It didn't look like other io schedulers were
>>>>incrementing this refcnt, so I removed the refcnt increment and it fixed the
>>>>memory leak for me.
>>>>
>>>>To reproduce the problem, simply use cfq and use the scsi_host scan sysfs
>>>>attribute to scan "- - -" repeatedly on a scsi host and watch the memory
>>>>vanish.
>>>
>>>
>>>Yeah, that actually looks like a dangling reference. I assume you tested
>>>this properly?
>>
>>Yes. I applied the patch, booted my system (which was crashing on
>>bootup before due to out of memory errors due to the leak) ran the
>>scan a few times and verified /proc/meminfo didn't continually
>>decrease like without it, and rebooted again.  If there is anything
>>else you would like me to do, I would be happy to do so.
> 
> 
> I think you need to remove the blk_put_queue() in cfq_put_cfqd() as
> well, otherwise I don't see how this can work without looking at freed
> memory. I'll audit the other paths as well.

Good catch. Here is an updated patch. 


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------030203090007040106080905
Content-Type: text/plain;
 name="cfq_refcnt_fix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cfq_refcnt_fix.patch"

CkkgcmFuIGFjcm9zcyBhIG1lbW9yeSBsZWFrIHJlbGF0ZWQgdG8gdGhlIGNmcSBzY2hlZHVs
ZXIuIFRoZSBjZnEKaW5pdCBmdW5jdGlvbiBpbmNyZW1lbnRzIHRoZSByZWZjbnQgb2YgdGhl
IGFzc29jaWF0ZWQgcmVxdWVzdF9xdWV1ZS4KVGhpcyByZWZjb3VudCBnZXRzIGRlY3JlbWVu
dGVkIGluIGNmcSdzIGV4aXQgZnVuY3Rpb24uIFNpbmNlIGJsa19jbGVhbnVwX3F1ZXVlCm9u
bHkgY2FsbHMgdGhlIGVsZXZhdG9yIGV4aXQgZnVuY3Rpb24gd2hlbiBpdHMgcmVmY250IGdv
ZXMgdG8gemVybywgdGhlCnJlcXVlc3RfcSBuZXZlciBnZXRzIGNsZWFuZWQgdXAuIEl0IGRp
ZG4ndCBsb29rIGxpa2Ugb3RoZXIgaW8gc2NoZWR1bGVycyB3ZXJlCmluY3JlbWVudGluZyB0
aGlzIHJlZmNudCwgc28gSSByZW1vdmVkIHRoZSByZWZjbnQgaW5jcmVtZW50IGFuZCBpdCBm
aXhlZCB0aGUKbWVtb3J5IGxlYWsgZm9yIG1lLgoKVG8gcmVwcm9kdWNlIHRoZSBwcm9ibGVt
LCBzaW1wbHkgdXNlIGNmcSBhbmQgdXNlIHRoZSBzY3NpX2hvc3Qgc2NhbiBzeXNmcwphdHRy
aWJ1dGUgdG8gc2NhbiAiLSAtIC0iIHJlcGVhdGVkbHkgb24gYSBzY3NpIGhvc3QgYW5kIHdh
dGNoIHRoZSBtZW1vcnkKdmFuaXNoLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gS2luZyA8YnJr
aW5nQHVzLmlibS5jb20+Ci0tLQoKIGxpbnV4LTIuNi1iamtpbmcxL2RyaXZlcnMvYmxvY2sv
Y2ZxLWlvc2NoZWQuYyB8ICAgIDMgLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDMgZGVsZXRpb25z
KC0pCgpkaWZmIC1wdU4gZHJpdmVycy9ibG9jay9jZnEtaW9zY2hlZC5jfmNmcV9yZWZjbnRf
Zml4IGRyaXZlcnMvYmxvY2svY2ZxLWlvc2NoZWQuYwotLS0gbGludXgtMi42L2RyaXZlcnMv
YmxvY2svY2ZxLWlvc2NoZWQuY35jZnFfcmVmY250X2ZpeAkyMDA1LTA4LTMwIDE3OjI2OjU1
LjAwMDAwMDAwMCAtMDUwMAorKysgbGludXgtMi42LWJqa2luZzEvZHJpdmVycy9ibG9jay9j
ZnEtaW9zY2hlZC5jCTIwMDUtMDgtMzEgMDg6NDg6MzAuMDAwMDAwMDAwIC0wNTAwCkBAIC0y
MjYwLDggKzIyNjAsNiBAQCBzdGF0aWMgdm9pZCBjZnFfcHV0X2NmcWQoc3RydWN0IGNmcV9k
YXRhCiAJaWYgKCFhdG9taWNfZGVjX2FuZF90ZXN0KCZjZnFkLT5yZWYpKQogCQlyZXR1cm47
CiAKLQlibGtfcHV0X3F1ZXVlKHEpOwotCiAJY2ZxX3NodXRkb3duX3RpbWVyX3dxKGNmcWQp
OwogCXEtPmVsZXZhdG9yLT5lbGV2YXRvcl9kYXRhID0gTlVMTDsKIApAQCAtMjMxOCw3ICsy
MzE2LDYgQEAgc3RhdGljIGludCBjZnFfaW5pdF9xdWV1ZShyZXF1ZXN0X3F1ZXVlXwogCWUt
PmVsZXZhdG9yX2RhdGEgPSBjZnFkOwogCiAJY2ZxZC0+cXVldWUgPSBxOwotCWF0b21pY19p
bmMoJnEtPnJlZmNudCk7CiAKIAljZnFkLT5tYXhfcXVldWVkID0gcS0+bnJfcmVxdWVzdHMg
LyA0OwogCXEtPm5yX2JhdGNoaW5nID0gY2ZxX3F1ZXVlZDsKXwo=
--------------030203090007040106080905--
