Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316999AbSFKLK1>; Tue, 11 Jun 2002 07:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317002AbSFKLK1>; Tue, 11 Jun 2002 07:10:27 -0400
Received: from asplinux.ru ([195.133.213.194]:19467 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id <S316999AbSFKLKZ>;
	Tue, 11 Jun 2002 07:10:25 -0400
From: Denis Lunev <den@asplinux.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kiVkQrD/eU"
Content-Transfer-Encoding: 7bit
Message-ID: <15621.56007.301827.451858@artemis.asplinux.ru>
Date: Tue, 11 Jun 2002 15:11:03 +0400
To: linux-kernel@vger.kernel.org
Subject: OOM killer problems
X-Mailer: VM 6.96 under 21.4 (patch 4) "Artificial Intelligence" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kiVkQrD/eU
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Hello, All!

1. 2.4.16 kernel is used on 2xP3-866 SMP machine. There is no
   difference in 2.4.18 
2. 2 problems found:
   a) Kernel threads can be killed under some circumstances. It
      looks like 2 OOMs were triggered simultaneously on different
      CPUs, see records from 18:11:06. The process exited and
      became zombie (mm == NULL). So, on the second CPU kernel
      threads were killed.
   b) Another problem is out_of_memory(). It detects OOM while huge
      amount of free pages is present. According to logs (record from
      18:10:38) there are 100k pages present in all zones and OOM
      still happens. From my point of view, some processes were
      scheduled from try_to_free_pages(). After they wake up, they
      still can't shrink anything as there is nothing to shrink due to
      prevous OOM and a lot of free memory present.

The log below was obtained adding some debug printk's into the generic
kernel code, the patch is attached.

Jun 10 18:10:28 ts6 before kill free=1313 spoofers=293 killed=0 eaten=1699035
Jun 10 18:10:28 ts6 Task to kill 3873 (MM=ede83be4, UBover=115267)
Jun 10 18:10:28 ts6 Out of Memory: Killed process 3873 (tstspoof), flags=40 mm=ede83be4.
Jun 10 18:10:38 ts6 before kill free=100571 spoofers=291 killed=0 eaten=1583158
Jun 10 18:10:38 ts6 before kill free=100571 spoofers=291 killed=0 eaten=1583158
Jun 10 18:10:38 ts6 Task to kill 1702 (MM=ec42cbe4, UBover=39)
Jun 10 18:10:38 ts6 Out of Memory: Killed process 1702 (sshd), flags=140 mm=ec42cbe4.
Jun 10 18:10:38 ts6 Task to kill 1716 (MM=ec42c784, UBover=17)
Jun 10 18:10:38 ts6 Out of Memory: Killed process 1716 (update), flags=40 mm=ec42c784.
Jun 10 18:10:48 ts6 before kill free=81495 spoofers=291 killed=0 eaten=1583158
Jun 10 18:10:48 ts6 Task to kill 3890 (MM=f3b03dc4, UBover=0)
Jun 10 18:10:48 ts6 Out of Memory: Killed process 3890 (tstspoof), flags=40 mm=f3b03dc4.
Jun 10 18:10:56 ts6 before kill free=61978 spoofers=290 killed=0 eaten=1577700
Jun 10 18:10:56 ts6 Task to kill 3891 (MM=efc49bc4, UBover=0)
Jun 10 18:10:56 ts6 Out of Memory: Killed process 3891 (tstspoof), flags=40 mm=efc49bc4.
Jun 10 18:11:06 ts6 before kill free=33945 spoofers=289 killed=0 eaten=1572242
Jun 10 18:11:06 ts6 Task to kill 3892 (MM=eba244a4, UBover=0)
Jun 10 18:11:06 ts6 before kill free=32906 spoofers=289 killed=0 eaten=1572242
Jun 10 18:11:06 ts6 Task to kill 3892 (MM=eba244a4, UBover=0)
Jun 10 18:11:06 ts6 Out of Memory: Killed process 3892 (tstspoof), flags=40 mm=eba244a4.
Jun 10 18:11:06 ts6 Out of Memory: Killed process 2 (keventd), flags=40 mm=00000000.
Jun 10 18:11:06 ts6 Out of Memory: Killed process 3 (ksoftirqd_CPU0), flags=40 mm=00000000.
Jun 10 18:11:06 ts6 Out of Memory: Killed process 4 (ksoftirqd_CPU1), flags=40 mm=00000000.
Jun 10 18:11:06 ts6 Out of Memory: Killed process 5 (kswapd), flags=840 mm=00000000.
Jun 10 18:11:06 ts6 Out of Memory: Killed process 6 (bdflush), flags=40 mm=00000000.
Jun 10 18:11:06 ts6 Out of Memory: Killed process 7 (kupdated), flags=40 mm=00000000.
Jun 10 18:11:06 ts6 Out of Memory: Killed process 8 (scsi_eh_0), flags=40 mm=00000000.
Jun 10 18:11:06 ts6 Out of Memory: Killed process 9 (scsi_eh_1), flags=40 mm=00000000.
Jun 10 18:11:06 ts6 Out of Memory: Killed process 10 (mdrecoveryd), flags=40 mm=00000000.
Jun 10 18:11:06 ts6 Out of Memory: Killed process 3892 (tstspoof), flags=1c44 mm=00000000.

Regards,
	Denis V. Lunev


--kiVkQrD/eU
Content-Type: text
Content-Description: diff-oom-debug
Content-Disposition: inline;
	filename="diff-oom-debug"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4Lmlub2Rlcy9tbS9vb21fa2lsbC5jCUZyaSBKdW4gIDcgMTI6NTM6MTAgMjAw
MgorKysgbGludXgvbW0vb29tX2tpbGwuYwlNb24gSnVuIDEwIDE3OjQwOjQyIDIwMDIKQEAg
LTI1Niw2ICsyNTYsMzAgQEAKIAkgKi8KIAlpZiAoKytjb3VudCA8IDEwKQogCQlyZXR1cm47
CisJCisJeworCQlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnB0cjsKKwkJaW50IGNjID0gMCwgemVy
b2VkID0gMDsKKwkJdW5zaWduZWQgbG9uZyB2bV9zaXplID0gMDsKKworCQlyZWFkX2xvY2so
JnRhc2tsaXN0X2xvY2spOworCQlmb3JfZWFjaF90YXNrX2FsbChwdHIpIHsKKwkJCWlmIChz
dHJuY21wKHB0ci0+Y29tbSwgInRzdHNwb29mIiwgOCkpCisJCQkJY29udGludWU7CisJCQlj
YysrOworCQkJCisJCQlzcGluX2xvY2soJm1tbGlzdF9sb2NrKTsKKwkJCWlmIChwdHItPm1t
KQorCQkJCXZtX3NpemUgKz0gcHRyLT5tbS0+dG90YWxfdm07CisJCQllbHNlCisJCQkJemVy
b2VkKys7CisJCQlzcGluX3VubG9jaygmbW1saXN0X2xvY2spOworCQl9CisJCXJlYWRfdW5s
b2NrKCZ0YXNrbGlzdF9sb2NrKTsKKworCQlwcmludGsoImJlZm9yZSBraWxsIGZyZWU9JXUg
c3Bvb2ZlcnM9JWQga2lsbGVkPSVkIGVhdGVuPSVsdVxuIiwKKwkJICAgICAgIG5yX2ZyZWVf
cGFnZXMoKSwgY2MsIHplcm9lZCwgdm1fc2l6ZSk7CisJfQogCiAJLyoKIAkgKiBPaywgcmVh
bGx5IG91dCBvZiBtZW1vcnkuIEtpbGwgc29tZXRoaW5nLgo=
--kiVkQrD/eU--
