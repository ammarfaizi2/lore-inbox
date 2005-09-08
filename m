Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVIHPCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVIHPCw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVIHPCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:02:52 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:2657
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932528AbVIHPCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:02:51 -0400
Message-Id: <43206EFE0200007800024451@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:03:58 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmmod notifier chain
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part97B5F9CE.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part97B5F9CE.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Debugging and maintenance support code occasionally needs to know not
only of module insertions, but also modulke removals. This adds a
notifier
chain for this purpose.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/include/linux/module.h
2.6.13-rmmod-notifier/include/linux/module.h
--- 2.6.13/include/linux/module.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-rmmod-notifier/include/linux/module.h	2005-09-01
11:32:12.000000000 +0200
@@ -431,6 +431,8 @@ const struct exception_table_entry *sear
 
 int register_module_notifier(struct notifier_block * nb);
 int unregister_module_notifier(struct notifier_block * nb);
+int register_rmmodule_notifier(struct notifier_block * nb);
+int unregister_rmmodule_notifier(struct notifier_block * nb);
 
 extern void print_modules(void);
 
diff -Npru 2.6.13/kernel/module.c
2.6.13-rmmod-notifier/kernel/module.c
--- 2.6.13/kernel/module.c	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-rmmod-notifier/kernel/module.c	2005-09-02
09:46:24.000000000 +0200
@@ -62,6 +62,8 @@ static LIST_HEAD(modules);
 
 static DECLARE_MUTEX(notify_mutex);
 static struct notifier_block * module_notify_list;
+static DECLARE_MUTEX(rmmod_notify_mutex);
+static struct notifier_block * rmmodule_notify_list;
 
 int register_module_notifier(struct notifier_block * nb)
 {
@@ -83,6 +85,26 @@ int unregister_module_notifier(struct no
 }
 EXPORT_SYMBOL(unregister_module_notifier);
 
+int register_rmmodule_notifier(struct notifier_block * nb)
+{
+	int err;
+	down(&rmmod_notify_mutex);
+	err = notifier_chain_register(&rmmodule_notify_list, nb);
+	up(&rmmod_notify_mutex);
+	return err;
+}
+EXPORT_SYMBOL(register_rmmodule_notifier);
+
+int unregister_rmmodule_notifier(struct notifier_block * nb)
+{
+	int err;
+	down(&rmmod_notify_mutex);
+	err = notifier_chain_unregister(&rmmodule_notify_list, nb);
+	up(&rmmod_notify_mutex);
+	return err;
+}
+EXPORT_SYMBOL(unregister_rmmodule_notifier);
+
 /* We require a truly strong try_module_get() */
 static inline int strong_try_module_get(struct module *mod)
 {
@@ -1165,6 +1187,10 @@ static int __unlink_module(void *_mod)
 /* Free a module, remove from lists, etc (must hold module mutex). */
 static void free_module(struct module *mod)
 {
+	down(&rmmod_notify_mutex);
+	notifier_call_chain(&rmmodule_notify_list, MODULE_STATE_GOING,
mod);
+	up(&rmmod_notify_mutex);
+
 	/* Delete from various lists */
 	stop_machine_run(__unlink_module, mod, NR_CPUS);
 	remove_sect_attrs(mod);
@@ -1910,9 +1936,13 @@ sys_init_module(void __user *umod,
                    buggy refcounters. */
 		mod->state = MODULE_STATE_GOING;
 		synchronize_sched();
-		if (mod->unsafe)
+		if (mod->unsafe) {
 			printk(KERN_ERR "%s: module is now stuck!\n",
 			       mod->name);
+			down(&rmmod_notify_mutex);
+			notifier_call_chain(&rmmodule_notify_list,
MODULE_STATE_GOING, mod);
+			up(&rmmod_notify_mutex);
+		}
 		else {
 			module_put(mod);
 			down(&module_mutex);


--=__Part97B5F9CE.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-rmmod-notifier.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-rmmod-notifier.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkRlYnVnZ2luZyBhbmQgbWFpbnRlbmFuY2Ug
c3VwcG9ydCBjb2RlIG9jY2FzaW9uYWxseSBuZWVkcyB0byBrbm93IG5vdApvbmx5IG9mIG1vZHVs
ZSBpbnNlcnRpb25zLCBidXQgYWxzbyBtb2R1bGtlIHJlbW92YWxzLiBUaGlzIGFkZHMgYSBub3Rp
ZmllcgpjaGFpbiBmb3IgdGhpcyBwdXJwb3NlLgoKU2lnbmVkLW9mZi1ieTogSmFuIEJldWxpY2gg
PGpiZXVsaWNoQG5vdmVsbC5jb20+CgpkaWZmIC1OcHJ1IDIuNi4xMy9pbmNsdWRlL2xpbnV4L21v
ZHVsZS5oIDIuNi4xMy1ybW1vZC1ub3RpZmllci9pbmNsdWRlL2xpbnV4L21vZHVsZS5oCi0tLSAy
LjYuMTMvaW5jbHVkZS9saW51eC9tb2R1bGUuaAkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAw
MCArMDIwMAorKysgMi42LjEzLXJtbW9kLW5vdGlmaWVyL2luY2x1ZGUvbGludXgvbW9kdWxlLmgJ
MjAwNS0wOS0wMSAxMTozMjoxMi4wMDAwMDAwMDAgKzAyMDAKQEAgLTQzMSw2ICs0MzEsOCBAQCBj
b25zdCBzdHJ1Y3QgZXhjZXB0aW9uX3RhYmxlX2VudHJ5ICpzZWFyCiAKIGludCByZWdpc3Rlcl9t
b2R1bGVfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICogbmIpOwogaW50IHVucmVnaXN0
ZXJfbW9kdWxlX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqIG5iKTsKK2ludCByZWdp
c3Rlcl9ybW1vZHVsZV9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKiBuYik7CitpbnQg
dW5yZWdpc3Rlcl9ybW1vZHVsZV9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKiBuYik7
CiAKIGV4dGVybiB2b2lkIHByaW50X21vZHVsZXModm9pZCk7CiAKZGlmZiAtTnBydSAyLjYuMTMv
a2VybmVsL21vZHVsZS5jIDIuNi4xMy1ybW1vZC1ub3RpZmllci9rZXJuZWwvbW9kdWxlLmMKLS0t
IDIuNi4xMy9rZXJuZWwvbW9kdWxlLmMJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAy
MDAKKysrIDIuNi4xMy1ybW1vZC1ub3RpZmllci9rZXJuZWwvbW9kdWxlLmMJMjAwNS0wOS0wMiAw
OTo0NjoyNC4wMDAwMDAwMDAgKzAyMDAKQEAgLTYyLDYgKzYyLDggQEAgc3RhdGljIExJU1RfSEVB
RChtb2R1bGVzKTsKIAogc3RhdGljIERFQ0xBUkVfTVVURVgobm90aWZ5X211dGV4KTsKIHN0YXRp
YyBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKiBtb2R1bGVfbm90aWZ5X2xpc3Q7CitzdGF0aWMgREVD
TEFSRV9NVVRFWChybW1vZF9ub3RpZnlfbXV0ZXgpOworc3RhdGljIHN0cnVjdCBub3RpZmllcl9i
bG9jayAqIHJtbW9kdWxlX25vdGlmeV9saXN0OwogCiBpbnQgcmVnaXN0ZXJfbW9kdWxlX25vdGlm
aWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqIG5iKQogewpAQCAtODMsNiArODUsMjYgQEAgaW50
IHVucmVnaXN0ZXJfbW9kdWxlX25vdGlmaWVyKHN0cnVjdCBubwogfQogRVhQT1JUX1NZTUJPTCh1
bnJlZ2lzdGVyX21vZHVsZV9ub3RpZmllcik7CiAKK2ludCByZWdpc3Rlcl9ybW1vZHVsZV9ub3Rp
ZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKiBuYikKK3sKKwlpbnQgZXJyOworCWRvd24oJnJt
bW9kX25vdGlmeV9tdXRleCk7CisJZXJyID0gbm90aWZpZXJfY2hhaW5fcmVnaXN0ZXIoJnJtbW9k
dWxlX25vdGlmeV9saXN0LCBuYik7CisJdXAoJnJtbW9kX25vdGlmeV9tdXRleCk7CisJcmV0dXJu
IGVycjsKK30KK0VYUE9SVF9TWU1CT0wocmVnaXN0ZXJfcm1tb2R1bGVfbm90aWZpZXIpOworCitp
bnQgdW5yZWdpc3Rlcl9ybW1vZHVsZV9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKiBu
YikKK3sKKwlpbnQgZXJyOworCWRvd24oJnJtbW9kX25vdGlmeV9tdXRleCk7CisJZXJyID0gbm90
aWZpZXJfY2hhaW5fdW5yZWdpc3Rlcigmcm1tb2R1bGVfbm90aWZ5X2xpc3QsIG5iKTsKKwl1cCgm
cm1tb2Rfbm90aWZ5X211dGV4KTsKKwlyZXR1cm4gZXJyOworfQorRVhQT1JUX1NZTUJPTCh1bnJl
Z2lzdGVyX3JtbW9kdWxlX25vdGlmaWVyKTsKKwogLyogV2UgcmVxdWlyZSBhIHRydWx5IHN0cm9u
ZyB0cnlfbW9kdWxlX2dldCgpICovCiBzdGF0aWMgaW5saW5lIGludCBzdHJvbmdfdHJ5X21vZHVs
ZV9nZXQoc3RydWN0IG1vZHVsZSAqbW9kKQogewpAQCAtMTE2NSw2ICsxMTg3LDEwIEBAIHN0YXRp
YyBpbnQgX191bmxpbmtfbW9kdWxlKHZvaWQgKl9tb2QpCiAvKiBGcmVlIGEgbW9kdWxlLCByZW1v
dmUgZnJvbSBsaXN0cywgZXRjIChtdXN0IGhvbGQgbW9kdWxlIG11dGV4KS4gKi8KIHN0YXRpYyB2
b2lkIGZyZWVfbW9kdWxlKHN0cnVjdCBtb2R1bGUgKm1vZCkKIHsKKwlkb3duKCZybW1vZF9ub3Rp
ZnlfbXV0ZXgpOworCW5vdGlmaWVyX2NhbGxfY2hhaW4oJnJtbW9kdWxlX25vdGlmeV9saXN0LCBN
T0RVTEVfU1RBVEVfR09JTkcsIG1vZCk7CisJdXAoJnJtbW9kX25vdGlmeV9tdXRleCk7CisKIAkv
KiBEZWxldGUgZnJvbSB2YXJpb3VzIGxpc3RzICovCiAJc3RvcF9tYWNoaW5lX3J1bihfX3VubGlu
a19tb2R1bGUsIG1vZCwgTlJfQ1BVUyk7CiAJcmVtb3ZlX3NlY3RfYXR0cnMobW9kKTsKQEAgLTE5
MTAsOSArMTkzNiwxMyBAQCBzeXNfaW5pdF9tb2R1bGUodm9pZCBfX3VzZXIgKnVtb2QsCiAgICAg
ICAgICAgICAgICAgICAgYnVnZ3kgcmVmY291bnRlcnMuICovCiAJCW1vZC0+c3RhdGUgPSBNT0RV
TEVfU1RBVEVfR09JTkc7CiAJCXN5bmNocm9uaXplX3NjaGVkKCk7Ci0JCWlmIChtb2QtPnVuc2Fm
ZSkKKwkJaWYgKG1vZC0+dW5zYWZlKSB7CiAJCQlwcmludGsoS0VSTl9FUlIgIiVzOiBtb2R1bGUg
aXMgbm93IHN0dWNrIVxuIiwKIAkJCSAgICAgICBtb2QtPm5hbWUpOworCQkJZG93bigmcm1tb2Rf
bm90aWZ5X211dGV4KTsKKwkJCW5vdGlmaWVyX2NhbGxfY2hhaW4oJnJtbW9kdWxlX25vdGlmeV9s
aXN0LCBNT0RVTEVfU1RBVEVfR09JTkcsIG1vZCk7CisJCQl1cCgmcm1tb2Rfbm90aWZ5X211dGV4
KTsKKwkJfQogCQllbHNlIHsKIAkJCW1vZHVsZV9wdXQobW9kKTsKIAkJCWRvd24oJm1vZHVsZV9t
dXRleCk7Cg==

--=__Part97B5F9CE.0__=--
