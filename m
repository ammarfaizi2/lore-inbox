Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUJRQJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUJRQJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 12:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUJRQJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 12:09:29 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:33522 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S266802AbUJRQJV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 12:09:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [BUG] in i386 semaphores.
Date: Mon, 18 Oct 2004 09:09:20 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B3017FBE1C@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] in i386 semaphores.
Thread-Index: AcS0zgInqzh0y+AIROCRKAqMQVLHbgAXnXOg
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Oct 2004 16:09:20.0741 (UTC) FILETIME=[D3A80950:01C4B52C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi.

I sent this yesterday, but seems like it missed the list somehow :
	 
  There are several assembly 'helpers' in arch/i386/semaphore.c, for
example, __up_wakeup. __up_wakeup's purpose is to call C function:
asmlinkage void __up(struct semaphore *sem)
	 
this is how it does it:
 
	pushl %eax
	pushl %edx
	pushl %ecx
	call __up
	popl %ecx
	popl %edx
	popl %eax
	 
  As one can see, actual parameter in %ecx is not only being copied in
formal parameter sem (which is correct), but also being restored from it
after function call via %ecx (which is incorrect). Since formal
parameter is not a constant one, it may be overwritten inside C
function, or gcc may (and in fact does that in some cases) use it for
something else.
If we want to keep %ecx, correct behavior would be

	pushl %ecx
	pushl %ecx
	call _up
	add $4, %ecx
	popl %ecx
	 
Above applies for other functions in semaphore.c in latest 2.6 kernels.
2.4 might also be affected.
	 
Thanks,
Aleks.


