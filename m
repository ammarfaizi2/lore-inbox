Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265416AbTFMPdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 11:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbTFMPdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 11:33:11 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:55432 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265416AbTFMPdF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 11:33:05 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 13 Jun 2003 08:44:59 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: David Schwartz <davids@webmaster.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKCEFJDKAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.55.0306130834590.4201@bigblue.dev.mcafeelabs.com>
References: <MDEHLPKNGKAHNMBLJOLKCEFJDKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, David Schwartz wrote:

> 	You could also do (in pseudo-code):
>
> top:
>  ret <- v->counter
>  inc ret
>  LOCK incl v->counter
>  cmp v->counter, ret
>  jz end
>  LOCK decl v->counter
>  jmp top:
> end:
>  return ret
>
> 	This does not strictly guarantee in order return values, but that's
> meaningless without a lock anyway.

It is even worse since it can return same values. Suppose counter is 0 :

TASK0                   TASK1

top:
ret <- v->counter     ; ret = 0
inc ret               ; ret -> 1
LOCK incl v->counter  ; counter -> 1

			top:
			ret <- v->counter     ; ret = 1
			inc ret               ; ret -> 2
			LOCK incl v->counter  ; counter -> 2
			cmp v->counter, ret   ; match !! got 2
			jz end
			...

cmp v->counter, ret  ; ret == 1 , counter == 2 no-match
jz end
LOCK decl v->counter ; counter -> 1
jmp top

Then TASK0 starts again with no interruption and gets 2. You need
instrucions that does atomic mod/cmp to do this kind of tricks.



- Davide

