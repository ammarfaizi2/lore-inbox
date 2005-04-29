Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262885AbVD2TGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbVD2TGf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVD2TGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:06:35 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:44242 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S262885AbVD2TGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:06:30 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3 mmap lack of consistency among runs
Date: Fri, 29 Apr 2005 18:36:16 GMT
Message-ID: <0563YCG12@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Tonneau wrote:
>
> I even tried adding the following instruction at the very beginning of my
> C program, with no more success:
> personality(0x0040000); // ADDR_NO_RANDOMIZE
> 
> Basically, the behaviour is not changed, as opposed to if I do:
> echo 0 >/proc/sys/kernel/randomize_va_space

I believe that I understand why calling 'personality' does not work:
it has to be called before the process is loaded as far as I could understand
the Linux source code.

So, at the moment, the only two effective workarounds I'm awared of are:
. switch to calling 'mmap' with specified requested address right from the
  beginning (also I find it very dangerous over the long run)
. call 'mmap' to allocate (waste) 1 MB of address space when the process
  runs for the first time, so that I'm granted that subsequente 'mmap'
  will allocate from a memory area that is always available from run to run

Also about the second solution (the one that I've included in Pliant)
I have two concernes:
. first it's ugly (should I include it in Posix OS agnostic version of
  Pliant or just declare that Linux cannot run the generic version anymore)
. second, and most important one, I have experimentaly determined that 1 MB
  is the minimum address space to allocate (waste), but I could not understand
  where it comes from reading the Kernel source, and I don't understand how
  stable will this value be over time:

unsigned long arch_align_stack(unsigned long sp)
{
  if (randomize_va_space)
    sp -= get_random_int() % 8192;
  return sp & ~0xf;
}

