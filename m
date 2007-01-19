Return-Path: <linux-kernel-owner+w=401wt.eu-S964937AbXASIIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbXASIIy (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 03:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbXASIIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 03:08:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:18123 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964933AbXASIIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 03:08:53 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,209,1167638400"; 
   d="new'?scan'208"; a="37644456:sNHT51537375"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C73BA1.0C2B08A1"
Subject: [RFC] [PATCH] Power S3 Resume Optimization Patch. Request for Comment
Date: Fri, 19 Jan 2007 13:38:47 +0530
Message-ID: <5B3EF00AF56209498A59172917BFE8130165151B@bgsmsx412.gar.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] [PATCH] Power S3 Resume Optimization Patch. Request for Comment
Thread-Index: Acc62uB8VHIFRj0uQXS5HO+rm+q4FwAxMU8A
From: "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
To: <inux-pm@lists.osdl.org>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
X-OriginalArrivalTime: 19 Jan 2007 08:08:52.0088 (UTC) FILETIME=[0E68EF80:01C73BA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C73BA1.0C2B08A1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[RFC][PATCH] Power S3 Resume optimisation=20
	Here is a simple patch for optimising the S3 resume. With this
patch the resume time is 0.85. Given the fact that device initialisation
on the resume takes almost 70% of time, By executing the whole
"device_resume()" function on a seperate kernel thread, the resume gets
completed( ie. the user can precieve) by ~0.85 sec.
	To avoid any possible race condition while processing the IO
request and to make sure all the io request are queued till the device
resume thread exits, the IO schedulars (patched cfq and as) checks a for
system_resume flag, which is set when the device resume thread starts,
if the flag is set, it doesnt put the request in the dispatch queue.
Once the flag is cleared i.e when the device resume thread is complete,
the IO-schedular behave as in normal situation.
 I did some validation of this patch on a  NAPA board ( Calistoga
chipset with Dothan Processor with and Without SMP)locally here and
havent noticed any issue so far.  Please review and let me know what
your comments. This patch is against 2.6.18 kernel
thanks
-hari
signed-off-by: hari < harinarayanan.seshadri@intel.com>
-----------------------------------
diff -ruN ../test/linux-vanilla/block/as-iosched.c
linux-2.6.18/block/as-iosched.c---
../test/linux-vanilla/block/as-iosched.c    2007-01-10
13:51:33.000000000 +0530
+++ linux-2.6.18/block/as-iosched.c     2007-01-18 13:37:01.000000000
+0530
@@ -1088,6 +1088,19 @@
        if (list_empty(&ad->fifo_list[adir]))
                return 0;

+       /*
+        * Check here for the System resume flag to be cleared, if flag
is
+       *  still set the resume thread hasnt completed yet, and hence
dont
+       *  takeout any new request from the FIFO
+       */
+       extern int system_resuming;
+       if (system_resuming !=3D 0)
+       {
+#ifdef DEBUG
+               printk("  system resuming still \n");
+#endif
+               return 0;
+       }
        arq =3D list_entry_fifo(ad->fifo_list[adir].next);

        return time_after(jiffies, arq->expires);
diff -ruN ../test/linux-vanilla/block/cfq-iosched.c
linux-2.6.18/block/cfq-iosched.c
--- ../test/linux-vanilla/block/cfq-iosched.c   2007-01-11
07:59:33.000000000 +0530
+++ linux-2.6.18/block/cfq-iosched.c    2007-01-18 13:35:02.000000000
+0530
@@ -1156,6 +1156,19 @@
        if (!cfqd->busy_queues)
                return 0;

+       /*
+        * Check here for the System resume flag to be cleared, if flag
is s
+       *  still set the resume thread hasnt completed yet, and hence
dont
+       *  move any request from the read/write to dispatch queue
+       */
+       extern int system_resuming;
+       if (system_resuming !=3D 0)
+       {
+#ifdef DEBUG
+               printk("System resuming still \n");
+#endif
+               return 0;
+       }
        if (unlikely(force))
                return cfq_forced_dispatch(cfqd);

diff -ruN ../test/linux-vanilla/kernel/power/main.c
linux-2.6.18/kernel/power/main.c
--- ../test/linux-vanilla/kernel/power/main.c   2007-01-11
08:00:11.000000000 +0530
+++ linux-2.6.18/kernel/power/main.c    2007-01-18 13:31:56.000000000
+0530
@@ -19,6 +19,7 @@

 #include "power.h"

+int system_resuming;
 /*This is just an arbitrary number */
 #define FREE_PAGE_NUMBER (100)

@@ -131,9 +132,29 @@
  *     console that we've allocated. This is not called for
suspend-to-disk.
  */

-static void suspend_finish(suspend_state_t state)
+static int dev_resume_proc(void * data)
{
+       /* Set the global resume flag, this will be checked by the
IO_schedular
+       * before dispatching the IO request
+       */
+       system_resuming =3D1;
        device_resume();
+       system_resuming =3D 0;
+#ifdef DEBUG
+       printk(" reseting system_resume \n");
+#endif
+       return (0);
+}
+static void suspend_finish(suspend_state_t state)
+{
+       int thread;
+       system_resuming =3D 0;
+       thread =3D kernel_thread(dev_resume_proc,NULL,CLONE_KERNEL);
+       if (thread < 0)
+       {
+               printk ("Suspend resume Cannot create Kernel_thread\n");
+               device_resume();
+       }
        resume_console();
        thaw_processes();
        enable_nonboot_cpus();
--------------------------------------

------_=_NextPart_001_01C73BA1.0C2B08A1
Content-Type: application/octet-stream;
	name="s3.patch.new"
Content-Transfer-Encoding: base64
Content-Description: s3.patch.new
Content-Disposition: attachment;
	filename="s3.patch.new"

ZGlmZiAtcnVOIC4uL3Rlc3QvbGludXgtdmFuaWxsYS9ibG9jay9hcy1pb3NjaGVkLmMgbGludXgt
Mi42LjE4L2Jsb2NrL2FzLWlvc2NoZWQuYwotLS0gLi4vdGVzdC9saW51eC12YW5pbGxhL2Jsb2Nr
L2FzLWlvc2NoZWQuYwkyMDA3LTAxLTEwIDEzOjUxOjMzLjAwMDAwMDAwMCArMDUzMAorKysgbGlu
dXgtMi42LjE4L2Jsb2NrL2FzLWlvc2NoZWQuYwkyMDA3LTAxLTE4IDEzOjM3OjAxLjAwMDAwMDAw
MCArMDUzMApAQCAtMTA4OCw2ICsxMDg4LDE5IEBACiAJaWYgKGxpc3RfZW1wdHkoJmFkLT5maWZv
X2xpc3RbYWRpcl0pKQogCQlyZXR1cm4gMDsKIAorCS8qCisJICogQ2hlY2sgaGVyZSBmb3IgdGhl
IFN5c3RlbSByZXN1bWUgZmxhZyB0byBiZSBjbGVhcmVkLCBpZiBmbGFnIGlzIAorCSogIHN0aWxs
IHNldCB0aGUgcmVzdW1lIHRocmVhZCBoYXNudCBjb21wbGV0ZWQgeWV0LCBhbmQgaGVuY2UgZG9u
dAorCSogIHRha2VvdXQgYW55IG5ldyByZXF1ZXN0IGZyb20gdGhlIEZJRk8KKwkqLworCWV4dGVy
biBpbnQgc3lzdGVtX3Jlc3VtaW5nOworCWlmIChzeXN0ZW1fcmVzdW1pbmcgIT0gMCkKKwl7Cisj
aWZkZWYgREVCVUcKKwkJcHJpbnRrKCIgIHN5c3RlbSByZXN1bWluZyBzdGlsbCBcbiIpOworI2Vu
ZGlmCisJCXJldHVybiAwOworCX0KIAlhcnEgPSBsaXN0X2VudHJ5X2ZpZm8oYWQtPmZpZm9fbGlz
dFthZGlyXS5uZXh0KTsKIAogCXJldHVybiB0aW1lX2FmdGVyKGppZmZpZXMsIGFycS0+ZXhwaXJl
cyk7CmRpZmYgLXJ1TiAuLi90ZXN0L2xpbnV4LXZhbmlsbGEvYmxvY2svY2ZxLWlvc2NoZWQuYyBs
aW51eC0yLjYuMTgvYmxvY2svY2ZxLWlvc2NoZWQuYwotLS0gLi4vdGVzdC9saW51eC12YW5pbGxh
L2Jsb2NrL2NmcS1pb3NjaGVkLmMJMjAwNy0wMS0xMSAwNzo1OTozMy4wMDAwMDAwMDAgKzA1MzAK
KysrIGxpbnV4LTIuNi4xOC9ibG9jay9jZnEtaW9zY2hlZC5jCTIwMDctMDEtMTggMTM6MzU6MDIu
MDAwMDAwMDAwICswNTMwCkBAIC0xMTU2LDYgKzExNTYsMTkgQEAKIAlpZiAoIWNmcWQtPmJ1c3lf
cXVldWVzKQogCQlyZXR1cm4gMDsKIAorCS8qCisJICogQ2hlY2sgaGVyZSBmb3IgdGhlIFN5c3Rl
bSByZXN1bWUgZmxhZyB0byBiZSBjbGVhcmVkLCBpZiBmbGFnIGlzIHMKKwkqICBzdGlsbCBzZXQg
dGhlIHJlc3VtZSB0aHJlYWQgaGFzbnQgY29tcGxldGVkIHlldCwgYW5kIGhlbmNlIGRvbnQKKwkq
ICBtb3ZlIGFueSByZXF1ZXN0IGZyb20gdGhlIHJlYWQvd3JpdGUgdG8gZGlzcGF0Y2ggcXVldWUK
KwkqLworCWV4dGVybiBpbnQgc3lzdGVtX3Jlc3VtaW5nOworCWlmIChzeXN0ZW1fcmVzdW1pbmcg
IT0gMCkKKwl7CisjaWZkZWYgREVCVUcKKwkJcHJpbnRrKCJTeXN0ZW0gcmVzdW1pbmcgc3RpbGwg
XG4iKTsKKyNlbmRpZgorCQlyZXR1cm4gMDsKKwl9CiAJaWYgKHVubGlrZWx5KGZvcmNlKSkKIAkJ
cmV0dXJuIGNmcV9mb3JjZWRfZGlzcGF0Y2goY2ZxZCk7CiAKZGlmZiAtcnVOIC4uL3Rlc3QvbGlu
dXgtdmFuaWxsYS9rZXJuZWwvcG93ZXIvbWFpbi5jIGxpbnV4LTIuNi4xOC9rZXJuZWwvcG93ZXIv
bWFpbi5jCi0tLSAuLi90ZXN0L2xpbnV4LXZhbmlsbGEva2VybmVsL3Bvd2VyL21haW4uYwkyMDA3
LTAxLTExIDA4OjAwOjExLjAwMDAwMDAwMCArMDUzMAorKysgbGludXgtMi42LjE4L2tlcm5lbC9w
b3dlci9tYWluLmMJMjAwNy0wMS0xOCAxMzozMTo1Ni4wMDAwMDAwMDAgKzA1MzAKQEAgLTE5LDYg
KzE5LDcgQEAKIAogI2luY2x1ZGUgInBvd2VyLmgiCiAKK2ludCBzeXN0ZW1fcmVzdW1pbmc7CiAv
KlRoaXMgaXMganVzdCBhbiBhcmJpdHJhcnkgbnVtYmVyICovCiAjZGVmaW5lIEZSRUVfUEFHRV9O
VU1CRVIgKDEwMCkKIApAQCAtMTMxLDkgKzEzMiwyOSBAQAogICoJY29uc29sZSB0aGF0IHdlJ3Zl
IGFsbG9jYXRlZC4gVGhpcyBpcyBub3QgY2FsbGVkIGZvciBzdXNwZW5kLXRvLWRpc2suCiAgKi8K
IAotc3RhdGljIHZvaWQgc3VzcGVuZF9maW5pc2goc3VzcGVuZF9zdGF0ZV90IHN0YXRlKQorc3Rh
dGljIGludCBkZXZfcmVzdW1lX3Byb2Modm9pZCAqIGRhdGEpCiB7CisJLyogU2V0IHRoZSBnbG9i
YWwgcmVzdW1lIGZsYWcsIHRoaXMgd2lsbCBiZSBjaGVja2VkIGJ5IHRoZSBJT19zY2hlZHVsYXIK
KwkqIGJlZm9yZSBkaXNwYXRjaGluZyB0aGUgSU8gcmVxdWVzdAorCSovCisJc3lzdGVtX3Jlc3Vt
aW5nID0xOwogCWRldmljZV9yZXN1bWUoKTsKKwlzeXN0ZW1fcmVzdW1pbmcgPSAwOworI2lmZGVm
IERFQlVHCisJcHJpbnRrKCIgcmVzZXRpbmcgc3lzdGVtX3Jlc3VtZSBcbiIpOworI2VuZGlmCisJ
cmV0dXJuICgwKTsKK30KK3N0YXRpYyB2b2lkIHN1c3BlbmRfZmluaXNoKHN1c3BlbmRfc3RhdGVf
dCBzdGF0ZSkKK3sKKwlpbnQgdGhyZWFkOworCXN5c3RlbV9yZXN1bWluZyA9IDA7CisJdGhyZWFk
ID0ga2VybmVsX3RocmVhZChkZXZfcmVzdW1lX3Byb2MsTlVMTCxDTE9ORV9LRVJORUwpOworCWlm
ICh0aHJlYWQgPCAwKQorCXsKKwkJcHJpbnRrICgiU3VzcGVuZCByZXN1bWUgQ2Fubm90IGNyZWF0
ZSBLZXJuZWxfdGhyZWFkXG4iKTsKKwkJZGV2aWNlX3Jlc3VtZSgpOworCX0KIAlyZXN1bWVfY29u
c29sZSgpOwogCXRoYXdfcHJvY2Vzc2VzKCk7CiAJZW5hYmxlX25vbmJvb3RfY3B1cygpOwo=

------_=_NextPart_001_01C73BA1.0C2B08A1--
