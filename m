Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVBHOYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVBHOYj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 09:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVBHOYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 09:24:39 -0500
Received: from p-mail1.rd.francetelecom.com ([195.101.245.15]:23561 "EHLO
	p-mail1.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S261534AbVBHOYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 09:24:36 -0500
Message-ID: <4208CBDA.5010903@francetelecom.REMOVE.com>
Date: Tue, 08 Feb 2005 15:25:30 +0100
From: Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
References: <42080689.15768.1B0C5E5F@localhost> <42093CC7.5086.1FC83D3E@localhost> <20050208134156.GA5017@elte.hu>
In-Reply-To: <20050208134156.GA5017@elte.hu>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Feb 2005 14:24:35.0698 (UTC) FILETIME=[EA285520:01C50DE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> i'm just curious, assuming that all those conditions are true, do you
> consider PaX a 100% sure solution against 'code injection' attacks?
> (assuming that the above PaX and access-control feature implementations
> are correct.) Do you think the upstream kernel could/should integrate it
> as a solution against code injection attacks?
> 
> 	Ingo

It depends on what you call 'code injection'.

- If code injection is the introduction of a new piece of directly 
executable-by-processor opcodes (I exclude interpreted code here) into a 
running process:

	1. If you trust the Linux kernel, your processor, etc..
	2. If you have a non executable pages semantics implementation
	3. If you have a restriction preventing PROT_EXEC|PROT_WRITE mappings 
from existing and any new PROT_EXEC mapping (meaning giving an existing 
mapping PROT_EXEC or creating a new PROT_EXEC mapping) from being created.

then the answer is yes.

PaX does 2 fully, and 3 partially:
  - It does'nt prevent executable file mapping (access control system must)
  - .text relocations are detected and permited if the option is enabled 
(necessary if you don't have PIC code)
  - there is an option that can be enable to emulate trampolines

But if you consider code injection as in your previous post:

 >btw., do you consider PaX as a 100% sure solution against 'code
 >injection' attacks (meaning that the attacker wants to execute an
 >arbitrary piece of code, and assuming the attacked application has a
 >stack overflow)? I.e. does PaX avoid all such attacks in a guaranteed
 >way?

then the answer to your question is no because a stack overflow usually 
allows two things: injection of new code, and execution flow redirection.
While the former is prevented, the later is not and the attacker could 
use chaining techniques as in [1] to execute "arbitrary code" (but not 
directly as an arbitrary, newly injected sequence of opcodes).
Address space obfuscation (address space layout randomization is one 
way) is making it harder (but not impossible, esp. if you don't have 
anything preventing the attacker from bruteforcing...) to use existing code.

[1]: Nergal, Advanced return into-lib(c) 
http://www.phrack.org/show.php?p=58&a=4


-- 
Julien TINNES - & france telecom - R&D Division/MAPS/NSS
Research Engineer - Internet/Intranet Security
GPG: C050 EF1A 2919 FD87 57C4 DEDD E778 A9F0 14B9 C7D6
