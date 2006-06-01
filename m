Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWFAUN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWFAUN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWFAUN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:13:58 -0400
Received: from mx2.netapp.com ([216.240.18.37]:19282 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1030274AbWFAUN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:13:58 -0400
X-IronPort-AV: i="4.05,199,1146466800"; 
   d="dif'?scan'208"; a="384231530:sNHT20409716"
Subject: Re: lock_kernel called under spinlock in NFS
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: joe.korty@ccur.com
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, akpm@osdl.org,
       mingo@elte.hu
In-Reply-To: <20060601195535.GA28188@tsunami.ccur.com>
References: <20060601195535.GA28188@tsunami.ccur.com>
Content-Type: multipart/mixed; boundary="=-DZV/DY6eZ8RChSsba4w7"
Organization: Network Appliance Inc
Date: Thu, 01 Jun 2006 16:13:39 -0400
Message-Id: <1149192820.3549.43.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-OriginalArrivalTime: 01 Jun 2006 20:13:56.0291 (UTC) FILETIME=[E9198130:01C685B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DZV/DY6eZ8RChSsba4w7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-06-01 at 15:55 -0400, Joe Korty wrote:
> Tree 5fdccf2354269702f71beb8e0a2942e4167fd992
> 
>         [PATCH] vfs: *at functions: core
> 
> introduced a bug where lock_kernel() can be called from
> under a spinlock.  To trigger the bug one must have
> CONFIG_PREEMPT_BKL=y and be using NFS heavily.  It is
> somewhat rare and, so far, haven't traced down the userland
> sequence that causes the fatal path to be taken.
> 
> The bug was caused by the insertion into do_path_lookup()
> of a call to file_permission().  do_path_lookup()
> read-locks current->fs->lock for most of its operation.
> file_permission() calls permission() which calls
> nfs_permission(), which has one path through it
> that uses lock_kernel().
> 
> I am not sure how to fix this bug.  It is not clear what
> the lock_kernel() call is protecting. Nor is it clear why,
> as part of the introduction of the openat() etc services,
> it was desirable to add a call to file_permission()
> to do_path_lookup().
> 
> For now, I plan to turn off CONFIG_PREEMPT_BKL.

Nowhere should anyone be calling file_permission() under a spinlock.

Why would you need to read-protect current->fs in the case where you are
starting from a file? The correct thing to do there would appear to be
to read_protect only the cases where (*name=='/') and (dfd == AT_FDCWD).

Something like the attached patch...

Cheers,
  Trond

--=-DZV/DY6eZ8RChSsba4w7
Content-Disposition: inline; filename=fix_do_path_lookup.dif
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=fix_do_path_lookup.dif; charset=utf-8

Y29tbWl0IDlhYzRjZGJiMzJkNTkzMTMyZTAzZWNmOTY3OWU2YmJmZTA0ZWQzNTgNCkF1dGhvcjog
VHJvbmQgTXlrbGVidXN0IDxUcm9uZC5NeWtsZWJ1c3RAbmV0YXBwLmNvbT4NCkRhdGU6ICAgVGh1
IEp1biAxIDE2OjEyOjQ3IDIwMDYgLTA0MDANCg0KICAgIGZzL25hbWVpLmM6IENhbGwgdG8gZmls
ZV9wZXJtaXNzaW9uKCkgdW5kZXIgYSBzcGlubG9jayBpbiBkb19sb29rdXBfcGF0aCgpDQogICAg
DQogICAgV2Ugc2hvdWxkIGluIGFueSBjYXNlIG5vdCBuZWVkIHRvIGhvbGQgdGhlIGN1cnJlbnQt
PmZzLT5sb2NrIGZvciBhIGNvZGVwYXRoDQogICAgdGhhdCBkb2Vzbid0IHVzZSBjdXJyZW50LT5m
cy4NCiAgICANCiAgICBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPFRyb25kLk15a2xl
YnVzdEBuZXRhcHAuY29tPg0KDQpkaWZmIC0tZ2l0IGEvZnMvbmFtZWkuYyBiL2ZzL25hbWVpLmMN
CmluZGV4IDk2NzIzYWUuLmEyZjc5ZDIgMTAwNjQ0DQotLS0gYS9mcy9uYW1laS5jDQorKysgYi9m
cy9uYW1laS5jDQpAQCAtMTA4MCw4ICsxMDgwLDggQEAgc3RhdGljIGludCBmYXN0Y2FsbCBkb19w
YXRoX2xvb2t1cChpbnQgZA0KIAluZC0+ZmxhZ3MgPSBmbGFnczsNCiAJbmQtPmRlcHRoID0gMDsN
CiANCi0JcmVhZF9sb2NrKCZjdXJyZW50LT5mcy0+bG9jayk7DQogCWlmICgqbmFtZT09Jy8nKSB7
DQorCQlyZWFkX2xvY2soJmN1cnJlbnQtPmZzLT5sb2NrKTsNCiAJCWlmIChjdXJyZW50LT5mcy0+
YWx0cm9vdCAmJiAhKG5kLT5mbGFncyAmIExPT0tVUF9OT0FMVCkpIHsNCiAJCQluZC0+bW50ID0g
bW50Z2V0KGN1cnJlbnQtPmZzLT5hbHRyb290bW50KTsNCiAJCQluZC0+ZGVudHJ5ID0gZGdldChj
dXJyZW50LT5mcy0+YWx0cm9vdCk7DQpAQCAtMTA5Miw5ICsxMDkyLDEyIEBAIHN0YXRpYyBpbnQg
ZmFzdGNhbGwgZG9fcGF0aF9sb29rdXAoaW50IGQNCiAJCX0NCiAJCW5kLT5tbnQgPSBtbnRnZXQo
Y3VycmVudC0+ZnMtPnJvb3RtbnQpOw0KIAkJbmQtPmRlbnRyeSA9IGRnZXQoY3VycmVudC0+ZnMt
PnJvb3QpOw0KKwkJcmVhZF91bmxvY2soJmN1cnJlbnQtPmZzLT5sb2NrKTsNCiAJfSBlbHNlIGlm
IChkZmQgPT0gQVRfRkRDV0QpIHsNCisJCXJlYWRfbG9jaygmY3VycmVudC0+ZnMtPmxvY2spOw0K
IAkJbmQtPm1udCA9IG1udGdldChjdXJyZW50LT5mcy0+cHdkbW50KTsNCiAJCW5kLT5kZW50cnkg
PSBkZ2V0KGN1cnJlbnQtPmZzLT5wd2QpOw0KKwkJcmVhZF91bmxvY2soJmN1cnJlbnQtPmZzLT5s
b2NrKTsNCiAJfSBlbHNlIHsNCiAJCXN0cnVjdCBkZW50cnkgKmRlbnRyeTsNCiANCkBAIC0xMTE4
LDcgKzExMjEsNiBAQCBzdGF0aWMgaW50IGZhc3RjYWxsIGRvX3BhdGhfbG9va3VwKGludCBkDQog
DQogCQlmcHV0X2xpZ2h0KGZpbGUsIGZwdXRfbmVlZGVkKTsNCiAJfQ0KLQlyZWFkX3VubG9jaygm
Y3VycmVudC0+ZnMtPmxvY2spOw0KIAljdXJyZW50LT50b3RhbF9saW5rX2NvdW50ID0gMDsNCiAJ
cmV0dmFsID0gbGlua19wYXRoX3dhbGsobmFtZSwgbmQpOw0KIG91dDoNCg==


--=-DZV/DY6eZ8RChSsba4w7--
