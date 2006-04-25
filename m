Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWDYTRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWDYTRw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWDYTRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:17:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932172AbWDYTRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:17:51 -0400
Date: Tue, 25 Apr 2006 12:16:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chandra Seetharaman <sekharan@us.ibm.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] Assert notifier_block and notifier_call are not in
 init section
In-Reply-To: <1145991663.16539.8.camel@linuxchandra>
Message-ID: <Pine.LNX.4.64.0604251211510.3701@g5.osdl.org>
References: <20060425023509.7529.84752.sendpatchset@localhost.localdomain> 
 <20060425023527.7529.9096.sendpatchset@localhost.localdomain> 
 <Pine.LNX.4.64.0604241945570.3701@g5.osdl.org> <1145991663.16539.8.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Apr 2006, Chandra Seetharaman wrote:
> 
> Two questions:
> 1) related to this patch: Do you want me to generate a patch that
> asserts only notifier calls ?

I don't really have any strong preferences. It seems a bit strange that 
we'd do it for notifiers but not for other people. It might be better to 
try to build it into the build system itself, and get it through the 
_normal_ "section checking".

One way to do that would be to make the "register_notifier()" thing just 
create this dummy asm() that just puts the arguments into a section that 
doesn't even get loaded, but that cna be checked.

> 2) Unrelated to this patch: If the _code_ section is never reallocated
> or reused, what is the purpose of putting _code_ in the init section ?
> Only to make sure that the init calls are called in order ?

No, the code section is re-used, it's just never re-used for any other 
code (since we don't generate code on the fly). So if you pass in a 
function pointer, you know that if it's in the init section, it means that 
init-code that was discarded.

But if you pass in a data pointer, you'll never know if it's a data 
pointer to the original init-code section, or if it was a data pointer 
that was just dynamically allocated after the init-code section was freed.

> PS: I fixed my mailer to put my name. sorry about that.

Looks good.

		Linus
