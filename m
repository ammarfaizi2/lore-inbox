Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293215AbSCEOuq>; Tue, 5 Mar 2002 09:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293218AbSCEOui>; Tue, 5 Mar 2002 09:50:38 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51955 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293215AbSCEOuY>;
	Tue, 5 Mar 2002 09:50:24 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Fwd: [Lse-tech] get_pid() performance fix
Date: Mon, 4 Mar 2002 20:57:49 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DG9HJABQ8AXX8XYK9S4E"
Message-Id: <20020305145004.BFA503FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_DG9HJABQ8AXX8XYK9S4E
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


Can somebody post why this patch shouldn't be picked up ?
The attached program shows the problem in user space 
and the patch is almost trivial ..

-- Hubertus

----------  Forwarded Message  ----------

Subject: [Lse-tech] get_pid() performance fix
Date: Tue, 26 Feb 2002 18:58:51 -0500
From: "Rajan Ravindran" <rajancr@us.ibm.com>
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, davej@suse.de

Paul Larson posted a patch which fixes the get_pid() hang,
if we run out of available pids. Nevertheless, we have
observed that it takes a long time to find the next available
pid once the last pid reaches the PID_MAX. This is due to
a constant rescan of the task list while progressing only one
pid at time, yielding an O(n**2) problem.
Here is a patch (together with Paul's fix) which eliminates the
time taken to search for an available pid, by not constantly
restarting the search through the entire task list.

Attached is also a user level test program getpid.c),
by which one can simulate creation and deletion of processes.
This application will measure the time taken for the get_pid()
routine to find the next available process.

example:
      getpid -p 32770 -n 3

which will try to create 32770 process, eventually get_pid can't
find any free pid after 32767, so it will delete 3 pids randomly
from the existing list and start calculating the time taken to
find the available pid (which we deleted).

In getpid.c the new fixes  are inside the #define NEW_METHOD.
Try compiling the getpid.c with and without -DNEW_METHOD compile
option to see the performance improvement.

here is an example output for the old and the new algorithm and
their respective execution time to find a new pid.

(See attached file: output)

This can/should be applied to 2.5 and 2.4 kernels.


(See attached file: getpid.c)

Thanks,
Rajan


diff -Naur linux-2.5.5/kernel/fork.c linux-2.5.5-new/kernel/fork.c
--- linux-2.5.5/kernel/fork.c Tue Feb 19 21:10:55 2002
+++ linux-2.5.5-new/kernel/fork.c   Tue Feb 26 15:46:36 2002
@@ -24,6 +24,7 @@
 #include <linux/file.h>
 #include <linux/binfmts.h>
 #include <linux/fs.h>
+#include <linux/compiler.h>

 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -129,12 +130,13 @@
 {
      static int next_safe = PID_MAX;
      struct task_struct *p;
-     int pid;
+     int pid, beginpid;

      if (flags & CLONE_PID)
            return current->pid;

      spin_lock(&lastpid_lock);
+     beginpid = last_pid;
      if((++last_pid) & 0xffff8000) {
            last_pid = 300;         /* Skip daemons etc. */
            goto inside;
@@ -153,13 +155,18 @@
                              if(last_pid & 0xffff8000)
                                    last_pid = 300;
                              next_safe = PID_MAX;
+                             goto repeat;
                        }
-                       goto repeat;
+                       if(unlikely(last_pid == beginpid))
+                             goto nomorepids;
+                       continue;
                  }
                  if(p->pid > last_pid && next_safe > p->pid)
                        next_safe = p->pid;
                  if(p->pgrp > last_pid && next_safe > p->pgrp)
                        next_safe = p->pgrp;
+                 if(p->tgid > last_pid && next_safe > p->tgid)
+                       next_safe = p->tgid;
                  if(p->session > last_pid && next_safe > p->session)
                        next_safe = p->session;
            }
@@ -169,6 +176,11 @@
      spin_unlock(&lastpid_lock);

      return pid;
+
+nomorepids:
+     read_unlock(&tasklist_lock);
+     spin_unlock(&lastpid_lock);
+     return 0;
 }

 static inline int dup_mmap(struct mm_struct * mm)
@@ -667,6 +679,8 @@

      copy_flags(clone_flags, p);
      p->pid = get_pid(clone_flags);
+     if (p->pid == 0 && current->pid != 0)
+           goto bad_fork_cleanup;

      INIT_LIST_HEAD(&p->run_list);

-------------------------------------------------------



-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
--------------Boundary-00=_DG9HJABQ8AXX8XYK9S4E
Content-Type: application/octet-stream;
  charset="us-ascii";
  name="output"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="output"

Li9nZXRwaWQgLXAgMzI3NzEgLW4gNCANCg0KT3V0cHV0IHdoZW4gY29tcGlsZWQgd2l0aG91dCAt
RE5FV19NRVRIT0QNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpu
cHJvY3M6IDMyNzcxLCBuZGVsZXRlOjAsIG5pdGVtczo0DQpzdGFydCBjcmVhdGluZyAzMjc3MSBw
cm9jZXNzZXMNCnJlYWNoZWQgbWF4IHBpZCA8MzI3Njg+IHJlc2V0IGxhc3RfcGlkIHRvIDwzMDA+
DQpyZW1vdmVkIHBpZDogPDE3NzY3Pg0KcmVtb3ZlZCBwaWQ6IDw5MTU4Pg0KcmVtb3ZlZCBwaWQ6
IDw2MjQ5Pg0KcmVtb3ZlZCBwaWQ6IDwxODU0Nz4NCnNwZW50IDEuMTcyOTQ1IHNlY29uZHMgaW4g
ZmluZGluZyBmcmVlIHBpZCA8NjI0OT4NCnNwZW50IDIuNTE5MDU3IHNlY29uZHMgaW4gZmluZGlu
ZyBmcmVlIHBpZCA8OTE1OD4NCnNwZW50IDkuODU3OTA4IHNlY29uZHMgaW4gZmluZGluZyBmcmVl
IHBpZCA8MTc3Njc+DQpzcGVudCAxMC45MjQyMTMgc2Vjb25kcyBpbiBmaW5kaW5nIGZyZWUgcGlk
IDwxODU0Nz4NCg0KDQpPdXRwdXQgd2hlbiBjb21waWxlZCB3aXRoIC1ETkVXX01FVEhPRA0KLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCm5wcm9jczogMzI3NzEsIG5kZWxl
dGU6MCwgbml0ZW1zOjQNCnN0YXJ0IGNyZWF0aW5nIDMyNzcxIHByb2Nlc3Nlcw0KcmVhY2hlZCBt
YXggcGlkIDwzMjc2OD4gcmVzZXQgbGFzdF9waWQgdG8gPDMwMD4NCnJlbW92ZWQgcGlkOiA8MTc3
Njc+DQpyZW1vdmVkIHBpZDogPDkxNTg+DQpzcGVudCAwLjE4NDY4IHNlY29uZHMgaW4gZmluZGlu
ZyBmcmVlIHBpZCA8MTc3Njc+DQpyZW1vdmVkIHBpZDogPDYyNDk+DQpyZW1vdmVkIHBpZDogPDE4
NTQ3Pg0Kc3BlbnQgMC4zMDgzMyBzZWNvbmRzIGluIGZpbmRpbmcgZnJlZSBwaWQgPDYyNDk+DQpz
cGVudCAwLjM0NTcyIHNlY29uZHMgaW4gZmluZGluZyBmcmVlIHBpZCA8OTE1OD4NCnNwZW50IDAu
NDE1OTQgc2Vjb25kcyBpbiBmaW5kaW5nIGZyZWUgcGlkIDwxODU0Nz4NCg0K

--------------Boundary-00=_DG9HJABQ8AXX8XYK9S4E
Content-Type: application/octet-stream;
  charset="us-ascii";
  name="getpid.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="getpid.c"

LyogDQogKiBQcm9ncmFtIHRvIG1lYXN1cmUgdGhlIGdldF9waWQoKSBmdW5jdGlvbiBwZXJmb3Jt
YW5jZQ0KICoNCiAqLw0KDQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRlIDxlcnJuby5oPg0K
I2luY2x1ZGUgPHNjaGVkLmg+DQojaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQojaW5jbHVkZSA8c3lz
L3dhaXQuaD4gICAgICAgICANCiNpbmNsdWRlIDxzeXMvdGltZS5oPiAgICAgICAgIA0KI2luY2x1
ZGUgPGdldG9wdC5oPg0KI2luY2x1ZGUgPHN0ZGxpYi5oPg0KDQpzdHJ1Y3QgdGFza19zdHJ1Y3Qg
ew0KCWludCBwaWQ7DQoJc3RydWN0IHRhc2tfc3RydWN0ICpuZXh0X3Rhc2s7DQp9OwkNCg0KI2Rl
ZmluZSBQSURfTUFYCTB4ODAwMA0KI2RlZmluZSBHRVRQSURfTUFTSwkweGZmZmY4MDAwDQojZGVm
aW5lIFNUQUNLX1NJWkUJODE5Mg0KDQpzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRza19oZWFkOw0KaW50
IGxhc3RfcGlkOw0KdW5zaWduZWQgbG9uZyBucHJvY3M7DQppbnQgdmVyYm9zZTsNCmludCBzdGFy
dF9kZWw7DQoNCiNkZWZpbmUgYWxsb2NfdGFza19zdHJ1Y3QoKSBcDQoJKChzdHJ1Y3QgdGFza19z
dHJ1Y3QgKiltYWxsb2Moc2l6ZW9mKHN0cnVjdCB0YXNrX3N0cnVjdCkpKQ0KI2RlZmluZSBmb3Jf
ZWFjaF90YXNrKHApIFwNCiAgICAgICAgZm9yIChwID0gdHNrX2hlYWQgOyAocCA9IHAtPm5leHRf
dGFzaykgIT0gdHNrX2hlYWQgOyApIA0KDQppbnQgY3JlYXRlX3Rhc2soKTsNCmludCAoKmN0YXNr
KSAodm9pZCAqYXJnKTsNCg0KaW50IF9fY2xvbmUgKGludCAoKmZuKSAodm9pZCAqYXJnKSwgdm9p
ZCAqdGhyZWFkX3N0YWNrLCBpbnQgZmxhZ3MsIHZvaWQgKmFyZyk7IA0KDQppbnQgZ2V0X3BpZCgp
DQp7DQoJc3RhdGljIGludCBuZXh0X3NhZmUgPSBQSURfTUFYOw0KCXN0cnVjdCB0YXNrX3N0cnVj
dCAqcDsNCglzdGF0aWMgc3RydWN0IHRpbWV2YWwgc3RpbWUsIGV0aW1lOw0KCXN0YXRpYyBpbnQg
c3RhcnRfc2VhcmNoPTA7DQoJaW50IGJlZ2lucGlkOw0KCWxvbmcgc2VjLHVzZWM7DQoNCgliZWdp
bnBpZCA9IGxhc3RfcGlkOw0KCWlmKCgrK2xhc3RfcGlkKSAmIEdFVFBJRF9NQVNLKSB7DQoJCXBy
aW50ZigicmVhY2hlZCBtYXggcGlkIDwlZD4gcmVzZXQgbGFzdF9waWQgdG8gPDMwMD5cbiIsIGxh
c3RfcGlkKTsNCgkJbGFzdF9waWQgPSAzMDA7CQkvKiBTa2lwIGRhZW1vbnMgZXRjLiAqLw0KCQlz
dGFydF9kZWwgPSBzdGFydF9zZWFyY2ggPTE7DQogICAgICAgIAlnZXR0aW1lb2ZkYXkoJnN0aW1l
LCAoc3RydWN0IHRpbWV6b25lICopIDApOyAgIA0KCQlnb3RvIGluc2lkZTsNCgl9DQoNCiNpZmRl
ZiBORVdfTUVUSE9EDQoJaWYobGFzdF9waWQgPj0gbmV4dF9zYWZlKSB7DQppbnNpZGU6DQoJCW5l
eHRfc2FmZSA9IFBJRF9NQVg7DQoJcmVwZWF0Og0KICAgICAgIAkJZm9yIChwID0gdHNrX2hlYWQg
OyAocCA9IHAtPm5leHRfdGFzaykgIT0gdHNrX2hlYWQgOyApIHsNCgkJCWlmKHAtPnBpZCA9PSBs
YXN0X3BpZCkgew0KCQkJCWlmKCsrbGFzdF9waWQgPj0gbmV4dF9zYWZlKSB7DQoJCQkJCWlmKGxh
c3RfcGlkICYgR0VUUElEX01BU0spDQoJCQkJCWxhc3RfcGlkID0gMzAwOw0KCQkJCQluZXh0X3Nh
ZmUgPSBQSURfTUFYOw0KCQkJCQlnb3RvIHJlcGVhdDsNCgkJCQl9DQoJCQkJY29udGludWU7DQoJ
CQl9DQoJCQlpZihwLT5waWQgPiBsYXN0X3BpZCAmJiBuZXh0X3NhZmUgPiBwLT5waWQpDQoJCQkJ
bmV4dF9zYWZlID0gcC0+cGlkOw0KCQl9DQoJfQ0KI2Vsc2UNCglpZihsYXN0X3BpZCA+PSBuZXh0
X3NhZmUpIHsNCmluc2lkZToNCgkJbmV4dF9zYWZlID0gUElEX01BWDsNCglyZXBlYXQ6DQogICAg
ICAgCQlmb3IgKHAgPSB0c2tfaGVhZCA7IChwID0gcC0+bmV4dF90YXNrKSAhPSB0c2tfaGVhZCA7
ICkgew0KCQkJaWYocC0+cGlkID09IGxhc3RfcGlkKSB7DQoJCQkJaWYoKytsYXN0X3BpZCA+PSBu
ZXh0X3NhZmUpIHsNCgkJCQkJaWYobGFzdF9waWQgJiBHRVRQSURfTUFTSykNCgkJCQkJCWxhc3Rf
cGlkID0gMzAwOw0KCQkJCQluZXh0X3NhZmUgPSBQSURfTUFYOw0KCQkJCX0NCgkJCQlnb3RvIHJl
cGVhdDsNCgkJCX0NCgkJaWYocC0+cGlkID4gbGFzdF9waWQgJiYgbmV4dF9zYWZlID4gcC0+cGlk
KQ0KCQkJCW5leHRfc2FmZSA9IHAtPnBpZDsNCgkJfQ0KCX0NCiNlbmRpZg0KCWlmIChzdGFydF9z
ZWFyY2gpIHsNCiAgICAgICAgCWdldHRpbWVvZmRheSgmZXRpbWUsIChzdHJ1Y3QgdGltZXpvbmUg
KikgMCk7ICANCgkJaWYgKChldGltZS50dl91c2VjIC0gc3RpbWUudHZfdXNlYykgPCAwKSB7DQoJ
CQlzZWMgPSAoZXRpbWUudHZfc2VjIC0gc3RpbWUudHZfc2VjKSAtMTsNCgkJCXVzZWMgPSBzdGlt
ZS50dl91c2VjIC0gZXRpbWUudHZfdXNlYzsNCgkJfQ0KCQllbHNlIHsNCgkJCXNlYyA9IChldGlt
ZS50dl9zZWMgLSBzdGltZS50dl9zZWMpOw0KCQkJdXNlYyA9IGV0aW1lLnR2X3VzZWMgLSBzdGlt
ZS50dl91c2VjOw0KCQl9DQoJCXByaW50Zigic3BlbnQgJWQuJTAyZCBzZWNvbmRzIGluIGZpbmRp
bmcgZnJlZSBwaWQgPCVkPlxuIiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzZWMsIHVzZWMsIGxhc3RfcGlkKTsNCgl9DQoJcmV0dXJuIGxhc3RfcGlkOw0KfQ0KDQpp
bnQgY3JlYXRlX3Rhc2soKSB7DQoJc3RydWN0IHRhc2tfc3RydWN0ICpwLCAqcHJldjsNCgl1bnNp
Z25lZCBpbnQgaTsNCg0KCXByZXYgPSB0c2tfaGVhZDsNCgl0c2tfaGVhZC0+cGlkID0gMDsgdHNr
X2hlYWQtPm5leHRfdGFzayA9IHRza19oZWFkOw0KCXByaW50Zigic3RhcnQgY3JlYXRpbmcgJWQg
cHJvY2Vzc2VzXG4iLCBucHJvY3MpOw0KCWZvciAoaT0wOyBpPG5wcm9jczsgaSsrKSB7DQoJCXAg
PSBhbGxvY190YXNrX3N0cnVjdCgpOw0KCQlwLT5uZXh0X3Rhc2sgPSB0c2tfaGVhZDsNCgkJcC0+
cGlkID0gZ2V0X3BpZCgpOw0KCQlpZiAodmVyYm9zZSkNCgkJCXByaW50ZigiY3JlYXRlZCA8JWQ+
XG4iLCBwLT5waWQpOw0KCQlwcmV2LT5uZXh0X3Rhc2sgPSBwOw0KCQlwcmV2ID0gcHJldi0+bmV4
dF90YXNrOw0KCX0NCn0NCg0Kdm9pZCBkZWxldGVfdGFzayhpbnQgbml0ZW1zKSB7DQoJc3RydWN0
IHRhc2tfc3RydWN0ICpwLCAqcHJldjsNCgl1bnNpZ25lZCBpbnQgaTsNCglsb25nIGludCByYW5k
Ow0KDQoJd2hpbGUgKCFzdGFydF9kZWwpOw0KCWZvciAoaT0wOyBpIDwgbml0ZW1zOyBpKyspIHsN
CgkJcmFuZCA9IHJhbmRvbSgpICUgUElEX01BWDsNCiAgICAgICAgCWZvciAocHJldiA9IHAgPSB0
c2tfaGVhZCA7IChwID0gcC0+bmV4dF90YXNrKSAhPSB0c2tfaGVhZCA7ICkgeyANCgkJCWlmIChw
LT5waWQgPT0gcmFuZCkgew0KCQkJCXByZXYtPm5leHRfdGFzayA9IHAtPm5leHRfdGFzazsNCgkJ
CQlwcmludGYoInJlbW92ZWQgcGlkOiA8JWQ+XG4iLCByYW5kKTsNCgkJCX0NCgkJCXByZXYgPSBw
Ow0KCQl9DQoJfQ0KCXN0YXJ0X2RlbD0wOwkNCn0NCg0Kdm9pZCB1c2FnZSgpIHsNCglwcmludGYo
IlVzYWdlOiBnZXRwaWQgLXAgPG5wcm9jcz4gLW4gPG5waWRzPiAtcyA8c2VlZD4gLXYgW3ZlcmJv
c2VdXG4iKTsNCglwcmludGYoIiAgICAgICBucHJvY3M6IG51bWJlciBvZiBwcm9jZXNzIHRvIGNy
ZWF0ZVxuIik7DQoJcHJpbnRmKCIgICAgICAgbnBpZHM6IG51bWJlciBvZiBwcm9jZXNzIHRvIGRl
bGV0ZVxuIik7DQoJcHJpbnRmKCIgICAgICAgdmVyYm9zZTogcHJpbnQgZGVidWcgc3RyaW5nc1xu
Iik7DQp9DQoNCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pIHsNCglpbnQgcGlkOw0K
CWNoYXIgKnN0azsNCglpbnQgd2FpdF9zdGF0dXMsIHJjOw0KCWludCBjLCBuaXRlbXM9MDsNCg0K
ICAgICAgICB3aGlsZSAoKGMgPSBnZXRvcHQoYXJnYywgYXJndiwgInA6czpuOnY6IikpICE9IC0x
KSB7DQogICAgICAgICAgc3dpdGNoKGMpIHsNCiAgICAgICAgICAgICAgICBjYXNlICdwJzogbnBy
b2NzID0gYXRvaShvcHRhcmcpOyBicmVhazsNCiAgICAgICAgICAgICAgICBjYXNlICduJzogbml0
ZW1zID0gYXRvaShvcHRhcmcpOyBicmVhazsNCgkJY2FzZSAncyc6IHNyYW5kKGF0b2kob3B0YXJn
KSk7IGJyZWFrOw0KICAgICAgICAgICAgICAgIGNhc2UgJ3YnOiB2ZXJib3NlID0gMTsgYnJlYWs7
DQogICAgICAgICAgICAgICAgZGVmYXVsdDogdXNhZ2UoKTsgcmV0dXJuIDA7DQogICAgICAgICAg
fQ0KICAgICAgICB9DQoNCglpZiAoKG5wcm9jcyA9PSAwKSB8fCAobml0ZW1zID4gUElEX01BWCkp
IHsNCgkJcHJpbnRmKCJJbnZhbGlkIHBhcmFtZXRlclxuIik7DQoJCXVzYWdlKCk7DQoJCXJldHVy
biAwOw0KCX0NCgl0c2tfaGVhZCA9IGFsbG9jX3Rhc2tfc3RydWN0KCk7DQoJc3RrID0gKGNoYXIg
KiltYWxsb2MoMiAqIFNUQUNLX1NJWkUpOw0KDQoJY3Rhc2sgPSBjcmVhdGVfdGFzazsNCglwaWQg
PSBfX2Nsb25lKGN0YXNrLCAmc3RrW1NUQUNLX1NJWkVdLCAgQ0xPTkVfVk0gfCBDTE9ORV9GUyB8
IENMT05FX1NJR0hBTkQsICh2b2lkICopMCk7DQoJaWYgKHBpZCA9PSAtMSkNCgkJcHJpbnRmKCJl
cnJubz0lZCA8JXM+XG4iLCBlcnJubyxzdHJlcnJvcihlcnJubykpOw0KCQ0KCWRlbGV0ZV90YXNr
KG5pdGVtcyk7DQoJd2FpdHBpZCgtMSwgJndhaXRfc3RhdHVzLCBfX1dDTE9ORSk7DQp9DQo=

--------------Boundary-00=_DG9HJABQ8AXX8XYK9S4E--

