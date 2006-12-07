Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032167AbWLGMuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032167AbWLGMuu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032169AbWLGMuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:50:50 -0500
Received: from mga03.intel.com ([143.182.124.21]:20289 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032167AbWLGMut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:50:49 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,508,1157353200"; 
   d="scan'208"; a="155079088:sNHT28399938"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C719FE.50F644CB"
Subject: RE: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Date: Thu, 7 Dec 2006 04:50:45 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454FA8DD5@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Thread-Index: AccZ0c0trjsNfL3dQI6JZriOqFvPUAAJJRZA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <ego@in.ibm.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>, <davej@redhat.com>,
       <dipankar@in.ibm.com>, <vatsa@in.ibm.com>
X-OriginalArrivalTime: 07 Dec 2006 12:50:47.0706 (UTC) FILETIME=[512427A0:01C719FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C719FE.50F644CB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org=20
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of=20
>Gautham R Shenoy
>Sent: Wednesday, December 06, 2006 11:07 PM
>To: Pallipadi, Venkatesh
>Cc: ego@in.ibm.com; Ingo Molnar; akpm@osdl.org;=20
>linux-kernel@vger.kernel.org; torvalds@osdl.org;=20
>davej@redhat.com; dipankar@in.ibm.com; vatsa@in.ibm.com
>Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
>
>Hi Venki,
>On Wed, Dec 06, 2006 at 10:27:01AM -0800, Pallipadi, Venkatesh wrote:
>
>> But, if we make cpufreq more affected_cpus aware and have a per_cpu
>> target()
>> call by moving set_cpus_allowed() from driver into cpufreq core and
>> define
>> the target function to be atomic/non-sleeping type, then we=20
>really don't
>> need a hotplug lock for the driver any more. Driver can have
>> get_cpu/put_cpu
>> pair to disable preemption and then change the frequency.
>
>Well, we would still need to keep the affected_cpus map in=20
>sync with the
>cpu_online map. That would still require hotplug protection, right?

Not really. Cpufreq can look at all the CPUs in affected_cpus and call
new_target() only for CPUs that are online. Or it can call for every CPU
and the actual implementation in driver can do something like

set_cpus_allowed(requested_processor_mask)
If (get_cpu() !=3D requested_cpu) {
	/* CPU offline and nothing can be done */
	put_cpu();
	return 0;
}

This is what I did for new cpufreq interface I added for getavg().
It was easy to ensure the atomic driver call as only one driver is
using it today :-)


>Besides, I would love to see a way of implementing target=20
>function to be
>atomic/non-sleeping type. But as of now, the target functions call
>cpufreq_notify_transition which might sleep.
>

That is the reason I don't have a patch for this now.. :-) There are
more
than 10 or so drivers that need to change for new interface. I haven't
checked
whether it is possible to do this without sleeping in all those drivers.


>That's not the last of my worries. The ondemand-workqueue interaction
>in the cpu_hotplug callback path can cause a deadlock if we go for
>per-subsystem hotcpu mutexes. Can you think of a way by which we can=20
>avoid destroying the kondemand workqueue from the cpu-hotplug callback
>path ? Please see http://lkml.org/lkml/2006/11/30/9 for the
>culprit-callpath.
>

Yes. I was thinking about it. One possible solution is to move=20
create_workqueue()/destroy_workqueue() as in attached patch.

Thanks,
Venki

Not fully tested at the moment.

Remove callbacks using workqueue callbacks in governor start and stop.
And move those call back to module init and exit time.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.19-rc-mm/drivers/cpufreq/cpufreq_ondemand.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-rc-mm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-2.6.19-rc-mm/drivers/cpufreq/cpufreq_ondemand.c
@@ -514,7 +514,6 @@ static inline void dbs_timer_exit(struct
 {
 	dbs_info->enable =3D 0;
 	cancel_delayed_work(&dbs_info->work);
-	flush_workqueue(kondemand_wq);
 }
=20
 static int cpufreq_governor_dbs(struct cpufreq_policy *policy,
@@ -543,16 +542,6 @@ static int cpufreq_governor_dbs(struct c
=20
 		mutex_lock(&dbs_mutex);
 		dbs_enable++;
-		if (dbs_enable =3D=3D 1) {
-			kondemand_wq =3D create_workqueue("kondemand");
-			if (!kondemand_wq) {
-				printk(KERN_ERR
-					 "Creation of kondemand
failed\n");
-				dbs_enable--;
-				mutex_unlock(&dbs_mutex);
-				return -ENOSPC;
-			}
-		}
=20
 		rc =3D sysfs_create_group(&policy->kobj, &dbs_attr_group);
 		if (rc) {
@@ -601,8 +590,6 @@ static int cpufreq_governor_dbs(struct c
 		dbs_timer_exit(this_dbs_info);
 		sysfs_remove_group(&policy->kobj, &dbs_attr_group);
 		dbs_enable--;
-		if (dbs_enable =3D=3D 0)
-			destroy_workqueue(kondemand_wq);
=20
 		mutex_unlock(&dbs_mutex);
=20
@@ -632,12 +619,18 @@ static struct cpufreq_governor cpufreq_g
=20
 static int __init cpufreq_gov_dbs_init(void)
 {
+	kondemand_wq =3D create_workqueue("kondemand");
+	if (!kondemand_wq) {
+		printk(KERN_ERR "Creation of kondemand failed\n");
+		return -EFAULT;
+	}
 	return cpufreq_register_governor(&cpufreq_gov_dbs);
 }
=20
 static void __exit cpufreq_gov_dbs_exit(void)
 {
 	cpufreq_unregister_governor(&cpufreq_gov_dbs);
+	destroy_workqueue(kondemand_wq);
 }

------_=_NextPart_001_01C719FE.50F644CB
Content-Type: application/octet-stream;
	name="ondemand_recursive_locking_fix.patch"
Content-Transfer-Encoding: base64
Content-Description: ondemand_recursive_locking_fix.patch
Content-Disposition: attachment;
	filename="ondemand_recursive_locking_fix.patch"

ClJlbW92ZSBjYWxsYmFja3MgdXNpbmcgd29ya3F1ZXVlIGNhbGxiYWNrcyBpbiBnb3Zlcm5vciBz
dGFydCBhbmQgc3RvcC4KQW5kIG1vdmUgdGhvc2UgY2FsbCBiYWNrIHRvIG1vZHVsZSBpbml0IGFu
ZCBleGl0IHRpbWUuCgpTaWduZWQtb2ZmLWJ5OiBWZW5rYXRlc2ggUGFsbGlwYWRpIDx2ZW5rYXRl
c2gucGFsbGlwYWRpQGludGVsLmNvbT4KCkluZGV4OiBsaW51eC0yLjYuMTktcmMtbW0vZHJpdmVy
cy9jcHVmcmVxL2NwdWZyZXFfb25kZW1hbmQuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYuMTkt
cmMtbW0ub3JpZy9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9vbmRlbWFuZC5jCisrKyBsaW51eC0y
LjYuMTktcmMtbW0vZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFfb25kZW1hbmQuYwpAQCAtNTE0LDcg
KzUxNCw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBkYnNfdGltZXJfZXhpdChzdHJ1Y3QKIHsKIAlk
YnNfaW5mby0+ZW5hYmxlID0gMDsKIAljYW5jZWxfZGVsYXllZF93b3JrKCZkYnNfaW5mby0+d29y
ayk7Ci0JZmx1c2hfd29ya3F1ZXVlKGtvbmRlbWFuZF93cSk7CiB9CiAKIHN0YXRpYyBpbnQgY3B1
ZnJlcV9nb3Zlcm5vcl9kYnMoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3ksCkBAIC01NDMs
MTYgKzU0Miw2IEBAIHN0YXRpYyBpbnQgY3B1ZnJlcV9nb3Zlcm5vcl9kYnMoc3RydWN0IGMKIAog
CQltdXRleF9sb2NrKCZkYnNfbXV0ZXgpOwogCQlkYnNfZW5hYmxlKys7Ci0JCWlmIChkYnNfZW5h
YmxlID09IDEpIHsKLQkJCWtvbmRlbWFuZF93cSA9IGNyZWF0ZV93b3JrcXVldWUoImtvbmRlbWFu
ZCIpOwotCQkJaWYgKCFrb25kZW1hbmRfd3EpIHsKLQkJCQlwcmludGsoS0VSTl9FUlIKLQkJCQkJ
ICJDcmVhdGlvbiBvZiBrb25kZW1hbmQgZmFpbGVkXG4iKTsKLQkJCQlkYnNfZW5hYmxlLS07Ci0J
CQkJbXV0ZXhfdW5sb2NrKCZkYnNfbXV0ZXgpOwotCQkJCXJldHVybiAtRU5PU1BDOwotCQkJfQot
CQl9CiAKIAkJcmMgPSBzeXNmc19jcmVhdGVfZ3JvdXAoJnBvbGljeS0+a29iaiwgJmRic19hdHRy
X2dyb3VwKTsKIAkJaWYgKHJjKSB7CkBAIC02MDEsOCArNTkwLDYgQEAgc3RhdGljIGludCBjcHVm
cmVxX2dvdmVybm9yX2RicyhzdHJ1Y3QgYwogCQlkYnNfdGltZXJfZXhpdCh0aGlzX2Ric19pbmZv
KTsKIAkJc3lzZnNfcmVtb3ZlX2dyb3VwKCZwb2xpY3ktPmtvYmosICZkYnNfYXR0cl9ncm91cCk7
CiAJCWRic19lbmFibGUtLTsKLQkJaWYgKGRic19lbmFibGUgPT0gMCkKLQkJCWRlc3Ryb3lfd29y
a3F1ZXVlKGtvbmRlbWFuZF93cSk7CiAKIAkJbXV0ZXhfdW5sb2NrKCZkYnNfbXV0ZXgpOwogCkBA
IC02MzIsMTIgKzYxOSwxOCBAQCBzdGF0aWMgc3RydWN0IGNwdWZyZXFfZ292ZXJub3IgY3B1ZnJl
cV9nCiAKIHN0YXRpYyBpbnQgX19pbml0IGNwdWZyZXFfZ292X2Ric19pbml0KHZvaWQpCiB7CisJ
a29uZGVtYW5kX3dxID0gY3JlYXRlX3dvcmtxdWV1ZSgia29uZGVtYW5kIik7CisJaWYgKCFrb25k
ZW1hbmRfd3EpIHsKKwkJcHJpbnRrKEtFUk5fRVJSICJDcmVhdGlvbiBvZiBrb25kZW1hbmQgZmFp
bGVkXG4iKTsKKwkJcmV0dXJuIC1FRkFVTFQ7CisJfQogCXJldHVybiBjcHVmcmVxX3JlZ2lzdGVy
X2dvdmVybm9yKCZjcHVmcmVxX2dvdl9kYnMpOwogfQogCiBzdGF0aWMgdm9pZCBfX2V4aXQgY3B1
ZnJlcV9nb3ZfZGJzX2V4aXQodm9pZCkKIHsKIAljcHVmcmVxX3VucmVnaXN0ZXJfZ292ZXJub3Io
JmNwdWZyZXFfZ292X2Ricyk7CisJZGVzdHJveV93b3JrcXVldWUoa29uZGVtYW5kX3dxKTsKIH0K
IAogCg==

------_=_NextPart_001_01C719FE.50F644CB--
