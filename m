Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbVIIJlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVIIJlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbVIIJlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:41:23 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:33813
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030198AbVIIJlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:41:22 -0400
Message-Id: <4321752202000078000248CC@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 11:42:26 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmmod notifier chain (attempt 2)
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com> <20050908153314.GM3966@smtp.west.cox.net>
In-Reply-To: <20050908153314.GM3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part41632E12.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part41632E12.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>>> Tom Rini <trini@kernel.crashing.org> 08.09.05 17:33:14 >>>
>On Thu, Sep 08, 2005 at 05:03:58PM +0200, Jan Beulich wrote:
>It's possible to do this a bit differently, if I'm guessing right at
>what NLKD does.  The following is from the KGDB patches (trimmed of
some
>other, unrelated to the notify part code):

I don't think the way you showed kgdb does this is quite useful;
especially calling the notifier chain with MODULE_GONE and a NULL module
seems rather pointless. I therefore used the placement as in the first
patch version, but deleted the extra notifier chain:

(Note: Patch also attached because the inline version is certain to
get
line wrapped.)

Debugging and maintenance support code occasionally needs to know not
only of module insertions, but also modulke removals. This adds a
notifier
chain for this purpose.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/include/linux/module.h
2.6.13-rmmod-notify/include/linux/module.h
--- 2.6.13/include/linux/module.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-rmmod-notify/include/linux/module.h	2005-09-09
10:28:29.490342264 +0200
@@ -210,6 +210,7 @@ enum module_state
 	MODULE_STATE_LIVE,
 	MODULE_STATE_COMING,
 	MODULE_STATE_GOING,
+	MODULE_STATE_GONE
 };
 
 /* Similar stuff for section attributes. */
diff -Npru 2.6.13/kernel/module.c 2.6.13-rmmod-notify/kernel/module.c
--- 2.6.13/kernel/module.c	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-rmmod-notify/kernel/module.c	2005-09-09
10:29:10.935041712 +0200
@@ -1165,6 +1165,10 @@ static int __unlink_module(void *_mod)
 /* Free a module, remove from lists, etc (must hold module mutex). */
 static void free_module(struct module *mod)
 {
+	down(&notify_mutex);
+	notifier_call_chain(&module_notify_list, MODULE_STATE_GONE,
mod);
+	up(&notify_mutex);
+
 	/* Delete from various lists */
 	stop_machine_run(__unlink_module, mod, NR_CPUS);
 	remove_sect_attrs(mod);
@@ -1910,9 +1914,13 @@ sys_init_module(void __user *umod,
                    buggy refcounters. */
 		mod->state = MODULE_STATE_GOING;
 		synchronize_sched();
-		if (mod->unsafe)
+		if (mod->unsafe) {
 			printk(KERN_ERR "%s: module is now stuck!\n",
 			       mod->name);
+			down(&notify_mutex);
+			notifier_call_chain(&module_notify_list,
MODULE_STATE_GONE, mod);
+			up(&notify_mutex);
+		}
 		else {
 			module_put(mod);
 			down(&module_mutex);


--=__Part41632E12.1__=
Content-Type: application/octet-stream; name="linux-2.6.13-rmmod-notify.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-rmmod-notify.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkRlYnVnZ2luZyBhbmQgbWFpbnRlbmFuY2Ug
c3VwcG9ydCBjb2RlIG9jY2FzaW9uYWxseSBuZWVkcyB0byBrbm93IG5vdApvbmx5IG9mIG1vZHVs
ZSBpbnNlcnRpb25zLCBidXQgYWxzbyBtb2R1bGtlIHJlbW92YWxzLiBUaGlzIGFkZHMgYSBub3Rp
ZmllcgpjaGFpbiBmb3IgdGhpcyBwdXJwb3NlLgoKU2lnbmVkLW9mZi1ieTogSmFuIEJldWxpY2gg
PGpiZXVsaWNoQG5vdmVsbC5jb20+CgpkaWZmIC1OcHJ1IDIuNi4xMy9pbmNsdWRlL2xpbnV4L21v
ZHVsZS5oIDIuNi4xMy1ybW1vZC1ub3RpZnkvaW5jbHVkZS9saW51eC9tb2R1bGUuaAotLS0gMi42
LjEzL2luY2x1ZGUvbGludXgvbW9kdWxlLmgJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAg
KzAyMDAKKysrIDIuNi4xMy1ybW1vZC1ub3RpZnkvaW5jbHVkZS9saW51eC9tb2R1bGUuaAkyMDA1
LTA5LTA5IDEwOjI4OjI5LjQ5MDM0MjI2NCArMDIwMApAQCAtMjEwLDYgKzIxMCw3IEBAIGVudW0g
bW9kdWxlX3N0YXRlCiAJTU9EVUxFX1NUQVRFX0xJVkUsCiAJTU9EVUxFX1NUQVRFX0NPTUlORywK
IAlNT0RVTEVfU1RBVEVfR09JTkcsCisJTU9EVUxFX1NUQVRFX0dPTkUKIH07CiAKIC8qIFNpbWls
YXIgc3R1ZmYgZm9yIHNlY3Rpb24gYXR0cmlidXRlcy4gKi8KZGlmZiAtTnBydSAyLjYuMTMva2Vy
bmVsL21vZHVsZS5jIDIuNi4xMy1ybW1vZC1ub3RpZnkva2VybmVsL21vZHVsZS5jCi0tLSAyLjYu
MTMva2VybmVsL21vZHVsZS5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisr
KyAyLjYuMTMtcm1tb2Qtbm90aWZ5L2tlcm5lbC9tb2R1bGUuYwkyMDA1LTA5LTA5IDEwOjI5OjEw
LjkzNTA0MTcxMiArMDIwMApAQCAtMTE2NSw2ICsxMTY1LDEwIEBAIHN0YXRpYyBpbnQgX191bmxp
bmtfbW9kdWxlKHZvaWQgKl9tb2QpCiAvKiBGcmVlIGEgbW9kdWxlLCByZW1vdmUgZnJvbSBsaXN0
cywgZXRjIChtdXN0IGhvbGQgbW9kdWxlIG11dGV4KS4gKi8KIHN0YXRpYyB2b2lkIGZyZWVfbW9k
dWxlKHN0cnVjdCBtb2R1bGUgKm1vZCkKIHsKKwlkb3duKCZub3RpZnlfbXV0ZXgpOworCW5vdGlm
aWVyX2NhbGxfY2hhaW4oJm1vZHVsZV9ub3RpZnlfbGlzdCwgTU9EVUxFX1NUQVRFX0dPTkUsIG1v
ZCk7CisJdXAoJm5vdGlmeV9tdXRleCk7CisKIAkvKiBEZWxldGUgZnJvbSB2YXJpb3VzIGxpc3Rz
ICovCiAJc3RvcF9tYWNoaW5lX3J1bihfX3VubGlua19tb2R1bGUsIG1vZCwgTlJfQ1BVUyk7CiAJ
cmVtb3ZlX3NlY3RfYXR0cnMobW9kKTsKQEAgLTE5MTAsOSArMTkxNCwxMyBAQCBzeXNfaW5pdF9t
b2R1bGUodm9pZCBfX3VzZXIgKnVtb2QsCiAgICAgICAgICAgICAgICAgICAgYnVnZ3kgcmVmY291
bnRlcnMuICovCiAJCW1vZC0+c3RhdGUgPSBNT0RVTEVfU1RBVEVfR09JTkc7CiAJCXN5bmNocm9u
aXplX3NjaGVkKCk7Ci0JCWlmIChtb2QtPnVuc2FmZSkKKwkJaWYgKG1vZC0+dW5zYWZlKSB7CiAJ
CQlwcmludGsoS0VSTl9FUlIgIiVzOiBtb2R1bGUgaXMgbm93IHN0dWNrIVxuIiwKIAkJCSAgICAg
ICBtb2QtPm5hbWUpOworCQkJZG93bigmbm90aWZ5X211dGV4KTsKKwkJCW5vdGlmaWVyX2NhbGxf
Y2hhaW4oJm1vZHVsZV9ub3RpZnlfbGlzdCwgTU9EVUxFX1NUQVRFX0dPTkUsIG1vZCk7CisJCQl1
cCgmbm90aWZ5X211dGV4KTsKKwkJfQogCQllbHNlIHsKIAkJCW1vZHVsZV9wdXQobW9kKTsKIAkJ
CWRvd24oJm1vZHVsZV9tdXRleCk7Cg==

--=__Part41632E12.1__=--
