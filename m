Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVLDQlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVLDQlv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 11:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVLDQlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 11:41:51 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:1735 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932141AbVLDQlu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 11:41:50 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: Questions on __initdata
Date: Sun, 4 Dec 2005 17:41:43 +0100
User-Agent: KMail/1.8.3
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20051204151533.13df37c6.khali@linux-fr.org>
In-Reply-To: <20051204151533.13df37c6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512041741.43591.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag 04 Dezember 2005 15:15 schrieb Jean Delvare:

> My tests (on i386) seem to suggest that "doesn't apply to uninitialized
> data" only holds for non-global variables. Tagging uninitialized global
> variables __initdata works, and moves the variables from .bss to .data.
> Is it correct? Does it work on all archs? If so, the comment above
> needs to be fixed.

Yes, your observation is correct. Note that newer gcc versions treat
data that is initialized to zero the same way as uninitialized data (by 
putting it into .bss), but that should be independent of the architecture.

> I'm also slightly puzzled by the whole concept of __initdata static
> local variables. They only seem to make sense if the function itself is
> tagged __init. If so, isn't it redundant to tag the data __initdata?

No. If the function is tagged __init, it goes into the init section, but 
static variable in it still go to .bss, so you have to flag them separately.
It would be nice if gcc could determine that automatically, but the
current __attribute__((section())) syntax does not allow that.

> As a side question, given that an uninitialized global variable being
> tagged __initdata will be moved from .bss to .data, will it become a
> truly uninitialized variable? Or will it automatically be initialized
> to 0 by the compiler as .bss is?

.bss is special in that it is not initialized by the compiler but by the
ELF loader, or case of the kernel, some very early kernel code.
Moving data from .bss to __initdata causes it to be initialized to
zero by the compiler and it becomes part of the object file.

> + *
> + * Uninitialized static local variables cannot be made "__initdata".
>   *
As explained above, this sentence is wrong.

>   *
>   * Also note, that this data cannot be "const".

I think this sentence is wrong as well, can anyone clarify why you should
not be able to have const __initdata?

	Arnd <><
