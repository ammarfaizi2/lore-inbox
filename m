Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbRFMN6u>; Wed, 13 Jun 2001 09:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263257AbRFMN6l>; Wed, 13 Jun 2001 09:58:41 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:58867 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S263149AbRFMN6a>;
	Wed, 13 Jun 2001 09:58:30 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq 
In-Reply-To: Your message of "Wed, 13 Jun 2001 05:13:02 MST."
             <15143.22734.747077.588558@pizda.ninka.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Jun 2001 23:58:05 +1000
Message-ID: <9878.992440685@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001 05:13:02 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>Keith Owens writes:
> > do_softirq is called from asm code which does not get preprocessed.
> > It needs to be exported with no version.
>
>It can get preprocessed if you know how.  Simply use the "i" asm
>constraint for an extra argument, and use the symbol there.  For
>example:
>
>	__asm__("%0" : : "i" (my_versioned_symbol));
>
>It works and we've been doing it on sparc for ages.

It works for integers but call do_softirq is more of a problem.  I
could not find an asm constraint that generated correct code in a
single instruction.  The closest I could get was
  __asm__("call *%%eax" : : "a" (do_softirq));
The 'obvious'
  __asm__("call %0" : : "m" (do_softirq));
calls to a location that contains the address of do_softirq, oops.

Any other architectures that call do_softirq inside asm would need
similar hard coding of indirect branches.  It is simpler to export
do_softirq with no version, and have cleaner asm.

