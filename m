Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275269AbTHMRAc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 13:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275279AbTHMRAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 13:00:32 -0400
Received: from fmr02.intel.com ([192.55.52.25]:51417 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S275269AbTHMRA0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 13:00:26 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: Re: 2.6.0-test2 : size of /proc/kcore is different from RAM size.
Date: Wed, 13 Aug 2003 10:00:08 -0700
Message-ID: <DD755978BA8283409FB0087C39132BD101B01063@fmsmsx404.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: 2.6.0-test2 : size of /proc/kcore is different from RAM size.
Thread-Index: AcNhvFm3BfGDZFnhRVm4P0HdeoeVqw==
From: "Luck, Tony" <tony.luck@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <remi.colinet@wanadoo.fr>
X-OriginalArrivalTime: 13 Aug 2003 17:00:23.0393 (UTC) FILETIME=[62AFA510:01C361BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have noticed that the /proc/kcore file has a different size (1Go) 
> compared with the available memory of my box (640Mo).
> 
> [root@tigre01 kernel]# dmesg | grep Memory
> Memory: 643148k/655360k available (2331k kernel code, 11424k reserved, 
> 730k data, 348k init, 0k highmem)
> 
> [root@tigre01 proc]# ls -l /proc | grep kcore
> -r--------    1 root     root     1073692672 Aug 10 21:43 kcore
> [root@tigre01 proc]#
> 
> Is it a bug or just a new behaviour of the /proc/kcore?

New behaivour ... /proc/kcore is a pseudo-file that tries to
look as much like a "core" file as possible.  For architectures
that use ELF executable format, this means that it starts with
an ELF header, then a few elf_phdr structures to describe the
various virtual sections, and then the sections themselves.  You
can use "objdump -fp" to display these in human readable form.

/proc/kcore will usually be somewhat sparse, as the offsets chosen
for the sections within the file depend on the virtual addresses
of the sections in kernel virtual memory.

The size of the file should be large enough to cover all of the
sections.  One glitch, that probably ought to be fixed, is that
the size is initially assigned based on memory size, but the first
time the file is opened we compute the correct size for all the
sections.

-Tony Luck  

