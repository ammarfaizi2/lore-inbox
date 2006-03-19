Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWCSTll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWCSTll (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 14:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWCSTll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 14:41:41 -0500
Received: from jade.aracnet.com ([216.99.193.136]:28397 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S1750771AbWCSTll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 14:41:41 -0500
Message-ID: <441DB3D8.4050807@BitWagon.com>
Date: Sun, 19 Mar 2006 11:41:12 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: vamsi krishna <vamsi.krishnak@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Idea to create a elf executable from running program	[process2executable]
References: <3faf05680603181422y7447fd7duc1032bd0e07b9c68@mail.gmail.com> <1142760646.3018.8.camel@laptopd505.fenrus.org>
In-Reply-To: <1142760646.3018.8.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Have you looked at the emacs dumper? This is more or less describing how
> emacs makes it's executable during the build process ;)
> (and yes it's horrid ;)

The emacs dumper does not address the fundamental problem with the kernel,
which Vamsi Krishna identified:
> Is there any way we can tell the elf loader to force the vaddr for
> sbrk(0) i.e brk base ?

load_elf_binary()/binfmt_elf.c sets the brk base from the PT_LOAD with
highest virtual address range.  A re-executed dump (or newly decompressed
executable that was stored compressed in the file system, etc.) may well
want to set the brk base below some of its "initial" PT_LOAD [initial as
far as execve() is concerned], but the kernel provides no means to cooperate.
Emacs does not care because it colludes on both ends (the state save and
the restore), but the user does not want to require that the general
restored process must know these details of history.

It seems to me that a proper solution requires a new .p_type PT_BRK
which (if present) would cause the kernel to set the brk base
from the corresponding .p_vaddr, independent of the address ranges
specified in any PT_LOAD.  Or, eliminate the whole concept of brk, which
is an anachronism from the days of primitive address-space management.

-- 
