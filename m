Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTJKV7b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 17:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbTJKV7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 17:59:31 -0400
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:10693 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S263128AbTJKV71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 17:59:27 -0400
Message-ID: <XFMail.20031011175859.f.duncan.m.haldane@worldnet.att.net>
X-Mailer: XFMail 1.5.4 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.5.4.Linux:20031011175859:3234=_"
Date: Sat, 11 Oct 2003 17:58:59 -0400 (EDT)
From: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
To: linux-parport@torque.net, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       Tim Waugh <twaugh@redhat.com>
Subject: [PATCH] Fix broken superio DMA support in parport_pc.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.5.4.Linux:20031011175859:3234=_
Content-Type: text/plain; charset=us-ascii

Hi

There is a bogus test for ECP mode in the Via 686 superio support
in drivers/parport/parport_pc.c:sio_via_686a_probe(..) 


The incorrect test used is that superio register F0_5 == 0x1
(this means "ECP+EPP" parport control mode is enabled; by default, it's not)

The correct test should be register E2_0-1 == 0x01
(This means Parport mode is ECP (BIOS setting))

see the VT82C686A data sheet, page 45 and 46
( available at http://www.via.com.tw/pdf/productinfo/686a.pdf )


Patches against 2.4.23-pre7 and 2.6.0-test7 are attached.
Who can help me push these into the kernels?

These patches are fully tested.  Without it DMA was never enabled by
the superio probe.  With it, it finally is.

Duncan Haldane
duncan _haldane at users dot sourceforge dot net
----------------------------------------------

diff -uNr linux-2.6.0-test7/drivers/parport/parport_pc.c
linux-2.6.0-test7-superio_fix/drivers/parport/parport_pc.c
--- linux-2.6.0-test7/drivers/parport/parport_pc.c      Fri Sep 12 03:05:52 2003
+++ linux-2.6.0-test7-superio_fix/drivers/parport/parport_pc.c  Sat Oct 11
16:35:46 2003
@@ -2564,7 +2564,7 @@
 {
        u8 tmp;
        int dma, irq;
-       unsigned port1, port2, have_eppecp;
+       unsigned port1, port2, mode;
 
        /*
         * unlock super i/o configuration, set 0x85_1
@@ -2579,9 +2579,9 @@
        
        /* 0xE2_1-0: Parallel Port Mode / Enable */
        outb (0xE2, 0x3F0);
-       tmp = inb (0x3F1);
+       mode = inb (0x3F1) & 0x03;
        
-       if ((tmp & 0x03) == 0x03) {
+       if (mode == 0x03) {
                printk (KERN_INFO "parport_pc: Via 686A parallel port disabled
in BIOS\n");
                return 0;
        }
@@ -2600,10 +2600,6 @@
                return 0;
        }
 
-       /* 0xF0_5: EPP+ECP enable */
-       outb (0xF0, 0x3F0);
-       have_eppecp = (inb (0x3F1) & (1 << 5));
-       
        /*
         * lock super i/o configuration, clear 0x85_1
         */
@@ -2637,7 +2633,7 @@
        }
 
        /* if ECP not enabled, DMA is not enabled, assumed bogus 'dma' value */
-       if (!have_eppecp)
+       if (mode != 0x01)
                dma = PARPORT_DMA_NONE;
 
        /* Let the user (or defaults) steer us away from interrupts and DMA */



----------------------------------
E-Mail: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
Date: 11-Oct-2003
Time: 17:27:23

This message was sent by XFMail
----------------------------------

--_=XFMail.1.5.4.Linux:20031011175859:3234=_
Content-Disposition: attachment; filename="README"
Content-Transfer-Encoding: base64
Content-Description: README
Content-Type: application/octet-stream; name=README; SizeOnDisk=164

UGF0Y2ggZml4ZXMgYnJva2VuIFZpYSA2ODZDIERNQSBhY3RpdmF0aW9uIGluIHBhcnBvcnRfcGMu
Yzo6c2lvX3ZpYV82ODZhX3Byb2JlCihEdW5jYW4gSGFsZGFuZSA8ZHVuY2FuX2hhbGRhbmVAdXNl
cnMuc291cmNlZm9yZ2UubmV0Pik7CjIuNC4yMy1wcmU3IGFuZCAyLjYuMC10ZXN0Nwo=

--_=XFMail.1.5.4.Linux:20031011175859:3234=_
Content-Disposition: attachment; filename="parport_pc_superio_patch.tar.bz2"
Content-Transfer-Encoding: base64
Content-Description: parport_pc_superio_patch.tar.bz2
Content-Type: application/octet-stream;
 name=parport_pc_superio_patch.tar.bz2; SizeOnDisk=1475

QlpoOTFBWSZTWQJDq/gABet/hMiwAQB1///+/+/fhP/v/+oAAgAIYAZ/AAAAAAAABxkyaNAaNMRk
aGIYE0aYgxGgwgAMOMmTRoDRpiMjQxDAmjTEGI0GEABhxkyaNAaNMRkaGIYE0aYgxGgwgAMOMmTR
oDRpiMjQxDAmjTEGI0GEABhxkyaNAaNMRkaGIYE0aYgxGgwgAMCqIjQjQRhNEYk2pPNTKeJomTTB
Bk0MEekeKf5Pf/d5+irlHXYrpTERwyCF7w4Vjri6R2O1e2dlBgNxMRChQdaQlJ/U3qo6y5KVFUSo
lVRHO66du6s/h31j2vM70pdBzNbSlJczYMFR7ijhi0LLHJLJLJoSoc72WynOk2bUc3+MK+7oNRUQ
2SPYf8yZPsWXJfs/M/JDzv1fMuNKeg+dmiju/hPdSaOwYLN8fL8RnGtJKflNbpeMlw63VX9O7P5q
U2XbP4v0jQ0vRVgquo62hydBwZtzbucXX9DuXY9DA5LP9tvnlV1MdLZxopOxhH8quaOifZZJsw+D
nVPLdlq/Ba6yLKZLXXm9pW3k+xOKWa/G757/X6fkzrWtc3i6ubTpTz1SrrfTqwbC833TNHDQ8TzF
9fgwzq5Uv5X3uPkbm9dgn627W9SXa63RrUq8so3pYSmWm5REVkXp44+R1PVQ9bik7nWubXoO3yka
kRsHjJUGuLPO2nBRwcqJ1FzZhM+b58O/d2X3pmdgc6JTOll7kOYZI0IuRVx5vBPLq7kbEcxHlg49
ye/3fu/chsesj9+N+7gmUqPQb4OyDT6fHnHV2uoij+yKPZ1IoR0pI7yOk+/GN0ebrWMC5GqVPFyp
GxpMDsv1eNoOaJDNEkpSllzNWdGxZjcxRwLMfUvjRGn7aqtueFftaC6ucJmEm0nJlwROh4TDzTMz
MzMymZr35xqwQ43xGzXwWVStMuCFYRVqRdqhsYJttu3UuVaTPRjlcUqzqMlltZRojcrqRhDGdUZj
Sy0Rq+6XVr0M4Wah5eOilEpSm4zNc6nSLoUT7U/rwOdGZmyYsHe+O9txtE3+peswNrpXrko9r6HQ
fR96ShHl+oKD1j822Up5avmVWdV0RSHW78rdS+X6P18q4+ilH6JdRgpKiMHy7b/frfk9S5+Yl979
Vm13vkanJZi9EKzKaMHKKM+ij0XOlrNy9+2TEu3rysvY8PxEu+Ps9Le1vMj6jRJ8cRGHoK6z6Y+x
hhQr5Zn+h/efOmFsPX7/f+39fwMb22IYn3tBufCzXppIj7qvCnOcb0Wnn1F/3JwRLJrRmV4uiEUP
tGmITJZCujBFpYFzCUW2I7kvNU6KwJX4QiWl6VHc/BSHeJt2HsPJnyZtaVHXJXiuv4Vtas17KVrX
xflXfKi9FnajQ4IuYqxlpKQy5XSpk7cVi7DcO16kaGhq1GxlSEfjetaC9xlchpvf9Zay74BzfAop
eouNuwpS6Y8TGqw1RuatVDRXrfW0qu9JbC66q6ntvrf5NVD0xweHMXNzI3m652TX41Iar8VWafCh
SEZWLojQ00jYtBpLOYv4uEuPbsdsMEjYePImS+FqOpkquWaI2owvbm5KsNaMRtNiiZn3NB62oXRG
lCbI3mOhiX2VJKCsodnMUjOW+YMXMeN9aYK7uEUjjgTDHemjx+dJByMmzqnpOjWnJRto5qqOBuQf
W9vu88+h5DCYiKYc6PBAnlZKEiYiNiLvxRzMrY3qYOwxSnrmUw+RKpaEqaUWYNBj/K9aEcoMilY4
eBpQjrZLETEQZsVy7BNV1r1ZvX3wcrlV/wzGtMvCfjTQraC8m5h1qRHBHApfnLwLYXNCY0Nhdffp
tfdN2DFdXCtoFyJiIu2VMSooTk0RmicpNcxTTYs7XBZXTO5zsOzadOTW44Pi39GhuWH1TtaC5Bxf
CZc5RZMnN7y+G5DO9KOfjBu6f4Z4YK9ngQxP4oHk5YJxRvR8sRD/4u5IpwoSAEh1fwA=

--_=XFMail.1.5.4.Linux:20031011175859:3234=_--
End of MIME message
