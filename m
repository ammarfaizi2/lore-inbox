Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWAQRus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWAQRus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWAQRus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:50:48 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:12858 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751264AbWAQRur convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:50:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kZHv54CLnSy0LnD4T8ylcC9TMNsq0JGfHj26d/+GcxyZmKkyxE5AwneDQvBphp7JAfAlFwiAztcyPgSlPU2GUdLMZ8O+/hx7CKDf6ikG9ezuFwohTicr3+SzRoln5Mzm0ycvhsA23fF9BVNkt+HMpZBCeeCLH0MTpYAZ2sXpBTA=
Message-ID: <a36005b50601170950u307ffb9dl52dc3655a1b90fa6@mail.gmail.com>
Date: Tue, 17 Jan 2006 09:50:46 -0800
From: Ulrich Drepper <drepper@gmail.com>
To: david singleton <dsingleton@mvista.com>
Subject: Re: [robust-futex-3] futex: robust futex support
Cc: akpm@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <C59522FA-8700-11DA-B27C-000A959BB91E@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43C84D4B.70407@mvista.com>
	 <a36005b50601141602y641567ebh5ff9b6a1fad4d7d2@mail.gmail.com>
	 <746DBAD6-855A-11DA-A824-000A959BB91E@mvista.com>
	 <a36005b50601142118h3a07a640ra668dab13129683b@mail.gmail.com>
	 <C59522FA-8700-11DA-B27C-000A959BB91E@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And another thing: semaphores are on their way out.  So, in
futex_deregister and in futex_head, shouldn't you use mutexes?  I
don't see that you realy need semaphores.

In futex_register, you define mm and initialize it with current->mm. 
That's OK.  But why then are you using

+       down_read(&current->mm->mmap_sem);

just a few lines below?

And finally (for now): in get_futex_key the VMA containing the futex
is determined.  And yet, in futex_register you have an identical
find_extend_vma call.  I don't know how expensive this function is. 
But I would assume that at least the error handling in futex_register
can go away since the VMA cannot be torn down while mmap_sem is taken,
right?  But perhaps this just points to more inconsistencies.  Why is
the list/sem lookup in get_futex_key?  Only to share the code with
futex_deregister.  But is that really worth it?  The majority of calls
to get_futex_key come from all the other call sites so the code you
added is only a cost without any gain.  Especially since you could in
futex_register do the whole thing without any additional cost and
because most of the new tests in get_futex_key are again tested in
futex_register (to determined shared vs non-shared) and do not have to
be tested in futex_deregister (we know the futex is in shared memory).

I suggest that if find_extend_vma is sufficiently expensive, pass a
pointer to a variable of that type to get_futex_key.  If it is cheap,
don't do anything.  Pull the new code in get_futex_key into
futex_register and futex_deregister, optimize out unnecessary code,
and merge with the rest of the functions.  It'll be much less
invasive.
