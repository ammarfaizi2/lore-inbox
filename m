Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbULISig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbULISig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 13:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbULISid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 13:38:33 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:9805 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261581AbULISiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 13:38:05 -0500
Date: Thu, 9 Dec 2004 18:37:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Christoph Lameter <clameter@sgi.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, <linux-mm@kvack.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
    tests
In-Reply-To: <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.44.0412091830580.17648-300000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-747545378-1102617460=:17648"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-747545378-1102617460=:17648
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 1 Dec 2004, Christoph Lameter wrote:
> 
> Changes from V11->V12 of this patch:
> - dump sloppy_rss in favor of list_rss (Linus' proposal)
> - keep up against current Linus tree (patch is based on 2.6.10-rc2-bk14)
> 
> This is a series of patches that increases the scalability of
> the page fault handler for SMP. Here are some performance results
> on a machine with 512 processors allocating 32 GB with an increasing
> number of threads (that are assigned a processor each).

Your V12 patches would apply well to 2.6.10-rc3, except that (as noted
before) your mailer or whatever is eating trailing whitespace: trivial
patch attached to apply before yours, removing that whitespace so yours
apply.  But what your patches need to apply to would be 2.6.10-mm.

Your i386 HIGHMEM64G 3level ptep_cmpxchg forgets to use cmpxchg8b, would
have tested out okay up to 4GB but not above: trivial patch attached.

Your scalability figures show a superb improvement.  But they are (I
presume) for the best case: intense initial faulting of distinct areas
of anonymous memory by parallel cpus running a multithreaded process.
This is not a common case: how much do what real-world apps benefit?

Since you also avoid taking the page_table_lock in handle_pte_fault,
there should be some scalability benefit to all kinds of page fault:
do you have any results to show how much (perhaps hard to quantify,
since even tmpfs file faults introduce other scalability issues)?

How do the scalability figures compare if you omit patch 7/7 i.e. revert
the per-task rss complications you added in for Linus?  I remain a fan
of sloppy rss, which you earlier showed to be accurate enough (I'd say),
though I guess should be checked on other architectures than your ia64.
I can't see the point of all that added ugliness for numbers which don't
need to be precise - but perhaps there's no way of rearranging fields,
and the point at which mm->(anon_)rss is updated (near up of mmap_sem?),
to avoid destructive cacheline bounce.  What I'm asking is, do you have
numbers to support 7/7?  Perhaps it's the fact you showed up to 512 cpus
this time, but only up to 32 with sloppy rss?  The ratios do look better
with the latest, but the numbers are altogether lower so we don't know.

The split rss patch, if it stays, needs some work.  For example,
task_statm uses "get_shared" to total up rss-anon_rss from the tasks,
but assumes mm->rss is already accurate.  Scrap the separate get_rss,
get_anon_rss, get_shared functions: just one get_rss to make a single
pass through the tasks adding up both rss and anon_rss at the same time.

I am bothered that every read of /proc/<pid>/status or /proc/<pid>/statm
is going to reread through all of that task_list each time; yet in that
massively parallel case that concerns you, there should be little change
to rss after startup.  Perhaps a later optimization would be to avoid
task_list completely for singly threaded processes.  I'd like get_rss to
update mm->rss and mm->anon_rss and flag it uptodate to avoid subsequent
task_list iterations, but the locking might defeat your whole purpose.

Updating current->rss in do_anonymous_page, current->anon_rss in
page_add_anon_rmap, is not always correct: ptrace's access_process_vm
uses get_user_pages on another task.  You need check that current->mm ==
mm (or vma->vm_mm) before incrementing current->rss or current->anon_rss,
fall back to mm (or vma->vm_mm) in rare case not (taking page_table_lock
for that).  You'll also need to check !(current->flags & PF_BORROWED_MM),
to guard against use_mm.  Or... just go back to sloppy rss.

Moving to the main patch, 1/7, the major issue I see there is the way
do_anonymous_page does update_mmu_cache after setting the pte, without
any page_table_lock to bracket them together.  Obviously no problem on
architectures where update_mmu_cache is a no-op!  But although there's
been plenty of discussion, particularly with Ben and Nick, I've not
noticed anything to guarantee that as safe on all architectures.  I do
think it's fine for you to post your patches before completing hooks in
all the arches, but isn't this a significant issue which needs to be
sorted before your patches go into -mm?  You hazily refer to such issues
in 0/7, but now you need to work with arch maintainers to settle them
and show the patches.

A lesser issue with the reordering in do_anonymous_page: don't you need
to move the lru_cache_add_active after the page_add_anon_rmap, to avoid
the very slight chance that vmscan will pick the page off the LRU and
unmap it before you've counted it in, hitting page_remove_rmap's
BUG_ON(page_mapcount(page) < 0)?

(I do wonder why do_anonymous_page calls mark_page_accessed as well as
lru_cache_add_active.  The other instances of lru_cache_add_active for
an anonymous page don't mark_page_accessed i.e. SetPageReferenced too,
why here?  But that's nothing new with your patch, and although you've
reordered the calls, the final page state is the same as before.)

Where handle_pte_fault does "entry = *pte" without page_table_lock:
you're quite right to passing down precisely that entry to the fault
handlers below, but there's still a problem on the 32bit architectures
supporting 64bit ptes (i386, mips, ppc), that the upper and lower ints
of entry may be out of synch.  Not a problem for do_anonymous_page, or
anything else relying on ptep_cmpxchg to check; but a problem for
do_wp_page (which could find !pfn_valid and kill the process) and
probably others (harder to think through).  Your 4/7 patch for i386 has
an unused atomic get_64bit function from Nick, I think you'll have to
define a get_pte_atomic macro and use get_64bit in its 64-on-32 cases.

Hmm, that will only work if you're using atomic set_64bit rather than
relying on page_table_lock in the complementary places which matter.
Which I believe you are indeed doing in your 3level set_pte.  Shouldn't
__set_64bit be using LOCK_PREFIX like __get_64bit, instead of lock?

But by making every set_pte use set_64bit, you are significantly slowing
down many operations which do not need that atomicity.  This is quite
visible in the fork/exec/shell results from lmbench on i386 PAE (and is
the only interesting difference, for good or bad, that I noticed with
your patches in lmbench on 2*HT*P4), which run 5-20% slower.  There are
no faults on dst mm (nor on src mm) while copy_page_range is copying,
so its set_ptes don't need to be atomic; likewise during zap_pte_range
(either mmap_sem is held exclusively, or it's in the final exit_mmap).
Probably revert set_pte and set_pte_atomic to what they were, and use
set_pte_atomic where it's needed.

Hugh

--8323328-747545378-1102617460=:17648
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="whitespace.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0412091837400.17648@localhost.localdomain>
Content-Description: Remove trailing whitespace before C.L. patches
Content-Disposition: attachment; filename="whitespace.patch"

LS0tIDIuNi4xMC1yYzMvaW5jbHVkZS9hc20taTM4Ni9zeXN0ZW0uaAkyMDA0
LTExLTE1IDE2OjIxOjEyLjAwMDAwMDAwMCArMDAwMA0KKysrIGxpbnV4L2lu
Y2x1ZGUvYXNtLWkzODYvc3lzdGVtLmgJMjAwNC0xMS0yMiAxNDo0NDozMC43
NjE5MDQ1OTIgKzAwMDANCkBAIC0yNzMsOSArMjczLDkgQEAgc3RhdGljIGlu
bGluZSB1bnNpZ25lZCBsb25nIF9fY21weGNoZyh2bw0KICNkZWZpbmUgY21w
eGNoZyhwdHIsbyxuKVwNCiAJKChfX3R5cGVvZl9fKCoocHRyKSkpX19jbXB4
Y2hnKChwdHIpLCh1bnNpZ25lZCBsb25nKShvKSxcDQogCQkJCQkodW5zaWdu
ZWQgbG9uZykobiksc2l6ZW9mKCoocHRyKSkpKQ0KLSAgICANCisNCiAjaWZk
ZWYgX19LRVJORUxfXw0KLXN0cnVjdCBhbHRfaW5zdHIgeyANCitzdHJ1Y3Qg
YWx0X2luc3RyIHsNCiAJX191OCAqaW5zdHI7IAkJLyogb3JpZ2luYWwgaW5z
dHJ1Y3Rpb24gKi8NCiAJX191OCAqcmVwbGFjZW1lbnQ7DQogCV9fdTggIGNw
dWlkOwkJLyogY3B1aWQgYml0IHNldCBmb3IgcmVwbGFjZW1lbnQgKi8NCi0t
LSAyLjYuMTAtcmMzL2luY2x1ZGUvYXNtLXMzOTAvcGdhbGxvYy5oCTIwMDQt
MDUtMTAgMDM6MzM6MzkuMDAwMDAwMDAwICswMTAwDQorKysgbGludXgvaW5j
bHVkZS9hc20tczM5MC9wZ2FsbG9jLmgJMjAwNC0xMS0yMiAxNDo1NDo0My43
MDQ3MjMxMjAgKzAwMDANCkBAIC05OSw3ICs5OSw3IEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCBwZ2RfcG9wdWxhdGUoc3RydWN0IG0NCiANCiAjZW5kaWYgLyog
X19zMzkweF9fICovDQogDQotc3RhdGljIGlubGluZSB2b2lkIA0KK3N0YXRp
YyBpbmxpbmUgdm9pZA0KIHBtZF9wb3B1bGF0ZV9rZXJuZWwoc3RydWN0IG1t
X3N0cnVjdCAqbW0sIHBtZF90ICpwbWQsIHB0ZV90ICpwdGUpDQogew0KICNp
Zm5kZWYgX19zMzkweF9fDQotLS0gMi42LjEwLXJjMy9tbS9tZW1vcnkuYwky
MDA0LTExLTE4IDE3OjU2OjExLjAwMDAwMDAwMCArMDAwMA0KKysrIGxpbnV4
L21tL21lbW9yeS5jCTIwMDQtMTEtMjIgMTQ6Mzk6MzMuOTI0MDMwODA4ICsw
MDAwDQpAQCAtMTQyNCw3ICsxNDI0LDcgQEAgb3V0Og0KIC8qDQogICogV2Ug
YXJlIGNhbGxlZCB3aXRoIHRoZSBNTSBzZW1hcGhvcmUgYW5kIHBhZ2VfdGFi
bGVfbG9jaw0KICAqIHNwaW5sb2NrIGhlbGQgdG8gcHJvdGVjdCBhZ2FpbnN0
IGNvbmN1cnJlbnQgZmF1bHRzIGluDQotICogbXVsdGl0aHJlYWRlZCBwcm9n
cmFtcy4gDQorICogbXVsdGl0aHJlYWRlZCBwcm9ncmFtcy4NCiAgKi8NCiBz
dGF0aWMgaW50DQogZG9fYW5vbnltb3VzX3BhZ2Uoc3RydWN0IG1tX3N0cnVj
dCAqbW0sIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KQEAgLTE2MTUs
NyArMTYxNSw3IEBAIHN0YXRpYyBpbnQgZG9fZmlsZV9wYWdlKHN0cnVjdCBt
bV9zdHJ1Y3QNCiAJICogRmFsbCBiYWNrIHRvIHRoZSBsaW5lYXIgbWFwcGlu
ZyBpZiB0aGUgZnMgZG9lcyBub3Qgc3VwcG9ydA0KIAkgKiAtPnBvcHVsYXRl
Og0KIAkgKi8NCi0JaWYgKCF2bWEtPnZtX29wcyB8fCAhdm1hLT52bV9vcHMt
PnBvcHVsYXRlIHx8IA0KKwlpZiAoIXZtYS0+dm1fb3BzIHx8ICF2bWEtPnZt
X29wcy0+cG9wdWxhdGUgfHwNCiAJCQkod3JpdGVfYWNjZXNzICYmICEodm1h
LT52bV9mbGFncyAmIFZNX1NIQVJFRCkpKSB7DQogCQlwdGVfY2xlYXIocHRl
KTsNCiAJCXJldHVybiBkb19ub19wYWdlKG1tLCB2bWEsIGFkZHJlc3MsIHdy
aXRlX2FjY2VzcywgcHRlLCBwbWQpOw0KDQo=
--8323328-747545378-1102617460=:17648
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ptep_cmpxchg.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0412091837401.17648@localhost.localdomain>
Content-Description: 3level ptep_cmpxchg use cmpxchg8b
Content-Disposition: attachment; filename="ptep_cmpxchg.patch"

LS0tIDIuNi4xMC1yYzMtY2wvaW5jbHVkZS9hc20taTM4Ni9wZ3RhYmxlLTNs
ZXZlbC5oCTIwMDQtMTItMDUgMTQ6MDE6MTEuMDAwMDAwMDAwICswMDAwDQor
KysgbGludXgvaW5jbHVkZS9hc20taTM4Ni9wZ3RhYmxlLTNsZXZlbC5oCTIw
MDQtMTItMDkgMTM6MTc6NDQuMDAwMDAwMDAwICswMDAwDQpAQCAtMTQ3LDcg
KzE0Nyw3IEBAIHN0YXRpYyBpbmxpbmUgcG1kX3QgcGZuX3BtZCh1bnNpZ25l
ZCBsb24NCiANCiBzdGF0aWMgaW5saW5lIGludCBwdGVwX2NtcHhjaGcoc3Ry
dWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgYWRkcmVz
cywgcHRlX3QgKnB0ZXAsIHB0ZV90IG9sZHZhbCwgcHRlX3QgbmV3dmFsKQ0K
IHsNCi0JcmV0dXJuIGNtcHhjaGcoKHVuc2lnbmVkIGludCAqKXB0ZXAsIHB0
ZV92YWwob2xkdmFsKSwgcHRlX3ZhbChuZXd2YWwpKSA9PSBwdGVfdmFsKG9s
ZHZhbCk7DQorCXJldHVybiBjbXB4Y2hnOGIoKHVuc2lnbmVkIGxvbmcgbG9u
ZyAqKXB0ZXAsIHB0ZV92YWwob2xkdmFsKSwgcHRlX3ZhbChuZXd2YWwpKSA9
PSBwdGVfdmFsKG9sZHZhbCk7DQogfQ0KIA0KIA0K
--8323328-747545378-1102617460=:17648--
