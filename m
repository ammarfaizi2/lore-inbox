Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267026AbSKSR27>; Tue, 19 Nov 2002 12:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267027AbSKSR27>; Tue, 19 Nov 2002 12:28:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45909 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267026AbSKSR24>; Tue, 19 Nov 2002 12:28:56 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7 -- Success Story!
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
	<m1k7jb3flo.fsf_-_@frodo.biederman.org>
	<m1el9j2zwb.fsf@frodo.biederman.org>
	<m11y5j2r9t.fsf_-_@frodo.biederman.org>
	<1037668241.10400.48.camel@andyp> <m1isyt26wr.fsf@frodo.biederman.org>
	<1037726468.10400.81.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2002 10:34:57 -0700
In-Reply-To: <1037726468.10400.81.camel@andyp>
Message-ID: <m1adk51n0e.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Tue, 2002-11-19 at 02:25, Eric W. Biederman wrote:
> > > Complete kernel boot-up log attached below.  I'm going to try to find my
> > > other 576MB of RAM with the right command-line magic... ;^)
> > 
> > Or you can write a routine to gather that information dynamically and send
> > me a patch for /sbin/kexec.  Though it may take another proc file to do
> > that one properly.
> > 
> > Eric
> 
> Just to make sure I understand the problem.  Until we can make all
> boot-time BIOS calls work, we need a way to:

A small clarification.  BIOS calls will never work 100%.  Especially in the
interesting cases like kexec on panic.  So entering the kernel in
32bit mode will continue to be the default mode of.  This means the
final solution to problems like this needs to be a good one.
 
>     1) capture the initial memory map used by the kernel, and
>     2) a way to supply that information to the to-be-run image.
>     
> On my system, the e820 map looks like this (from full reboot):
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
>  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000027fed140 (usable)
>  BIOS-e820: 0000000027fed140 - 0000000027ff0000 (ACPI data)
>  BIOS-e820: 0000000027ff0000 - 0000000028000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
> 639MB LOWMEM available.
> 
> And /proc/iomem looks like this:
> 00000000-0009dbff : System RAM
> 0009dc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000ca000-000cb7ff : Extension ROM
> 000cb800-000cffff : Extension ROM
> 000f0000-000fffff : System ROM
> 00100000-27fed13f : System RAM
>   00100000-00309f9a : Kernel code
>   00309f9b-003d873f : Kernel data
> 27fed140-27feffff : ACPI Tables
> 27ff0000-27ffffff : reserved
> effff000-efffffff : Adaptec AIC-7892P U160/m
>   effff000-efffffff : aic7xxx
> f0000000-f7ffffff : S3 Inc. Savage 4
> fea00000-feafffff : Intel Corp. 82557/8/9 [Ethernet 
>   fea00000-feafffff : e100
> feb7e000-feb7efff : ServerWorks OSB4/CSB5 USB Contro
> feb7f000-feb7ffff : Intel Corp. 82557/8/9 [Ethernet 
>   feb7f000-feb7ffff : e100
> feb80000-febfffff : S3 Inc. Savage 4
> fec00000-ffffffff : reserved
> 
> Comparing the two:
> Range			e820		/proc/iomem
> 0000000-0009dbff	usable		System RAM
> 0100000-27fed140	usable		System RAM
> 
> >From a sample of 1 system, it looks like we should be able to use any
> ranges marked as "System RAM" that are listed /proc/iomem.  Did I miss
> something?

Only that /proc/iomem is only useful this way on x86 and that
it doesn't capture the details of the memory map above 4GB.  But
it is much better than only having 4GB of main memory.

Eric
