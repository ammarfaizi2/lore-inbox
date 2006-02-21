Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWBUQ0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWBUQ0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWBUQ0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:26:07 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:28422 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932309AbWBUQ0G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:26:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aitF6Sm1LDUSKhzZdB10ppQ3spEkaOhomCJDbzNrPiR6rRJrvc7iPGmd/kXtPU5YUHq9m8sxi6vq5dxU1xKBcMt08W8pAxCV+zYw2blm4L3LPY26RlBnoAuNqnX0Kl7yU3xU5mOHl2xGbwMKOxoTr6VfilTvgsZekHOt6XjMGOk=
Message-ID: <a36005b50602210826i567effabsd4b43da9804db86d@mail.gmail.com>
Date: Tue, 21 Feb 2006 08:26:05 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Jakub Jelinek" <jakub@redhat.com>
Subject: Re: [patch 0/6] lightweight robust futexes: -V4
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Ulrich Drepper" <drepper@redhat.com>, "Paul Jackson" <pj@sgi.com>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060221092338.GV24295@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060221084631.GA5506@elte.hu>
	 <20060221092338.GV24295@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, Jakub Jelinek <jakub@redhat.com> wrote:
> TID address is registered through:
> pid_t set_tid_address (int *tidptr)
> syscall, so IMHO we should add a new syscall
> pid_t set_tid_robust_addresses (int *tidptr, struct robust_list_head *robustptr)
> which could register both tid and robust addresses.

The new syscall what certainly be used like this.  In fact, the two
syscalls happen exactly one after the other in my sources.  So I would
be in favor of making a change along these lines.  But instead of
fixing the interface in this way it should be extendable.  Pass a
structure and a flag value.  The latter specifies which elements of
the structure are used.  The structure could even grow over time.


> For thread creation, we can just add CLONE_CHILD_SETROBUST clone flag
> and if that flag is set, pass struct robust_list_head * as additional
> argument.

This is not necessary.  Especially because we already reached the
limit of parameters to clone.  A dedicated syscall to set up various
things like the TID pointer and the robust list is fine.


> The `len' argument (or really revision of the structure if really needed)
> can be encoded in the structure, as in:
> struct robust_list_head {
>        struct robust_list list;
>        short robust_list_head_len; /* or robust_list_head_version ? */
>        short futex_offset;
>        struct robust_list __user *list_op_pending;
> };
> or with long futex_offset, but using say upper 8 bits of the field as
> version or length.

I know you want to save SPARC but this kind of overloading I don't
really like.  If you need special treatment of the futex value make
this explicit and arch-dependent.
