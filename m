Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbVIEJsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbVIEJsz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVIEJsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:48:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32154 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750878AbVIEJsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:48:54 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.63.0509031134240.567@cuia.boston.redhat.com> 
References: <Pine.LNX.4.63.0509031134240.567@cuia.boston.redhat.com> 
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/2] fix for -mm add-sem_is_read-write_locked.patch 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Mon, 05 Sep 2005 10:48:43 +0100
Message-ID: <26510.1125913723@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:

> Here is an incremental fix to the add-sem_is_read-write_locked
> patch in -mm.  Also attached is a full version of that file,
> which can just be dropped into place - I've verified that none
> of the patches in your stack get rejects.

The comment attached to the drop-in replacement patch is wrong:

| [1. text/plain; add-sem_is_read-write_locked.patch]   
| 
| From: Rik Van Riel <riel@redhat.com>
| 
| Add sem_is_read/write_locked functions to the read/write semaphores, along the
| same lines of the *_is_locked spinlock functions.  The swap token tuning patch
| uses sem_is_read_locked; sem_is_write_locked is added for completeness.

The function names you've used are incorrect.

Furthermore, the substance of the patch is wrong in a number of ways:

| Index: linux-2.6.13/include/asm-ppc64/rwsem.h
| ===================================================================
| --- linux-2.6.13.orig/include/asm-ppc64/rwsem.h
| +++ linux-2.6.13/include/asm-ppc64/rwsem.h
| @@ -163,5 +163,10 @@ static inline int rwsem_atomic_update(in
|  	return atomic_add_return(delta, (atomic_t *)(&sem->count));
|  }
|  
| +static inline int sem_is_read_locked(struct rw_semaphore *sem)
| +{
| +	return (sem->count != 0);
| +}
| +

This uses the function wrong name. And:

| Index: linux-2.6.13/include/linux/rwsem-spinlock.h
| ===================================================================
| --- linux-2.6.13.orig/include/linux/rwsem-spinlock.h
| +++ linux-2.6.13/include/linux/rwsem-spinlock.h
| @@ -61,5 +61,15 @@ extern void FASTCALL(__up_read(struct rw
|  extern void FASTCALL(__up_write(struct rw_semaphore *sem));
|  extern void FASTCALL(__downgrade_write(struct rw_semaphore *sem));
|  
| +static inline int sem_is_read_locked(struct rw_semaphore *sem)
| +{
| +	return (sem->activity > 0);
| +}
| +
| +static inline int sem_is_write_locked(struct rw_semaphore *sem)
| +{
| +	return (sem->activity < 0);
| +}
| +

Is inconsistent, though the tests are valid.

Also, you don't need to bracket the expression handed to the return directive,
but that's a minor matter.

David
