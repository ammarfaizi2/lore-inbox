Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTLUG2p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 01:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTLUG2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 01:28:45 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:17050
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262196AbTLUG2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 01:28:41 -0500
Message-ID: <3FE53D27.5090406@redhat.com>
Date: Sat, 20 Dec 2003 22:26:47 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>
Subject: O_CANLINK and flink
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090000030502090602090802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090000030502090602090802
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is a refresh of a patch I've sent quite some time ago (in April).
That old patch introduced a flink() syscall without proper security
measures.  I've now integrated a proposal for how to fix it.

int flink (int fd, const char *newname)

The file associated with fd is linked with the newname.  But this will
only succeed if the file descriptor fd was created with the O_CANLINK
flag set.  It is not possible to set O_CANLINK afterwards,
fcntl(F_SETFL) cannot set the bit, this is important.

The changes to implement this are pretty trivial.  The patch consists of
more than a few lines only because the link code is reusing as much as
possible in the link() and flink() code and the O_* flags definitions
were reformatted.


The purpose of this change is two fold.

For now it is possible to use this functionality in a couple of ways:

~ we can create quasi-anonymous files.  Like

    fd = open ("RANDOM", O_EXCL|O_CREAT|O_CANLINK|O_RDWR, 0600);
    unlink ("RANDOM");
    ... do some work ...
    if (work is auccessful)
      flink (fd, "REALNAME");
    close (fd)

~ file descriptors which are passed to a process (by inheritance from
the parent, through Unix sockets, ...) can be linked to the filesystem.


Longer-term I think the kernel should support real anonymous files which
can optionally be created with the O_CANLINK flag.  This would "only"
save the unlink() call in the example above but not having the file at
all in the filesystem namespace eliminates one more possible attack vector.

This patch covers so far only x86.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/5T0n2ijCOnn/RHQRAmEOAJ9ZiAfMl0EcudUUREFki0Axpp/MLwCfc9qS
HMTHoEkve1Tjc70jQTvdElw=
=InNQ
-----END PGP SIGNATURE-----

--------------090000030502090602090802
Content-Type: text/plain;
 name="d-canlink"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="d-canlink"

LS0tIGxpbnV4LTIuNi9hcmNoL2kzODYva2VybmVsL2VudHJ5LlMtY2FubGluawkyMDAzLTEx
LTIxIDIwOjMxOjAxLjAwMDAwMDAwMCAtMDgwMAorKysgbGludXgtMi42L2FyY2gvaTM4Ni9r
ZXJuZWwvZW50cnkuUwkyMDAzLTEyLTIwIDIxOjMzOjI3LjAwMDAwMDAwMCAtMDgwMApAQCAt
ODgyLDUgKzg4Miw2IEBACiAJLmxvbmcgc3lzX3V0aW1lcwogIAkubG9uZyBzeXNfZmFkdmlz
ZTY0XzY0CiAJLmxvbmcgc3lzX25pX3N5c2NhbGwJLyogc3lzX3ZzZXJ2ZXIgKi8KKwkubG9u
ZyBzeXNfZmxpbmsKIAogc3lzY2FsbF90YWJsZV9zaXplPSguLXN5c19jYWxsX3RhYmxlKQot
LS0gbGludXgtMi42L2ZzL25hbWVpLmMtY2FubGluawkyMDAzLTEwLTAyIDEzOjU3OjMwLjAw
MDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42L2ZzL25hbWVpLmMJMjAwMy0xMi0yMCAyMToz
Mjo1MC4wMDAwMDAwMDAgLTA4MDAKQEAgLTE3LDYgKzE3LDcgQEAKICNpbmNsdWRlIDxsaW51
eC9pbml0Lmg+CiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CiAjaW5jbHVkZSA8bGludXgv
c2xhYi5oPgorI2luY2x1ZGUgPGxpbnV4L2ZpbGUuaD4KICNpbmNsdWRlIDxsaW51eC9mcy5o
PgogI2luY2x1ZGUgPGxpbnV4L25hbWVpLmg+CiAjaW5jbHVkZSA8bGludXgvcXVvdGFvcHMu
aD4KQEAgLTE4NDcsMTAgKzE4NDgsMTEgQEAKICAqIHdpdGggbGludXggMi4wLCBhbmQgdG8g
YXZvaWQgaGFyZC1saW5raW5nIHRvIGRpcmVjdG9yaWVzCiAgKiBhbmQgb3RoZXIgc3BlY2lh
bCBmaWxlcy4gIC0tQURNCiAgKi8KLWFzbWxpbmthZ2UgbG9uZyBzeXNfbGluayhjb25zdCBj
aGFyIF9fdXNlciAqIG9sZG5hbWUsIGNvbnN0IGNoYXIgX191c2VyICogbmV3bmFtZSkKK3N0
YXRpYyBsb25nIGxpbmtfY29tbW9uKHN0cnVjdCB2ZnNtb3VudCAqb2xkX21udCwgc3RydWN0
IGRlbnRyeSAqb2xkX2RlbnRyeSwKKwkJCWNvbnN0IGNoYXIgX191c2VyICogbmV3bmFtZSkK
IHsKIAlzdHJ1Y3QgZGVudHJ5ICpuZXdfZGVudHJ5OwotCXN0cnVjdCBuYW1laWRhdGEgbmQs
IG9sZF9uZDsKKwlzdHJ1Y3QgbmFtZWlkYXRhIG5kOwogCWludCBlcnJvcjsKIAljaGFyICog
dG87CiAKQEAgLTE4NTgsMzIgKzE4NjAsNTYgQEAKIAlpZiAoSVNfRVJSKHRvKSkKIAkJcmV0
dXJuIFBUUl9FUlIodG8pOwogCi0JZXJyb3IgPSBfX3VzZXJfd2FsayhvbGRuYW1lLCAwLCAm
b2xkX25kKTsKLQlpZiAoZXJyb3IpCi0JCWdvdG8gZXhpdDsKIAllcnJvciA9IHBhdGhfbG9v
a3VwKHRvLCBMT09LVVBfUEFSRU5ULCAmbmQpOwogCWlmIChlcnJvcikKLQkJZ290byBvdXQ7
CisJCWdvdG8gZXhpdDsKIAllcnJvciA9IC1FWERFVjsKLQlpZiAob2xkX25kLm1udCAhPSBu
ZC5tbnQpCisJaWYgKG9sZF9tbnQgIT0gbmQubW50KQogCQlnb3RvIG91dF9yZWxlYXNlOwog
CW5ld19kZW50cnkgPSBsb29rdXBfY3JlYXRlKCZuZCwgMCk7CiAJZXJyb3IgPSBQVFJfRVJS
KG5ld19kZW50cnkpOwogCWlmICghSVNfRVJSKG5ld19kZW50cnkpKSB7Ci0JCWVycm9yID0g
dmZzX2xpbmsob2xkX25kLmRlbnRyeSwgbmQuZGVudHJ5LT5kX2lub2RlLCBuZXdfZGVudHJ5
KTsKKwkJZXJyb3IgPSB2ZnNfbGluayhvbGRfZGVudHJ5LCBuZC5kZW50cnktPmRfaW5vZGUs
IG5ld19kZW50cnkpOwogCQlkcHV0KG5ld19kZW50cnkpOwogCX0KIAl1cCgmbmQuZGVudHJ5
LT5kX2lub2RlLT5pX3NlbSk7CiBvdXRfcmVsZWFzZToKIAlwYXRoX3JlbGVhc2UoJm5kKTsK
LW91dDoKLQlwYXRoX3JlbGVhc2UoJm9sZF9uZCk7CiBleGl0OgogCXB1dG5hbWUodG8pOwog
CiAJcmV0dXJuIGVycm9yOwogfQogCithc21saW5rYWdlIGxvbmcgc3lzX2xpbmsoY29uc3Qg
Y2hhciAqb2xkbmFtZSwgY29uc3QgY2hhciAqbmV3bmFtZSkKK3sKKwlzdHJ1Y3QgbmFtZWlk
YXRhIG9sZF9uZDsKKwlpbnQgZXJyb3I7CisKKwllcnJvciA9IF9fdXNlcl93YWxrKG9sZG5h
bWUsIDAsICZvbGRfbmQpOworCWlmICghZXJyb3IpIHsKKwkJZXJyb3IgPSBsaW5rX2NvbW1v
bihvbGRfbmQubW50LCBvbGRfbmQuZGVudHJ5LCBuZXduYW1lKTsKKwkJcGF0aF9yZWxlYXNl
KCZvbGRfbmQpOworCX0KKwlyZXR1cm4gZXJyb3I7Cit9CisKK2FzbWxpbmthZ2UgbG9uZyBz
eXNfZmxpbmsodW5zaWduZWQgaW50IGZkLCBjb25zdCBjaGFyICpuZXduYW1lKQoreworCXN0
cnVjdCBmaWxlICpmaWxlOworCWludCBlcnJvciA9IC1FQkFERjsKKworCWZpbGUgPSBmZ2V0
KGZkKTsKKwlpZiAoZmlsZSkgeworCQllcnJvciA9IC1FUEVSTTsKKwkJaWYgKGZpbGUtPmZf
ZmxhZ3MgJiBPX0NBTkxJTkspCisJCQllcnJvciA9IGxpbmtfY29tbW9uKGZpbGUtPmZfdmZz
bW50LCBmaWxlLT5mX2RlbnRyeSwKKwkJCQkJICAgIG5ld25hbWUpOworCQlmcHV0KGZpbGUp
OworCX0KKwlyZXR1cm4gZXJyb3I7Cit9CisKIC8qCiAgKiBUaGUgd29yc3Qgb2YgYWxsIG5h
bWVzcGFjZSBvcGVyYXRpb25zIC0gcmVuYW1pbmcgZGlyZWN0b3J5LiAiUGVydmVydGVkIgog
ICogZG9lc24ndCBldmVuIHN0YXJ0IHRvIGRlc2NyaWJlIGl0LiBTb21lYm9keSBpbiBVQ0Ig
aGFkIGEgaGVjayBvZiBhIHRyaXAuLi4KLS0tIGxpbnV4LTIuNi9pbmNsdWRlL2FzbS1pMzg2
L2ZjbnRsLmgtY2FubGluawkyMDAyLTA5LTI2IDEyOjE2OjUzLjAwMDAwMDAwMCAtMDcwMAor
KysgbGludXgtMi42L2luY2x1ZGUvYXNtLWkzODYvZmNudGwuaAkyMDAzLTEyLTIwIDIxOjI2
OjM5LjAwMDAwMDAwMCAtMDgwMApAQCAtMTQsMTIgKzE0LDEzIEBACiAjZGVmaW5lIE9fQVBQ
RU5ECSAgMDIwMDAKICNkZWZpbmUgT19OT05CTE9DSwkgIDA0MDAwCiAjZGVmaW5lIE9fTkRF
TEFZCU9fTk9OQkxPQ0sKLSNkZWZpbmUgT19TWU5DCQkgMDEwMDAwCi0jZGVmaW5lIEZBU1lO
QwkJIDAyMDAwMAkvKiBmY250bCwgZm9yIEJTRCBjb21wYXRpYmlsaXR5ICovCi0jZGVmaW5l
IE9fRElSRUNUCSAwNDAwMDAJLyogZGlyZWN0IGRpc2sgYWNjZXNzIGhpbnQgKi8KLSNkZWZp
bmUgT19MQVJHRUZJTEUJMDEwMDAwMAotI2RlZmluZSBPX0RJUkVDVE9SWQkwMjAwMDAwCS8q
IG11c3QgYmUgYSBkaXJlY3RvcnkgKi8KLSNkZWZpbmUgT19OT0ZPTExPVwkwNDAwMDAwIC8q
IGRvbid0IGZvbGxvdyBsaW5rcyAqLworI2RlZmluZSBPX1NZTkMJCSAgMDEwMDAwCisjZGVm
aW5lIEZBU1lOQwkJICAwMjAwMDAJLyogZmNudGwsIGZvciBCU0QgY29tcGF0aWJpbGl0eSAq
LworI2RlZmluZSBPX0RJUkVDVAkgIDA0MDAwMAkvKiBkaXJlY3QgZGlzayBhY2Nlc3MgaGlu
dCAqLworI2RlZmluZSBPX0xBUkdFRklMRQkgMDEwMDAwMAorI2RlZmluZSBPX0RJUkVDVE9S
WQkgMDIwMDAwMAkvKiBtdXN0IGJlIGEgZGlyZWN0b3J5ICovCisjZGVmaW5lIE9fTk9GT0xM
T1cJIDA0MDAwMDAJLyogZG9uJ3QgZm9sbG93IGxpbmtzICovCisjZGVmaW5lIE9fQ0FOTElO
SwkwMTAwMDAwMAkvKiBmbGluayBjYW4gYmUgdXNlZCAqLwogCiAjZGVmaW5lIEZfRFVQRkQJ
CTAJLyogZHVwICovCiAjZGVmaW5lIEZfR0VURkQJCTEJLyogZ2V0IGNsb3NlX29uX2V4ZWMg
Ki8KLS0tIGxpbnV4LTIuNi9pbmNsdWRlL2FzbS1pMzg2L3VuaXN0ZC5oLWNhbmxpbmsJMjAw
My0xMC0wMiAxMzo1NzozMC4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNi9pbmNsdWRl
L2FzbS1pMzg2L3VuaXN0ZC5oCTIwMDMtMTItMjAgMjI6MjU6MjEuMDAwMDAwMDAwIC0wODAw
CkBAIC0yNzksOCArMjc5LDkgQEAKICNkZWZpbmUgX19OUl91dGltZXMJCTI3MQogI2RlZmlu
ZSBfX05SX2ZhZHZpc2U2NF82NAkyNzIKICNkZWZpbmUgX19OUl92c2VydmVyCQkyNzMKKyNk
ZWZpbmUgX19OUl9mbGluawkJMjc0CiAKLSNkZWZpbmUgTlJfc3lzY2FsbHMgMjc0CisjZGVm
aW5lIE5SX3N5c2NhbGxzIDI3NQogCiAvKiB1c2VyLXZpc2libGUgZXJyb3IgbnVtYmVycyBh
cmUgaW4gdGhlIHJhbmdlIC0xIC0gLTEyNDogc2VlIDxhc20taTM4Ni9lcnJuby5oPiAqLwog
Cg==
--------------090000030502090602090802--
