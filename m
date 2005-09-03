Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbVICPhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVICPhy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 11:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbVICPhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 11:37:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3989 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750943AbVICPhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 11:37:53 -0400
Date: Sat, 3 Sep 2005 11:37:41 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][1/2] fix for -mm add-sem_is_read-write_locked.patch
Message-ID: <Pine.LNX.4.63.0509031134240.567@cuia.boston.redhat.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279735632-589940821-1125761861=:567"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--279735632-589940821-1125761861=:567
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Andrew,

Here is an incremental fix to the add-sem_is_read-write_locked
patch in -mm.  Also attached is a full version of that file,
which can just be dropped into place - I've verified that none
of the patches in your stack get rejects.

The reason for this change is that a lock that's held for
reading can be negative when there is a writer waiting, as
David pointed out to me a while ago.

The corresponding change to swaptoken-tuning.patch is in the
next mail.

Signed-off-by: Rik van Riel <riel@redhat.com>

Index: linux-2.6.13/include/asm-alpha/rwsem.h
===================================================================
--- linux-2.6.13.orig/include/asm-alpha/rwsem.h
+++ linux-2.6.13/include/asm-alpha/rwsem.h
@@ -262,14 +262,9 @@ static inline long rwsem_atomic_update(l
 #endif
 }
 
-static inline int sem_is_read_locked(struct rw_semaphore *sem)
+static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
-	return (sem->count > 0);
-}
-
-static inline int sem_is_write_locked(struct rw_semaphore *sem)
-{
-	return (sem->count < 0);
+	return (sem->count != 0);
 }
 
 #endif /* __KERNEL__ */
Index: linux-2.6.13/include/asm-i386/rwsem.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/rwsem.h
+++ linux-2.6.13/include/asm-i386/rwsem.h
@@ -284,14 +284,9 @@ LOCK_PREFIX	"xadd %0,(%2)"
 	return tmp+delta;
 }
 
-static inline int sem_is_read_locked(struct rw_semaphore *sem)
+static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
-	return (sem->count > 0);
-}
-
-static inline int sem_is_write_locked(struct rw_semaphore *sem)
-{
-	return (sem->count < 0);
+	return (sem->count != 0);
 }
 
 #endif /* __KERNEL__ */
Index: linux-2.6.13/include/asm-ia64/rwsem.h
===================================================================
--- linux-2.6.13.orig/include/asm-ia64/rwsem.h
+++ linux-2.6.13/include/asm-ia64/rwsem.h
@@ -186,14 +186,9 @@ __downgrade_write (struct rw_semaphore *
 #define rwsem_atomic_add(delta, sem)	atomic64_add(delta, (atomic64_t *)(&(sem)->count))
 #define rwsem_atomic_update(delta, sem)	atomic64_add_return(delta, (atomic64_t *)(&(sem)->count))
 
-static inline int sem_is_read_locked(struct rw_semaphore *sem)
+static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
-	return (sem->count > 0);
-}
-
-static inline int sem_is_write_locked(struct rw_semaphore *sem)
-{
-	return (sem->count < 0);
+	return (sem->count != 0);
 }
 
 #endif /* _ASM_IA64_RWSEM_H */
Index: linux-2.6.13/include/asm-ppc64/rwsem.h
===================================================================
--- linux-2.6.13.orig/include/asm-ppc64/rwsem.h
+++ linux-2.6.13/include/asm-ppc64/rwsem.h
@@ -165,12 +165,7 @@ static inline int rwsem_atomic_update(in
 
 static inline int sem_is_read_locked(struct rw_semaphore *sem)
 {
-	return (sem->count > 0);
-}
-
-static inline int sem_is_write_locked(struct rw_semaphore *sem)
-{
-	return (sem->count < 0);
+	return (sem->count != 0);
 }
 
 #endif /* __KERNEL__ */
Index: linux-2.6.13/include/asm-ppc/rwsem.h
===================================================================
--- linux-2.6.13.orig/include/asm-ppc/rwsem.h
+++ linux-2.6.13/include/asm-ppc/rwsem.h
@@ -168,14 +168,9 @@ static inline int rwsem_atomic_update(in
 	return atomic_add_return(delta, (atomic_t *)(&sem->count));
 }
 
-static inline int sem_is_read_locked(struct rw_semaphore *sem)
+static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
-	return (sem->count > 0);
-}
-
-static inline int sem_is_write_locked(struct rw_semaphore *sem)
-{
-	return (sem->count < 0);
+	return (sem->count != 0);
 }
 
 #endif /* __KERNEL__ */
Index: linux-2.6.13/include/asm-s390/rwsem.h
===================================================================
--- linux-2.6.13.orig/include/asm-s390/rwsem.h
+++ linux-2.6.13/include/asm-s390/rwsem.h
@@ -351,14 +351,9 @@ static inline long rwsem_atomic_update(l
 	return new;
 }
 
-static inline int sem_is_read_locked(struct rw_semaphore *sem)
+static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
-	return (sem->count > 0);
-}
-
-static inline int sem_is_write_locked(struct rw_semaphore *sem)
-{
-	return (sem->count < 0);
+	return (sem->count != 0);
 }
 
 #endif /* __KERNEL__ */
Index: linux-2.6.13/include/asm-sh/rwsem.h
===================================================================
--- linux-2.6.13.orig/include/asm-sh/rwsem.h
+++ linux-2.6.13/include/asm-sh/rwsem.h
@@ -166,14 +166,9 @@ static inline int rwsem_atomic_update(in
 	return atomic_add_return(delta, (atomic_t *)(&sem->count));
 }
 
-static inline int sem_is_read_locked(struct rw_semaphore *sem)
+static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
-	return (sem->count > 0);
-}
-
-static inline int sem_is_write_locked(struct rw_semaphore *sem)
-{
-	return (sem->count < 0);
+	return (sem->count != 0);
 }
 
 #endif /* __KERNEL__ */
Index: linux-2.6.13/include/asm-sparc64/rwsem.h
===================================================================
--- linux-2.6.13.orig/include/asm-sparc64/rwsem.h
+++ linux-2.6.13/include/asm-sparc64/rwsem.h
@@ -56,14 +56,9 @@ static inline void rwsem_atomic_add(int 
 	atomic_add(delta, (atomic_t *)(&sem->count));
 }
 
-static inline int sem_is_read_locked(struct rw_semaphore *sem)
+static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
-	return (sem->count > 0);
-}
-
-static inline int sem_is_write_locked(struct rw_semaphore *sem)
-{
-	return (sem->count < 0);
+	return (sem->count != 0);
 }
 
 #endif /* __KERNEL__ */
Index: linux-2.6.13/include/asm-x86_64/rwsem.h
===================================================================
--- linux-2.6.13.orig/include/asm-x86_64/rwsem.h
+++ linux-2.6.13/include/asm-x86_64/rwsem.h
@@ -274,14 +274,9 @@ LOCK_PREFIX	"xaddl %0,(%2)"
 	return tmp+delta;
 }
 
-static inline int sem_is_read_locked(struct rw_semaphore *sem)
+static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
-	return (sem->count > 0);
-}
-
-static inline int sem_is_write_locked(struct rw_semaphore *sem)
-{
-	return (sem->count < 0);
+	return (sem->count != 0);
 }
 
 #endif /* __KERNEL__ */
--279735632-589940821-1125761861=:567
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=add-sem_is_read-write_locked.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.63.0509031137410.567@cuia.boston.redhat.com>
Content-Description: 
Content-Disposition: attachment; filename=add-sem_is_read-write_locked.patch

DQpGcm9tOiBSaWsgVmFuIFJpZWwgPHJpZWxAcmVkaGF0LmNvbT4NCg0KQWRk
IHNlbV9pc19yZWFkL3dyaXRlX2xvY2tlZCBmdW5jdGlvbnMgdG8gdGhlIHJl
YWQvd3JpdGUgc2VtYXBob3JlcywgYWxvbmcgdGhlDQpzYW1lIGxpbmVzIG9m
IHRoZSAqX2lzX2xvY2tlZCBzcGlubG9jayBmdW5jdGlvbnMuICBUaGUgc3dh
cCB0b2tlbiB0dW5pbmcgcGF0Y2gNCnVzZXMgc2VtX2lzX3JlYWRfbG9ja2Vk
OyBzZW1faXNfd3JpdGVfbG9ja2VkIGlzIGFkZGVkIGZvciBjb21wbGV0ZW5l
c3MuDQoNClNpZ25lZC1vZmYtYnk6IFJpayB2YW4gUmllbCA8cmllbEByZWRo
YXQuY29tPg0KU2lnbmVkLW9mZi1ieTogQW5kcmV3IE1vcnRvbiA8YWtwbUBv
c2RsLm9yZz4NCkluZGV4OiBsaW51eC0yLjYuMTMvaW5jbHVkZS9hc20tYWxw
aGEvcndzZW0uaA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIGxpbnV4
LTIuNi4xMy5vcmlnL2luY2x1ZGUvYXNtLWFscGhhL3J3c2VtLmgNCisrKyBs
aW51eC0yLjYuMTMvaW5jbHVkZS9hc20tYWxwaGEvcndzZW0uaA0KQEAgLTI2
Miw1ICsyNjIsMTAgQEAgc3RhdGljIGlubGluZSBsb25nIHJ3c2VtX2F0b21p
Y191cGRhdGUobA0KICNlbmRpZg0KIH0NCiANCitzdGF0aWMgaW5saW5lIGlu
dCByd3NlbV9pc19sb2NrZWQoc3RydWN0IHJ3X3NlbWFwaG9yZSAqc2VtKQ0K
K3sNCisJcmV0dXJuIChzZW0tPmNvdW50ICE9IDApOw0KK30NCisNCiAjZW5k
aWYgLyogX19LRVJORUxfXyAqLw0KICNlbmRpZiAvKiBfQUxQSEFfUldTRU1f
SCAqLw0KSW5kZXg6IGxpbnV4LTIuNi4xMy9pbmNsdWRlL2FzbS1pMzg2L3J3
c2VtLmgNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBsaW51eC0yLjYu
MTMub3JpZy9pbmNsdWRlL2FzbS1pMzg2L3J3c2VtLmgNCisrKyBsaW51eC0y
LjYuMTMvaW5jbHVkZS9hc20taTM4Ni9yd3NlbS5oDQpAQCAtMjg0LDUgKzI4
NCwxMCBAQCBMT0NLX1BSRUZJWAkieGFkZCAlMCwoJTIpIg0KIAlyZXR1cm4g
dG1wK2RlbHRhOw0KIH0NCiANCitzdGF0aWMgaW5saW5lIGludCByd3NlbV9p
c19sb2NrZWQoc3RydWN0IHJ3X3NlbWFwaG9yZSAqc2VtKQ0KK3sNCisJcmV0
dXJuIChzZW0tPmNvdW50ICE9IDApOw0KK30NCisNCiAjZW5kaWYgLyogX19L
RVJORUxfXyAqLw0KICNlbmRpZiAvKiBfSTM4Nl9SV1NFTV9IICovDQpJbmRl
eDogbGludXgtMi42LjEzL2luY2x1ZGUvYXNtLWlhNjQvcndzZW0uaA0KPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KLS0tIGxpbnV4LTIuNi4xMy5vcmlnL2lu
Y2x1ZGUvYXNtLWlhNjQvcndzZW0uaA0KKysrIGxpbnV4LTIuNi4xMy9pbmNs
dWRlL2FzbS1pYTY0L3J3c2VtLmgNCkBAIC0xODYsNCArMTg2LDkgQEAgX19k
b3duZ3JhZGVfd3JpdGUgKHN0cnVjdCByd19zZW1hcGhvcmUgKg0KICNkZWZp
bmUgcndzZW1fYXRvbWljX2FkZChkZWx0YSwgc2VtKQlhdG9taWM2NF9hZGQo
ZGVsdGEsIChhdG9taWM2NF90ICopKCYoc2VtKS0+Y291bnQpKQ0KICNkZWZp
bmUgcndzZW1fYXRvbWljX3VwZGF0ZShkZWx0YSwgc2VtKQlhdG9taWM2NF9h
ZGRfcmV0dXJuKGRlbHRhLCAoYXRvbWljNjRfdCAqKSgmKHNlbSktPmNvdW50
KSkNCiANCitzdGF0aWMgaW5saW5lIGludCByd3NlbV9pc19sb2NrZWQoc3Ry
dWN0IHJ3X3NlbWFwaG9yZSAqc2VtKQ0KK3sNCisJcmV0dXJuIChzZW0tPmNv
dW50ICE9IDApOw0KK30NCisNCiAjZW5kaWYgLyogX0FTTV9JQTY0X1JXU0VN
X0ggKi8NCkluZGV4OiBsaW51eC0yLjYuMTMvaW5jbHVkZS9hc20tcHBjNjQv
cndzZW0uaA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIGxpbnV4LTIu
Ni4xMy5vcmlnL2luY2x1ZGUvYXNtLXBwYzY0L3J3c2VtLmgNCisrKyBsaW51
eC0yLjYuMTMvaW5jbHVkZS9hc20tcHBjNjQvcndzZW0uaA0KQEAgLTE2Myw1
ICsxNjMsMTAgQEAgc3RhdGljIGlubGluZSBpbnQgcndzZW1fYXRvbWljX3Vw
ZGF0ZShpbg0KIAlyZXR1cm4gYXRvbWljX2FkZF9yZXR1cm4oZGVsdGEsIChh
dG9taWNfdCAqKSgmc2VtLT5jb3VudCkpOw0KIH0NCiANCitzdGF0aWMgaW5s
aW5lIGludCBzZW1faXNfcmVhZF9sb2NrZWQoc3RydWN0IHJ3X3NlbWFwaG9y
ZSAqc2VtKQ0KK3sNCisJcmV0dXJuIChzZW0tPmNvdW50ICE9IDApOw0KK30N
CisNCiAjZW5kaWYgLyogX19LRVJORUxfXyAqLw0KICNlbmRpZiAvKiBfUFBD
X1JXU0VNX1hBRERfSCAqLw0KSW5kZXg6IGxpbnV4LTIuNi4xMy9pbmNsdWRl
L2FzbS1wcGMvcndzZW0uaA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0t
IGxpbnV4LTIuNi4xMy5vcmlnL2luY2x1ZGUvYXNtLXBwYy9yd3NlbS5oDQor
KysgbGludXgtMi42LjEzL2luY2x1ZGUvYXNtLXBwYy9yd3NlbS5oDQpAQCAt
MTY4LDUgKzE2OCwxMCBAQCBzdGF0aWMgaW5saW5lIGludCByd3NlbV9hdG9t
aWNfdXBkYXRlKGluDQogCXJldHVybiBhdG9taWNfYWRkX3JldHVybihkZWx0
YSwgKGF0b21pY190ICopKCZzZW0tPmNvdW50KSk7DQogfQ0KIA0KK3N0YXRp
YyBpbmxpbmUgaW50IHJ3c2VtX2lzX2xvY2tlZChzdHJ1Y3Qgcndfc2VtYXBo
b3JlICpzZW0pDQorew0KKwlyZXR1cm4gKHNlbS0+Y291bnQgIT0gMCk7DQor
fQ0KKw0KICNlbmRpZiAvKiBfX0tFUk5FTF9fICovDQogI2VuZGlmIC8qIF9Q
UENfUldTRU1fWEFERF9IICovDQpJbmRleDogbGludXgtMi42LjEzL2luY2x1
ZGUvYXNtLXMzOTAvcndzZW0uaA0KPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
LS0tIGxpbnV4LTIuNi4xMy5vcmlnL2luY2x1ZGUvYXNtLXMzOTAvcndzZW0u
aA0KKysrIGxpbnV4LTIuNi4xMy9pbmNsdWRlL2FzbS1zMzkwL3J3c2VtLmgN
CkBAIC0zNTEsNSArMzUxLDEwIEBAIHN0YXRpYyBpbmxpbmUgbG9uZyByd3Nl
bV9hdG9taWNfdXBkYXRlKGwNCiAJcmV0dXJuIG5ldzsNCiB9DQogDQorc3Rh
dGljIGlubGluZSBpbnQgcndzZW1faXNfbG9ja2VkKHN0cnVjdCByd19zZW1h
cGhvcmUgKnNlbSkNCit7DQorCXJldHVybiAoc2VtLT5jb3VudCAhPSAwKTsN
Cit9DQorDQogI2VuZGlmIC8qIF9fS0VSTkVMX18gKi8NCiAjZW5kaWYgLyog
X1MzOTBfUldTRU1fSCAqLw0KSW5kZXg6IGxpbnV4LTIuNi4xMy9pbmNsdWRl
L2FzbS1zaC9yd3NlbS5oDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0g
bGludXgtMi42LjEzLm9yaWcvaW5jbHVkZS9hc20tc2gvcndzZW0uaA0KKysr
IGxpbnV4LTIuNi4xMy9pbmNsdWRlL2FzbS1zaC9yd3NlbS5oDQpAQCAtMTY2
LDUgKzE2NiwxMCBAQCBzdGF0aWMgaW5saW5lIGludCByd3NlbV9hdG9taWNf
dXBkYXRlKGluDQogCXJldHVybiBhdG9taWNfYWRkX3JldHVybihkZWx0YSwg
KGF0b21pY190ICopKCZzZW0tPmNvdW50KSk7DQogfQ0KIA0KK3N0YXRpYyBp
bmxpbmUgaW50IHJ3c2VtX2lzX2xvY2tlZChzdHJ1Y3Qgcndfc2VtYXBob3Jl
ICpzZW0pDQorew0KKwlyZXR1cm4gKHNlbS0+Y291bnQgIT0gMCk7DQorfQ0K
Kw0KICNlbmRpZiAvKiBfX0tFUk5FTF9fICovDQogI2VuZGlmIC8qIF9BU01f
U0hfUldTRU1fSCAqLw0KSW5kZXg6IGxpbnV4LTIuNi4xMy9pbmNsdWRlL2Fz
bS1zcGFyYzY0L3J3c2VtLmgNCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0t
LSBsaW51eC0yLjYuMTMub3JpZy9pbmNsdWRlL2FzbS1zcGFyYzY0L3J3c2Vt
LmgNCisrKyBsaW51eC0yLjYuMTMvaW5jbHVkZS9hc20tc3BhcmM2NC9yd3Nl
bS5oDQpAQCAtNTYsNiArNTYsMTEgQEAgc3RhdGljIGlubGluZSB2b2lkIHJ3
c2VtX2F0b21pY19hZGQoaW50IA0KIAlhdG9taWNfYWRkKGRlbHRhLCAoYXRv
bWljX3QgKikoJnNlbS0+Y291bnQpKTsNCiB9DQogDQorc3RhdGljIGlubGlu
ZSBpbnQgcndzZW1faXNfbG9ja2VkKHN0cnVjdCByd19zZW1hcGhvcmUgKnNl
bSkNCit7DQorCXJldHVybiAoc2VtLT5jb3VudCAhPSAwKTsNCit9DQorDQog
I2VuZGlmIC8qIF9fS0VSTkVMX18gKi8NCiANCiAjZW5kaWYgLyogX1NQQVJD
NjRfUldTRU1fSCAqLw0KSW5kZXg6IGxpbnV4LTIuNi4xMy9pbmNsdWRlL2Fz
bS14ODZfNjQvcndzZW0uaA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0t
IGxpbnV4LTIuNi4xMy5vcmlnL2luY2x1ZGUvYXNtLXg4Nl82NC9yd3NlbS5o
DQorKysgbGludXgtMi42LjEzL2luY2x1ZGUvYXNtLXg4Nl82NC9yd3NlbS5o
DQpAQCAtMjc0LDUgKzI3NCwxMCBAQCBMT0NLX1BSRUZJWAkieGFkZGwgJTAs
KCUyKSINCiAJcmV0dXJuIHRtcCtkZWx0YTsNCiB9DQogDQorc3RhdGljIGlu
bGluZSBpbnQgcndzZW1faXNfbG9ja2VkKHN0cnVjdCByd19zZW1hcGhvcmUg
KnNlbSkNCit7DQorCXJldHVybiAoc2VtLT5jb3VudCAhPSAwKTsNCit9DQor
DQogI2VuZGlmIC8qIF9fS0VSTkVMX18gKi8NCiAjZW5kaWYgLyogX1g4NjY0
X1JXU0VNX0ggKi8NCkluZGV4OiBsaW51eC0yLjYuMTMvaW5jbHVkZS9saW51
eC9yd3NlbS1zcGlubG9jay5oDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQot
LS0gbGludXgtMi42LjEzLm9yaWcvaW5jbHVkZS9saW51eC9yd3NlbS1zcGlu
bG9jay5oDQorKysgbGludXgtMi42LjEzL2luY2x1ZGUvbGludXgvcndzZW0t
c3BpbmxvY2suaA0KQEAgLTYxLDUgKzYxLDE1IEBAIGV4dGVybiB2b2lkIEZB
U1RDQUxMKF9fdXBfcmVhZChzdHJ1Y3QgcncNCiBleHRlcm4gdm9pZCBGQVNU
Q0FMTChfX3VwX3dyaXRlKHN0cnVjdCByd19zZW1hcGhvcmUgKnNlbSkpOw0K
IGV4dGVybiB2b2lkIEZBU1RDQUxMKF9fZG93bmdyYWRlX3dyaXRlKHN0cnVj
dCByd19zZW1hcGhvcmUgKnNlbSkpOw0KIA0KK3N0YXRpYyBpbmxpbmUgaW50
IHNlbV9pc19yZWFkX2xvY2tlZChzdHJ1Y3Qgcndfc2VtYXBob3JlICpzZW0p
DQorew0KKwlyZXR1cm4gKHNlbS0+YWN0aXZpdHkgPiAwKTsNCit9DQorDQor
c3RhdGljIGlubGluZSBpbnQgc2VtX2lzX3dyaXRlX2xvY2tlZChzdHJ1Y3Qg
cndfc2VtYXBob3JlICpzZW0pDQorew0KKwlyZXR1cm4gKHNlbS0+YWN0aXZp
dHkgPCAwKTsNCit9DQorDQogI2VuZGlmIC8qIF9fS0VSTkVMX18gKi8NCiAj
ZW5kaWYgLyogX0xJTlVYX1JXU0VNX1NQSU5MT0NLX0ggKi8NCg==

--279735632-589940821-1125761861=:567--
