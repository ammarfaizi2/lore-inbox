Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVDFRKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVDFRKQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 13:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVDFRKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 13:10:02 -0400
Received: from graphe.net ([209.204.138.32]:62217 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262224AbVDFRJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 13:09:44 -0400
Date: Wed, 6 Apr 2005 10:09:38 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Kumar Gala <kumar.gala@freescale.com>,
       LKML list <linux-kernel@vger.kernel.org>
Subject: Re: return value of ptep_get_and_clear
In-Reply-To: <425412FB.7030209@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0504061006120.4635@graphe.net>
References: <a0b2cb42ff815dcf964b7a728f638b87@freescale.com>
 <425412FB.7030209@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005, Nick Piggin wrote:

> Kumar Gala wrote:
> > ptep_get_and_clear has a signature that looks something like:
> >
> > static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned
> > long addr,
> >                                        pte_t *ptep)
> >
> > It appears that its suppose to return the pte_t pointed to by ptep
> > before its modified.  Why do we bother doing this?  The caller seems
> > perfectly able to dereference ptep and hold on to it.  Am I missing
> > something here?
> >
>
> You need to be able to *atomically* clear the pte and retrieve the
> old value.

The effect of the clearing is that the present bit is cleared which makes
the CPU generate a fault if this pte is referenced.

The problem with replacing pte values is that the code executing is racing
with cpu mmu access to the pte (which may set bits on i386 I believe). So
if you would access the pte and then clear it later then there would be a
small window where the MMU could modify the pte. These changes would not
be detected since you later overwrite the pte.

Using ptep_get_and_clear insures that this does not happen...
