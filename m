Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312680AbSDLBYe>; Thu, 11 Apr 2002 21:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313300AbSDLBYd>; Thu, 11 Apr 2002 21:24:33 -0400
Received: from air-2.osdl.org ([65.201.151.6]:22027 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S312680AbSDLBYc>;
	Thu, 11 Apr 2002 21:24:32 -0400
Date: Thu, 11 Apr 2002 18:21:25 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
cc: <axboe@suse.de>, <andrea@suse.de>
Subject: [patch 2.5.8] bounce/swap stats
Message-ID: <Pine.LNX.4.33L2.0204111807070.28475-400000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="346823425-468598838-1018574485=:28475"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--346823425-468598838-1018574485=:28475
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi,

This patch adds stats for all bounce I/O and bounce swap I/O
to /proc/stats .

I've been testing bounce I/O and VM performance in 2.4.teens
with the highio patch and in 2.5.x.

Summary:
* 2.5.8-pre3 with highio runs to completion with an intense workload
* 2.5.8-pre3 with "nohighio" and same workload dies
* 2.5.8-pre3 with "nohighio" and less workload runs
[attachments contain /proc/stat for completed runs]


Here's the patch.  Jens, please apply to 2.5.8-N.

--- ./fs/proc/proc_misc.c.org	Thu Jan  3 09:16:31 2002
+++ ./fs/proc/proc_misc.c	Tue Jan  8 16:12:56 2002
@@ -324,6 +324,12 @@
 		xtime.tv_sec - jif / HZ,
 		total_forks);

+	len += sprintf(page + len,
+		"bounce_io %u %u\n"
+		"bounce_swap_io %u %u\n",
+		kstat.bouncein, kstat.bounceout,
+		kstat.bounceswapin, kstat.bounceswapout);
+
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }

--- ./mm/highmem.c.org	Thu Jan  3 09:16:31 2002
+++ ./mm/highmem.c	Tue Jan  8 16:16:51 2002
@@ -21,6 +21,7 @@
 #include <linux/mempool.h>
 #include <linux/blkdev.h>
 #include <asm/pgalloc.h>
+#include <linux/kernel_stat.h>

 static mempool_t *page_pool, *isa_page_pool;

@@ -401,7 +401,10 @@
 			vfrom = kmap(from->bv_page) + from->bv_offset;
 			memcpy(vto, vfrom, to->bv_len);
 			kunmap(from->bv_page);
+			kstat.bounceout++;
 		}
+		else
+			kstat.bouncein++;
 	}

 	/*
--- ./include/linux/kernel_stat.h.org	Thu Jan  3 09:28:04 2002
+++ ./include/linux/kernel_stat.h	Tue Jan  8 16:10:20 2002
@@ -26,6 +26,8 @@
 	unsigned int dk_drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int pgpgin, pgpgout;
 	unsigned int pswpin, pswpout;
+	unsigned int bouncein, bounceout;
+	unsigned int bounceswapin, bounceswapout;
 #if !defined(CONFIG_ARCH_S390)
 	unsigned int irqs[NR_CPUS][NR_IRQS];
 #endif
--- ./mm/page_io.c.orig	Tue Apr  9 14:54:02 2002
+++ ./mm/page_io.c	Tue Apr  9 16:18:18 2002
@@ -10,11 +10,13 @@
  *  Always use brw_page, life becomes simpler. 12 May 1998 Eric Biederman
  */

+#include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
 #include <linux/locks.h>
 #include <linux/swapctl.h>
+#include <linux/blkdev.h>

 #include <asm/pgtable.h>

@@ -41,6 +43,7 @@
 	int block_size;
 	struct inode *swapf = 0;
 	struct block_device *bdev;
+	kdev_t kdev;

 	if (rw == READ) {
 		ClearPageUptodate(page);
@@ -54,6 +57,7 @@
 		zones[0] = offset;
 		zones_used = 1;
 		block_size = PAGE_SIZE;
+		kdev = swapf->i_rdev;
 	} else {
 		int i, j;
 		unsigned int block = offset
@@ -67,6 +71,19 @@
 			}
 		zones_used = i;
 		bdev = swapf->i_sb->s_bdev;
+		kdev = swapf->i_sb->s_dev;
+	}
+
+	{
+	request_queue_t *q = blk_get_queue(kdev); /* TBD: is kdev always correct here? */
+	zone_t *zone = page_zone(page);
+	if (q && (page - zone->zone_mem_map) + (zone->zone_start_paddr
+	    >> PAGE_SHIFT) >= q->bounce_pfn) {
+		if (rw == WRITE)
+			kstat.bounceswapout++;
+		else
+			kstat.bounceswapin++;
+	}
 	}

  	/* block_size == PAGE_SIZE/zones_used */


I'll keep looking into the "kernel dies" problem(s) that I'm
seeing [using more tools], but I have some data and a patch for 2.5.8
concerning bounce I/O and bounce swap statistics that I would
like to have integrated so that both users and developers
can have more insight into how much bounce I/O is happening.

I'll generate the patch for 2.4.teens + highmem if anyone
is interested in it, or after highmem is merged into 2.4.
...it will be added to 2.4, right?

There is a second patch (attached) that prints the device
major:minor of devices that are being used for bounce I/O
[258-bounce-identify.patch].  This is a user helper, not
intended for kernel inclusion.

Some of the symptoms that I usually see with the most memory-intensive
workloads are:
. 'top' reports that all 8 processors are in system exec. state
  at 98-99% level and 'top' display is only being updated every
  few minutes (should be updated every 1 second)
. Magic SysRq does not work when all 8 CPUs are tied up in system
  mode
. there is a looping script running (with 'sleep 1') that
  prints the last 50 lines of 'dmesg', but it often doesn't print
  for 10-20 minutes and then finally comes back to life
. I usually don't see a kernel death, just lack of response or
  my sessions to the test system dies.

Comments?

Thanks,
~Randy

--346823425-468598838-1018574485=:28475
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="258-bounce-identify.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33L2.0204111821250.28475@dragon.pdx.osdl.net>
Content-Description: 
Content-Disposition: attachment; filename="258-bounce-identify.patch"

LS0tIGxpbnV4L21tL2hpZ2htZW0uYy5JRERFVglUdWUgQXByICA5IDE0OjU1
OjQzIDIwMDINCisrKyBsaW51eC9tbS9oaWdobWVtLmMJVHVlIEFwciAgOSAx
NToyODoxMiAyMDAyDQpAQCAtMzQ3LDYgKzM0Nyw4IEBADQogCXJldHVybiBf
X2JvdW5jZV9lbmRfaW9fcmVhZChiaW8sIGlzYV9wYWdlX3Bvb2wpOw0KIH0N
CiANCitzdGF0aWMgaW50IGJtc2dfY291bnQ7CQkvKiBmb3IgcHJpbnRrIHJh
dGUgdGhyb3R0bGluZyAqLw0KKw0KIHZvaWQgY3JlYXRlX2JvdW5jZSh1bnNp
Z25lZCBsb25nIHBmbiwgaW50IGdmcCwgc3RydWN0IGJpbyAqKmJpb19vcmln
KQ0KIHsNCiAJc3RydWN0IHBhZ2UgKnBhZ2U7DQpAQCAtNDQ5LDYgKzQ1MSwx
MiBAQA0KIA0KIAliaW8tPmJpX3ByaXZhdGUgPSAqYmlvX29yaWc7DQogCSpi
aW9fb3JpZyA9IGJpbzsNCisNCisJYm1zZ19jb3VudCsrOw0KKwlpZiAoKGJt
c2dfY291bnQgJSAxMDAwMCkgPT0gMSkNCisJCXByaW50ayhLRVJOX0lORk8g
ImJvdW5jZV9pbyAoJWMpIGZvciAlZDolZFxuIiwNCisJCQkocncgJiBXUklU
RSkgPyAnVycgOiAnUicsDQorCQkJbWFqb3IoYmlvLT5iaV9kZXYpLCBtaW5v
cihiaW8tPmJpX2RldikpOw0KIH0NCiANCiAjaWYgQ09ORklHX0RFQlVHX0hJ
R0hNRU0NCg==
--346823425-468598838-1018574485=:28475
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="258p3hi.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33L2.0204111821251.28475@dragon.pdx.osdl.net>
Content-Description: 
Content-Disposition: attachment; filename="258p3hi.txt"

IyMjIC4vYmFzaG1lbXJ1bi4xLnRpbWVzDQoxNC4wOXVzZXIgMzEyLjcwc3lz
dGVtIDM6MzE6MjVlbGFwc2VkIDIlQ1BVICgwYXZndGV4dCswYXZnZGF0YSAw
bWF4cmVzaWRlbnQpaw0KMGlucHV0cyswb3V0cHV0cyAoNDY0NjMwbWFqb3Ir
NDVtaW5vcilwYWdlZmF1bHRzIDBzd2Fwcw0KDQojIyMgLi9iYXNobWVtcnVu
LjIudGltZXMNCjI3LjEydXNlciA3NS43MnN5c3RlbSAzOjUxOjI0ZWxhcHNl
ZCAwJUNQVSAoMGF2Z3RleHQrMGF2Z2RhdGEgMG1heHJlc2lkZW50KWsNCjBp
bnB1dHMrMG91dHB1dHMgKDgyODc0NW1ham9yKzQzbWlub3IpcGFnZWZhdWx0
cyAwc3dhcHMNCg0KIyMjIC4vYmFzaG1lbXJ1bi4zLnRpbWVzDQozLjEwdXNl
ciAzOS4yOHN5c3RlbSAzOjU4OjMzZWxhcHNlZCAwJUNQVSAoMGF2Z3RleHQr
MGF2Z2RhdGEgMG1heHJlc2lkZW50KWsNCjBpbnB1dHMrMG91dHB1dHMgKDE4
ODE0M21ham9yKzQwbWlub3IpcGFnZWZhdWx0cyAwc3dhcHMNCg0KIyMjIC4v
YmFzaG1lbXJ1bi40LnRpbWVzDQo4LjAwdXNlciAxODYuMTRzeXN0ZW0gMzoz
NzoxNWVsYXBzZWQgMSVDUFUgKDBhdmd0ZXh0KzBhdmdkYXRhIDBtYXhyZXNp
ZGVudClrDQowaW5wdXRzKzBvdXRwdXRzICgzNTE3MzJtYWpvcis0MG1pbm9y
KXBhZ2VmYXVsdHMgMHN3YXBzDQoNCiMjIyAuL2Jhc2htZW1ydW4uNS50aW1l
cw0KMjEuMjF1c2VyIDk1Ni4zMXN5c3RlbSAzOjM0OjAyZWxhcHNlZCA3JUNQ
VSAoMGF2Z3RleHQrMGF2Z2RhdGEgMG1heHJlc2lkZW50KWsNCjBpbnB1dHMr
MG91dHB1dHMgKDQ1ODkzN21ham9yKzQ1bWlub3IpcGFnZWZhdWx0cyAwc3dh
cHMNCg0KIyMjIC4vYmFzaG1lbXJ1bi42LnRpbWVzDQoxNS4wOXVzZXIgMjQy
LjA2c3lzdGVtIDM6NDA6MDhlbGFwc2VkIDElQ1BVICgwYXZndGV4dCswYXZn
ZGF0YSAwbWF4cmVzaWRlbnQpaw0KMGlucHV0cyswb3V0cHV0cyAoNDM0Nzg1
bWFqb3IrNDBtaW5vcilwYWdlZmF1bHRzIDBzd2Fwcw0KDQovcHJvYy9zdGF0
OiAgKHNlbGVjdGVkIHBhcnRzOyBjb21wbGV0ZSBmaWxlcyBhdmFpbGFibGUp
DQo9PT09PT09PT09PT09PT09DQpCRUZPUkUgV09SS0xPQUQNCj09PT09PT09
PT09PT09PT0NCmNwdSAgMzMzOTg4IDE2OTkgNDgwMTkxIDMwMzgwMjYNCnBh
Z2UgMzMyMjM2IDMxMzAzMjUzDQpzd2FwIDgzMyAyNTQxDQpkaXNrX2lvOiAo
OCwwKTooMjQ0OTk4Myw1MDczNSw2MTk5NTYsMjM5OTI0OCw2MjUxMDg4Mikg
KDgsMSk6KDc3NzAsMjI2NSw0NDU0MCw1NTA1LDEwMTkyOCkgDQpjdHh0IDgw
MzA3NQ0KYnRpbWUgMTAxODM5NTAyMQ0KcHJvY2Vzc2VzIDg5OTANCmJvdW5j
ZV9pbyAwIDANCmJvdW5jZV9zd2FwX2lvIDAgMA0KPT09PT09PT09PT09PT09
PQ0KQUZURVIgV09SS0xPQUQNCj09PT09PT09PT09PT09PT0NCmNwdSAgMzY2
MzAzIDIzODcgOTk3OTkyMiA0OTY4NTAwDQpwYWdlIDM0OTI0NjAgNTUyNjY5
NjENCnN3YXAgNjI4OTI1IDE2MjMzNTkNCmRpc2tfaW86ICg4LDApOig0MTcw
NTkyLDIyNDAwMSw0OTAzNDYwLDM5NDY1OTEsMTAxNjAyNDY2KSAoOCwxKToo
MzM4MjQyLDUxMjIxLDIwODc3MzIsMjg3MDIxLDg5NjUzMDQpIA0KY3R4dCAy
MzI4ODUwDQpidGltZSAxMDE4Mzk1MDIxDQpwcm9jZXNzZXMgMTE3MjkNCmJv
dW5jZV9pbyAwIDANCmJvdW5jZV9zd2FwX2lvIDAgMA0K
--346823425-468598838-1018574485=:28475
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="258p3nohi.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33L2.0204111821252.28475@dragon.pdx.osdl.net>
Content-Description: 
Content-Disposition: attachment; filename="258p3nohi.txt"

IyMjIC4vYmFzaG1lbXJ1bi4xLnRpbWVzDQoxOC4xMnVzZXIgMjA3Ljczc3lz
dGVtIDk6MzkuOTJlbGFwc2VkIDM4JUNQVSAoMGF2Z3RleHQrMGF2Z2RhdGEg
MG1heHJlc2lkZW50KWsNCjBpbnB1dHMrMG91dHB1dHMgKDQ3Njk1NG1ham9y
KzQ2bWlub3IpcGFnZWZhdWx0cyAwc3dhcHMNCg0KIyMjIC4vYmFzaG1lbXJ1
bi4yLnRpbWVzDQoyLjMzdXNlciAxNS40NXN5c3RlbSAwOjMyLjY0ZWxhcHNl
ZCA1NCVDUFUgKDBhdmd0ZXh0KzBhdmdkYXRhIDBtYXhyZXNpZGVudClrDQow
aW5wdXRzKzBvdXRwdXRzICg4MzY3OW1ham9yKzIzbWlub3IpcGFnZWZhdWx0
cyAwc3dhcHMNCg0KIyMjIC4vYmFzaG1lbXJ1bi4zLnRpbWVzDQoyNC4xMHVz
ZXIgMzgyLjk5c3lzdGVtIDM0OjQ3LjA0ZWxhcHNlZCAxOSVDUFUgKDBhdmd0
ZXh0KzBhdmdkYXRhIDBtYXhyZXNpZGVudClrDQowaW5wdXRzKzBvdXRwdXRz
ICg1MjMyNzhtYWpvcis0M21pbm9yKXBhZ2VmYXVsdHMgMHN3YXBzDQoNCiMj
IyAuL2Jhc2htZW1ydW4uNC50aW1lcw0KNC4wMHVzZXIgMTE3LjI3c3lzdGVt
IDI2OjQ1LjU0ZWxhcHNlZCA3JUNQVSAoMGF2Z3RleHQrMGF2Z2RhdGEgMG1h
eHJlc2lkZW50KWsNCjBpbnB1dHMrMG91dHB1dHMgKDE3MDU3Mm1ham9yKzQ4
bWlub3IpcGFnZWZhdWx0cyAwc3dhcHMNCg0KIyMjIC4vYmFzaG1lbXJ1bi41
LnRpbWVzDQoxMC43OHVzZXIgMjAwLjg2c3lzdGVtIDI4OjEyLjc2ZWxhcHNl
ZCAxMiVDUFUgKDBhdmd0ZXh0KzBhdmdkYXRhIDBtYXhyZXNpZGVudClrDQow
aW5wdXRzKzBvdXRwdXRzICgzMDMyMjhtYWpvcis1MG1pbm9yKXBhZ2VmYXVs
dHMgMHN3YXBzDQoNCiMjIyAuL2Jhc2htZW1ydW4uNi50aW1lcw0KNy4wM3Vz
ZXIgMTUxLjc2c3lzdGVtIDU6MjYuODhlbGFwc2VkIDQ4JUNQVSAoMGF2Z3Rl
eHQrMGF2Z2RhdGEgMG1heHJlc2lkZW50KWsNCjBpbnB1dHMrMG91dHB1dHMg
KDM2ODQ0Mm1ham9yKzQzbWlub3IpcGFnZWZhdWx0cyAwc3dhcHMNCg0KL3By
b2Mvc3RhdDogIChzZWxlY3RlZCBwYXJ0czsgY29tcGxldGUgZmlsZXMgYXZh
aWxhYmxlKQ0KPT09PT09PT09PT09PT09PQ0KQkVGT1JFIFdPUktMT0FEDQo9
PT09PT09PT09PT09PT09DQpjcHUgIDY3MyAzOCAxMjIxIDIyNzQ0NA0KcGFn
ZSAyODUxMiAxOTQ5Nw0Kc3dhcCA4IDANCmRpc2tfaW86ICg4LDApOigxNjE4
LDEzMzQsMjYxMzIsMjg0LDgxNzgpICg4LDEpOigzNjcyLDE0MTksMzA4OTIs
MjI1MywzMDgyNCkgDQpjdHh0IDIyNDcxDQpidGltZSAxMDE4NTQyOTg5DQpw
cm9jZXNzZXMgMTYxMA0KYm91bmNlX2lvIDYxODAgOTY4DQpib3VuY2Vfc3dh
cF9pbyAwIDANCj09PT09PT09PT09PT09PT0NCkFGVEVSIFdPUktMT0FEDQo9
PT09PT09PT09PT09PT09DQpjcHUgIDUzNjE4IDg1NiA4NTI1NDggOTk3MTIy
DQpwYWdlIDM3NjEwOTIgMTE0MzkxMTMNCnN3YXAgNjAzNDE1IDUyOTEzMg0K
ZGlza19pbzogKDgsMCk6KDkzNjQwNCwzMDgwMDQsNjgxODk5Niw2Mjg0MDAs
MjE5ODUxMjIpICg4LDEpOigzOTQyMCwxNzQwNyw3MDgxMzIsMjIwMTMsOTEw
NzIwKSANCmN0eHQgMTY3MzYwNQ0KYnRpbWUgMTAxODU0Mjk4OQ0KcHJvY2Vz
c2VzIDQ5NDYNCmJvdW5jZV9pbyA4MjYyMzUgMjI2NTY0MQ0KYm91bmNlX3N3
YXBfaW8gNTQ3MTk2IDIzNTA5Ng0K
--346823425-468598838-1018574485=:28475--
