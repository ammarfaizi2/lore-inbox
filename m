Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277094AbRKJH1J>; Sat, 10 Nov 2001 02:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279505AbRKJH07>; Sat, 10 Nov 2001 02:26:59 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:14345 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277094AbRKJH0v>;
	Sat, 10 Nov 2001 02:26:51 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives? 
In-Reply-To: Your message of "Sat, 10 Nov 2001 14:35:58 +1100."
             <20011110143557.A767@krispykreme> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 10 Nov 2001 18:26:38 +1100
Message-ID: <14470.1005377198@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2001 14:35:58 +1100, 
Anton Blanchard <anton@samba.org> wrote:
>Yep all indirect function calls require save and reload of the TOC
>(which is r2):
>
>When calling a function in the kernel from within the kernel (eg printk),
>we dont have to save and reload the TOC:

Same on IA64, indirect function calls have to save R1, load R1 for the
target function from the function descriptor, call the function,
restore R1.  Incidentally that makes a function descriptor on IA64
_two_ words, you cannot save an IA64 function pointer in a long or even
a void * variable.

>Alan Modra tells me the linker does the fixup of nop -> r2 reload. So
>in this case it isnt needed.

IA64 kernels are compiled with -mconstant-gp which tells gcc that
direct calls do not require R1 save/reload, gcc does not even generate
a nop.  However indirect function calls from one part of the kernel to
another still require save and reload code, gcc cannot tell if the call
is local or not.

>However when we do the same printk from a module, the nop is replaced
>with an r2 reload:

Same on IA64, calls from a module into the kernel require R1 save and
reload, even if the call is direct.  So there is some code overhead
when making direct function calls from modules to kernel on IA64, that
overhead disappears when code is linked into the kernel.  Indirect
functions calls always have the overhead, whether in kernel or in
module.

