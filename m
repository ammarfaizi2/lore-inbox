Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbULDSJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbULDSJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 13:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbULDSJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 13:09:15 -0500
Received: from mail.aknet.ru ([217.67.122.194]:39953 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262564AbULDSJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 13:09:10 -0500
Message-ID: <41B1FD4B.9000208@aknet.ru>
Date: Sat, 04 Dec 2004 21:09:15 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: prasanna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
References: <20041109130407.6d7faf10.akpm@osdl.org> <20041110104914.GA3825@in.ibm.com> <4192638C.6040007@aknet.ru> <20041117131552.GA11053@in.ibm.com>
In-Reply-To: <20041117131552.GA11053@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------030800020008060600010700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030800020008060600010700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Prasanna.

I've found yet another bug in this
very same piece of code. Now I can
reproduce the interrupt theft without
using either vm86() or modify_ldt().
Test-case is attached. It gets
ocasionally fixed by the patch I've
sent in my previous mail, but it is
really another bug that requires a
separate fix.

--------------030800020008060600010700
Content-Type: text/x-csrc;
 name="trap1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trap1.c"

#include <stdlib.h>
#include <signal.h>

void my_trap(int sig)
{
  printf("Test passed, all OK\n");
  exit(0);
}

int main()
{
  signal(SIGTRAP, my_trap);
  asm volatile (".byte 0xcd,3");
  printf("Stolen interrupt, very bad!\n");
}

--------------030800020008060600010700--
