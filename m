Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946551AbWKJMq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946551AbWKJMq4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 07:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946552AbWKJMq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 07:46:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:43388 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946551AbWKJMqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 07:46:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hv0/CBSV+86ASiYUntCHW1vvQSpBdWT5ZVMm2clLxSmWKa8CkNBaLpaWuTxrQxTV7hsFkma7pMjggnXuLgtMmrsiqPfy+e2soLGpJAPHp8DJcyN7xRSO8DFRwZesojbhlBuxxTlgzXkk5SQOeNdlgFrlVRudNmgNulXztna/HNI=
Message-ID: <6e0cfd1d0611100446j77a27b29jc23f76a515451377@mail.gmail.com>
Date: Fri, 10 Nov 2006 13:46:53 +0100
From: "Martin Schwidefsky" <schwidefsky@googlemail.com>
To: "Jeremy Fitzhardinge" <jeremy@goop.org>
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
Cc: "Avi Kivity" <avi@qumranet.com>, "Arnd Bergmann" <arnd@arndb.de>,
       kvm-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4553BC18.6090207@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061109110852.A6B712500F7@cleopatra.q>
	 <200611091429.42040.arnd@arndb.de> <45532EE3.4000104@qumranet.com>
	 <200611091542.31101.arnd@arndb.de> <455340B8.2080206@qumranet.com>
	 <4553BC18.6090207@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/06, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> >> Or gcc
> >> might move the assignment of phys_addr to after the inline assembly.
> >>
> > "asm volatile" prevents that (and I'm not 100% sure it's necessary).
>
> No, it won't necessarily.  "asm volatile" simply forces gcc to emit the
> assembler, even if it thinks its output doesn't get used.  It makes no
> ordering guarantees with respect to other code (or even other "asm
> volatiles").   The "memory" clobbers should fix the ordering of the asms
> though.

The "memory" clobber just tells the compiler that any memory object
might get access by the inline. This forces the compiler to write back
values it cached in registers and to reload the values after the
inline assembly. This does NOT make it generate correct code for local
objects. We had the case where we created a control block on the stack
and passed it to a magic instruction. Since we did not tell the
compiler that the content of the control block is used but only the
address of it, gcc just passed a local stack address to the inline but
optimized the initialization of the control block away. So the
following can break:

struct control_block {
        int a, b;
};

void fn(void)
{
        struct control_block x;

        x.a = 42;
        x.b = 0815;
        asm volatile ("<magic>" : : "a" (&x) : "memory");
}

You won't find the assignments to x.a and x.b in the compiled code.

-- 
blue skies,
  Martin
