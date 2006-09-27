Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030742AbWI0UK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030742AbWI0UK5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030743AbWI0UK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:10:57 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:18061 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1030742AbWI0UK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:10:56 -0400
Date: Wed, 27 Sep 2006 21:05:49 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Stas Sergeev <stsp@aknet.ru>
cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC MAP_PRIVATE mmaps
In-Reply-To: <451ACE29.4080005@aknet.ru>
Message-ID: <Pine.LNX.4.64.0609272045560.24191@blonde.wat.veritas.com>
References: <45150CD7.4010708@aknet.ru>  <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
  <451555CB.5010006@aknet.ru>  <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>
  <1159037913.24572.62.camel@localhost.localdomain>  <45162BE5.2020100@aknet.ru>
 <1159106032.11049.12.camel@localhost.localdomain> <45169C0C.5010001@aknet.ru>
 <4516A8E3.4020100@redhat.com> <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>
 <451ACE29.4080005@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 27 Sep 2006 20:05:43.0864 (UTC) FILETIME=[50559B80:01C6E270]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006, Stas Sergeev wrote:
> 
> It looks like in a course of a discussion people
> agreed that at least for MAP_PRIVATE the MNT_NOEXEC
> check makes no sense (no one spoke up otherwise, at least).

Thanks for the CC Stas, but I'm sorry, I don't think you should
take our silence as agreement: certainly not mine anyway.

I can see absolutely no reason to distinguish MAP_PRIVATE from
MAP_SHARED here: the distinction between them is all to do with
modification (PROT_WRITE), nothing to do with PROT_EXEC.  And
since executables are typically mapped MAP_PRIVATE, I suspect
your patch will simply break mmap's intended MNT_NOEXEC check.

I think you need to face up to the fact that "noexec"
doesn't suit your mount, and just leave it at that.

I've not replied to your questions about the security of "noexec",
partly because I've other things occupying me, partly because I'm
naive in such matters, and my guesses not worth anyone's bandwidth.
I'm quite prepared to believe that "noexec" is about reducing the
likelihood of accidents rather than enforcing security, but that's
still no reason to change its accepted 3-year-old behaviour.

But I do concede that I'm reluctant to present that patch Alan
encouraged, adding a matching MNT_NOEXEC check to mprotect: it
would be consistent, and I do like consistency, but in this case
fear that change in behaviour may cause new userspace breakage.

Hugh

> 
> The attached patch removes the check for MAP_PRIVATE but
> leaves for MAP_SHARED for now, as this was not agreed on.
> 
> Reasons:
> - MAP_PRIVATE should not behave like that, "ro" and PROT_WRITE
> is a witness ("ro" doesn't deny PROT_WRITE for MAP_PRIVATE).
> - This is not a security check - file-backed MAP_PRIVATE mmaps
> can just be replaced with MAP_PRIVATE | MAP_ANONYMOUS
> mmap and read().
> - The programs (like AFAIK wine) use MAP_PRIVATE mmaps to
> access the windows dlls, which are usually on a "noexec"
> fat or ntfs partitions. Wine might be smart enough not to
> break but fallback to read(), but this is slower and more
> memory-consuming. Some other program may not be that smart
> and break. So there is clearly a need for MAP_PRIVATE with
> PROT_EXEC on the noexec partitions.
> 
> Sign-off: Stas Sergeev <stsp@aknet.ru>
