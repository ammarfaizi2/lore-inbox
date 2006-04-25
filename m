Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWDYSHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWDYSHN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWDYSHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:07:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:63421 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932127AbWDYSHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:07:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=G26E/iMH4/sNHXsg3n5uxvCmH5xYSaiLxro9mAUPHeA2goYWpl37eV7PmrvA2AhlJCf1K7Uz0wJy85HVqJjOBOvxMpmB1dN2gq86hhH63p5iH4mD3l3o76549ranSHNQShlFgM3nbyUemJxD2HdKgRYMuH0i8QF8tl+2dnlHDyY=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Daniel Walker'" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Profile likely/unlikely macros
Date: Tue, 25 Apr 2006 11:06:55 -0700
Message-ID: <003801c66893$0f873c00$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <444DF5B4.6030004@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcZoWgNmNp+sR8+fTBmNZoHAAl9ZiwAOJ6xw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> Andrew Morton wrote:
> > Daniel Walker <dwalker@mvista.com> wrote:
> > 
> >> +	if (likeliness->type & LIKELY_UNSEEN) {
> >> +		if (atomic_dec_and_test(&likely_lock)) {
> >> +			if (likeliness->type & LIKELY_UNSEEN) {
> >> +				likeliness->type &= (~LIKELY_UNSEEN);
> >> +				likeliness->next = likeliness_head;
> >> +				likeliness_head = likeliness;
> >> +			}
> >> +		}
> >> +		atomic_inc(&likely_lock);
> > 
> > 
> > hm, good enough I guess.  It does need a comment explaining why we 
> > don't just do spin_lock().
> 
> I guess it is so it can be used in NMIs and interrupts 
> without turning interrupts off (so is somewhat lightweight).
> 
> But please Daniel, just use spinlocks and trylock. This is 
> buggy because it doesn't get the required release consistency correct.

Could you elaborate a bit what's wrong here? (memory barriers, etc? What about the test_and_set_bit() thing Andrew suggested?)

Trylock is a bit more dirty because we need to avoid recursion (it used likely/unlikely too). While there are ways to work around
it, atomic operations seem to be cleaner.

