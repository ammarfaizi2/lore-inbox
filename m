Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288845AbSA2NWx>; Tue, 29 Jan 2002 08:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289239AbSA2NWo>; Tue, 29 Jan 2002 08:22:44 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:30932 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S288845AbSA2NWd>; Tue, 29 Jan 2002 08:22:33 -0500
Subject: [PATCH]:net/ipv4/route.c
To: linux-kernel@vger.kernel.org
Cc: gw4pts@gw4pts.ampr.org, kuznet@ms2.inr.ac.ru
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF2E25B54C.970EA602-ON65256B50.0043942C@in.ibm.com>
From: "Rajasekhar Inguva" <irajasek@in.ibm.com>
Date: Tue, 29 Jan 2002 18:43:23 +0530
X-MIMETrack: Serialize by Router on d23m0067/23/M/IBM(Release 5.0.8 |June 18, 2001) at
 29/01/2002 06:43:30 PM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=65256B500043942C8f9e8a93df938690918c65256B500043942C"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=65256B500043942C8f9e8a93df938690918c65256B500043942C
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: quoted-printable


Hello,

The patch applies to net/ipv4/route.c , Kernel version 2.5.2

Please find a detailed description of my patch below. Firstly I would l=
ike
to apologize if my patch is

In a wrong format
Already submitted by someone and rejected by you guys.
Non-conformance to kernel coding style.

The problem:

When neighbour tables are full, an attempt is made from rt_intern_hash =
to
release a few neighbour entries that the route cache might still be
referring to. This is achieved by calling rt_garbage_collect.
rt_garbage_collect does fail sometimes to release some entries as it ch=
ecks
not only for reference counts, but also some expiry timers. This ends u=
p in
the infamous 'Neighbour table overflow' message being displayed.

The patch:

My patch solves this problem. The approach was to write a new routine
rt_delete_now, which unlike rt_garbage_collect, deletes the route cache=

entries based only on reference counts and not on expiry timers.
rt_delete_now is called from rt_intern_hash instead of rt_garbage_colle=
ct.

The reason of this approach is to act as per demand. The call to
rt_garbage_collect from rt_intern_hash is made in emergency situations
(Neighbour tables are full). At this juncture, it is better IMHO, to de=
lete
'un-referred' entries rather than finding garbage entries (un-referred =
&&
expired) and deleting them. The patch is actually a copy of
rt_garbage_collect code minus expiry time checking code.

I would be glad to receive your comments and feedback on this patch.

Regards,

Raj
(See attached file: neigh.patch)

--- /usr/src/linux/net/ipv4/route.c     Tue Jan 29 17:24:15 2002
+++ /usr/src/linux/net/patches/route.c  Tue Jan 29 17:26:22 2002
@@ -471,6 +471,37 @@
        mod_timer(&rt_flush_timer, now+delay);
        spin_unlock_bh(&rt_flush_lock);
 }
+/*
+       Called by rt_intern_hash. Deletes unused entries immediately
+       in emergency situations.
+*/
+static void rt_delete_now()
+{
+       int i;
+       struct rtable *rth, **rthp;
+
+       for(i=3Drt_hash_mask; i>=3D0; i--) {
+
+       rthp =3D &rt_hash_table[i].chain;
+       write_lock_bh(&rt_hash_table[i].lock);
+
+               while((rth=3D*rthp) !=3D NULL) {
+               if(atomic_read(&rth->u.dst.__refcnt)) {
+               rthp =3D &rth->u.rt_next;
+               continue;
+               }
+
+       *rthp =3D rth->u.rt_next;
+       rt_free(rth);
+
+       }
+
+       write_unlock_bh(&rt_hash_table[i].lock);
+
+       }
+
+}
+

 /*
    Short description of GC goals.
@@ -646,13 +677,7 @@
                           it is most likely it holds some neighbour
records.
                         */
                        if (attempts-- > 0) {
-                               int saved_elasticity =3D ip_rt_gc_elast=
icity;
-                               int saved_int =3D ip_rt_gc_min_interval=
;
-                               ip_rt_gc_elasticity     =3D 1;
-                               ip_rt_gc_min_interval   =3D 0;
-                               rt_garbage_collect();
-                               ip_rt_gc_min_interval   =3D saved_int;
-                               ip_rt_gc_elasticity     =3D saved_elast=
icity;
+                               rt_delete_now();
                                goto restart;
                        }=

--0__=65256B500043942C8f9e8a93df938690918c65256B500043942C
Content-type: application/octet-stream; 
	name="=?iso-8859-1?Q?neigh.patch?="
Content-Disposition: attachment; filename="=?iso-8859-1?Q?neigh.patch?="
Content-transfer-encoding: base64

LS0tIC91c3Ivc3JjL2xpbnV4L25ldC9pcHY0L3JvdXRlLmMJVHVlIEphbiAyOSAxNzoyNDoxNSAy
MDAyCisrKyAvdXNyL3NyYy9saW51eC9uZXQvcGF0Y2hlcy9yb3V0ZS5jCVR1ZSBKYW4gMjkgMTc6
MjY6MjIgMjAwMgpAQCAtNDcxLDYgKzQ3MSwzNyBAQAogCW1vZF90aW1lcigmcnRfZmx1c2hfdGlt
ZXIsIG5vdytkZWxheSk7CiAJc3Bpbl91bmxvY2tfYmgoJnJ0X2ZsdXNoX2xvY2spOwogfQorLyoK
KwlDYWxsZWQgYnkgcnRfaW50ZXJuX2hhc2guIERlbGV0ZXMgdW51c2VkIGVudHJpZXMgaW1tZWRp
YXRlbHkKKwlpbiBlbWVyZ2VuY3kgc2l0dWF0aW9ucy4KKyovCitzdGF0aWMgdm9pZCBydF9kZWxl
dGVfbm93KCkKK3sKKwlpbnQgaTsKKwlzdHJ1Y3QgcnRhYmxlICpydGgsICoqcnRocDsKKworCWZv
cihpPXJ0X2hhc2hfbWFzazsgaT49MDsgaS0tKSB7CisKKwlydGhwID0gJnJ0X2hhc2hfdGFibGVb
aV0uY2hhaW47CisJd3JpdGVfbG9ja19iaCgmcnRfaGFzaF90YWJsZVtpXS5sb2NrKTsKKwkKKwkJ
d2hpbGUoKHJ0aD0qcnRocCkgIT0gTlVMTCkgeworCQlpZihhdG9taWNfcmVhZCgmcnRoLT51LmRz
dC5fX3JlZmNudCkpIHsKKwkJcnRocCA9ICZydGgtPnUucnRfbmV4dDsKKwkJY29udGludWU7CisJ
CX0KKworCSpydGhwID0gcnRoLT51LnJ0X25leHQ7CisJcnRfZnJlZShydGgpOworCisJfQorCisJ
d3JpdGVfdW5sb2NrX2JoKCZydF9oYXNoX3RhYmxlW2ldLmxvY2spOworCisJfQorCit9CisJCiAK
IC8qCiAgICBTaG9ydCBkZXNjcmlwdGlvbiBvZiBHQyBnb2Fscy4KQEAgLTY0NiwxMyArNjc3LDcg
QEAKIAkJCSAgIGl0IGlzIG1vc3QgbGlrZWx5IGl0IGhvbGRzIHNvbWUgbmVpZ2hib3VyIHJlY29y
ZHMuCiAJCQkgKi8KIAkJCWlmIChhdHRlbXB0cy0tID4gMCkgewotCQkJCWludCBzYXZlZF9lbGFz
dGljaXR5ID0gaXBfcnRfZ2NfZWxhc3RpY2l0eTsKLQkJCQlpbnQgc2F2ZWRfaW50ID0gaXBfcnRf
Z2NfbWluX2ludGVydmFsOwotCQkJCWlwX3J0X2djX2VsYXN0aWNpdHkJPSAxOwotCQkJCWlwX3J0
X2djX21pbl9pbnRlcnZhbAk9IDA7Ci0JCQkJcnRfZ2FyYmFnZV9jb2xsZWN0KCk7Ci0JCQkJaXBf
cnRfZ2NfbWluX2ludGVydmFsCT0gc2F2ZWRfaW50OwotCQkJCWlwX3J0X2djX2VsYXN0aWNpdHkJ
PSBzYXZlZF9lbGFzdGljaXR5OworCQkJCXJ0X2RlbGV0ZV9ub3coKTsKIAkJCQlnb3RvIHJlc3Rh
cnQ7CiAJCQl9CiAK

--0__=65256B500043942C8f9e8a93df938690918c65256B500043942C--

