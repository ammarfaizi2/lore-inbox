Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUHHJU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUHHJU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 05:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUHHJU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 05:20:56 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:4028 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265230AbUHHJUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 05:20:55 -0400
Message-ID: <4115F0FA.30503@colorfullife.com>
Date: Sun, 08 Aug 2004 11:23:06 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.8-rc3 slab corruption (jffs2?)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmk wrote:

>Due to tail call optimisation, its difficult to work out exactly what's
>going on, but the first seems to be a kfree call from the erase callback
>(possibly jffs2_erase_callback).  The second function is the call to
>jffs2_free_full_dirent() in jffs2_garbage_collect_deletion_dirent().
>
>  
>
I'd concentrate on cfi_intelext_erase_varsize+0x58/0x64:
When slab encounters a corruption, it dumps three objects: the corrupted 
one, the previous one and the next one. Theoretically, a write 
before/after the end of the object could corrupt the neighboring object, 
but probably the first function is the relevant one.

Could you double check that gcc did a tail optimization in 
cfi_intelext_erase_varsize?
I don't understand how this is possible: cfi_intelext_erase_varsize 
returns (int)0, instr->callback is a void function.
And even if there is a tail optimization: how would that affect the call 
address of the kfree() call? Perhaps gcc automatically inlined something?

--
    Manfred
