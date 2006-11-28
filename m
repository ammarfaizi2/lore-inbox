Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755627AbWK1XOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627AbWK1XOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 18:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757849AbWK1XOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 18:14:07 -0500
Received: from ribosome.natur.cuni.cz ([195.113.57.20]:3848 "EHLO
	ribosome.natur.cuni.cz") by vger.kernel.org with ESMTP
	id S1755627AbWK1XOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 18:14:05 -0500
Message-ID: <456CC2BA.7000102@ribosome.natur.cuni.cz>
Date: Wed, 29 Nov 2006 00:14:02 +0100
From: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060426
X-Accept-Language: cs
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Regression: spurious 8259A interrupt: IRQ7 appears in 2.6.19-rc6-git10
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have just tested for fun the upcoming release candidate and have
found the following difference with a 'spurious 8259A interrupt:
IRQ7' message, possibly triggered by the

--- linux-2.6.19-rc5.txt        2006-11-28 19:23:54.145722821 +0100
+++ linux-2.6.19-rc6-git10.txt  2006-11-28 19:14:04.579597162 +0100
@@ -1,4 +1,4 @@
-Linux version 2.6.19-rc5 (root@vrapenec) (gcc version 4.1.1 (Gentoo
4.1.1-r1)) #1 Tue Nov 14 02:54:07 CET 2006
+Linux version 2.6.19-rc6-git10 (root@vrapenec) (gcc version 4.1.1
(Gentoo 4.1.1-r2)) #1 Tue Nov 28 17:56:27 CET 2006
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
@@ -43,7 +43,7 @@
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Initializing CPU#0
-CPU 0 irqstacks, hard=c147f000 soft=c147e000
+CPU 0 irqstacks, hard=c1480000 soft=c147f000
 PID hash table entries: 4096 (order: 12, 16384 bytes)
 Console: colour VGA+ 80x25
 Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo
Molnar
@@ -88,7 +88,8 @@
          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
-    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
+    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |<7>spurious
8259A interrupt: IRQ7.
+
     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |




Here is the relevant part of full dmesg output from 2.6.19-rc6-git10:

Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 904 kB
 per task-struct memory footprint: 1200 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem
| rsem |

--------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok
|  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok
|  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok
|  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok
|  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok
|  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok
|  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok
|  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok
|  ok  |
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok
|  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok
|  ok  |

--------------------------------------------------------------------------
              recursive read-lock:             |  ok  |
|  ok  |
           recursive read-lock #2:             |  ok  |
|  ok  |
            mixed read-write-lock:             |  ok  |
|  ok  |
            mixed write-read-lock:             |  ok  |
|  ok  |

--------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |<7>spurious
8259A interrupt: IRQ7.

    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
...
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
-------------------------------------------------------
Good, all 218 testcases passed! |
---------------------------------


Please Cc: me in replies.
Thanks.
Martin
