Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVCWXhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVCWXhT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVCWXhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:37:19 -0500
Received: from ip-138-34.sn1.eutelia.it ([62.94.138.34]:6148 "EHLO gandalf")
	by vger.kernel.org with ESMTP id S262100AbVCWXhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:37:03 -0500
Message-ID: <424192BE.2030805@gmail.com>
Date: Wed, 23 Mar 2005 16:01:02 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Some questions about VM flags
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was playing with mprotect and VM flags when I noticed two curious behaviours.



1)

This C program modifies data segments's flags:

#include <stdio.h>
#include <sys/mman.h>

/* Values shown by /proc/<pid>/maps */
#define START	0x08049000
#define END	0x0804a000

int target;

int main(void)
{
	printf("ADDRESS: %p\n", &target);
	target = 1;
	mprotect((void *)START, END - START, PROT_WRITE);
	printf("%d\n", target);
	return 0;
}

After the mprotect call, data segment's flags are
08049000-0804a000 -w-p 00000000 03:06 297330     /home/dktrkranz/vmflags_read

Shouldn't printf generate a segfault trying to read a variabile located in a
write-only area?



2)

This C program tries to execute a shellcode:

/* This shellcode calls write and exit. It's harmless ;) */
char shellcode[] =
"\x31\xc0\x31\xdb\x31\xd2\x53\x68\x7a\x0a\x00\x00\x68\x4b\x72"
"\x61\x6e\x68\x44\x6b\x74\x72\x89\xe1\xb2\x0a\xb0\x04\xcd\x80"
"\x31\xc0\x31\xdb\xb0\x01\xcd\x80";

int main(void)
{
	void(*sc)(void);
	sc = (void *)&shellcode;
	sc();
	return 0;
}

These are data segment's flags:
08049000-0804a000 rw-p 00000000 03:06 297330     /home/dktrkranz/vmflags_sc

Shellcode lies in this segment. It is executed even if VM_EXEC isn't set. I
think execution shouldn't be permitted if only VM_READ or VM_WRITE flags are
set. Buffer overflows/format string based exploits wouldn't be so popular if we
implemented this feaure. Please let me know your opinion.

Thank you,



					Luca



