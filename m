Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262998AbREaPH3>; Thu, 31 May 2001 11:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263034AbREaPHT>; Thu, 31 May 2001 11:07:19 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:58296 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262998AbREaPHK>; Thu, 31 May 2001 11:07:10 -0400
From: COTTE@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Message-ID: <C1256A5D.00530071.00@d12mta11.de.ibm.com>
Date: Thu, 31 May 2001 17:04:06 +0200
Subject: Patch against ll_rw_blk and blkdev.h in 2.2
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=La1HrIzDHV4YTiUU6KgjBGjFGH5Wm5WPN0OU7lcClyYJOMSbwS3O3T5W"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=La1HrIzDHV4YTiUU6KgjBGjFGH5Wm5WPN0OU7lcClyYJOMSbwS3O3T5W
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable




Hello Alan, Hi list-readers!

I'd like to suggest a change to ll_rw_blk and blkdev.h in the 2.2-Kerne=
l:

rational
-----
On mainframe architectures, we're running a large number of disks on a
System. Our disk-device-driver (dasd) has a static major number for the=

first 64 disks and uses dynamicaly allocated ones for the rest.
In ll_rw_blk there are static allocated lists (CASE_COALESCE*) for majo=
rs
that support merging requests (including our static one DASD_MAJOR).
For the dynamic allocated majors, our requests do not get clustered whi=
ch
leads to a major performance drop.

the patch
-------
I added a global int field named blk_merge_rule to blkdev.h, which cont=
ains
the device driver's  rule about merging. I did three definitions for th=
is
variable: do not merge (the default), do merge, and merge but not the f=
irst
request (like for the static majors).
The device driver has to set this field for a major it uses and reset i=
t
to BLK_MERGE_NEVER when freeing the major.
In ll_rw_blk I invented a case, which is taken if there is no static
setting
for the major. It then processes like set in blk_merge_rule.
If the device driver has a static setting for its major, it does'nt hav=
e to
care
about blk_merge_rule. If the device driverhas no static setting and doe=
s
not
set blk_merge_rule, the requests do not get merged (same as before).

I attached the patch (sorry, notes messes up white-spaces when embeddin=
g
stuff), it applies against 2.2.19. (See attached file: dyn_majors.diff)=


What is your opinion about including it into the standard brach?
Why not change all block-dev-drivers so that they set blk_merge_rule an=
d
throw out the CASE_COALESCE* stuff and simplify the code again?

mit freundlichem Gru=DF / with kind regards
Carsten Otte

IBM Deutschland Entwicklung GmbH
Linux for 390/zSeries Development - Device Driver Team
Phone: +49/07031/16-4076
IBM internal phone: *120-4076
--
We are Linux.
Resistance indicates that you're missing the point!
=

--0__=La1HrIzDHV4YTiUU6KgjBGjFGH5Wm5WPN0OU7lcClyYJOMSbwS3O3T5W
Content-type: application/octet-stream; 
	name="dyn_majors.diff"
Content-Disposition: attachment; filename="dyn_majors.diff"
Content-transfer-encoding: base64

SW5kZXg6IGRyaXZlcnMvYmxvY2svbGxfcndfYmxrLmMKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2hv
bWUvY3ZzL2xpbnV4L2RyaXZlcnMvYmxvY2svbGxfcndfYmxrLmMsdgpyZXRyaWV2aW5nIHJldmlz
aW9uIDEuMTUKcmV0cmlldmluZyByZXZpc2lvbiAxLjE3CmRpZmYgLXUgLXcgLXIxLjE1IC1yMS4x
NwotLS0gZHJpdmVycy9ibG9jay9sbF9yd19ibGsuYwkyMDAxLzAzLzI4IDExOjM4OjQ5CTEuMTUK
KysrIGRyaXZlcnMvYmxvY2svbGxfcndfYmxrLmMJMjAwMS8wNS8zMSAxNDoxNjoyMAkxLjE3CkBA
IC00LDYgKzQsNyBAQAogICogQ29weXJpZ2h0IChDKSAxOTkxLCAxOTkyIExpbnVzIFRvcnZhbGRz
CiAgKiBDb3B5cmlnaHQgKEMpIDE5OTQsICAgICAgS2FybCBLZXl0ZTogQWRkZWQgc3VwcG9ydCBm
b3IgZGlzayBzdGF0aXN0aWNzCiAgKiBFbGV2YXRvciBsYXRlbmN5LCAoQykgMjAwMCAgQW5kcmVh
IEFyY2FuZ2VsaSA8YW5kcmVhQHN1c2UuZGU+IFN1U0UKKyAqIE1lcmdpbmcgZm9yIGR5bi4gYWxs
b2NhdGVkIG1ham9ycywgKEMpIDIwMDEgIENhcnN0ZW4gT3R0ZSA8Y290dGVAZGUuaWJtLmNvbT4g
SUJNCiAgKi8KIAogLyoKQEAgLTExOSw2ICsxMjAsMTIgQEAKICAqLwogaW50ICogbWF4X3NlZ21l
bnRzW01BWF9CTEtERVZdOwogCisvKgorICogcnVsZSB0byBtZXJnZSByZXF1ZXN0cyBmb3IgbWFq
b3IKKyAqCisgKi8KK2ludCBibGtfbWVyZ2VfcnVsZVtNQVhfQkxLREVWXTsKKwogc3RhdGljIGlu
bGluZSBpbnQgZ2V0X21heF9zZWN0b3JzKGtkZXZfdCBkZXYpCiB7CiAJaWYgKCFtYXhfc2VjdG9y
c1tNQUpPUihkZXYpXSkKQEAgLTU3OCw2ICs1ODUsNyBAQAogCWludCByd19haGVhZCwgbWF4X3Jl
cSwgbWF4X3NlY3RvcnMsIG1heF9zZWdtZW50czsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwogCWlu
dCBiYWNrLCBmcm9udDsKKwlpbnQgc2tpcF9maXJzdF9yZXE7CiAKIAljb3VudCA9IGJoLT5iX3Np
emUgPj4gOTsKIAlzZWN0b3IgPSBiaC0+Yl9yc2VjdG9yOwpAQCAtNjYwLDEyICs2NjgsMjkgQEAK
IAkgKi8KIAlzcGluX2xvY2tfaXJxc2F2ZSgmaW9fcmVxdWVzdF9sb2NrLGZsYWdzKTsKIAlyZXEg
PSAqZ2V0X3F1ZXVlKGJoLT5iX3JkZXYpOworICAgICAgICAvKgorCSAqIERvIG5vdCBza2lwIG1l
cmdpbmcgZmlyc3QgcmVxdWVzdCBpbiBxdWV1ZSAKKwkgKi8KKwlza2lwX2ZpcnN0X3JlcSA9IDA7
CiAJaWYgKCFyZXEpIHsKIAkJLyogTUQgYW5kIGxvb3AgY2FuJ3QgaGFuZGxlIHBsdWdnaW5nIHdp
dGhvdXQgZGVhZGxvY2tpbmcgKi8KIAkJaWYgKG1ham9yICE9IE1EX01BSk9SICYmIG1ham9yICE9
IExPT1BfTUFKT1IgJiYgCiAJCSAgICBtYWpvciAhPSBERFZfTUFKT1IgJiYgbWFqb3IgIT0gTkJE
X01BSk9SKQogCQkJcGx1Z19kZXZpY2UoYmxrX2RldiArIG1ham9yKTsgLyogaXMgYXRvbWljICov
CiAJfSBlbHNlIHN3aXRjaCAobWFqb3IpIHsKKwkgICAgIGRlZmF1bHQ6CisJCS8qCisJCSAqIEZv
ciBkeW5hbWljYWx5IGFsbG9jYXRlZCBtYWpvcnMsIHRoYXQgYXJlIG5vdCBkZWZpbmVkIGluIAor
CQkgKiBDQVNFX0NPQUxFU0NFX0JVVF9GSVJTVF9SRVFVRVNUX01BWUJFX0JVU1kgb3IKKwkJICog
Q0FTRV9DT0FMRVNDRV9BTFNPX0ZJUlNUX1JFUVVFU1QgaGF2ZSBhIGxvb2sgYXQgYmxrX21lcmdl
X3J1bGUKKwkJICogdG8gZGV0ZXJtaW5lIHdoZXRoZXIgcmVxdWVzdHMgbWF5IGJlIG1lcmdlZCAK
KwkJICovCisJCWlmICgoYmxrX21lcmdlX3J1bGVbbWFqb3JdICE9IEJMS19NRVJHRV9CVVRfRklS
U1RfUkVRVUVTVF9NQVlfQkVfQlVTWSkgJiYKKyAgICAgICAgICAgICAgICAgICAgKGJsa19tZXJn
ZV9ydWxlW21ham9yXSAhPSBCTEtfTUVSR0VfQUxTT19GSVJTVF9SRVFVRVNUKSkKKwkJICAgICAg
ICBicmVhazsKKwkJaWYgKGJsa19tZXJnZV9ydWxlW21ham9yXSA9PSBCTEtfTUVSR0VfQUxTT19G
SVJTVF9SRVFVRVNUKQorCQkgICAgICAgIHNraXBfZmlyc3RfcmVxID0gMTsKKwkJLyogZmFsbCB0
aHJvdWdoICovCiAJICAgICBDQVNFX0NPQUxFU0NFX0JVVF9GSVJTVF9SRVFVRVNUX01BWUJFX0JV
U1kKIAkJLyoKIAkJICogVGhlIHNjc2kgZGlzayBhbmQgY2Ryb20gZHJpdmVycyBjb21wbGV0ZWx5
IHJlbW92ZSB0aGUgcmVxdWVzdApAQCAtNjc2LDcgKzcwMSw3IEBACiAJCSAqIEFsbCBvdGhlciBk
cml2ZXJzIG5lZWQgdG8ganVtcCBvdmVyIHRoZSBmaXJzdCBlbnRyeSwgYXMgdGhhdAogCQkgKiBl
bnRyeSBtYXkgYmUgYnVzeSBiZWluZyBwcm9jZXNzZWQgYW5kIHdlIHRodXMgY2FuJ3QgY2hhbmdl
IGl0LgogCQkgKi8KLQkJaWYgKHJlcSA9PSBibGtfZGV2W21ham9yXS5jdXJyZW50X3JlcXVlc3Qp
CisJCWlmIChyZXEgPT0gYmxrX2RldlttYWpvcl0uY3VycmVudF9yZXF1ZXN0ICYmIHNraXBfZmly
c3RfcmVxID09IDApCiAJICAgICAgICAJaWYgKCEocmVxID0gcmVxLT5uZXh0KSkKIAkJCQlicmVh
azsKIAkJLyogZmFsbCB0aHJvdWdoICovCkluZGV4OiBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KUkNTIGZpbGU6IC9ob21lL2N2cy9saW51eC9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5o
LHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjQKcmV0cmlldmluZyByZXZpc2lvbiAxLjUKZGlmZiAt
dSAtdyAtcjEuNCAtcjEuNQotLS0gaW5jbHVkZS9saW51eC9ibGtkZXYuaAkyMDAxLzAxLzE4IDEz
OjA1OjEyCTEuNAorKysgaW5jbHVkZS9saW51eC9ibGtkZXYuaAkyMDAxLzA1LzMxIDE0OjEwOjUz
CTEuNQpAQCAtMTA3LDYgKzEwNywxNSBAQAogCiBleHRlcm4gaW50ICogbWF4X3NlZ21lbnRzW01B
WF9CTEtERVZdOwogCitleHRlcm4gaW50IGJsa19tZXJnZV9ydWxlW01BWF9CTEtERVZdOworCisv
KgorICogZGVmaW5pdGlvbnMgd2hpY2ggY2FuIGJlIHNldCBpbnRvIGJsa19tZXJnZV9ydWxlIAor
ICovCisjZGVmaW5lIEJMS19NRVJHRV9ORVZFUiAwIAorI2RlZmluZSBCTEtfTUVSR0VfQlVUX0ZJ
UlNUX1JFUVVFU1RfTUFZX0JFX0JVU1kgMQorI2RlZmluZSBCTEtfTUVSR0VfQUxTT19GSVJTVF9S
RVFVRVNUIDIKKwogI2RlZmluZSBNQVhfU0VDVE9SUyAxMjgKIAogI2RlZmluZSBNQVhfU0VHTUVO
VFMgTUFYX1NFQ1RPUlMK

--0__=La1HrIzDHV4YTiUU6KgjBGjFGH5Wm5WPN0OU7lcClyYJOMSbwS3O3T5W--

