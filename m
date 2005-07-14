Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVGNCUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVGNCUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 22:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVGNCUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 22:20:14 -0400
Received: from bay108-dav14.bay108.hotmail.com ([65.54.162.86]:24116 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261567AbVGNCUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 22:20:11 -0400
Message-ID: <BAY108-DAV14071EF16A4482FB4B691593D10@phx.gbl>
X-Originating-IP: [65.54.162.200]
X-Originating-Email: [multisyncfe991@hotmail.com]
Reply-To: <multisyncfe991@hotmail.com>
From: <multisyncfe991@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: About a change to the implementation of spin lock in 2.6.12 kernel.
Date: Wed, 13 Jul 2005 19:20:06 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 14 Jul 2005 02:20:07.0302 (UTC) FILETIME=[8D6A7A60:01C5881A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found _spin_lock used a LOCK instruction to make the following operation 
"decb %0" atomic. As you know, LOCK instruction alone takes almost 70 clock 
cycles to finish and this add lots of cost to the _spin_lock. However 
_spin_unlock does not use this LOCK instruction and it uses "movb $1,%0" 
instead since 4-byte writes on 4-byte aligned addresses are atomic.

So I want rewrite the _spin_lock defined spinlock.h 
(/linux/include/asm-i386) as follows to reduce the overhead of _spin_lock 
and make it more efficient.
#define spin_lock_string \
        "\n1:\t" \
        "cmpb $0,%0\n\t" \
        "jle 2f\n\t" \
        "movb $0, %0\n\t" \
        "jmp 3f\n" \
        "2:\t" \
        "rep;nop\n\t" \
        "cmpb $0, %0\n\t" \
        "jle 2b\n\t" \
        "jmp 1b\n" \
        "3:\n\t"

Compared with the original version as follows, LOCK instruction is removed. 
I rebuilt the Intel e1000 Gigabit driver with this _spin_lock. There is 
about 2% throughput improvement.
#define spin_lock_string \
            "\n1:\t" \
            "lock ; decb %0\n\t" \
            "jns 3f\n" \
            "2:\t" \
            "rep;nop\n\t" \
            "cmpb $0,%0\n\t" \
            "jle 2b\n\t" \
            "jmp 1b\n" \
            "3:\n\t"

Do you think I can get a better performance if I dig further?

Any ideas will be greatly appreciated,

L.Y.
