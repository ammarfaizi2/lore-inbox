Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbUKQF66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUKQF66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 00:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbUKQF65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 00:58:57 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:56194 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262178AbUKQF5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 00:57:44 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WTF is VLI? 
In-reply-to: Your message of "Tue, 16 Nov 2004 09:56:34 -0000."
             <Pine.LNX.4.44.0411160948530.4179-100000@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Nov 2004 16:55:49 +1100
Message-ID: <5431.1100670949@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 09:56:34 +0000 (GMT), 
Hugh Dickins <hugh@veritas.com> wrote:
>On Tue, 16 Nov 2004, Keith Owens wrote:
>> 
>> ksymoops has to work with lots of different log formats from lots of
>> different architectures.  Some arch's already print the code around the
>> oops and enclose the failing instruction in <> or [], some do not.
>> 
>> Just looking at a code string, you cannot tell if the arch has variable
>> length instructions or not (don't forget that ksymoops also works cross
>> architecture).  The VLI tag will work for _all_ architectures that have
>> variable length instructions, not just i386.  At the very least, s390
>> can use it as well.
>
>But, to an outsider, it seems that the "VLI" can only be relevant when
>disassembling the "Code:", and surely each arch disassembler knows
>already if it's dealing with Variable Length Instructions.

ksymoops takes the Code: line, converts it to a suitable object file,
passes that object to the arch specific disassembler then ksymoops
reformats the output to match the kernel symbol table.  With fixed
length instructions, ksymoops can dump the entire code line into a
single object.  With variable length instructions, disassembling the
code before the instruction pointer is dodgy, it may or may not work.

So for VLI code, ksymoops splits the code line into two separate pieces
and processes each one seperately.  ksymoops prints the first bit with
a warning that it may not be reliable.  The second bit, and all the
code line for non-VLI architectures, is reliable and is printed without
a warning.

The VLI tag, together with <> or [] around the failing instruction,
tells ksymoops if this oops needs to be processed in one chunk or two.
_Before_ passing the synthesized object(s) to the disassembler.

