Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271681AbRHUPqb>; Tue, 21 Aug 2001 11:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271684AbRHUPqZ>; Tue, 21 Aug 2001 11:46:25 -0400
Received: from porsta.cs.Helsinki.FI ([128.214.48.124]:42760 "EHLO
	porsta.cs.Helsinki.FI") by vger.kernel.org with ESMTP
	id <S271681AbRHUPqL>; Tue, 21 Aug 2001 11:46:11 -0400
Date: Tue, 21 Aug 2001 18:46:25 +0300 (EEST)
From: Jani Jaakkola <jjaakkol@cs.Helsinki.FI>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix a bug in 2.4.9 drivers/char/console.c, vc_disallocate()
Message-ID: <Pine.LNX.4.33.0108211825470.7637-200000@hallikari.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696247541-855047161-998408785=:7637"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---696247541-855047161-998408785=:7637
Content-Type: TEXT/PLAIN; charset=US-ASCII


I have made myself a Linux console aware getty program, which allocates
and disallocates console ttys on the fly when users login and logout. It
exposed a bug ioctl(/dev/console,VT_DISALLOCATE) with SMP machines (or at
least, I could reproduce it only in a SMP machine). It turned out,
that vc_disallocate() misses spin_lock_irq(&console_lock). It seems that
nobody but me actually uses VT_DISALLOCATE..

If you have a SMP machine, you can reproduce the bug and CRASH YOUR KERNEL
(so don't do it, if you don't want to crash your kernel) by running the
following program as root in /dev/tty1 a few times (assuming you have
nothing running in tty11):

#include <unistd.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <linux/vt.h>

int main() {
        int console_fd=open("/dev/console",O_WRONLY);
        int i;
        for (i=0; i<100; i++) {
                int ttyfd=open("/dev/tty11",O_WRONLY);
                write(ttyfd,"blah",5);
                ioctl(console_fd,VT_ACTIVATE,11);
                close(ttyfd);
                ioctl(console_fd,VT_ACTIVATE,1);
                ioctl(console_fd,VT_DISALLOCATE,11);
        }

}

A trivial patch against drivers/char/console.c is included. Please CC your
comments to me, since I am not on the list.

- Jani


---696247541-855047161-998408785=:7637
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="console.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0108211846250.7637@hallikari.cs.Helsinki.FI>
Content-Description: 
Content-Disposition: attachment; filename="console.patch"

LS0tIGNvbnNvbGUuYy5vcmlnCVR1ZSBBdWcgMjEgMTg6MzE6MDMgMjAwMQ0K
KysrIGNvbnNvbGUuYwlUdWUgQXVnIDIxIDE4OjMxOjM1IDIwMDENCkBAIC03
ODAsNiArNzgwLDcgQEANCiANCiB2b2lkIHZjX2Rpc2FsbG9jYXRlKHVuc2ln
bmVkIGludCBjdXJyY29ucykNCiB7DQorCXNwaW5fbG9ja19pcnEoJmNvbnNv
bGVfbG9jayk7DQogCWlmICh2Y19jb25zX2FsbG9jYXRlZChjdXJyY29ucykp
IHsNCiAJICAgIHN3LT5jb25fZGVpbml0KHZjX2NvbnNbY3VycmNvbnNdLmQp
Ow0KIAkgICAgaWYgKGttYWxsb2NlZCkNCkBAIC03ODgsNiArNzg5LDcgQEAN
CiAJCWtmcmVlKHZjX2NvbnNbY3VycmNvbnNdLmQpOw0KIAkgICAgdmNfY29u
c1tjdXJyY29uc10uZCA9IE5VTEw7DQogCX0NCisJc3Bpbl91bmxvY2tfaXJx
KCZjb25zb2xlX2xvY2spOw0KIH0NCiANCiAvKg0K
---696247541-855047161-998408785=:7637--
